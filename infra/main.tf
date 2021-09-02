resource "null_resource"  "build" {
  count = var.npm_install ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    interpreter = ["/bin/ash", "-c"]
    command = <<EOF
      which npm &&\
      ls -l &&\
      cd ../../src/$LAMBDA_SRC &&\
      ls -l &&\
      npm install &&\
      $NPM_BUILD &&\
      pwd &&\
      ls -l 
    EOF

    environment = {
      LAMBDA_SRC = var.lambda_src ## Define for multiple lambdas in the same repository, ignore if index.js is directly under src
      NPM_BUILD = var.npm_build == true ? "npm run build" : "echo 'INFO: npm run build set to FALSE.'"
    }
  }
}



data "archive_file" "lambda_zip" {
  type = "zip"
  output_path = local.output_path
  source_dir = var.source_configuration.type == "dir" ? var.source_configuration.path : null
  depends_on = [
    null_resource.build
  ]
}

resource "aws_lambda_function" "function" {
  description                    = var.description
  filename                       = var.source_configuration.type == "dir" ? data.archive_file.lambda_zip.output_path : null
  s3_bucket                      = var.source_configuration.type == "s3" ? local.s3_path_split[0] : null
  s3_key                         = var.source_configuration.type == "s3" ? length(local.s3_path_split) <= 2 ? local.s3_path_split[1] : join("/", slice(local.s3_path_split, 1, length(local.s3_path_split))) : null
  image_uri                      = var.source_configuration.type == "ecr" ? var.source_configuration.path : null
  function_name                  = var.name != null ? var.name : "${local.prefix}-lmb"
  handler                        = var.handler
  layers                         = var.layers
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  role                           = module.lambda_execution_role.arn
  runtime                        = var.runtime
  timeout                        = var.timeout
  source_code_hash               = var.source_configuration.type == "dir" ? data.archive_file.lambda_zip.output_base64sha256 : var.source_code_hash
  tags = merge(
    var.tags,
    {
      Name           = var.name != null ? var.name : "${local.prefix}-lmb"
    }
  )

  dynamic "tracing_config" {
    for_each = var.tracing_mode != "" ? [var.tracing_mode] : []
    content {
      mode = var.tracing_mode
    }
  }

  environment {
    variables = var.environment_variables
  }

  vpc_config {
    subnet_ids         = var.vpc_config["subnet_ids"]
    security_group_ids = var.vpc_config["security_group_ids"]
  }

  depends_on = [ 
    # module.cloudwatchlog,
    module.lambda_execution_role 
    ]
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    sid     = "AllowLambdaService"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

module "lambda_execution_role" {
  source = "git::git@ssh.source.tui:customer/cloud-engineering/terraform/tf-customer-modules-templates.git//modules/aws/iam-role?ref=v1.0.0"
  name   = var.lambda_role_name != null ? var.lambda_role_name : "${local.prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  permission_policies = var.lambda_permissions
  policy_arns = local.policy_arns
  tags       = var.tags
}


# module "cloudwatchlog" {
#   source = "../cloudwatch_loggroup"
#   logs_path = "/lambda/${local.prefix}-logs"
#   log_group_retention_in_days = var.log_group_retention
#   log_group_kms_key_id = var.log_group_kms_key_arn
#   tags = merge(
#     var.tags,
#     {
#       Name           = "${local.prefix}-logs"
#     }
#   )
# }

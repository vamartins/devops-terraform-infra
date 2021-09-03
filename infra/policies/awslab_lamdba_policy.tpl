{
  "Id": "Policy1630675570669",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1630675559870",
      "Action": [
        "s3:Delete*",
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": "${s3_arn}/*",
      "Principal": {
        "AWS": [
          "",
          ""
        ]
      }
    }
  ]
}
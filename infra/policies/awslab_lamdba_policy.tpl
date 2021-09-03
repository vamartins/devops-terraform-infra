{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:Delete*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": "${s3_arn}/*"
    }
  ]
}
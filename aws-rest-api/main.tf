terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

data "archive_file" "lambdazip" {
  type        = "zip"
  output_path = "lambda.zip"
  source_dir  = "lambda/"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_lambda_function" "example_lambda" {
  filename      = "lambda.zip"
  function_name = "example_lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  source_code_hash = filebase64sha256("lambda.zip")
}

data "template_file" "_" {
  template = file("blog-1.0.0-resolved.yaml")
  vars = {
    "region" = "eu-west-2"
    "lambda_identity_timeout" = 600
    "lambda_get_blog_arn" = aws_lambda_function.example_lambda.arn
    "lambda_post_blog_arn" = aws_lambda_function.example_lambda.arn
    "lambda_get_blog_byid_arn" = aws_lambda_function.example_lambda.arn
    "lambda_put_blog_byid_arn" = aws_lambda_function.example_lambda.arn
    "lambda_patch_blog_byid_arn" = aws_lambda_function.example_lambda.arn
    "lambda_delete_blog_byid_arn" = aws_lambda_function.example_lambda.arn
    "lambda_get_comment_arn" = aws_lambda_function.example_lambda.arn
  }
}

resource "aws_api_gateway_rest_api" "example_blog_api" {
  name = "blog-api"
  body = data.template_file._.rendered
}

resource "aws_lambda_permission" "example_blog_api_permission" {
  statement_id  = "example_blog_api_permission_statement"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.example_blog_api.execution_arn}/*/*/*"
}


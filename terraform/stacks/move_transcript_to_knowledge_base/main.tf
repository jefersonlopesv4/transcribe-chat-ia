terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
  }
}

locals {
  environment           = var.ENVIRONMENT
  stack                 = "Trasncript To Knowledge base"
  account_name          = "sample-chat-ai"
  source_file           = "src/lambda_function.py"
  function_name         = "${local.environment}_transcribe_to_knowledge_base"
  function_description  = "Processamento dos arquivos e transcrição de gravações para base de conhecimento do Bedrock."
  lambda_handler        = "lambda_function.lambda_handler"
  runtime               = "python3.8"
  timeout               = 900
  memory_size           = 10240
  log_retention_in_days = 1
  enable_lambda_version = true
  env_variables = {
    "OUTPUT_BUCKET" : "${local.environment}-knowledge-base-bucket-chat-ai"
  }

  default_tags = {
    terraform    = "true"
    environment  = local.environment
    stack        = local.stack
    account_name = local.account_name
  }
}

provider "aws" {
  default_tags {
    tags = local.default_tags
  }
}

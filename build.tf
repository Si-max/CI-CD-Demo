data "template_file" "build" {
  template = file("config.yml")
  vars = {
    env = var.env
  }
}

resource "aws_codebuild_project" "CI-CD-Demo" {
  badge_enabled  = false
  build_timeout  = 60
  name           = "CI-CD-Demo"
  queued_timeout = 480
  service_role   = data.aws_iam_role.static_build_role.arn
  tags = {
    Environment = var.env
  }

  artifacts {
    encryption_disabled    = false
    name                   = "CI-CD-Demo-${var.env}"
    override_artifact_name = false
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:2.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
    type                        = "LINUX_CONTAINER"
  }
    logs_config {
      cloudwatch_logs {
        status = "ENABLED"
  }
  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
      s3_logs {
        encryption_disabled = false
        status              = "DISABLED"
      }
  }

  source {
    buildspec           = data.template_file.buildspec.rendered
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE"
  }
}
}
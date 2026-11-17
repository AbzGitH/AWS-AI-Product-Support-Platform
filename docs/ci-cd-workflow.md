# CI/CD Deployment Workflow

## Continuous Integration
- Trigger: push to main and pull requests targeting main.
- Install Python dependencies for the Flask catalogue API.
- Validate Python syntax and application imports.
- Build the catalogue Docker image.
- Fail the pipeline if validation or build fails.

## Continuous Deployment
- Planned for Lesson 7B.
- Authenticate to AWS using GitHub OIDC.
- Push the validated image to Amazon ECR.
- Update the ECS service only after deployment approval.
- Keep infrastructure provisioning outside this pipeline.

## Safety
- No AWS deployment during initial CI setup.
- No long-lived AWS access keys in GitHub.
- Prevent unintended ECS running costs.

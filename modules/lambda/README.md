## AWS Lambda and IAM Configuration

### Resource: aws_iam_role lambda_role
- **name**: Specifies the unique name of the IAM role for AWS Lambda.
    - **Value**: `"lambda_role_${var.name_suffix}"` incorporates a suffix for a unique identification.
- **assume_role_policy**: JSON policy that allows AWS Lambda service to assume this role.
    - **JSON Configuration**:
        - **Version**: "2012-10-17" is the policy version.
        - **Statement**: Array containing one statement that allows the "lambda.amazonaws.com" service to assume the role.

### Resource: aws_iam_policy lambda_policy
- **name**: Defines the name of the IAM policy tailored for Lambda function.
    - **Value**: `"lambda_policy_${var.name_suffix}"` uses a suffix for differentiation.
- **policy**: JSON encoded policy that broadly grants permissions.
    - **JSON Configuration**:
        - **Version**: "2012-10-17".
        - **Statement**: Contains one statement that allows all actions (`*`) on all resources (`*`), which is not recommended for production due to security risks.

### Resource: aws_iam_role_policy_attachment lambda_role_attached_policy
- **role**: References the IAM role to which the policy will be attached.
    - **Value**: `aws_iam_role.lambda_role.name` links this attachment to the previously defined lambda role.
- **policy_arn**: Specifies the Amazon Resource Name (ARN) of the policy to attach.
    - **Value**: `aws_iam_policy.lambda_policy.arn` points to the ARN of the created policy.

### Data Source: archive_file zip
- **type**: The type of the archive, set to "zip".
- **source_file**: The location of the file to be zipped.
    - **Value**: `"${path.module}/js/index.js"` points to the JavaScript file within the module path.
- **output_path**: Where the zip file will be stored after creation.
    - **Value**: `"${path.module}/index.zip"` defines the output location within the module.

### Resource: aws_lambda_function lambda_files
- **filename**: Path to the zip file containing the function's code.
    - **Value**: `data.archive_file.zip.output_path` uses the output from the zip data source.
- **source_code_hash**: Helps Lambda determine if changes in source code require redeployment.
    - **Value**: `filebase64sha256(data.archive_file.zip.output_path)` calculates a hash of the zip file.
- **function_name**: Names the Lambda function uniquely.
    - **Value**: `"lambda_files_${var.name_suffix}"` includes a suffix for unique identification.
- **role**: The IAM role that the Lambda function assumes when it is executed.
    - **Value**: `aws_iam_role.lambda_role.arn` provides the ARN of the role created for Lambda execution.
- **handler**: Specifies the entry point in the code.
    - **Value**: `"index.handler"` points to the handler function within the index.js file.
- **runtime**: The runtime environment for the Lambda function.
    - **Value**: `var.lambda_runtime` sets the runtime according to the variable.
- **environment**: Defines environment variables for the Lambda function.
    - **variables**: Includes various keys like database URL, bucket name, and more.
        - **Values**:
            - `MONGO_URL`: `var.mongo_url`
            - `S3_BUCKET_NAME`: `var.s3_bucket_name`
            - `MONGO_DB_NAME`: `var.db_name`
            - `MONGO_COLLECTION_NAME`: `var.collection_name`

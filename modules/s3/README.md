## AWS S3 Bucket Configuration with CORS and Notifications

### Resource: aws_s3_bucket
- **bucket**: Specifies the name of the S3 bucket.
    - **Value**: `var.bucket_name` is used to set the bucket name dynamically from a variable.

### Resource: aws_s3_bucket_cors_configuration
- **bucket**: Links the CORS configuration to the specified S3 bucket.
    - **Value**: `aws_s3_bucket.files_bucket.bucket` references the bucket name defined in the aws_s3_bucket resource.
- **cors_rule**: Defines the rules for Cross-Origin Resource Sharing (CORS).
    - **allowed_methods**: Specifies HTTP methods that are allowed.
        - **Value**: `var.cors["allowed_methods"]` fetches allowed methods from variable settings.
    - **allowed_origins**: Defines which origins are allowed.
        - **Value**: `var.cors["allowed_origins"]` fetches allowed origins from variable settings.
    - **allowed_headers**: Specifies which headers are allowed in preflight requests.
        - **Value**: `var.cors["allowed_headers"]` fetches allowed headers from variable settings.
    - **expose_headers**: Headers that are safe to expose to the API of a CORS API specification.
        - **Value**: `var.cors["expose_headers"]` fetches exposed headers from variable settings.
    - **max_age_seconds**: Indicates how long the results of a preflight request can be cached.
        - **Value**: `var.cors["max_age_seconds"]` fetches the max age in seconds from variable settings.

### Resource: aws_s3_bucket_notification
- **bucket**: Associates the notification configuration with a specific S3 bucket.
    - **Value**: `aws_s3_bucket.files_bucket.id` uses the ID of the previously defined S3 bucket.
- **lambda_function**: Configures notifications to trigger a Lambda function.
    - **lambda_function_arn**: The ARN of the Lambda function to be triggered.
        - **Value**: `var.lambda_arn` provides the ARN from a variable.
    - **events**: Specifies which types of events will trigger the function.
        - **Value**: `["s3:ObjectCreated:*"]` triggers the Lambda function for any object created within the bucket.

### Resource: aws_lambda_permission
- **statement_id**: A unique identifier for the policy statement.
    - **Value**: `"AllowExecutionFromS3Bucket"` identifies this particular permission statement.
- **action**: Specifies the action that the principal can use on the function.
    - **Value**: `"lambda:InvokeFunction"` grants permission to invoke the Lambda function.
- **function_name**: The name or ARN of the Lambda function.
    - **Value**: `var.lambda_arn` provides the ARN from a variable.
- **principal**: The service allowed to invoke the function.
    - **Value**: `"s3.amazonaws.com"` specifies that Amazon S3 can invoke the Lambda function.
- **source_arn**: The ARN of the resource (S3 bucket) from which the principal can invoke the Lambda function.
    - **Value**: `aws_s3_bucket.files_bucket.arn` provides the ARN of the S3 bucket.

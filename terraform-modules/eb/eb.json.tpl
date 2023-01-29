{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ContentBucket",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${content_bucket}"
        },
        {
            "Sid": "ContentBucketObject",
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${content_bucket}/*"
        }
    ]
}
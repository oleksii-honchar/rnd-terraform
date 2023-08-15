import { TerraformStack, S3Backend, Token } from "cdktf";
import { Construct } from "constructs";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";

import { defaults } from "../defaults.ts";
import { S3BucketServerSideEncryptionConfigurationA } from "@cdktf/provider-aws/lib/s3-bucket-server-side-encryption-configuration";
import { S3BucketPublicAccessBlock } from "@cdktf/provider-aws/lib/s3-bucket-public-access-block";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";
import { S3BucketVersioningA, S3BucketVersioningAConfig } from "@cdktf/provider-aws/lib/s3-bucket-versioning";

export class GlobalS3StateStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: defaults.awsRegion,
      defaultTags: [{ tags: defaults.commonTags }],
    });

    // S3 Backend - should be executed when bucket already exists.
    // So when run first - comment following lines ¯\(ツ)/¯
    new S3Backend(this, {
      bucket: defaults.projectStateBucket.id,
      key: defaults.projectStateBucket.key,
      region: defaults.awsRegion,
      encrypt: true,
    });

    // create S3 bucket
    const gsBucket = new S3Bucket(this, "GlobalStateBucket", {
      bucket: defaults.projectStateBucket.id,
    });

    new S3BucketVersioningA(this, "GSBVersioning", {
      bucket: gsBucket.id,
      versioningConfiguration: {
        status: "Enabled",
      },
    } as S3BucketVersioningAConfig);

    new S3BucketServerSideEncryptionConfigurationA(this, "GSBSSCfg", {
      bucket: gsBucket.id,
      rule: [
        {
          applyServerSideEncryptionByDefault: {
            sseAlgorithm: "AES256",
          },
        },
      ],
    });

    new S3BucketPublicAccessBlock(this, "GSBPublicAccBlock", {
      bucket: gsBucket.id,
      blockPublicAcls: true,
      blockPublicPolicy: true,
      ignorePublicAcls: true,
      restrictPublicBuckets: true,
    });
  }
}

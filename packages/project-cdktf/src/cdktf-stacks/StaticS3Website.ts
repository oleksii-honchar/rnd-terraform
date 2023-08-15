import { TerraformStack, S3Backend, Token } from "cdktf";
import { Construct } from "constructs";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";

import { defaults } from "../defaults.ts";
import { S3BucketServerSideEncryptionConfigurationA } from "@cdktf/provider-aws/lib/s3-bucket-server-side-encryption-configuration";
import { S3BucketPublicAccessBlock } from "@cdktf/provider-aws/lib/s3-bucket-public-access-block";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";
import { S3BucketVersioningA, S3BucketVersioningAConfig } from "@cdktf/provider-aws/lib/s3-bucket-versioning";
import { AwsS3GlobalStateBucket } from "../../.gen/modules/aws-s3-global-state-bucket.ts";

export class GlobalS3StateStack extends TerraformStack {
  // public id: string;
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: defaults.awsRegion,
      defaultTags: [{ tags: defaults.commonTags }],
    });

    // S3 Backend - https://www.terraform.io/docs/backends/types/s3.html
    new S3Backend(this, {
      bucket: defaults.projectStateBucket.id,
      key: defaults.projectStateBucket.key,
      region: defaults.awsRegion,
      encrypt: true,
    });

    // create S3 bucket
    // const gsBucket = new S3Bucket(this, "GlobalStateBucket", {
    //   bucket: defaults.projectStateBucket.id,
    // });

    new S3BucketVersioningA(this, "GSBVersioning", {
      bucket: defaults.projectStateBucket.id,
      versioningConfiguration: {
        status: "Enabled",
      },
    } as S3BucketVersioningAConfig);

    new S3BucketServerSideEncryptionConfigurationA(this, "GSBSSCfg", {
      bucket: defaults.projectStateBucket.id,
      rule: [
        {
          applyServerSideEncryptionByDefault: {
            sseAlgorithm: "AES256",
          },
        },
      ],
    });

    new S3BucketPublicAccessBlock(this, "GSBPublicAccBlock", {
      bucket: defaults.projectStateBucket.id,
      blockPublicAcls: true,
      blockPublicPolicy: true,
      ignorePublicAcls: true,
      restrictPublicBuckets: true,
    });

    // this.id = gsBucket.id;
    // new AwsS3GlobalStateBucket(this, "GlobalStateBucket", {
    //   bucketName: defaults.projectStateBucket.id,
    //   key: defaults.projectStateBucket.key,
    //   awsRegion: defaults.awsRegion,
    // });
  }
}

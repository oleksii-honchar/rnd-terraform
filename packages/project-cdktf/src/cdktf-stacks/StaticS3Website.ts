import { TerraformStack, S3Backend, Token } from "cdktf";
import { Construct } from "constructs";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";

import { defaults } from "../defaults.ts";

export class StaticS3WebsiteStack extends TerraformStack {
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
      key: "StaticS3WebsiteStack/terraform.state",
      region: defaults.awsRegion,
      encrypt: true,
    });
  }
}

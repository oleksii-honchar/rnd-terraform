import { TerraformStack } from "cdktf";
import { Construct } from "constructs";

export class GlobalS3StateStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    // define resources here
  }
}

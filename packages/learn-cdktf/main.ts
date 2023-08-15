import { Construct } from "constructs";
import { App, TerraformStack, TerraformOutput } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { Instance } from "@cdktf/provider-aws/lib/instance";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: "eu-central-1",
    });

    const ec2Instance = new Instance(this, "compute", {
      ami: "ami-09af72ad2a3676ba8",
      instanceType: "t2.micro",
      tags: {
        Name: "CDKTF-Demo",
      }
    });

    new TerraformOutput(this, "public_ip", {
      value: ec2Instance.publicIp,
    });
  }
}

const app = new App();
new MyStack(app, "aws_instance");

app.synth();

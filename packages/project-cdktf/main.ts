import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";



const app = new App();
new GlobalS3State(app, "project-cdktf");
app.synth();

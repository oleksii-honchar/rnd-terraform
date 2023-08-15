import { App } from "cdktf";

import { GlobalS3StateStack } from "./cdktf-stacks/GlobalS3StateStack.ts";
import { StaticS3WebsiteStack } from "./cdktf-stacks/StaticS3Website.ts";

const app = new App();
new GlobalS3StateStack(app, "GlobalS3State");
new StaticS3WebsiteStack(app, "StaticS3Website");
app.synth();

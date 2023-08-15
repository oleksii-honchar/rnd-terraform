import { App } from "cdktf";

import { GlobalS3StateStack } from "./cdktf-stacks/GlobalS3StateStack.ts";

const app = new App();
new GlobalS3StateStack(app, "GlobalS3State");
app.synth();

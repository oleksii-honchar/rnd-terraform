import type { StringIndex } from "./typings.d.ts";

export const defaults: StringIndex = {
  commonTags: {
    Project: "project-cdktf",
    Environment: "development",
    ResourceGroup: "cdktf-rnd",
  },
  awsRegion: "eu-central-1",
  projectStateBucket: {
    id: "olho.rnd.project-cdktf",
    key: "global/terraform.tfstate",
  },
};

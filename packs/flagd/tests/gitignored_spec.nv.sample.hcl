# The root-level Makefile will automatically map these variables this file if it is renamed to `gitignored_spec.nv.hcl`.
# This file may be used to set sensitive variables for testing purposes.

items {
  flags = {
    "flags": {
      "myBoolFlag": {
        "state": "ENABLED",
        "variants": {
          "on": true,
          "off": false
        },
        "defaultVariant": "on"
      },
    }
  }
}

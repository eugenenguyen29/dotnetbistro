---
title: "I Kept Delaying Using 1Password as My Secret Manager and I Was Wrong"
date: 2025-01-13
tags:
  - 1password
  - secret manager
---

### New dot env feature for developers

It lets you inject .env to the project directory, with 1Password controlling the data stream to the file and updating it at compile time.
This .env file cannot be committed with git, and you must authenticate with 1Password to unmask it.

### One other cool trick with 1Password secret injection

I use 1Password to inject secrets into a Butane template and compile it to a Butane file, then translate it to an Ignition file.

```bu config.bu.tpl
variant: flatcar
version: 1.1.0

passwd:
  users:
    - name: core
      ssh_authorized_keys:
        - {{ op://Infrastructure/$FLATCAR_NODE/public key }}
      groups:
        - sudo
        - docker
```

The `justfile` script shows a workaround to compile Butane with dynamic variables using envsubst and secret injection. The trick is to also `rm` the compiled file with the secret after use, which makes things more secure.

```justfile
convert $NODE_NAME $BU:
    export FLATCAR_NODE={{ NODE_NAME }}; op inject -i {{ BU }}.template | envsubst - > {{ BU }}.trans
    rm {{ BU }}.trans
```

While these features are cool, there's one missing feature I wish 1Password would implement to complete the feature set: a Certificate Manager. 1Password does not allow you to manage CA certificates. But for now, I manage those via step-ca CLI.

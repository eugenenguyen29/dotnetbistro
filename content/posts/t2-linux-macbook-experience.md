---
title: "My Experience with T2 Linux on My MacBook So Far"
date: 2025-01-13
tags:
  - linux
  - t2-chip
  - apple
  - macbook
  - nixos
---

I just decided to nuke my MacBook 2018 as it was getting older and slightly slower when updated to the latest macOS (Sequoia). My MacBook was constantly eating 13-14GB of RAM with just a few things running like 2 browsers, WezTerm, Lulu, 1Password, etc., and OMG it was running hot as hell.

So I decided to do what anyone with some NixOS experience who's aware of the T2 Linux project would do. Heck yes! I nuked my MacBook and installed NixOS.
The reason behind NixOS is that I already run my homelab with NixOS and already have a PC also running NixOS, so yeah NixOS is kinda my comfort zone. I like the workflow with NixOS where I can have a package available at that specific moment

```sh
nix shell pkgs#dig -c dig blog.dotnetbistro.cloud
```

and just like that I can have `dig` without installing it via package manager and forever forget to uninstall it since it's just a one-time use.

One more cool thing about NixOS is that it documents itself without me forgetting what I did last week.

But yeah not all that fun stuff is without caveat.

Yes, NixOS is very verbose. Yup, I express it as verbosity since everything must be written in that bloody configuration—there is no quick and dirty way to do it, maybe there is but I'm not aware of it. But I'm ok with it, just a small trade-off for my sanity.

A side story: I tried Omarchy following the hype to check out the Hyprland DE. Omarchy is too opinionated, but I like the minimalism of its Hyprland configuration. And then I found the [omarchy-nix repository](https://github.com/henrysipp/omarchy-nix), but it seems to be abandoned, so I forked it and maintain my own configuration there.

Great, now all the pieces are coming together!


Now just follow this [tutorial](https://wiki.t2linux.org/distributions/nixos/installation/) to install the Apple driver and then this [tutorial](https://www.youtube.com/watch?v=lUB2rwDUm5A) to install NixOS.

With a lot of help from the T2 Linux NixOS channel on Discord, I was able to successfully configure NixOS with the T2 Linux kernel.

| Feature | Work? | Note |
| --- | --- | --- |
| Bluetooth | Nope | I disabled for stability — my BCM4377 chip is unstable according to T2 Linux Discord |
| Wifi | Yes | -  |
| Camera | Yes | - |
| Microphone | Yes | - |
| Touchbar | Yes, if it turns on | - |
| Haptic | Don't know | My trackpad haptics were already hit and miss even on macOS |
| Speaker | Yes | I have to set the internal speaker as default to make it work |


You can reference my configuration [here](https://github.com/eugenenguyen29/nix-config/tree/master/host/saber).

Thank you for reading!

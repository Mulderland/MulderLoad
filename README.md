# MulderLoad

MulderLoad is a core component of Mulderland, a website dedicated to video game preservation, restoration, and modernization. The name is a play on words between the name of the website, Mulderland, and what one might call download software. Hence, MulderLoad.

MulderLoad are installers built with NSIS (Nullsoft Scriptable Install System), whose full source code is available in this repository. These installers are also built directly from this repository through GitHub Actions.

This repository contains:
- All the "recipes" used to generate the installers
- The CI/CD responsible for automatically building and publishing them
- A large collection of reusable functions, macros and templates, designed to make writing and maintaining recipes easier and faster
- Some tests for critical & cores functions

If you are only looking for the final installers, you can visit the project website: www.mulderland.com 

## Type of Installers

There are currently three installer templates:

**1) Enhancement Packs**

Designed to fix and/or modernize a game that is already installed (mostly Steam or GOG releases).
This is, by far, the most common type of MulderLoad installer.

**2) BYOF Installers** (Bring Your Own Files)

These installers set up, and optionally enhance, a game using files provided by the user (ISO or archive).
This approach is used for games that are not available digitally. Think of abandonware, but legally, since we do not provide any original copyrighted game files.

**3) Full Installers**

These installers fully install, and optionally enhance, a game without any prior requirement.
This format is mainly used for freeware titles.

## Enhancement Philosophy

The guiding principle behind Mulderland's enhancements is simple: **preserve the vanilla experience**.

The goal is not to transform games with gameplay-altering mods or controversial redesigns. Such changes are often subjective and divisive. Instead, Mulderland focuses on:
- Fixing compatibility issues on modern systems
- Resolving stability problems
- Resolving sound issues
- Adding widescreen support when missing
- Improving graphics, when it respects the original artistic direction and atmosphere.

For example, HD texture packs may be used, but only if they remain faithful to the original aesthetic. The ideal case is an upscale pack generated from the original textures rather than a complete artistic reinterpretation.

## Installer Design Principles

MulderLoad installers aim to be:
- As clean and lightweight as possible
- Secure and resilient (open source, file hash verification, mirrors, etc.)
- Free from legacy installers (InstallShield and similar outdated systems)
- Portable whever possible

Administrator privileges are avoided unless absolutely necessary.

## Build Locally

- Clone the repository
- Open Powershell, go to the "build" directory, and run this script (once) to install NSIS and its extensions locally: 

> .\setup.ps1

- Then, still from the build directory, build a recipe:

> .\make.ps1 ..\games\one-game\enhancement-pack.nsi

- The generated installer will be available at 
> ..\dist\one-game-enhancement-pack.exe

## Contribute

If you want to improve existing recipes or write new ones, contributions are welcome.
Just give me few days to terminate the documentation :)

# Dev Images & Tools

This repository keeps Dockerfiles, helper scripts, and CI workflows for the dev
images we use locally and in CI. Each image lives in its own folder with a
`Dockerfile.dev` and a `build-push-*.sh` helper, with GitHub Actions workflows
wired to those folders.

## Images

- `dotnet/` – .NET SDK dev image.
- `full-stack/` – .NET SDK + Node + Angular CLI dev image.
- `node-angular/` – Node + Angular CLI dev image.
- `mongodb/` – MongoDB server image extended with `mongosh` and database tools.

## Quick reference

| Image | Folder | Workflow | Dockerfile |
| --- | --- | --- | --- |
| dotnet | `dotnet/` | `.github/workflows/build-dotnet-dev.yml` | `dotnet/Dockerfile.dev` |
| fullstack-dev | `full-stack/` | `.github/workflows/build-fullstack-dev.yml` | `full-stack/Dockerfile.dev` |
| node-angular | `node-angular/` | `.github/workflows/build-node-angular-dev.yml` | `node-angular/Dockerfile.dev` |
| tools (MongoDB) | `mongodb/` | `.github/workflows/build-mongo-tools-dev.yml` | `mongodb/Dockerfile.dev` |

## Image tags

- `dotnet`: `<dotnet-version>-<variant>` (example: `10.0-sdk`).
- `fullstack-dev`: `dotnet<DOTNET>-node<NODE>-ng<ANGULAR>`
  (example: `dotnet10.0-node24-ng21`).
- `node-angular`: `node<NODE>-ng<ANGULAR>` (example: `node24-ng21`).
- `tools` (MongoDB): `mongo-<version>` (example: `mongo-7.0`).

## Local build examples

```bash
cd dotnet
./build-push-dotnet-dev.sh 10.0 sdk
```

```bash
cd full-stack
./build-push-dev-full.sh 10.0 24 21
```

```bash
cd node-angular
./build-push-node-angular-dev.sh 24 21
```

```bash
cd mongodb
./build-push-mongodb.sh 7.0 7.0 mongo-7.0
```

## CI builds

Each image has a matching workflow under `.github/workflows/` that builds on
pushes touching its folder. Update version defaults in each workflow `env` block.

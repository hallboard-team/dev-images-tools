# Dev Images & Tools

This repository keeps Dockerfiles and helper scripts for the tooling images we
use locally, in CI, or to seed cloud environments. Each tool gets its own
folder that contains:

- `Dockerfile.*` files that define how to build the image.
- A `build-push-*.sh` helper that bakes the image and pushes it to the container
  registry (GitHub Container Registry by default).

Keeping these assets together means we can version-control how each tool is
configured and reproduce the same setup anywhere.

## Current tools

- `mongodb/` – extends the official `mongo` image and adds MongoDB CLI tooling
  (`mongosh`, `mongodb-database-tools`) so the container ships with everything
  we use when connecting to the database.
- `postgres/` – placeholder for future Postgres image work.

## Image naming convention

All tool images live under the shared GitHub Container Registry repository
`ghcr.io/hallboard-team/tools`. Each tool/version combination gets its own tag
using the pattern `<tool>-<version>` (for example, `tools:mongo-7.0`). This lets
us keep every tool in a single repo while still pulling exact versions.

## Prerequisites

- Docker CLI installed locally.
- Logged in to the target registry (`docker login ghcr.io` for GitHub
  Container Registry).

## Build & push the MongoDB image

```bash
cd mongodb
./build-push-mongodb.sh [mongo_version] [mongo_tools_version] [image_tag]
```

Defaults:

- `mongo_version`: `7.0`
- `mongo_tools_version`: defaults to the MongoDB server version
- `image_tag`: `mongo-{mongo_version}`

The script also respects `IMAGE_REPO` (defaults to
`ghcr.io/hallboard-team/tools`) if you need to target a different registry or
namespace.

Example:

```bash
./build-push-mongodb.sh 7.0 7.0 mongo-7
```

## Adding a new tool

1. Create a new folder at the repo root (for example, `redis/`).
2. Add the Dockerfile(s) that describe the image.
3. Add a build/push helper script modeled after `mongodb/build-push-mongodb.sh`.
4. Document the tool and how to build it in this README so collaborators know it
   exists and how to use it.

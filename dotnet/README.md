# .NET Dev Image Template

This template contains a reusable Dockerfile for building a .NET SDK based development image and the automation required to publish it to GitHub Container Registry (GHCR).

## Image naming

Images are tagged with the `<dotnet-version>-<variant>` pattern (for example `10.0-sdk`). The Dockerfile now accepts a `DOTNET_VARIANT` build arg, so you can reuse the same file for `sdk`, `runtime`, or any other Microsoft-provided variant simply by adding it to the build matrix.

## GitHub Actions build & push

The workflow in `.github/workflows/build-dotnet-dev.yml` replicates the manual build process on GitHub Actions. It runs automatically on pushes that touch `Dockerfile.dev`, the workflow itself, or the helper script, and it can also be triggered manually. The job logs in to GHCR using the built-in `GITHUB_TOKEN`, builds the image with Buildx, and pushes it to `ghcr.io/<org-or-user>/dotnet` with a tag such as `10.0-sdk`.

All of the knobs you are likely to tweak live in the workflow `env` block (registry, repository, .NET version, variants JSON, build context/file, and platforms). To publish both sdk and runtime images, set `VARIANTS_JSON` to `["sdk","runtime"]` and the workflow will build/push both tags automatically.

## Local testing

You can still build locally before pushing changes:

```bash
./build-push-dotnet-dev.sh 10.0
# or specify a variant explicitly
./build-push-dotnet-dev.sh 10.0 runtime
```

The script now publishes to `ghcr.io/hallboard-team/dotnet:<version>-<variant>`, matching the tags produced by GitHub Actions.

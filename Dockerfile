# Use a specific, official Microsoft SDK image that includes both .NET 8 and 9 SDKs.
# The 'mcr.microsoft.com/dotnet/sdk:9.0' image is a lean, secure, and stable base
# for building .NET applications. It includes the 9.0 SDK, which is backward-compatible and can
# restore projects targeting earlier frameworks like net8.0.
FROM mcr.microsoft.com/dotnet/sdk:9.0

# Create a non-root user for security best practices.
# The 'app' user is the standard for .NET chiseled images.
USER app

# Set the working directory for all subsequent commands.
WORKDIR /app

# Pin the SDK version for deterministic builds by copying the global.json from the host.
# This ensures consistency and prevents the .NET CLI from selecting a different SDK version.
COPY global.json .

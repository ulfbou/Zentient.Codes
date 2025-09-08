# Use a specific, official Microsoft SDK image that includes both .NET 8 and 9 SDKs.
# The 'mcr.microsoft.com/dotnet/sdk:9.0-jammy' image is a lean, secure, and stable base
# for building .NET applications. It includes the 9.0 SDK, which is backward-compatible and can
# restore projects targeting earlier frameworks like net8.0.
FROM mcr.microsoft.com/dotnet/sdk:9.0-jammy

# Create a non-root user for security best practices.
# The 'app' user is the standard for .NET chiseled images.
USER app

# Set the working directory for all subsequent commands.
WORKDIR /app

# Pin the SDK version for deterministic builds using global.json.
# This prevents the .NET CLI from selecting a different SDK version if multiple are present.
COPY global.json .

# Create a sample global.json file that pins the SDK version to ensure consistency.
# In a real-world scenario, you would manually create this file and copy it.
# We are creating it here for demonstration purposes.
RUN echo '{ "sdk": { "version": "9.0.100" } }' > global.json

# Restore dependencies for all projects to pre-populate the NuGet cache.
# This helps subsequent builds and packs to be faster and more reliable.
# In your pipeline, you can still run `dotnet restore` but the cache should be warm.
RUN dotnet new console -o MyProject
RUN dotnet new classlib -o MyLibrary
RUN dotnet restore

# Clean up the temporary project files created for cache priming to keep the image lean.
RUN rm -rf MyProject MyLibrary

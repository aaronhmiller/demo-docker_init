FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
WORKDIR /source

# Copy everything to the working directory
COPY . .

# List the contents to debug (optional)
RUN ls -la

# Explicitly specify your project file
RUN dotnet publish HelloWorld.csproj -a arm64 --use-current-runtime --self-contained false -o /app

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "HelloWorld.dll"]

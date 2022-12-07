FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
RUN pwd
RUN ls -la
WORKDIR .

# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet build -c release --no-restore -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
COPY --from=build-env /out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
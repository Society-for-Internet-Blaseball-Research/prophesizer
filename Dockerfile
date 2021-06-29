FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY prophesizer/*.csproj ./prophesizer/
COPY Cauldron/*.csproj ./Cauldron/
RUN dotnet restore ./prophesizer/prophesizer.csproj

# Copy everything else and build
COPY . ./
RUN dotnet publish --framework net5.0 ./prophesizer/prophesizer.csproj -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/runtime:5.0
WORKDIR /app
COPY --from=build-env /app/out .
COPY ./pg-ca-certificate.crt /usr/local/share/ca-certificates/mycert.crt
RUN update-ca-certificates

ENTRYPOINT ["dotnet", "prophesizer.dll"]
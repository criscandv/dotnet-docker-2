FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["dotnet-core-hello-world.csproj", "./"]
RUN dotnet restore "dotnet-core-hello-world.csproj"
COPY . .
RUN dotnet publish "dotnet-core-hello-world.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "dotnet-core-hello-world.dll"]

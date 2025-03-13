# Use official Microsoft .NET SDK image to build and publish the project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project files
COPY . ./
RUN dotnet restore

# Build and publish the project
RUN dotnet publish -c Release -o /publish

# Use a lightweight runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /publish .

# Expose the port Swagger runs on (default: 7174)
EXPOSE 7174

# Start the API
CMD ["dotnet", "WebApplication1.dll"]

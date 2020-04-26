UrlGitRepositoryBuildTools=git@ssh.dev.azure.com:v3/kargware/KargWareUtilities/PipelineTools
FolderNameBuildTools=.\PipelineTools
BuildConfiguration=Release
ArtifactFolder=.\Artifacts

my-default-targets: log-variables

# Auto-Documented Makefile, https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

log-variables:
	@echo "/ ########################## #"
	@echo "* UrlGitRepositoryBuildTools : $(UrlGitRepositoryBuildTools)"
	@echo "* FolderNameBuildTools       : $(FolderNameBuildTools)"
	@echo "* BuildConfiguration         : $(BuildConfiguration)"
	@echo "* ArtifactFolder             : $(ArtifactFolder)"
	@echo "\ ########################## #"

example: ## Shows the example of a multiline comment
example: \
	log-variables \
    log-environment-variables-ps1

checkout-buildtools:
	@if exist "$(FolderNameBuildTools)" (rmdir /S /Q "$(FolderNameBuildTools)")
	@git clone -q "$(UrlGitRepositoryBuildTools)" "$(FolderNameBuildTools)"	

create-artifacts: ## Build and Copy the artifacts for the MSI
create-artifacts: \
	build \
	copy-files-to-artifact-folder

build: ## Build the .NET Core and .NET Framework solutions
build:
	dotnet build .\Source\CustomProtocolHandler\CustomProtocolHandler.sln -c "$(BuildConfiguration)" --no-incremental
	dotnet build .\Source\CustomProtocolHandler\CustomProtocolHandler.sln -c "$(BuildConfiguration)" -r "win-x86" --no-incremental
	dotnet build .\Source\CustomProtocolHandler\CustomProtocolHandler.sln -c "$(BuildConfiguration)" -r "win-x64" --no-incremental

copy-files-to-artifact-folder-generic:
	xcopy /v /h /y ".\Source\CustomProtocolHandler\CustomProtocolHandler\bin\$(BuildConfiguration)\netcoreapp3.1\$(Runtime)\CustomProtocolHandler.deps.json" "$(ArtifactFolder)\$(ArtifactPlatform)\"
	xcopy /v /h /y ".\Source\CustomProtocolHandler\CustomProtocolHandler\bin\$(BuildConfiguration)\netcoreapp3.1\$(Runtime)\CustomProtocolHandler.dll" "$(ArtifactFolder)\$(ArtifactPlatform)\"
	xcopy /v /h /y ".\Source\CustomProtocolHandler\CustomProtocolHandler\bin\$(BuildConfiguration)\netcoreapp3.1\$(Runtime)\CustomProtocolHandler.exe" "$(ArtifactFolder)\$(ArtifactPlatform)\"
	xcopy /v /h /y ".\Source\CustomProtocolHandler\CustomProtocolHandler\bin\$(BuildConfiguration)\netcoreapp3.1\$(Runtime)\CustomProtocolHandler.runtimeconfig.json" "$(ArtifactFolder)\$(ArtifactPlatform)\"

copy-files-to-artifact-folder: ## Copy bin-output to artifacts
copy-files-to-artifact-folder:
	if exist "$(ArtifactFolder)\" (rmdir /s /q "$(ArtifactFolder)\")
	make copy-files-to-artifact-folder-generic Runtime=. ArtifactPlatform=.
	make copy-files-to-artifact-folder-generic Runtime=win-x86 ArtifactPlatform=x86
	make copy-files-to-artifact-folder-generic Runtime=win-x64 ArtifactPlatform=x64
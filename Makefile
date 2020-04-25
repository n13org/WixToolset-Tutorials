UrlGitRepositoryBuildTools=git@ssh.dev.azure.com:v3/kargware/KargWareUtilities/PipelineTools
FolderNameBuildTools=.\PipelineTools

log-variables:
	@echo "/ ############################# #"
	@echo "* UrlGitRepositoryBuildTools    : $(UrlGitRepositoryBuildTools)"
	@echo "* FolderNameBuildTools          : $(FolderNameBuildTools)"
	@echo "\ ############################# #"

checkout-buildtools:
	@if exist "$(FolderNameBuildTools)" (rmdir /S /Q "$(FolderNameBuildTools)")
	@git clone -q "$(UrlGitRepositoryBuildTools)" "$(FolderNameBuildTools)"	
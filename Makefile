serve:
	@echo "starting the project..."
	@cd $(root_path) && ./$(app_name)

build:
	@cd $(root_path) && go build -o $(app_name) main.go
	@echo "project build successfully!"


clean:
	@rm -f  $(root_path)/$(app_name)
	@echo "project cleaned!"

start: clean build serve

app_name:= "aws-project"
root_path:= ./
.PHONY: build clean clean-all list help

build:
	@chmod +x build.sh
	@./build.sh

clean:
	@docker rmi -f fjordock/yarp:3.22.1 2>/dev/null || true
	@docker rmi -f fjordock/yarp:3.22.1-amd64 2>/dev/null || true
	@docker rmi -f fjordock/yarp:3.22.1-arm64 2>/dev/null || true
	@echo "Cleanup completed"

clean-all:
	@docker rmi -f $(shell docker images "fjordock/yarp*" -q) 2>/dev/null || true
	@echo "Complete cleanup of all fjordock/yarp images"

list:
	@cd $(FJORDOCK) && act -l && docker images

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  build     - test build"
	@echo "  clean     - delete test images"
	@echo "  clean-all - delete ALL fjordock/yarp images"
	@echo "  list      - list available workflows (from FJORDOCK)"
	@echo "  help      - display this help message"

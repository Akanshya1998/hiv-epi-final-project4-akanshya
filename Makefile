.PHONY: report clean

# Detect OS for path handling
ifeq ($(OS),Windows_NT)
    # Windows with Git Bash requires extra /
    PWD_PREFIX := /
else
    PWD_PREFIX :=
endif

# Target to generate the report using Docker
report:
	docker run --rm -v "$(PWD_PREFIX)$$(pwd)/output":/project/output akanshya1998/hiv-report:latest

# Clean output directory
clean:
	rm -rf output/tables/* output/figures/* output/*.html
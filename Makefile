IMAGE_NAME = ghcr.io/lmt-swallow/writing-environment:latest
SRC_DIR = ./src
SRC_MAIN = main.md

OUTPUT_DIR = ./build
OUTPUT_MAIN = main.pdf
OUTPUT = $(OUTPUT_DIR)/$(OUTPUT_MAIN)

all: $(OUTPUT)

$(OUTPUT_DIR): 
	mkdir ./build

$(OUTPUT): $(SRCS) $(OUTPUT_DIR)
	docker run -it \
		-v $(abspath $(SRC_DIR)):/workspace  \
		-v $(abspath $(OUTPUT_DIR)):/build  \
		$(IMAGE_NAME) \
		--pdf-engine=lualatex \
		--template=./templates/plain.tex \
		-N --listings \
		-M 'crossrefYaml=./configurations/crossref.yaml' \
		-F pandoc-crossref \
		-F pandoc-citeproc \
		-f markdown+tex_math_double_backslash \
		-o /build/$(OUTPUT_MAIN) \
		$(SRC_MAIN)

.PHONY: lint
lint: $(SRCS)
	docker run -it --rm \
		-v $(abspath $(SRC_DIR))/:/work \
		textlint/technical-writing \
		$(SRC_MAIN)

.PHONY: clean
clean: $(OUTPUT_DIR)
	rm -rf $(OUTPUT_DIR)
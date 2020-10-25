all: $(OUTPUT_DIR)/$(OUTPUT_NAME)

IMAGE_NAME = ghcr.io/lmt-swallow/pandoc
SRC_DIR = ./src
SRC_MAIN = main.md

OUTPUT_DIR = ./build
OUTPUT_MAIN = main.pdf

$(BUILD_DIR): 
	mkdir ./build

$(OUTPUT_DIR)/$(OUTPUT_NAME): $(SRCS) $(OUTPUT_DIR)
	docker run -it \
		-v $(abspath $(SRC_DIR)):/workspace  \
		-v $(abspath $(OUTPUT_DIR)):/build  \
		$(IMAGE_NAME)
		--pdf-engine=lualatex \
		--template=./templates/plain.tex \
		-N --listings \
		-M 'crossrefYaml=./configurations/crossref.yaml' \
		-F pandoc-crossref \
		-F pandoc-citeproc \
		-f markdown+tex_math_double_backslash \
		-o /build/$(OUTPUT_MAIN) \
		$(SRC_MAIN)
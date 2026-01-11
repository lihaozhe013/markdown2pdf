# Detect OS for compatibility
ifeq ($(OS),Windows_NT)
    # Windows (Git Bash, WSL, etc.)
    # Docker Desktop handles permissions, so we use default IDs to avoid warnings
	DOCKER_RUN := docker compose run --rm converter
else
    # Linux / macOS
    UID := $(shell id -u)
    GID := $(shell id -g)
	DOCKER_RUN := UID=$(UID) GID=$(GID) docker compose run --rm converter
endif

default: pdf-en-formal-serif

help:
	@echo "Available commands:"
	@echo ""
	@echo "PDF Generation (Chinese):"
	@echo "  make pdf-cn-casual   - Generate PDF with Chinese casual style (no TOC, no title page)"
	@echo "  make pdf-cn-formal   - Generate PDF with Chinese formal style (with TOC and title page)"
	@echo ""
	@echo "PDF Generation (English):"
	@echo "  make pdf-en-casual-serif - Generate PDF with English casual serif style (no TOC, no title page)"
	@echo "  make pdf-en-casual-sans  - Generate PDF with English casual sans-serif style (no TOC, no title page)"
	@echo "  make pdf-en-formal-serif - Generate PDF with English formal serif style (with TOC and title page)"
	@echo "  make pdf-en-formal-sans  - Generate PDF with English formal sans-serif style (with TOC and title page)"
	@echo ""
	@echo "TeX Export (Chinese):"
	@echo "  make tex-cn-casual   - Export TeX with Chinese casual style"
	@echo "  make tex-cn-formal   - Export TeX with Chinese formal style"
	@echo ""
	@echo "TeX Export (English):"
	@echo "  make tex-en-casual-serif - Export TeX with English casual serif style"
	@echo "  make tex-en-casual-sans  - Export TeX with English casual sans-serif style"
	@echo "  make tex-en-formal-serif - Export TeX with English formal serif style"
	@echo "  make tex-en-formal-sans  - Export TeX with English formal sans-serif style"

docker-build:
	docker compose up -d --build

docker-start:
	docker compose up -d

docker-stop:
	docker compose stop

docker-down:
	docker compose down

docker-install-fonts:
	docker compose run --rm converter "apt update && apt install -y fonts-noto-cjk fonts-noto-cjk-extra"

clear-emoji:
	python3 clear-emoji.py

docker-sh:
	$(DOCKER_RUN) /bin/bash

# Optional Arguments:
# --number-sections
# -V mathfont='Noto Sans CJK SC' \

pdf-cn-casual:
	$(DOCKER_RUN) "pandoc content.md styles/cn-casual.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=xelatex"

pdf-cn-formal:
	$(DOCKER_RUN) "pandoc content.md styles/cn-formal.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=xelatex"

pdf-en-casual-serif:
	$(DOCKER_RUN) "pandoc content.md styles/en-casual-serif.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=pdflatex"

pdf-en-casual-sans:
	$(DOCKER_RUN) "pandoc content.md styles/en-casual-sans.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=pdflatex"

pdf-en-formal-serif:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-serif.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=pdflatex"

pdf-en-formal-sans:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-sans.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=pdflatex"

tex-en-casual-serif:
	$(DOCKER_RUN) "pandoc content.md styles/en-casual-serif.yaml -o content_en_casual_serif.tex \
		--lua-filter=img_filter.lua \
		--standalone"

tex-en-casual-sans:
	$(DOCKER_RUN) "pandoc content.md styles/en-casual-sans.yaml -o content_en_casual_sans.tex \
		--lua-filter=img_filter.lua \
		--standalone"

tex-en-formal-serif:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-serif.yaml -o content_serif.tex \
		--lua-filter=img_filter.lua \
		--standalone"

tex-en-formal-sans:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-sans.yaml -o content_sans.tex \
		--lua-filter=img_filter.lua \
		--standalone"

tex-cn-casual:
	$(DOCKER_RUN) "pandoc content.md styles/cn-casual.yaml -o content_casual.tex \
		--lua-filter=img_filter.lua \
		--standalone"

tex-cn-formal:
	$(DOCKER_RUN) "pandoc content.md styles/cn-formal.yaml -o content_formal.tex \
		--lua-filter=img_filter.lua \
		--standalone"
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



default: cn

docker-build:
	docker compose up -d --build

docker-start:
	docker compose up -d

docker-stop:
	docker compose stop

docker-down:
	docker compose down

clear-emoji:
	python3 clear-emoji.py

docker-sh:
	$(DOCKER_RUN) /bin/bash

# Optional Arguments:
# --number-sections
# -V mathfont='Noto Sans CJK SC' \

cn-casual:
	$(DOCKER_RUN) "pandoc content.md -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=xelatex \
		-V mainfont='Noto Sans CJK SC' \
		-V mainfontoptions='BoldFont=Noto Sans CJK SC Bold' \
		-V sansfont='Noto Sans CJK SC' \
		-V sansfontoptions='BoldFont=Noto Sans CJK SC Bold' \
		-V CJKmainfont='Noto Sans CJK SC' \
		-V CJKoptions='BoldFont=Noto Sans CJK SC Bold' \
		-V geometry:margin=2cm"

pdf-en-formal-serif:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-serif.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=pdflatex"

pdf-en-formal-sans:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-sans.yaml -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=pdflatex"

tex-en-formal-serif:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-serif.yaml -o content_serif.tex \
		--lua-filter=img_filter.lua \
		--standalone"

tex-en-formal-sans:
	$(DOCKER_RUN) "pandoc content.md styles/en-formal-sans.yaml -o content_sans.tex \
		--lua-filter=img_filter.lua \
		--standalone"
DOCKER_RUN := UID=$(UID) GID=$(GID) docker compose run --rm converter

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

cn:
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

en-serif:
	$(DOCKER_RUN) "pandoc content.md -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=xelatex \
		-V mainfont='TeX Gyre Termes' \
		-V geometry:margin=2cm"

en-sans:
	$(DOCKER_RUN) "pandoc content.md -o content.pdf \
		--lua-filter=img_filter.lua \
		--pdf-engine=xelatex \
		-V mainfont='Open Sans' \
		-V geometry:margin=2cm"
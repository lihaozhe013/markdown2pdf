DOCKER_RUN := UID=$(UID) GID=$(GID) docker compose run --rm converter

default: cn

clear-emoji:
	python3 clear-emoji.py

shell:
	$(DOCKER_RUN) /bin/bash

cn:
	$(DOCKER_RUN) "pandoc content.md -o content.pdf \
		--pdf-engine=xelatex \
		-V mainfont='Noto Sans CJK SC' \
		-V sansfont='Noto Sans CJK SC' \
		-V CJKmainfont='Noto Sans CJK SC' \
		-V geometry:margin=2cm \
		--number-sections"

# ----------------------------------------------------------------
# 英文转换 (Times / TeX Gyre Termes)
# ----------------------------------------------------------------
en:
	$(DOCKER_RUN) "pandoc content.md -o content.pdf \
		--pdf-engine=xelatex \
		-V mainfont='TeX Gyre Termes' \
		-V geometry:margin=2cm"

en-sans:
	$(DOCKER_RUN) "pandoc content.md -o content.pdf \
		--pdf-engine=xelatex \
		-V mainfont='TeX Gyre Heros' \
		-V geometry:margin=2cm"
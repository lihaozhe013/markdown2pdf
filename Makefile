default: run

run:
	uv run scripts/compile.py

dev:
	uv run scripts/dev.py

clean:
	rm -rf *.pdf
	rm -rf ./assets/

format:
	markdownlint-cli2 "**/*.md" --fix
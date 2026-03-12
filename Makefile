default: dev

run:
	uv run src/compile.py

dev:
	uv run main.py

clean:
	rm -rf *.pdf
	rm -rf ./assets/
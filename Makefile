default: run

run:
	uv run main.py

clean:
	rm -rf *.pdf
	rm -rf ./assets/
	rm -rf */.bak
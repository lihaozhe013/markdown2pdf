# markdown2pdf Tool

## Installation

Python Dependencies

```bash
uv sync
```

Markdown Formatter

```bash
pnpm install -g markdownlint-cli2
```

## How to use

Create config file

```bash
cp config.yaml.example config.yaml
```

Formatter

```bash
make format
```

Auto Recompile

```bash
make dev
```

Compile Once

```bash
make
```

## Optional `header-includes` parameters

### Remove Space Before/After Paragraph

```latex
\usepackage{titlesec}
\titlespacing*{\section}{0pt}{1.2ex plus 1ex minus .2ex}{0.5ex plus .2ex}
\titlespacing*{\subsection}{0pt}{1ex plus 1ex minus .2ex}{0.3ex plus .2ex}
\titlespacing*{\subsubsection}{0pt}{0.8ex plus 1ex minus .2ex}{0.2ex plus .2ex}
```

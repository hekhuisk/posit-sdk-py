# Name of the project
NAME := posit-sdk

# Command aliases
PIP := pip3
PYTHON := python3

.PHONY:
	build
	clean
	cov
	default
	deps
	fmt
	fix
	install
	lint
	test
	uninstall
	version

# Default target that runs the necessary steps to build the project
default:
	make deps
	make install
	make test
	make lint
	make build

# Target for building the project, which will generate the distribution files in the `dist` directory.
build:
	$(PYTHON) -m build

# Target for cleaning up generated files and directories
clean:
	find . -name "*.egg-info" -exec rm -rf {} +
	find . -name "*.pyc" -exec rm -f {} +
	find . -name "__pycache__" -exec rm -rf {} +
	rm -rf .coverage .mypy_cache .pytest_cache .ruff_cache *.egg-info build dist htmlcov

# Target for generating coverage report
cov:
	$(PYTHON) -m coverage report

# Target for generating HTML coverage report
cov-html:
	$(PYTHON) -m coverage html

# Target for generating XML coverage report
cov-xml:
	$(PYTHON) -m coverage xml

# Target for installing project dependencies
deps:
	$(PIP) install -r requirements.txt -r requirements-dev.txt

# Target for formatting the code.
fmt:
	$(PYTHON) -m ruff format .

# Target for fixing linting issues.
fix:
	$(PYTHON) -m ruff check --fix

# Target for installing the project in editable mode
install:
	$(PIP) install -e .

# Target for running static type checking and linting
lint:
	$(PYTHON) -m mypy --install-types --non-interactive .
	$(PYTHON) -m ruff check

# Target for running tests with coverage
test:
	$(PYTHON) -m coverage run --source=src --omit=_version.py -m pytest

# Target for uninstalling the project
uninstall:
	$(PIP) uninstall -y $(NAME)

# Target for displaying the project version
version:
	$(PYTHON) -m setuptools_scm

# Project settings
PROJECT := ipag
API := api
WEB := web

# Project paths
MODULES := $(wildcard $(API)/*.py)

# MAIN TASKS ##################################################################

.PHONY: all
all: exe

.PHONY: run ## Start the program
run: install
	poetry run python $(API)/__main__.py

# PROJECT DEPENDENCIES ########################################################

.PHONY: install
install: poetry.lock
	poetry config settings.virtualenvs.in-project true
	poetry install
	@ touch $@

poetry.lock: pyproject.toml
	poetry lock
	@ touch $@

.PHONY: web
web:
	cd web && umi build

# CHECKS ######################################################################

.PHONY: format
format: install
	poetry run isort $(API) --recursive --apply
	poetry run black $(API)
	@ echo

# BUILD #######################################################################

EXE_FILES := dist/$(PROJECT).*

.PHONY: exe
# exe: install web .clean-build $(EXE_FILES)
exe: install .clean-build $(EXE_FILES)
$(EXE_FILES): $(MODULES) $(PROJECT).spec
	poetry run pyinstaller $(PROJECT).spec --noconfirm --clean

$(PROJECT).spec: $(MODULES)
	poetry run pyi-makespec $(API)/__main__.py --add-data 'web/dist:www' -D --name=$(PROJECT)

# CLEANUP #####################################################################

.PHONY: clean
clean: .clean-build .clean-install ## Delete all generated and temporary files

.PHONY: .clean-install
.clean-install:
	find $(API) -name '__pycache__' -delete
	rm -rf *.egg-info

.PHONY: .clean-build
.clean-build:
	rm -rf *.spec dist build

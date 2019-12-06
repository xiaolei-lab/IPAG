# OS detection
ifeq ($(OS),Windows_NT)
  POETRY := poetry.bat
  SEP := ;
else
  POETRY := poetry
  SEP := :
endif

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
	$(POETRY) run python $(API)/__main__.py

# PROJECT DEPENDENCIES ########################################################

.PHONY: install
install: poetry.lock
	$(POETRY) config settings.virtualenvs.in-project true
	$(POETRY) install
	@ touch $@

poetry.lock: pyproject.toml
	$(POETRY) lock
	@ touch $@

.PHONY: web
web:
	cd web && umi build

# CHECKS ######################################################################

.PHONY: format
format:
	$(POETRY) run isort $(API) --recursive --apply
	$(POETRY) run black $(API)
	@ echo

# BUILD #######################################################################

EXE_FILES := dist/$(PROJECT).*

.PHONY: exe
# exe: install web .clean-build $(EXE_FILES)
exe: install .clean-build $(EXE_FILES)
$(EXE_FILES): $(MODULES) $(PROJECT).spec
	$(POETRY) run pyinstaller $(PROJECT).spec --noconfirm --clean

$(PROJECT).spec: $(MODULES)
	$(POETRY) run pyi-makespec $(API)/__main__.py --add-data 'web/dist$(SEP)www' -F --name=$(PROJECT)

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

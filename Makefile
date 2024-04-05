export IMAGE_NAME=marketminingpycaret3.azurecr.io/picaret3

# Local development
install:
	python -m venv venv; \
	. venv/bin/activate; \
	pip install --upgrade pip; \
	pip install pre-commit; \
	pip install -e .[interactive]; \
	pre-commit install; \
	git config --bool flake8.strict true; \

formatter:
	black src

help:
	python setup.py --help-commands		

# Continuous Integration
typing: formatter
	mypy src

lint:
	flake8  src

build:
	python setup.py install

test:
	pytest

# Containter

c_build:
	docker build -t ${IMAGE_NAME} .

c_run:
	if [ ! -f .env ]; then \
		docker run -d -p 8000:8000 ${IMAGE_NAME}; \
	else \
		docker run --env-file .env -d -p 8000:8000 ${IMAGE_NAME}; \
	fi

c_push:
	docker push ${IMAGE_NAME}

# Continuous Deployment/Delivery

coverage:
	echo "run coverage"

deploy_staging:
	echo "deploy staging"

deploy_production:
	echo "deploy production"

smoke_test:
	echo "smoke test"	

package: 
	rm -rf dist
	python setup.py sdist --formats=zip

publish: test package 
	twine upload dist/*

# Run

run:
	python src/app.py


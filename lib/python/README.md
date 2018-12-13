heroku buildpacks:add --index 2 heroku/python
heroku config:set PRICE_PREDICTION_ENABLED=true

To use python, add at the root a Pipfile file (see below), the correct .env variable, and remove the 'false' in the 'if' statement in the transaction model

[requires]
python_version = "3.7"

[packages]
pandas = '*'
numpy = '*'
scikit-learn = '*'

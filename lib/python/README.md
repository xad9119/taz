/Users/maximezarka/anaconda3/bin/conda create --name test-la-mort python=3 pandas numpy scikit-learn
/Users/maximezarka/anaconda3/envs/test-la-mort/bin/python lib/python/price_train_predict.py
heroku buildpacks:add -i 1 https://github.com/teamupstart/conda-buildpack.git

heroku buildpacks:add --index 1 heroku/ruby

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

%matplotlib inline

## training

df = pd.read_csv('../../db/python_training.csv', sep=';')
# filtering outliers (> 12ke per sqm)
df = df.loc[df['pricesqm']<12000]
df.head()

def days_from_present(x):
    measureDay = pd.Timestamp('20190101')
    td = pd.to_datetime(x,yearfirst=True) - measureDay
    return td.days

def processing(df):
    # handling dates
    df['date'] = '2000-01-01'
    if type(df) == type(pd.DataFrame()):
        df['date'] = df['date'].apply(days_from_present)
    else:
        df['date'] = days_from_present(df['date'])

    # encoding asset category column
    if type(df) == type(pd.DataFrame()):
        types = ['Housing / Retail', 'Light Industrial', 'Light Industrial / Office', 'Office', 'Retail']
        for t in types:
            df[t] = 0
            df.loc[df['asset_type']==t, t] = 1
        df = df.drop('asset_type', axis=1)
    else:
        types = ['Housing / Retail', 'Light Industrial', 'Light Industrial / Office', 'Office', 'Retail']
        for t in types:
            df[t] = 0
            if df['asset_type']==t: df[t] = 1
        df = df.drop(labels=['asset_type'])

    return(df)

df = processing(df)

from sklearn.base import BaseEstimator, TransformerMixin

class NumberSelector(BaseEstimator, TransformerMixin):
    """
    Transformer to select a single column from the data frame to perform additional transformations on
    Use on numeric columns in the data
    """
    def __init__(self, key):
        self.key = key

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        return X[[self.key]]

from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler

date =  Pipeline([
                ('date', NumberSelector(key='date')),
                ('standard', StandardScaler())
            ])
surface =  Pipeline([
                ('surface', NumberSelector(key='surface')),
                ('standard', StandardScaler())
            ])
latitude =  Pipeline([
                ('latitude', NumberSelector(key='latitude')),
                ('standard', StandardScaler())
            ])
longitutde =  Pipeline([
                ('longitutde', NumberSelector(key='longitutde')),
                ('standard', StandardScaler())
            ])
asset_type_hr =  Pipeline([
                ('asset_type_hr', NumberSelector(key='Housing / Retail'))
            ])
asset_type_li =  Pipeline([
                ('asset_type_li', NumberSelector(key='Light Industrial'))
            ])
asset_type_lio =  Pipeline([
                ('asset_type_lio', NumberSelector(key='Light Industrial / Office'))
            ])
asset_type_o =  Pipeline([
                ('asset_type_o', NumberSelector(key='Office'))
            ])
asset_type_r =  Pipeline([
                ('asset_type_r', NumberSelector(key='Retail'))
            ])

from sklearn.pipeline import FeatureUnion

feats = FeatureUnion([('date', date),
                      ('surface', surface),
                      ('latitude', latitude),
                      ('longitutde', longitutde),
                      ('asset_type_hr', asset_type_hr),
                      ('asset_type_li', asset_type_li),
                      ('asset_type_lio', asset_type_lio),
                      ('asset_type_o', asset_type_o),
                      ('asset_type_r', asset_type_r),
                    ])

feature_processing = Pipeline([('feats', feats)])
feature_processing.fit_transform(df.drop('pricesqm', axis=1))

from sklearn.neighbors import KNeighborsRegressor

model = KNeighborsRegressor(n_neighbors=5)

model.fit(feature_processing.transform(df.drop('pricesqm', axis=1)), np.array(df['pricesqm']))


## predicting

df = pd.read_csv('../../db/python_training.csv', sep=';')
# filtering outliers (> 12ke per sqm)
df = df.loc[df['pricesqm']<12000]

X = pd.read_csv('../../db/python_to_predict.csv', sep=';')
X_ = processing(X)
X_ = feature_processing.transform(X_)

estimate = int(model.predict(X_))
kn = model.kneighbors(X_, n_neighbors=10, return_distance=True)

ids = [x for x in kn[1][0]]
distances = [x for x in kn[0][0]]
estimates = [float(df.iloc[int(x)]['pricesqm']) for x in ids]

ids.insert(0,int(X['id']))
distances.insert(0,np.mean(distances)) # average distance from 10 nearest --> confidence index
estimates.insert(0, estimate)

result = {'id': ids,
          'estimate': estimates,
          'distance': distances
         }
result = pd.DataFrame(data=result)

result.to_csv('../../db/python_predicted.csv', sep=';', index = False)

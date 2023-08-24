import pandas as pd
import dill

df = pd.read_csv('X.csv')

with open('model.dill', 'rb') as handle:
    model = dill.load(handle)

df = model.predict(df.values)
print(df)

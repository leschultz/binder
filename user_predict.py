from madml.hosting.docker import predict
import numpy as np

container_name = 'leschultz/cmg:diffusion'

X = np.loadtxt('X.csv', delimiter=',')

y = predict(X, container_name)
print(y)

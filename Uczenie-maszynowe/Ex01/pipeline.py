import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score



# ex 1
np.random.seed(1)

X = np.arange(1, 101).reshape(-1, 1) 
noise = 5*np.random.randn(100, 1)

y = X + 5 + noise

plt.scatter(X, y)
plt.xlabel("X")
plt.ylabel("y")
plt.title("y = x + 5 + noise")
plt.show()


# ex 2
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)


# ex 3
model = LinearRegression()

model.fit(X_train, y_train)
y_pred = model.predict(X_test)


# ex 4
plt.scatter(X_test, y_test, label='Real values', color='red')
plt.scatter(X_test, y_pred, label='Predicted values', color='blue')
plt.xlabel('X_test')
plt.ylabel('y')
plt.title('Real vs predicted values')
plt.legend()
plt.show()


# ex 5
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
print('Mean Squared Error:', mse)
print('R^2 Score:', r2)

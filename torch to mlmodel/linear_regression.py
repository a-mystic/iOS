import torch
import torch.nn as nn
import torch.nn.functional as F
x_train = torch.FloatTensor([[1,2,3], [2,4,6], [3,6,9]])
y_train = torch.FloatTensor([[6], [12], [18]])
class LinearRegressionModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.linear = nn.Linear(3, 1)

    def forward(self, x):
        return self.linear(x)

model = LinearRegressionModel()
optimizer = torch.optim.SGD(model.parameters(), lr=1e-5) 
nb_epochs = 2000
for epoch in range(nb_epochs+1):

    # H(x) 계산
    prediction = model(x_train)

    # cost 계산
    cost = F.mse_loss(prediction, y_train) # <== 파이토치에서 제공하는 평균 제곱 오차 함수

    # cost로 H(x) 개선하는 부분
    # gradient를 0으로 초기화
    optimizer.zero_grad()
    # 비용 함수를 미분하여 gradient 계산
    cost.backward() # backward 연산
    # W와 b를 업데이트
    optimizer.step()
exmaple_input = torch.rand([3])
traced = torch.jit.trace(model,exmaple_input)
import coremltools as ct 
model = ct.convert(traced,inputs=[ct.TensorType(shape=exmaple_input.shape)])
model.save("lineartest.mlmodel")
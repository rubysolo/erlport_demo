import torch
import torchvision
import torch.nn as nn
import torch.nn.functional as F

torch.backends.cudnn.enabled = False

# image preprocessor
normalizer = torchvision.transforms.Compose([
                               torchvision.transforms.ToTensor(),
                               torchvision.transforms.Normalize(
                                 (0.1307,), (0.3081,))
                             ])

# network architecture
class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(1, 10, kernel_size=5)
        self.conv2 = nn.Conv2d(10, 20, kernel_size=5)
        self.conv2_drop = nn.Dropout2d()
        self.fc1 = nn.Linear(320, 50)
        self.fc2 = nn.Linear(50, 10)

    def forward(self, x):
        x = F.relu(F.max_pool2d(self.conv1(x), 2))
        x = F.relu(F.max_pool2d(self.conv2_drop(self.conv2(x)), 2))
        x = x.view(-1, 320)
        x = F.relu(self.fc1(x))
        x = F.dropout(x, training=self.training)
        x = self.fc2(x)
        return F.log_softmax(x, dim=1)

# build a network and initialize weights from file
def hydrate(weights_path):
    network = Net()
    network_state_dict = torch.load(weights_path)
    network.load_state_dict(network_state_dict)
    network.eval()
    return network

# given a network and an input tensor, return the predicted digit
def predict(model, input_tensor):
    with torch.no_grad():
        output = model(input_tensor)
        pred = output.data.max(1, keepdim=True)[1][0]
        return pred[0].item()

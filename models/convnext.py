from torchvision import models
import torch.nn as nn
import torch

class convnext_base(nn.Module):
    def __init__(self):
        super().__init__()
        backbone =  models.convnext_base(pretrained=True)
        self.features = backbone.features

    def forward(self, x):
        x = self.features(x)
        x = nn.functional.adaptive_avg_pool2d(x, (1, 1))
        x = torch.flatten(x, 1)
        return x


# model = convnext_base()
# input = torch.randn((2,3,256,256))
# output = model(input)
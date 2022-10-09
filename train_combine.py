import h5py
from datasets.dataset_h5 import Dataset_All_Bags, Whole_Slide_Bag_FP
import argparse
import openslide
from models.resnet_custom import resnet50_baseline
import os
from torch.utils.data import DataLoader
import torch
import numpy as np

parser = argparse.ArgumentParser(description='Feature Extraction')
parser.add_argument('--data_h5_dir', type=str, default='20220511')
parser.add_argument('--data_slide_dir', type=str, default='/media/user/data/CPTAC-LUAD/train')
parser.add_argument('--slide_ext', type=str, default= '.svs')
parser.add_argument('--feat_dir', type=str, default=None)
parser.add_argument('--batch_size', type=int, default=100)
parser.add_argument('--no_auto_skip', default=False, action='store_true')
parser.add_argument('--custom_downsample', type=int, default=1)
parser.add_argument('--target_patch_size', type=int, default=-1)
args = parser.parse_args()

model = resnet50_baseline(pretrained=True)
model = model.cuda()
h5_file_list = os.listdir(os.path.join(args.data_h5_dir, 'patches'))
slide_number=len(h5_file_list)
def collate_features(batch):
	img = torch.cat([item[0] for item in batch], dim = 0)
	coords = np.vstack([item[1] for item in batch])
	return [img, coords]

i=0
# for i in range(slide_number):
h5_file_path = os.path.join(args.data_h5_dir, 'patches', h5_file_list[i])
slide_id=h5_file_list[i].split('.')[0]
slide_file_path = os.path.join(args.data_slide_dir, slide_id + args.slide_ext)    
wsi = openslide.open_slide(slide_file_path)
dataset = Whole_Slide_Bag_FP(file_path=h5_file_path, wsi=wsi, pretrained=True, 
    custom_downsample=args.custom_downsample, target_patch_size=args.target_patch_size)

loader = DataLoader(dataset=dataset, batch_size=args.batch_size, num_workers=8, pin_memory=True, collate_fn=collate_features)
results=None
for count, (batch, coords) in enumerate(loader):
    batch=batch.cuda()
    features = model(batch)
    print(count*100)
    if results==None:
        results=features.cpu()
    else:
        results=torch.cat((results,features.cpu()),0)
        print(results.shape)
results.unsqueeze(0)
print('finsh!')
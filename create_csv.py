import os

files=os.listdir('20220503_feat/pt_files')

fconv = open('breastcancer.csv', 'w')
fconv.write('case_id,slide_id,label\n')
fconv.close()

for i in range(len(files)):
    case_id='patient_'+str(i)
    slide_id=files[i].split('.')[0]
    classes=files[i].split('.')[0].split('_')[0]
    if classes=='normal':
        label='normal_tissue'
    else:
        label='tumor_tissue'
    fconv = open('breastcancer.csv', 'a')
    fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
    fconv.close()


import csv
fconv = open('test.csv', 'w')
fconv.write('case_id,slide_id,label\n')
fconv.close()
with open('reference.csv') as f:
    f_csv=csv.reader(f)
    # headers=next(f_csv)
    i=0
    for row in f_csv:
        # print(row)
        case_id='patient_'+str(i)
        slide_id=row[0]
        classes=row[1]
        if classes=='Normal':
            label='normal_tissue'
        else:
            label='tumor_tissue'
        fconv = open('test.csv', 'a')
        fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
        fconv.close()
        i=i+1


import csv
fconv = open('test1.csv', 'w')
fconv.close()
with open('test.csv') as f:
    f_csv=csv.reader(f)
    for row in f_csv:
        slide_id=row[1]
        label=row[2]
        fconv = open('test1.csv', 'a')
        fconv.write('{},{}\n'.format(slide_id,label))
        fconv.close()



import csv
with open('reference.csv') as f:
    f_csv=csv.reader(f)
    # headers=next(f_csv)
    i=270
    for row in f_csv:
        # print(row)
        case_id='patient_'+str(i)
        slide_id=row[0]
        classes=row[1]
        if classes=='Normal':
            label='normal_tissue'
        else:
            label='tumor_tissue'
        fconv = open('1617.csv', 'a')
        fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
        fconv.close()
        i=i+1

import csv
with open('stage_labels.csv') as f:
    f_csv=csv.reader(f)
    i=0
    for row in f_csv:
        if i!=0 and row[0].split('.')[1]=='tif':
            slide_id=row[0].split('.')[0]
            case_id='patient_'+str(i+397)
            # print(case_id)
            classes=row[1]
            if classes=='negative':
                label='normal_tissue'
            else:
                # print(classes)
                label='tumor_tissue'            
            fconv = open('1617.csv', 'a')
            fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
            fconv.close()
        i=i+1


import shutil
import csv
path1='1617_20x/pt_files/'
path2='1617_20x/itc/'
path3='1617_20x/others/'
num=0
with open('stage_labels.csv') as f:
    f_csv=csv.reader(f)
    for row in f_csv:
        slide_id=row[0].split('.')[0]
        print(slide_id)
        if row[1]=='itc':
            # print(row[0])
            shutil.move(path1+slide_id+'.pt',path2+slide_id+'.pt')
            num=num+1
        elif row[1]=='negative' or row[1]=='micro' or row[1]=='macro':
            # print(row)
            shutil.move(path1+slide_id+'.pt',path3+slide_id+'.pt')
            num=num+1
print(num)


import os
path='1617_20x/pt_files'
path3='1617_20x/others/'
file_list=os.listdir(path)
for i in file_list:
    if i[:-3].split('_')[-1]=='0.5' or i[:-3].split('_')[-1]=='1.5':
        continue
    else:
        shutil.move(path+'/'+i,path3+i)


import csv
import os
path='1617_20x/others'
file_list=os.listdir(path)
id=[i.split('.')[0] for i in file_list]
i=0
fconv = open('1617_itc_remove.csv', 'w')
fconv.write('case_id,slide_id,label\n')
fconv.close()
with open('1617_raw.csv') as f:
    f_csv=csv.reader(f)
    for row in f_csv:
        if row[1] in id:
            # print(row[1])
            case_id='patient_'+str(i)
            slide_id, label=row[1], row[2]
            fconv = open('1617_itc_remove.csv', 'a')
            fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
            fconv.close()
            i=i+1


##### 20220815
import csv
import os

tcga_luad_path=os.listdir('lung_512/tcga_luad_1024_feat/h5_files')

i=1060
for j in tcga_luad_path:
    case_id='patient_'+str(i)
    slide_id=j[:-3]
    label='tumor_tissue'
    fconv = open('dataset_csv/luad_817.csv', 'a')
    fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
    fconv.close()
    i=i+1

cptac_lscc_normal_path=os.listdir('lung_512/cptac_lscc_512_feat/h5_files')
fconv = open('dataset_csv/luad_817.csv', 'a')
i=1600
for j in cptac_lscc_normal_path:
    case_id='patient_'+str(i)
    slide_id=j[:-3]
    label='normal_tissue'
    fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
    i=i+1

fconv.close()


##### 20221031  lung256
import csv
import os

cptac_luad_path = 'lung256/cptac_luad_feat/h5_files'
file_list = os.listdir(cptac_luad_path)
file_list1=[ i.split('.')[0] for i in file_list]
file_list1.sort()
fconv = open('dataset_csv/lung256_1031.csv', 'w')
fconv.write('case_id,slide_id,label\n')
fconv.close()
i=0
with open('luad.csv') as f:
    f_csv=csv.reader(f)
    fconv = open('dataset_csv/lung256_1031.csv', 'a')
    for row in f_csv:
        if row[1] in file_list1:
            case_id='patient_'+str(i)
            slide_id=row[1]
            label=row[2]
            i=i+1
            fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
    fconv.close()
                

tcga_luad_path=os.listdir('lung256/tcga_luad_feat/h5_files')

i=1055
fconv = open('dataset_csv/lung256_1031.csv', 'a')
for j in tcga_luad_path:
    case_id='patient_'+str(i)
    slide_id=j[:-3]
    label='tumor_tissue'
    fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
    i=i+1
fconv.close()


cptac_lscc_normal_path=os.listdir('lung256/cptac_lscc_feat/h5_files')
fconv = open('dataset_csv/lung256_1031.csv', 'a')
i=1595
for j in cptac_lscc_normal_path:
    case_id='patient_'+str(i)
    slide_id=j[:-3]
    label='normal_tissue'
    fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
    i=i+1

fconv.close()
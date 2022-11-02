import pyvips
import openslide
import os

def convert(img_path, save_path):
    image = pyvips.Image.new_from_file(img_path, access='sequential')
    image.tiffsave(save_path,tile=True,tile_width=256,tile_height=256,pyramid=True,compression='deflate')


path='heatmap_generate/luad_test/weixing'
file_list=os.listdir(path)
for i in file_list:
    path1= path +'/'+i
    path2= path +'/'+i.split('.')[0]+'.tif'
    print(path1,path2)
    convert(path1,path2)



# img_path='1.tif'
# slide=openslide.OpenSlide(img_path)
# slide.level_dimensions
# img=slide.read_region((0, 0), 1, slide.level_dimensions[1])
# img.save('11.jpg')

import csv
fconv = open('test2.csv', 'w')
fconv.write('case_id,slide_id,label\n')
fconv.close()
for i in range(len(file_list)):
    case_id='patient_'+str(i)
    slide_id=file_list[i].split('.')[0]
    label='normal_tissue'
    fconv = open('test2.csv', 'a')
    fconv.write('{},{},{}\n'.format(case_id,slide_id,label))
    fconv.close()


import csv
import os
fconv = open('heatmap_generate/lab_test/process_lists/vs.csv', 'w')
fconv.write('slide_id,label\n')
fconv.close()
path='heatmap_generate/lab_test/vs'
file_list=os.listdir(path)
for i in range(len(file_list)):
    slide_id=file_list[i].split('.')[0]
    label='tumor_tissue'
    fconv = open('heatmap_generate/lab_test/process_lists/vs.csv', 'a')
    fconv.write('{},{}\n'.format(slide_id,label))
    fconv.close()
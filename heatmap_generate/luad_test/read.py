import os
import csv

files=os.listdir('heatmap_generate/luad_test/weixing')

fconv = open('heatmap_generate/luad_test/process_lists/weixing.csv', 'w')
fconv.write('slide_id,label\n')
fconv.close()

fconv = open('heatmap_generate/luad_test/process_lists/weixing.csv', 'a')
for i in range(len(files)):
    slide_id=files[i].split('.')[0]
    label='tumor_tissue'
    fconv.write('{},{}\n'.format(slide_id,label))

fconv.close()
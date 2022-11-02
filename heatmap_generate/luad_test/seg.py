import openslide
import numpy as np
import cv2

wsi=openslide.open_slide('heatmap_generate/luad_test/weixing/H029_P1_D1_S1(NQ)_(2)_10X_V2_AF_Reg_sat_20_170_vHE_new.tif')
print(wsi.level_dimensions)
print(wsi.level_count)
# img = np.array(wsi.read_region((0,0), 3, wsi.level_dimensions[3]))
# img_hsv = cv2.cvtColor(img, cv2.COLOR_RGB2HSV)
# img_med = cv2.medianBlur(img_hsv[:,:,1], 11)
# cv2.imwrite('1.jpg',img_hsv)
# cv2.imwrite('2.jpg',img_med)
# _, img_otsu = cv2.threshold(img_med, -1, 255, cv2.THRESH_BINARY)
# cv2.imwrite('3.jpg',img_otsu)
# close=2
# kernel = np.ones((close, close), np.uint8)
# img_otsu = cv2.morphologyEx(img_otsu, cv2.MORPH_CLOSE, kernel) 
# cv2.imwrite('4.jpg',img_otsu)  
# contours, hierarchy = cv2.findContours(img_otsu, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)
# hierarchy = np.squeeze(hierarchy, axis=(0,))[:, 2:]
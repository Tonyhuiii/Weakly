python create_patches_fp.py --source /media/user/CAMELYON16 --save_dir 16_20x --patch_size 256 --preset tcga.csv --patch_level 1 --seg --patch  

/media/user/CAMELYON17/training/slides


CUDA_VISIBLE_DEVICES=0,1 python extract_features_fp.py --data_h5_dir 16_20x --data_slide_dir /media/user/CAMELYON16 --csv_path 16_20x/process_list_autogen.csv --feat_dir 16_20x_feat --batch_size 256 --slide_ext .tif


python create_splits_seq.py --task task_1_tumor_vs_normal --seed 1 --label_frac 1 --k 10


CUDA_VISIBLE_DEVICES=0 python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_tumor_vs_normal_CLAM_1617_20x --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_1617_20x


tensorboard --logdir=results/task_1_tumor_vs_normal_CLAM_luad_s1/0


CUDA_VISIBLE_DEVICES=1 python eval.py --drop_out --k 10 --models_exp_code results/task_1_tumor_vs_normal_CLAM_1617_20x_s1 --save_exp_code task_1_tumor_vs_normal_CLAM_20x --task task_1_tumor_vs_normal --model_type clam_sb --results_dir ./ --data_root_dir ./  --split all



CUDA_VISIBLE_DEVICES=2,3 python extract_features_fp.py --data_h5_dir 1617_20x --data_slide_dir /media/user/CAMELYON1617 --csv_path 1617_raw.csv --feat_dir 1617_20x_feat --batch_size 128 --slide_ext .tif


##### 10x
python create_patches_fp.py --source /media/user/CAMELYON1617 --save_dir 1617_10x --patch_size 256 --preset tcga.csv --patch_level 2 --seg --patch 


##### 20220824
python create_patches_fp.py --source /media/user/CAMELYON1617 --save_dir 1617_20x --patch_size 256 --preset bwh_biopsy.csv --patch_level 1 --seg --patch 
CUDA_VISIBLE_DEVICES=3 python extract_features_fp.py --data_h5_dir 1617_20x --data_slide_dir /media/user/CAMELYON1617 --csv_path 1617_20x/process_list_autogen.csv --feat_dir 1617_20x_feat --batch_size 128 --slide_ext .tif

python create_patches_fp.py --source heatmap_generate/lab_test/train/biopsy --save_dir biopsy_20x --patch_size 256 --preset bwh_biopsy.csv --patch_level 0 --seg --patch 
CUDA_VISIBLE_DEVICES=3 python extract_features_fp.py --data_h5_dir biopsy_20x --data_slide_dir heatmap_generate/lab_test/train/biopsy --csv_path biopsy_20x/process_list_autogen.csv --feat_dir biopsy_20x_feat --batch_size 128 --slide_ext .tif

CUDA_VISIBLE_DEVICES=3 python main.py --drop_out --early_stopping --lr 2e-4 --k_start 0 --k_end 1 --label_frac 1 --exp_code 1617_20x_add3 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_1617_20x

##### 20220825
python create_patches_fp.py --source /media/user/CAMELYON1617 --save_dir 1617_20x_512 --patch_size 512 --step_size 512 --preset bwh_biopsy.csv --patch_level 1 --seg --patch 
CUDA_VISIBLE_DEVICES=3 python extract_features_fp.py --data_h5_dir 1617_20x_512 --data_slide_dir /media/user/CAMELYON1617 --csv_path 1617_20x_512/process_list_autogen.csv --feat_dir 1617_20x_512_feat --batch_size 128 --slide_ext .tif

python create_patches_fp.py --source heatmap_generate/lab_test/train/biopsy --save_dir biopsy_20x_512 --patch_size 512 --step_size 512 --preset bwh_biopsy.csv --patch_level 0 --seg --patch 
CUDA_VISIBLE_DEVICES=2 python extract_features_fp.py --data_h5_dir biopsy_20x_512 --data_slide_dir heatmap_generate/lab_test/train/biopsy --csv_path biopsy_20x_512/process_list_autogen.csv --feat_dir biopsy_20x_512_feat --batch_size 128 --slide_ext .tif

CUDA_VISIBLE_DEVICES=2 python main.py --drop_out --early_stopping --lr 2e-4 --k_start 0 --k_end 1 --label_frac 1 --exp_code 1617_20x_512 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_1617_20x
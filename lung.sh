python create_patches_fp.py --source /media/user/data/CPTAC-LUAD/train --save_dir 20220511 --patch_size 256 --preset tcga.csv --patch_level 1 --seg --patch  


CUDA_VISIBLE_DEVICES=1,2 python extract_features_fp.py --data_h5_dir 20220511 --data_slide_dir /media/user/data/CPTAC-LUAD/train --csv_path 20220511/process_list_autogen.csv --feat_dir 20220511_feat --batch_size 1024 --slide_ext .svs


python create_splits_seq.py --task task_1_tumor_vs_normal --seed 1 --label_frac 1 --k 10


CUDA_VISIBLE_DEVICES=0 python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_tumor_vs_normal_CLAM_luad --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad


tensorboard --logdir=results/task_1_tumor_vs_normal_CLAM_luad_s1/0



CUDA_VISIBLE_DEVICES=1 python eval.py --drop_out --k 10 --models_exp_code task_1_tumor_vs_normal_CLAM_luad_s1 --save_exp_code task_1_tumor_vs_normal_CLAM_luad --task task_1_tumor_vs_normal --model_type clam_sb --results_dir results --data_root_dir ./  --split all


python create_patches_fp.py --source /media/user/data/CPTAC-LUAD/train --save_dir cptac_luad --patch_size 256 --preset bwh_biopsy.csv --patch_level 0 --seg --patch  

CUDA_VISIBLE_DEVICES=1,2 python extract_features_fp.py --data_h5_dir 20220511 --data_slide_dir /media/user/data/CPTAC-LUAD/train --csv_path 20220511/process_list_autogen.csv --feat_dir tcga_feat_20x --batch_size 256 --slide_ext .svs

CUDA_VISIBLE_DEVICES=0 python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_2_tumor_subtyping_lung --weighted_sample --bag_loss ce --inst_loss svm --task task_2_tumor_subtyping --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_2_tumor_subtyping_100_lung  --subtyping

##### 2022.8.11
python create_patches_fp.py --source /media/user/TCGA_lung/TCGA-LUAD-slides --save_dir 812_512_tcga_luad --patch_size 512 --preset bwh_biopsy.csv --patch_level 0 --seg --patch  

python extract_features_fp.py --data_h5_dir 812_512_tcga_luad --data_slide_dir /media/user/TCGA_lung/TCGA-LUAD-slides --csv_path 812_512_tcga_luad/process_list_autogen.csv --feat_dir 812_512_tcga_luad_feat --batch_size 1024 --slide_ext .svs  --custom_downsample 2

CUDA_VISIBLE_DEVICES=0 python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_luad_815 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_815

##### 2022.8.15
python create_patches_fp.py --source /media/user/data/CPTAC-LUAD/train --save_dir cptac_luad_512 --patch_size 512 --step_size 512 --preset bwh_biopsy.csv --patch_level 0 --seg --patch
CUDA_VISIBLE_DEVICES=1  python extract_features_fp.py --data_h5_dir cptac_luad_512 --data_slide_dir /media/user/data/CPTAC-LUAD/train --csv_path cptac_luad_512/process_list_autogen.csv --feat_dir cptac_luad_512_feat --batch_size 128 --slide_ext .svs

python create_patches_fp.py --source /media/user/TCGA_lung/TCGA-LUAD-slides --save_dir tcga_luad_1024 --patch_size 1024 --step_size 1024 --preset bwh_biopsy.csv --patch_level 0 --seg --patch
CUDA_VISIBLE_DEVICES=2  python extract_features_fp.py --data_h5_dir tcga_luad_1024 --data_slide_dir /media/user/TCGA_lung/TCGA-LUAD-slides --csv_path tcga_luad_1024/process_list_autogen.csv --feat_dir tcga_luad_1024_feat --batch_size 32 --slide_ext .svs  --custom_downsample 2

python create_patches_fp.py --source /media/user/data/CPTAC-LSCC/normal --save_dir cptac_lscc_512 --patch_size 512 --step_size 512 --preset bwh_biopsy.csv --patch_level 0 --seg --patch
CUDA_VISIBLE_DEVICES=0  python extract_features_fp.py --data_h5_dir cptac_lscc_512 --data_slide_dir /media/user/data/CPTAC-LSCC/normal --csv_path cptac_lscc_512/process_list_autogen.csv --feat_dir cptac_lscc_512_feat --batch_size 64 --slide_ext .svs

CUDA_VISIBLE_DEVICES=0 python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_luad_512 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_512 --B 3


CUDA_VISIBLE_DEVICES=2  python extract_features_fp.py --data_h5_dir lung_512/cptac_luad_512 --data_slide_dir /media/user/data/CPTAC-LUAD/train --csv_path lung_512/cptac_luad_512/process_list_autogen.csv --feat_dir lung_512/cptac_luad_512_feat_convnext --batch_size 128 --slide_ext .svs
CUDA_VISIBLE_DEVICES=3  python extract_features_fp.py --data_h5_dir lung_512/tcga_luad_1024 --data_slide_dir /media/user/TCGA_lung/TCGA-LUAD-slides --csv_path lung_512/tcga_luad_1024/process_list_autogen.csv --feat_dir lung_512/tcga_luad_1024_feat_convnext --batch_size 16 --slide_ext .svs   --custom_downsample 2
CUDA_VISIBLE_DEVICES=1  python extract_features_fp.py --data_h5_dir lung_512/cptac_lscc_512 --data_slide_dir /media/user/data/CPTAC-LSCC/normal --csv_path lung_512/cptac_lscc_512/process_list_autogen.csv --feat_dir lung_512/cptac_lscc_512_feat_convnext --batch_size 64 --slide_ext .svs
CUDA_VISIBLE_DEVICES=0 python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_luad_512_convnext --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_512 --B 3

##### 20220831
python create_patches_fp.py --source /media/user/data/CPTAC-LUAD/train --save_dir lung_256/cptac_luad --patch_size 256 --step_size 256 --preset bwh_biopsy.csv --patch_level 0 --seg --patch
CUDA_VISIBLE_DEVICES=2  python extract_features_fp.py --data_h5_dir lung_256/cptac_luad --data_slide_dir /media/user/data/CPTAC-LUAD/train --csv_path lung_256/cptac_luad/process_list_autogen.csv --feat_dir lung_256/cptac_luad_feat --batch_size 128 --slide_ext .svs
python create_patches_fp.py --source /media/user/TCGA_lung/TCGA-LUAD-slides --save_dir lung_256/tcga_luad --patch_size 512 --step_size 512 --preset bwh_biopsy.csv --patch_level 0 --seg --patch
CUDA_VISIBLE_DEVICES=2  python extract_features_fp.py --data_h5_dir lung_256/tcga_luad --data_slide_dir /media/user/TCGA_lung/TCGA-LUAD-slides --csv_path lung_256/tcga_luad/process_list_autogen.csv --feat_dir lung_256/tcga_luad_feat --batch_size 32 --slide_ext .svs  --custom_downsample 2
python create_patches_fp.py --source /media/user/data/CPTAC-LSCC/normal --save_dir lung_256/cptac_lscc --patch_size 256 --step_size 256 --preset bwh_biopsy.csv --patch_level 0 --seg --patch
CUDA_VISIBLE_DEVICES=2  python extract_features_fp.py --data_h5_dir lung_256/cptac_lscc --data_slide_dir /media/user/data/CPTAC-LSCC/normal --csv_path lung_256/cptac_lscc/process_list_autogen.csv --feat_dir lung_256/cptac_lscc_feat --batch_size 128 --slide_ext .svs

CUDA_VISIBLE_DEVICES=2 python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_luad_256 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_815 --B 4

CUDA_VISIBLE_DEVICES=2 python main.py --drop_out --early_stopping --lr 2e-4 --k_start 0 --k_end 1 --label_frac 1 --exp_code task_1_luad_256_8 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_815 --B 4

CUDA_VISIBLE_DEVICES=2 python main.py --drop_out --early_stopping --lr 2e-4 --k_start 0 --k_end 1 --label_frac 1 --exp_code task_1_luad_256_4 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_512 --B 4

##### 20220914
python create_patches_fp.py --source /media/user/data/CPTAC-LUAD/train --save_dir lung_test/cptac_luad --patch_size 512 --step_size 512 --preset 20220914.csv --patch_level 0 --seg --patch
python create_patches_fp.py --source /media/user/TCGA_lung/TCGA-LUAD-slides --save_dir lung_test/tcga_luad --patch_size 1024 --step_size 1024 --preset 20220914.csv --patch_level 0 --seg --patch
python create_patches_fp.py --source /media/user/data/CPTAC-LSCC/normal --save_dir lung_test/cptac_lscc --patch_size 512 --step_size 512 --preset 20220914.csv --patch_level 0 --seg --patch

CUDA_VISIBLE_DEVICES=0  python extract_features_fp.py --data_h5_dir lung_test/cptac_luad --data_slide_dir /media/user/data/CPTAC-LUAD/train --csv_path lung_test/cptac_luad/process_list_autogen.csv --feat_dir lung_test/cptac_luad_feat --batch_size 128 --slide_ext .svs
CUDA_VISIBLE_DEVICES=1  python extract_features_fp.py --data_h5_dir lung_test/cptac_lscc --data_slide_dir /media/user/data/CPTAC-LSCC/normal --csv_path lung_test/cptac_lscc/process_list_autogen.csv --feat_dir lung_test/cptac_lscc_feat --batch_size 128 --slide_ext .svs
CUDA_VISIBLE_DEVICES=2  python extract_features_fp.py --data_h5_dir lung_test/tcga_luad --data_slide_dir /media/user/TCGA_lung/TCGA-LUAD-slides --csv_path lung_test/tcga_luad/process_list_autogen.csv --feat_dir lung_test/tcga_luad_feat --batch_size 32 --slide_ext .svs  --custom_downsample 2

CUDA_VISIBLE_DEVICES=2  python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_luad_test --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_test --B 4

##### 20220929
python create_patches_fp.py --source lung_512/lab_add --save_dir lung_test/lab_4 --patch_size 512 --step_size 512 --preset 20220914.csv --patch_level 0 --seg --patch
CUDA_VISIBLE_DEVICES=0  python extract_features_fp.py --data_h5_dir lung_test/lab_4 --data_slide_dir lung_512/lab_add  --csv_path lung_test/lab_4/process_list_autogen.csv --feat_dir lung_test/lab4_512_feat --batch_size 128 --slide_ext .tif
CUDA_VISIBLE_DEVICES=0 python main.py --drop_out --early_stopping --lr 2e-4 --k_start 0 --k_end 1 --label_frac 1 --exp_code task_1_luad_test_4 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_luad_512 --B 4

##### 20221007
python create_patches_fp.py --source heatmap_generate/luad_test/zesis --save_dir 20221003 --patch_size 512 --step_size 512 --preset 202201007_zesis.csv --patch_level 0 --seg --patch

##### 20221028
python create_patches_fp.py --source /media/user/data/CPTAC-LUAD/train --save_dir lung256/cptac_luad --patch_size 256 --step_size 256 --preset 1028_lung.csv --patch_level 0 --seg --patch
python create_patches_fp.py --source /media/user/TCGA_lung/TCGA-LUAD-slides --save_dir lung256/tcga_luad --patch_size 512 --step_size 512 --preset 1028_lung.csv --patch_level 0 --seg --patch
python create_patches_fp.py --source /media/user/data/CPTAC-LSCC/normal --save_dir lung256/cptac_lscc --patch_size 256 --step_size 256 --preset 1028_lscc.csv --patch_level 0 --seg --patch

CUDA_VISIBLE_DEVICES=0  python extract_features_fp.py --data_h5_dir lung256/cptac_luad --data_slide_dir /media/user/data/CPTAC-LUAD/train --csv_path lung256/cptac_luad/1.csv --feat_dir lung256/cptac_luad_feat --batch_size 128 --slide_ext .svs
CUDA_VISIBLE_DEVICES=1  python extract_features_fp.py --data_h5_dir lung256/cptac_lscc --data_slide_dir /media/user/data/CPTAC-LSCC/normal --csv_path lung256/cptac_lscc/1.csv --feat_dir lung256/cptac_lscc_feat --batch_size 128 --slide_ext .svs
CUDA_VISIBLE_DEVICES=2  python extract_features_fp.py --data_h5_dir lung256/tcga_luad --data_slide_dir /media/user/TCGA_lung/TCGA-LUAD-slides --csv_path lung256/tcga_luad/1.csv --feat_dir lung256/tcga_luad_feat --batch_size 32 --slide_ext .svs  --custom_downsample 2

python create_splits_seq.py --task task_1_tumor_vs_normal --seed 1 --label_frac 1 --k 10

CUDA_VISIBLE_DEVICES=0  python main.py --drop_out --early_stopping --lr 2e-4 --k 10 --label_frac 1 --exp_code task_1_lung256 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir ./ --split_dir task_1_tumor_vs_normal_100_lung256 --B 8
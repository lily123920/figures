rm(list = ls())

## ①使用聚类的seurat对象，建议提高resolution展示
load("./3_聚类/sce_all_cluster.RData")
sce <- sce_all_cluster #数据备份

## ②用于注释的maker基因list
mar_lym <- c("CD3G","CD3D", "CD3E")
mar_T <- c("NCAM1", "SELL","CD38")
mar_CD4_T <- "CD4"
mar_CD8_T <- c("CD8A", "CD8B")
mar_activity <- c("HLA-DRA","HLA-DRB1","HLA-DRB5","CD27")
mar_B <- c("ITGAM","MRC1")
mar_mac <- c("ITGAX", "CD14",  "THBD", 
             "CD33","FCGR1A", 
             "CD24")
genes_to_check <- list(lym = mar_lym, 
                       T = mar_T, 
                       CD4 =mar_CD4_T, 
                       CD8 =mar_CD8_T, 
                       act = mar_activity,
                       B = mar_B, 
                       mac = mar_mac)
genes_to_check

## check指定细胞团体按照指定identy分组的marker基因表达结果
#table(sce$RNA_snn_res.2)
active.idents <- "RNA_snn_res.2"  # 指定seurat对象的活跃identity
idents = c(5,19,7,8,2,16,3)   # 指定分析的细胞群体 
group.by = "RNA_snn_res.2"   # 指定细胞群体分组标准
levels(Idents(sce))
Idents(sce) <-  sce@meta.data[,active.idents]
levels(Idents(sce))

# 绘制dotplot图
DotPlot(sce, 
        idents = idents,            # 用于分析的细胞群体
        group.by = group.by,        # 基因分组计算标准
        features = genes_to_check,  #一定是基因列表
        scale = T
        ) + 
  ggtitle(group.by) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))








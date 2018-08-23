### data cleaning, agreement and adjudication ###

### import Y15 reads from George and Yuka ###
gy_reads_pre = read_excel("data/raw_data/CARDIA Year 15 adjudication.xlsx")
gy_reads = gy_reads_pre %>% distinct(SID, .keep_all = TRUE)

### calculate kappa between george and yuka ###
gy_CLE = gy_reads %>% select(CLE1,CLE2)
agree(gy_CLE, tolerance=0)
kappa2(gy_CLE)

gy_PSE = gy_reads %>% select(PSE1,PSE2)
agree(gy_PSE, tolerance = 0)
kappa2(gy_PSE)

gy_any = gy_reads %>% select(anyE1,anyE2)
agree(gy_any, tolerance = 0)
kappa2(gy_PSE)

### import data from Laura regarding those with Y15 and Y25 CT scans
overlap = read_excel("data/raw_data/ids_oney15read.xlsx")
overlap2 = overlap %>% rename(SID=short_id)

### left bind longitudinal overlap with george and yuka data
overlap3 = left_join(overlap2,gy_reads)

### calculate kappa between george and yuka ###
overlap3_CLE = overlap3 %>% select(CLE1,CLE2)
agree(overlap3_CLE, tolerance=0)
kappa2(overlap3_CLE)

overlap3_PSE = overlap3 %>% select(PSE1,PSE2)
agree(overlap3_PSE, tolerance = 0)
kappa2(overlap3_PSE)

overlap3_any = overlap3 %>% select(anyE1,anyE2)
agree(overlap3_any, tolerance = 0)
kappa2(overlap3_any)

### export only those with longitudinal data but including reads ###
write_csv(select(overlap3,-disagree),"data/raw_data/CARDIA_Y15_visual_2018_08_23.csv")

############################################after adjudication###########################

### import adjudicated file 
gys_reads = read_csv("data/raw_data/CARDIA_Y15_visual_3_readers_2018_08_23.csv")

### calculate kappa between george and sam ###
gs_CLE = gys_reads %>% select(CLE1,CLE3)
agree(gs_CLE, tolerance=0)
kappa2(gs_CLE)

gs_PSE = gys_reads %>% select(PSE1,PSE3)
agree(gs_PSE, tolerance = 0)
kappa2(gs_PSE)

gs_any = gys_reads %>% select(anyE1,anyE3)
agree(gs_any, tolerance = 0)
kappa2(gs_PSE)

### calculate kappa between yuka and sam ###
ys_CLE = gys_reads %>% select(CLE2,CLE3)
agree(ys_CLE, tolerance=0)
kappa2(ys_CLE)

ys_PSE = gys_reads %>% select(PSE2,PSE3)
agree(ys_PSE, tolerance = 0)
kappa2(ys_PSE)

ys_any = gys_reads %>% select(anyE2,anyE3)
agree(ys_any, tolerance = 0)
kappa2(ys_PSE)

######### export visual reads #########
y15_final = gys_reads %>% select(SID,CLE3,PSE3) %>% rename(CLE=CLE3,PSE=PSE3)
write_csv(y15_final,"data/raw_data/CARDIA_Y15_visual_final_2018_08_23.csv")

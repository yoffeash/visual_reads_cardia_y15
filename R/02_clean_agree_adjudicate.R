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

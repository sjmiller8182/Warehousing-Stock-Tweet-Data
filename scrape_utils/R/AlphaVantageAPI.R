library(pacman)
p_load(xts, alphavantager, knitr, testthat)


##################################################################
##################################################################
##################################################################
##################################################################
setwd("./NYSE_MACD_Low_15min")

### Needed to rename files in the directory to include an underscore before the stock symbol
library(stringr)
library(stringi)

df <- data.frame(list.files())
df$list.files.. <- sub("(.{0})(.*)", "\\1NYSE\\2", df$list.files..) #insert change between \\1 and \\2 immediately after the {n}th position in string

df$list.files.. <- gsub("NASDAQ", "NYSE", df$list.files..) #insert change between \\1 and \\2 immediately after the {n}th position in string
file.rename(list.files(),df$list.files..) # rename all files based on the above specification
##################################################################
##################################################################
##################################################################
##################################################################




####### You'll need to set up an API key with Alpha Advantage (they're free for this R code)
############## API Keys: https://www.alphavantage.co/support/
##################################################################### check metric on system sleep time
#####################################################################
testit <- function(x)
{
  p1 <- proc.time()
  Sys.sleep(x)
  proc.time() - p1 # The cpu usage should be negligible
}

testit(2.2) # see how long 5 second execution suspension interval truly is
#####################################################################
#####################################################################

########################################################################################################
########################################################################################################
######################################## NASDAQ Symbols below ##########################################
########################################################################################################
########################################################################################################

setwd("./NASDAQ_MACD_Close_15min")

symbolsNASDAQ <- c("AAL", "AAOI", "AAON", "AAPL", "AAWW", "AAXJ", "AAXN", "ABCB", "ABDC", "ABEO", "ABIL", "ABIO", "ABMD", "ABTX", "ABUS", "ACAD", "ACBI", "ACER", "ACGL", "ACGLO", "ACGLP", "ACHC", 
                   "ACHN", "ACHV", "ACIA", "ACIU", "ACIW", "ACLS", "ACMR", "ACNB", "ACOR", "ACRS", "ACRX", "ACST", "ACT", "ACTG", "ACTTU", "ACTTW", "ACWI", "ACWX", "ADAP", "ADBE", "ADES", "ADI", "ADIL", 
                   "ADMA", "ADMP", "ADMS", "ADP", "ADPT", "ADRA", "ADRD", "ADRE", "ADRO", "ADRU", "ADSK", "ADTN", "ADUS", "ADVM", "ADXS", "AEGN", "AEHR", "AEIS", "AEMD", "AERI", "AESE", "AEY", "AEYE", 
                   "AEZS", "AFH", "AFHBL", "AFIN", "AFINP", "AFMD", "AFYA", "AGBAR", "AGBAU", "AGEN", "AGFS", "AGFSW", "AGIO", "AGLE", "AGMH", "AGNC", "AGNCB", "AGNCM", "AGNCN", "AGND", "AGRX", "AGTC", 
                   "AGYS", "AGZD", "AIA", "AIHS", "AIMC", "AIMT", "AINV", "AIQ", "AIRG", "AIRR", "AIRT", "AIRTP", "AIRTW", "AKAM", "AKBA", "AKCA", "AKER", "AKRO", "AKRX", "AKTS", "AKTX", "ALBO", "ALCO", 
                   "ALDR", "ALDX", "ALEC", "ALGN", "ALGRR", "ALGRU", "ALGRW", "ALGT", "ALIM", "ALJJ", "ALKS", "ALLK", "ALLO", "ALLT", "ALNA", "ALNY", "ALOT", "ALPN", "ALRM", "ALRN", "ALRS", "ALSK", 
                   "ALT", "ALTM", "ALTR", "ALTY", "ALXN", "ALYA", "AMAG", "AMAL", "AMAT", "AMBA", "AMBC", "AMCA", "AMCI", "AMCX", "AMD", "AMED", "AMEH", "AMGN", "AMKR", "AMNB", "AMOT", "AMPH", "AMRB", 
                   "AMRH", "AMRK", "AMRN", "AMRS", "AMSC", "AMSF", "AMSWA", "AMTB", "AMTBB", "AMTD", "AMTX", "AMWD", "AMZN", "ANAB", "ANAT", "ANCN", "ANDA", "ANDAU", "ANDAW", "ANDE", "ANGI", "ANGO", 
                   "ANIK", "ANIP", "ANIX", "ANSS", "ANTE", "ANY", "AOBC", "AOSL", "APDN", "APDNW", "APEI", "APEN", "APEX", "APLS", "APLT", "APM", "APOG", "APOP", "APPF", "APPN", "APPS", "APTO", "APTX", 
                   "APVO", "APWC", "APXTU", "APYX", "AQB", "AQMS", "AQST", "ARAV", "ARAY", "ARCB", "ARCC", "ARCE", "ARCT", "ARDS", "ARDX", "AREC", "AREX", "ARGX", "ARKR", "ARLP", "ARNA", "AROW", "ARPO", 
                   "ARQL", "ARTL", "ARTLW", "ARTNA", "ARTW", "ARTX", "ARVN", "ARWR", "ARYAU", "ARYAW", "ASET", "ASFI", "ASLN", "ASMB", "ASML", "ASNA", "ASND", "ASPS", "ASPU", "ASRT", "ASRV", "ASTC", 
                   "ASTE", "ASUR", "ASYS", "ATAI", "ATAX", "ATEC", "ATEX", "ATHE", "ATHX", "ATIF", "ATIS", "ATLC", "ATLO", "ATNI", "ATNX", "ATOM", "ATOS", "ATRA", "ATRC", "ATRI", "ATRO", "ATRS", "ATSG", 
                   "ATVI", "ATXI", "AUB", "AUDC", "AUPH", "AUTL", "AUTO", "AVAV", "AVCO", "AVDL", "AVDR", "AVEO", "AVGO", "AVGR", "AVID", "AVNW", "AVRO", "AVT", "AVXL", "AWRE", "AWSM", "AXAS", "AXDX", 
                   "AXGN", "AXGT", "AXLA", "AXNX", "AXSM", "AXTI", "AY", "AYTU", "AZPN", "AZRX", "BAND", "BANF", "BANR", "BANX", "BASI", "BATRA", "BATRK", "BBBY", "BBCP", "BBGI", "BBH", "BBI", "BBIO", 
                   "BBQ", "BBSI", "BCBP", "BCDA", "BCEL", "BCLI", "BCML", "BCNA", "BCOR", "BCOV", "BCPC", "BCRX", "BCYC", "BDGE", "BDSI", "BEAT", "BECN", "BELFB", "BFC", "BFIN", "BFST", "BGCP", "BGFV", 
                   "BGNE", "BGRN", "BHAT", "BHF", "BHFAL", "BHFAP", "BHTG", "BIB", "BICK", "BIDU", "BIIB", "BILI", "BIMI", "BIOC", "BIOL", "BIOS", "BIS", "BJRI", "BKCC", "BKEP", "BKEPP", "BKNG", "BKSC", 
                   "BKYI", "BL", "BLBD", "BLCM", "BLCN", "BLDP", "BLDR", "BLFS", "BLIN", "BLKB", "BLMN", "BLNK", "BLNKW", "BLPH", "BLRX", "BLU", "BLUE", "BMCH", "BMLP", "BMRA", "BMRC", "BMRN", "BMTC", 
                   "BND", "BNDW", "BNDX", "BNFT", "BNGO", "BNGOW", "BNSO", "BNTC", "BOCH", "BOKF", "BOKFL", "BOLD", "BOMN", "BOOM", "BOSC", "BOTJ", "BOTZ", "BOXL", "BPFH", "BPMC", "BPOP", "BPOPM", 
                   "BPOPN", "BPR", "BPRAP", "BPRN", "BPTH", "BPY", "BPYPO", "BPYPP", "BREW", "BRID", "BRKL", "BRKR", "BRKS", "BROGW", "BRPA", "BRY", "BSET", "BSGM", "BSQR", "BSRR", "BSTC", "BSVN", 
                   "BTAI", "BTEC", "BURG", "BUSE", "BVSN", "BVXV", "BWAY", "BWB", "BWEN", "BWFG", "BWMC", "BWMCW", "BYFC", "BYND", "BYSI", "BZUN", "CAAS", "CAC", "CACC", "CACG", "CAKE", "CALA", "CALM", 
                   "CAMP", "CAMT", "CAPR", "CAR", "CARA", "CARB", "CARE", "CARG", "CARO", "CARV", "CARZ", "CASA", "CASH", "CASI", "CASS", "CASY", "CATB", "CATC", "CATH", "CATM", "CATS", "CATY", "CBAN", 
                   "CBAT", "CBAY", "CBFV", "CBIO", "CBLI", "CBLK", "CBMB", "CBMG", "CBNK", "CBPO", "CBRL", "CBSH", "CBTX", "CCB", "CCBG", "CCCL", "CCD", "CCLP", "CCMP", "CCNE", "CCOI", "CCRC", "CCRN", 
                   "CCXI", "CDC", "CDEV", "CDK", "CDL", "CDLX", "CDMO", "CDMOP", "CDNA", "CDNS", "CDTX", "CDW", "CDXC", "CDXS", "CDZI", "CECE", "CECO", "CELC", "CELG", "CELGZ", "CELH", "CEMI", "CENT", 
                   "CENTA", "CENX", "CERC", "CERN", "CERS", "CETV", "CETX", "CEVA", "CEY", "CEZ", "CFA", "CFB", "CFBI", "CFBK", "CFFAU", "CFFAW", "CFFI", "CFFN", "CFMS", "CFO", "CFRX", "CG", "CGBD", 
                   "CGEN", "CGIX", "CGNX", "CGO", "CHCO", "CHDN", "CHEF", "CHEK", "CHFS", "CHI", "CHKP", "CHMA", "CHMG", "CHNA", "CHNG", "CHNGU", "CHNR", "CHRS", "CHRW", "CHSCL", "CHSCM", "CHSCN", 
                   "CHSCO", "CHSCP", "CHTR", "CHUY", "CHW", "CHY", "CIBR", "CID", "CIDM", "CIFS", "CIGI", "CIH", "CIL", "CINF", "CIVB", "CJJD", "CKPT", "CLAR", "CLBK", "CLBS", "CLCT", "CLDB", 
                   "CLDX", "CLFD", "CLGN", "CLIR", "CLLS", "CLMT", "CLNE", "CLOU", "CLPS", "CLRB", "CLRG", "CLRO", "CLSD", "CLSN", "CLUB", "CLVS", "CLWT", "CLXT", "CMBM", "CMCO", "CMCSA", "CMCT", "CME", 
                   "CMFNL", "CMLS", "CMPR", "CMRX", "CMTL", "CNAT", "CNBKA", "CNCE", "CNCR", "CNET", "CNFR", "CNFRL", "CNMD", "CNOB", "CNSL", "CNST", "CNTY", "CNXN", "COCP", "CODA", "CODX", "COHR", 
                   "COHU", "COKE", "COLB", "COLL", "COLM", "COMM", "COMT", "CONE", "CONN", "COOP", "CORE", "CORT", "CORV", "COST", "COUP", "COWN", "COWNL", "COWNZ", "CPAAU", "CPAH", "CPHC", "CPIX", 
                   "CPLP", "CPRT", "CPRX", "CPSH", "CPSI", "CPSS", "CPST", "CPTA", "CPTAG", "CPTAL", "CRAI", "CRBP", "CREE", "CREG", "CRESY", "CREX", "CRIS", "CRMT", "CRNT", "CRNX", "CRON", "CROX", 
                   "CRSAU", "CRSAW", "CRSP", "CRTO", "CRTX", "CRUS", "CRVL", "CRVS", "CRWD", "CRWS", "CRZO", "CSA", "CSB", "CSBR", "CSCO", "CSF", "CSFL", "CSGP", "CSGS", "CSII", "CSIQ", "CSML", "CSOD", 
                   "CSPI", "CSQ", "CSSE", "CSSEP", "CSTE", "CSTL", "CSTR", "CSWC", "CSWCL", "CSWI", "CSX", "CTAS", "CTBI", "CTG", "CTHR", "CTIC", "CTMX", "CTRC", "CTRE", "CTRM", "CTRN", "CTRP", "CTSH", 
                   "CTSO", "CTWS", "CTXR", "CTXRW", "CTXS", "CUBA", "CUE", "CUI", "CUR", "CUTR", "CVBF", "CVCO", "CVCY", "CVET", "CVGI", "CVGW", "CVLT", "CVLY", "CVTI", "CVV", "CWBR", "CWCO", "CWST", 
                   "CXDC", "CXSE", "CY", "CYAD", "CYAN", "CYBE", "CYBR", "CYCC", "CYCN", "CYOU", "CYRN", "CYRX", "CYRXW", "CYTK", "CZNC", "CZR", "CZWI", "DAIO", "DAKT", "DALI", "DARE", "DAX", "DBVT", 
                   "DBX", "DCAR", "DCIX", "DCOM", "DCPH", "DDIV", "DDMXW", "DDOG", "DEAC", "DEACU", "DEACW", "DENN", "DERM", "DEST", "DFBH", "DFBHW", "DFFN", "DFNL", "DGICA", "DGII", "DGLD", "DGLY", 
                   "DGRE", "DGRS", "DGRW", "DHIL", "DHXM", "DINT", "DIOD", "DISCA", "DISCK", "DISH", "DJCO", "DLHC", "DLPN", "DLPNW", "DLTH", "DLTR", "DMAC", "DMLP", "DMPI", "DMRC", "DMTK", "DMTKW", 
                   "DNBF", "DNJR", "DNKN", "DNLI", "DOCU", "DOGZ", "DOMO", "DOOO", "DORM", "DOVA", "DOX", "DOYU", "DRAD", "DRADP", "DRIO", "DRIV", "DRNA", "DRRX", "DRYS", "DSGX", "DSKE", "DSKEW", 
                   "DSLV", "DSPG", "DSWL", "DTEA", "DTIL", "DTSS", "DUSA", "DVAX", "DVLU", "DVOL", "DVY", "DWAQ", "DWAS", "DWFI", "DWIN", "DWLD", "DWMC", "DWPP", "DWSH", "DWSN", "DWTR", "DXCM", "DXGE", 
                   "DXJS", "DXLG", "DXPE", "DXYN", "DYAI", "DYNT", "DZSI", "EA", "EARS", "EAST", "EBAY", "EBAYL", "EBIX", "EBIZ", "EBMT", "EBSB", "EBTC", "ECHO", "ECOL", "ECOR", "ECPG", "EDAP", "EDIT", 
                   "EDNT", "EDRY", "EDSA", "EDTX", "EDUC", "EEFT", "EEI", "EEMA", "EFAS", "EFBI", "EFOI", "EFSC", "EGAN", "EGBN", "EGLE", "EGOV", "EGRX", "EHTH", "EIDX", "EIGI", "EIGR", "EKSO", "ELGX", 
                   "ELOX", "ELSE", "ELTK", "EMB", "EMCF", "EMCG", "EMIF", "EMKR", "EML", "EMMS", "EMXC", "ENDP", "ENFC", "ENG", "ENLV", "ENOB", "ENPH", "ENSG", "ENT", "ENTA", "ENTG", "ENTX", "ENZL", 
                   "EOLS", "EPAY", "EPIX", "EPSN", "EPZM", "EQ", "EQBK", "EQIX", "EQRR", "ERI", "ERIC", "ERIE", "ERII", "ERYP", "ESBK", "ESCA", "ESEA", "ESGD", "ESGE", "ESGG", "ESGR", "ESGRO", "ESGRP", 
                   "ESGU", "ESLT", "ESPR", "ESQ", "ESSA", "ESTA", "ESTR", "ESTRW", "ESXB", "ETFC", "ETON", "ETSY", "ETTX", "EUFN", "EVBG", "EVER", "EVFM", "EVGN", "EVLO", "EVOK", "EVOL", "EVOP", "EVSI", 
                   "EWBC", "EWZS", "EXAS", "EXC", "EXEL", "EXFO", "EXLS", "EXPCU", "EXPD", "EXPE", "EXPI", "EXPO", "EXTR", "EYE", "EYEG", "EYEGW", "EYEN", "EYES", "EYPT", "EZPW", "FAAR", "FAB", "FAD", 
                   "FALN", "FAMI", "FANG", "FANH", "FARM", "FARO", "FAST", "FAT", "FATE", "FB", "FBIO", "FBIOP", "FBIZ", "FBMS", "FBNC", "FBSS", "FBZ", "FCA", "FCAL", "FCAN", "FCAP", "FCBC", "FCBP", 
                   "FCCO", "FCCY", "FCEF", "FCEL", "FCFS", "FCNCA", "FCSC", "FCVT", "FDBC", "FDEF", "FDIV", "FDT", "FDUS", "FDUSL", "FDUSZ", "FEIM", "FELE", "FEM", "FEMB", "FEMS", "FENC", "FEP", "FEUZ", 
                   "FEX", "FEYE", "FFBC", "FFBW", "FFHL", "FFIC", "FFIN", "FFIV", "FFNW", "FFWM", "FGBI", "FGEN", "FGM", "FHB", "FHK", "FHL", "FIBK", "FID", "FINX", "FISI", "FISV", "FITB", "FITBI", 
                   "FITBP", "FIVE", "FIVN", "FIXD", "FIXX", "FIZZ", "FJP", "FKO", "FKU", "FLDM", "FLEX", "FLGT", "FLIC", "FLIR", "FLL", "FLLCU", "FLMN", "FLN", "FLNT", "FLWS", "FLXN", "FLXS", "FMAO", 
                   "FMB", "FMBH", "FMBI", "FMCIW", "FMHI", "FMK", "FMNB", "FNCB", "FNHC", "FNJN", "FNK", "FNKO", "FNLC", "FNWB", "FNX", "FNY", "FOCS", "FOLD", "FOMX", "FONR", "FORD", "FORK", "FORM", 
                   "FORR", "FOSL", "FOX", "FOXA", "FOXF", "FPA", "FPAY", "FPRX", "FPXI", "FRAF", "FRAN", "FRBA", "FRBK", "FRGI", "FRME", "FRPH", "FRPT", "FRSX", "FRTA", "FSBC", "FSBW", "FSCT", "FSFG", 
                   "FSLR", "FSTR", "FSV", "FSZ", "FTA", "FTACU", "FTACW", "FTC", "FTCS", "FTDR", "FTEK", "FTFT", "FTGC", "FTHI", "FTLB", "FTNT", "FTR", "FTRI", "FTSL", "FTSM", "FTSV", "FTXD", "FTXG", 
                   "FTXH", "FTXL", "FTXN", "FTXO", "FTXR", "FULC", "FULT", "FUNC", "FUND", "FUSB", "FUV", "FV", "FVC", "FVCB", "FVE", "FWONA", "FWONK", "FWP", "FWRD", "FXNC", "FYC", "FYT", "FYX", 
                   "GABC", "GAIA", "GAIN", "GAINL", "GAINM", "GALT", "GARS", "GASS", "GBCI", "GBDC", "GBLI", "GBLIL", "GBLIZ", "GBT", "GCBC", "GCVRZ", "GDEN", "GDS", "GEC", "GECC", "GECCL", "GECCM", 
                   "GECCN", "GEMP", "GENC", "GENE", "GENY", "GEOS", "GERN", "GEVO", "GFED", "GFN", "GFNCP", "GFNSL", "GGAL", "GH", "GHDX", "GHSI", "GIFI", "GIGM", "GIII", "GILD", "GILT", "GLAC", 
                   "GLACR", "GLACW", "GLAD", "GLADD", "GLBS", "GLBZ", "GLDD", "GLDI", "GLG", "GLIBA", "GLIBP", "GLMD", "GLNG", "GLPG", "GLPI", "GLRE", "GLUU", "GLYC", "GMAB", "GMDA", "GMHIU", "GMLP", 
                   "GMLPP", "GNCA", "GNFT", "GNLN", "GNMA", "GNMK", "GNMX", "GNOM", "GNPX", "GNTX", "GNTY", "GNUS", "GO", "GOGL", "GOGO", "GOOD", "GOODM", "GOODO", "GOODP", "GOOG", "GOOGL", "GOSS", 
                   "GPAQ", "GPOR", "GPP", "GPRE", "GPRO", "GRBK", "GRFS", "GRID", "GRIF", "GRIN", "GRMN", "GRNQ", "GROW", "GRPN", "GRSH", "GRSHU", "GRTS", "GRVY", "GSBC", "GSHD", "GSIT", "GSKY", "GSM", 
                   "GSUM", "GT", "GTHX", "GTIM", "GTLS", "GTYH", "GULF", "GURE", "GVP", "GWGH", "GWPH", "GWRS", "GXGX", "GXGXU", "HA", "HABT", "HAFC", "HAIN", "HAIR", "HALL", "HALO", "HARP", "HAS", 
                   "HAYN", "HBAN", "HBANO", "HBCP", "HBIO", "HBMD", "HBNC", "HBP", "HCACW", "HCAP", "HCAT", "HCCI", "HCKT", "HCM", "HCSG", "HDS", "HDSN", "HEAR", "HEBT", "HEES", "HELE", "HEPA", "HEWG", 
                   "HFFG", "HFWA", "HGSH", "HHHH", "HHHHR", "HHHHW", "HHR", "HHT", "HIBB", "HIFS", "HIHO", "HIIQ", "HIMX", "HJLI", "HLAL", "HLG", "HLIO", "HLIT", "HLNE", "HMHC", "HMNF", "HMST", "HMSY", 
                   "HMTV", "HNDL", "HNNA", "HNRG", "HOFT", "HOLI", "HOLX", "HOMB", "HONE", "HOOK", "HOPE", "HOTH", "HOVNP", "HPJ", "HQI", "HQY", "HROW", "HRTX", "HRZN", "HSAC", "HSACU", "HSACW", "HSDT", 
                   "HSIC", "HSII", "HSKA", "HSON", "HSTM", "HTBI", "HTBK", "HTBX", "HTGM", "HTHT", "HTLD", "HTLF", "HUBG", "HURC", "HURN", "HWBK", "HWC", "HWCC", "HWCPL", "HWKN", "HX", "HYAC", "HYACU", 
                   "HYACW", "HYLS", "HYND", "HYRE", "HYXE", "HYZD", "HZNP", "IAC", "IART", "IBB", "IBCP", "IBKC", "IBKCN", "IBKCO", "IBKCP", "IBOC", "IBTX", "IBUY", "ICAD", "ICBK", "ICCC", "ICFI", 
                   "ICHR", "ICLK", "ICLN", "ICLR", "ICMB", "ICON", "ICPT", "ICUI", "IDCC", "IDEX", "IDLB", "IDRA", "IDSA", "IDXG", "IDXX", "IDYA", "IEA", "IEAWW", "IEF", "IEI", "IEP", "IESC", "IEUS", 
                   "IFEU", "IFGL", "IFMK", "IFRX", "IFV", "IGF", "IGIB", "IGLD", "IGMS", "IGOV", "IGSB", "IHRT", "III", "IIIN", "IIIV", "IIN", "IIVI", "IJT", "ILMN", "ILPT", "IMAC", "IMBI", "IMGN", 
                   "IMKTA", "IMMP", "IMMR", "IMMU", "IMOS", "IMRN", "IMRNW", "IMTE", "IMUX", "IMV", "IMXI", "INAP", "INBK", "INBKZ", "INCY", "INDB", "INDY", "INFI", "INFN", "INFR", "INGN", "INMB", 
                   "INMD", "INNT", "INO", "INOD", "INOV", "INPX", "INSE", "INSG", "INSM", "INTC", "INTL", "INTU", "INVA", "INVE", "INWK", "IONS", "IOSP", "IOTS", "IOVA", "IPAR", "IPGP", "IPHS", "IPKW", 
                   "IPLDP", "IPWR", "IQ", "IRBT", "IRCP", "IRDM", "IRIX", "IRMD", "IROQ", "IRTC", "IRWD", "ISBC", "ISCA", "ISDS", "ISDX", "ISEE", "ISEM", "ISHG", "ISIG", "ISNS", "ISRG", "ISSC", "ISTB", 
                   "ISTR", "ITCI", "ITI", "ITIC", "ITMR", "ITRI", "ITRM", "ITRN", "IUS", "IUSB", "IUSG", "IUSS", "IUSV", "IVAC", "IXUS", "IZEA", "JACK", "JAGX", "JAKK", "JAN", "JASN", "JAZZ", "JBHT", 
                   "JBLU", "JBSS", "JCOM", "JCS", "JD", "JFIN", "JFU", "JG", "JJSF", "JKHY", "JKI", "JMU", "JNCE", "JOBS", "JOUT", "JRJC", "JRSH", "JRVR", "JSM", "JSMD", "JSML", "JVA", "JYNT", "KALA", 
                   "KALU", "KALV", "KBAL", "KBLM", "KBSF", "KBWB", "KBWD", "KBWP", "KBWR", "KBWY", "KCAPL", "KE", "KELYA", "KEQU", "KERN", "KERNW", "KFRC", "KGJI", "KHC", "KIDS", "KIN", "KINS", "KIRK", 
                   "KLAC", "KLDO", "KLIC", "KLXE", "KMDA", "KMPH", "KNDI", "KNSA", "KNSL", "KOD", "KOOL", "KOPN", "KOSS", "KPTI", "KRMA", "KRNT", "KRNY", "KRTX", "KRUS", "KRYS", "KTCC", "KTOS", "KTOV", 
                   "KTOVW", "KURA", "KVHI", "KXIN", "KZIA", "KZR", "LAKE", "LAMR", "LANC", "LAND", "LANDP", "LARK", "LASR", "LAUR", "LAWS", "LAZY", "LBAI", "LBC", "LBRDA", "LBRDK", "LBTYA", "LBTYB", 
                   "LBTYK", "LCAHU", "LCNB", "LCUT", "LDRI", "LDSF", "LE", "LECO", "LEDS", "LEGH", "LEGR", "LEVL", "LFUS", "LFVN", "LGIH", "LGND", "LHCG", "LIFE", "LILA", "LILAK", "LINC", "LIND", 
                   "LIQT", "LITE", "LIVE", "LIVN", "LIVX", "LJPC", "LK", "LKCO", "LKFN", "LKOR", "LKQ", "LLIT", "LLNW", "LMAT", "LMB", "LMBS", "LMFA", "LMNR", "LMNX", "LMRK", "LMRKN", "LMRKO", "LMRKP", 
                   "LMST", "LNDC", "LNGR", "LNT", "LNTH", "LOAN", "LOB", "LOCO", "LOGC", "LOGI", "LOGM", "LONE", "LOOP", "LOPE", "LORL", "LOVE", "LPCN", "LPLA", "LPSN", "LPTH", "LPTX", "LQDA", "LQDT", 
                   "LRAD", "LRCX", "LRGE", "LSCC", "LSTR", "LSXMA", "LSXMK", "LTBR", "LTRPA", "LTRX", "LTXB", "LULU", "LUNA", "LVGO", "LVHD", "LWAY", "LX", "LXRX", "LYFT", "LYTS", "MACK", "MAGS", 
                   "MAMS", "MANH", "MANT", "MAR", "MARA", "MARK", "MARPS", "MASI", "MAT", "MATW", "MAYS", "MBB", "MBCN", "MBII", "MBIN", "MBINO", "MBINP", "MBIO", "MBOT", "MBRX", "MBSD", "MBUU", "MBWM", 
                   "MCBC", "MCEF", "MCEP", "MCFT", "MCHI", "MCHP", "MCHX", "MCRB", "MCRI", "MDB", "MDCA", "MDCO", "MDGL", "MDIV", "MDJH", "MDLZ", "MDRR", "MDRX", "MDSO", "MDWD", "MEDP", "MEET", "MEIP", 
                   "MELI", "MEOH", "MERC", "MESA", "MESO", "METC", "MFIN", "MFINL", "MFNC", "MFSF", "MGEE", "MGEN", "MGI", "MGIC", "MGLN", "MGNX", "MGPI", "MGRC", "MGTA", "MGTX", "MHLD", "MICT", "MIDD", 
                   "MIK", "MILN", "MIME", "MIND", "MINDP", "MINI", "MIRM", "MIST", "MITK", "MITO", "MJCO", "MKGI", "MKSI", "MKTX", "MLAB", "MLCO", "MLHR", "MLND", "MLNT", "MLNX", "MLVF", "MMAC", "MMLP", 
                   "MMSI", "MMYT", "MNCLW", "MNDO", "MNKD", "MNLO", "MNOV", "MNRO", "MNSB", "MNST", "MNTA", "MNTX", "MOBL", "MOFG", "MOGO", "MOMO", "MOR", "MORF", "MORN", "MOSY", "MOTS", "MOXC", "MPAA", 
                   "MPB", "MPVD", "MPWR", "MRAM", "MRBK", "MRCC", "MRCCL", "MRCY", "MREO", "MRIN", "MRKR", "MRLN", "MRNA", "MRNS", "MRSN", "MRTN", "MRTX", "MRUS", "MRVL", "MSBF", "MSBI", "MSEX", "MSFT", 
                   "MSON", "MSTR", "MSVB", "MTBC", "MTBCP", "MTC", "MTCH", "MTEM", "MTEX", "MTFB", "MTFBW", "MTLS", "MTP", "MTRX", "MTSC", "MTSI", "MTSL", "MU", "MUDS", "MUDSW", "MVBF", "MVIS", "MWK", 
                   "MXIM", "MYFW", "MYGN", "MYL", "MYOK", "MYOS", "MYRG", "MYSZ", "MYT", "NAII", "NAKD", "NANO", "NAOV", "NATH", "NATI", "NATR", "NAVI", "NBEV", "NBIX", "NBN", "NBRV", "NBSE", "NBTB", 
                   "NCBS", "NCMI", "NCNA", "NCSM", "NCTY", "NDAQ", "NDLS", "NDRA", "NDRAW", "NDSN", "NEO", "NEOG", "NEON", "NEOS", "NEPH", "NEPT", "NERV", "NESR", "NESRW", "NETE", "NEWA", "NEWT", 
                   "NEWTI", "NEWTL", "NEXT", "NFBK", "NFE", "NFIN", "NFINU", "NFINW", "NFLX", "NGHC", "NGHCN", "NGHCO", "NGHCP", "NGHCZ", "NGM", "NH", "NHLD", "NHTC", "NICE", "NICK", "NIHD", "NIU", 
                   "NK", "NKSH", "NKTR", "NLNK", "NLTX", "NMCI", "NMIH", "NMRD", "NMRK", "NNBR", "NNDM", "NODK", "NOVN", "NOVT", "NPAUU", "NRC", "NRIM", "NSIT", "NSSC", "NSTG", "NSYS", "NTAP", "NTCT", 
                   "NTEC", "NTES", "NTGN", "NTGR", "NTIC", "NTLA", "NTNX", "NTRA", "NTRP", "NTRS", "NTRSP", "NTUS", "NTWK", "NUAN", "NURO", "NUVA", "NVAX", "NVCN", "NVCR", "NVDA", "NVEC", "NVEE", 
                   "NVFY", "NVIV", "NVLN", "NVMI", "NVTR", "NVUS", "NWBI", "NWFL", "NWL", "NWLI", "NWPX", "NWS", "NWSA", "NXGN", "NXPI", "NXST", "NXTC", "NXTD", "NXTG", "NYMT", "NYMTN", "NYMTO", 
                   "NYMTP", "NYMX", "NYNY", "OBAS", "OBCI", "OBLN", "OBNK", "OBSV", "OCC", "OCCI", "OCCIP", "OCFC", "OCGN", "OCSI", "OCSL", "OCSLL", "OCUL", "ODFL", "ODP", "ODT", "OESX", "OFIX", "OFLX", 
                   "OFS", "OFSSL", "OFSSZ", "OGI", "OHAI", "OIIM", "OKTA", "OLBK", "OLD", "OLED", "OLLI", "OMAB", "OMCL", "OMER", "OMEX", "ON", "ONB", "ONCE", "ONCS", "ONCT", "ONCY", "ONEQ", "ONTX", 
                   "ONVO", "OPB", "OPBK", "OPES", "OPGN", "OPHC", "OPI", "OPINI", "OPK", "OPNT", "OPRA", "OPRT", "OPRX", "OPTN", "OPTT", "ORBC", "ORG", "ORGO", "ORGS", "ORIT", "ORLY", "ORMP", "ORRF", 
                   "ORSNU", "ORTX", "OSBC", "OSBCP", "OSIS", "OSMT", "OSN", "OSPN", "OSS", "OSTK", "OSUR", "OSW", "OTEL", "OTEX", "OTIC", "OTIV", "OTLK", "OTLKW", "OTTR", "OTTW", "OVBC", "OVID", "OVLY", 
                   "OXBR", "OXFD", "OXLC", "OXLCM", "OXLCO", "OXSQ", "OXSQL", "OZK", "PAAC", "PAACR", "PAACU", "PAACW", "PAAS", "PACB", "PACQ", "PACQW", "PACW", "PAHC", "PANL", "PATK", "PAVM", "PAYS", 
                   "PAYX", "PBBI", "PBCT", "PBCTP", "PBFS", "PBIP", "PBPB", "PBTS", "PBYI", "PCAR", "PCB", "PCH", "PCOM", "PCRX", "PCSB", "PCTI", "PCTY", "PCYG", "PCYO", "PDBC", "PDCE", "PDCO", "PDD", 
                   "PDEV", "PDEX", "PDFS", "PDLB", "PDLI", "PDP", "PDSB", "PEBK", "PEBO", "PECK", "PEGA", "PEGI", "PEIX", "PENN", "PEP", "PERI", "PESI", "PETQ", "PETS", "PETZ", "PEY", "PEZ", "PFBC", 
                   "PFBI", "PFF", "PFG", "PFI", "PFIE", "PFIN", "PFIS", "PFLT", "PFM", "PFMT", "PFPT", "PFSW", "PGC", "PGJ", "PGNX", "PHAS", "PHCF", "PHIO", "PHO", "PHUN", "PHUNW", "PI", "PICO", "PID", 
                   "PIE", "PIH", "PIHPP", "PINC", "PIO", "PIRS", "PIXY", "PIZ", "PKBK", "PKOH", "PKW", "PLAB", "PLAY", "PLBC", "PLCE", "PLIN", "PLL", "PLMR", "PLPC", "PLSE", "PLUG", "PLUS", "PLW", 
                   "PLXP", "PLXS", "PLYA", "PMBC", "PMD", "PME", "PMTS", "PNBK", "PNFP", "PNNT", "PNNTG", "PNQI", "PNRG", "PNRL", "PNTG", "POAI", "PODD", "POLA", "POOL", "POPE", "POTX", "POWI", "POWL", 
                   "PPBI", "PPC", "PPH", "PPIH", "PPSI", "PRAA", "PRAH", "PRCP", "PRFT", "PRFZ", "PRGS", "PRGX", "PRIM", "PRMW", "PRN", "PRNB", "PROV", "PRPL", "PRPO", "PRQR", "PRSC", "PRTA", "PRTH", 
                   "PRTK", "PRTO", "PRTS", "PRVB", "PRVL", "PS", "PSC", "PSCC", "PSCD", "PSCE", "PSCF", "PSCH", "PSCI", "PSCM", "PSCT", "PSCU", "PSDO", "PSEC", "PSET", "PSL", "PSM", "PSMT", "PSNL", 
                   "PSTI", "PSTV", "PSTVZ", "PT", "PTC", "PTCT", "PTE", "PTEN", "PTF", "PTGX", "PTH", "PTI", "PTLA", "PTMN", "PTON", "PTSI", "PTVCB", "PUB", "PUI", "PULM", "PUYI", "PVAC", "PVAL", 
                   "PVBC", "PWOD", "PXI", "PXLW", "PXS", "PY", "PYPL", "PYZ", "PZZA", "QABA", "QADA", "QADB", "QAT", "QBAK", "QCLN", "QCOM", "QCRH", "QDEL", "QFIN", "QIWI", "QLC", "QLYS", "QNST", 
                   "QQEW", "QQQ", "QQQX", "QQXT", "QRHC", "QRTEA", "QRTEB", "QRVO", "QTEC", "QTNT", "QTRH", "QTRX", "QTT", "QUIK", "QUMU", "QURE", "QYLD", "RADA", "RAIL", "RAND", "RARE", "RARX", "RAVE", 
                   "RAVN", "RBB", "RBBN", "RBCAA", "RBCN", "RBNC", "RBZ", "RCEL", "RCII", "RCKT", "RCKY", "RCM", "RCMT", "RCON", "RDCM", "RDFN", "RDHL", "RDI", "RDNT", "RDUS", "RDVT", "RDVY", "RDWR", 
                   "REAL", "RECN", "REDU", "REED", "REFR", "REG", "REGI", "REGN", "REKR", "RELL", "REPH", "REPL", "RESN", "RETA", "RETO", "REXN", "RFAP", "RFDI", "RFEM", "RFEU", "RFIL", "RGCO", "RGEN", 
                   "RGLD", "RGLS", "RGNX", "RIBT", "RICK", "RIGL", "RILY", "RILYG", "RILYH", "RILYI", "RILYL", "RILYN", "RILYO", "RILYZ", "RING", "RIOT", "RIVE", "RKDA", "RMBI", "RMBL", "RMBS", "RMCF", 
                   "RMNI", "RMR", "RMTI", "RNDB", "RNDM", "RNDV", "RNEM", "RNET", "RNLC", "RNMC", "RNSC", "RNST", "RNWK", "ROAD", "ROBT", "ROCK", "ROIC", "ROKU", "ROLL", "ROSE", "ROSEW", "ROST", "RP", 
                   "RPAY", "RPD", "RRBI", "RRGB", "RRR", "RTIX", "RTLR", "RTRX", "RTTR", "RUBY", "RUHN", "RUN", "RUSHA", "RUSHB", "RUTH", "RVEN", "RVLT", "RVNC", "RVSB", "RWLK", "RYAAY", "RYTM", "SABR", 
                   "SAEX", "SAFM", "SAFT", "SAGE", "SAIA", "SAL", "SALM", "SAMG", "SANM", "SANW", "SASR", "SATS", "SAUC", "SAVA", "SBAC", "SBBP", "SBBX", "SBCF", "SBGI", "SBLK", "SBNY", "SBPH", "SBRA", 
                   "SBSI", "SBT", "SBUX", "SCHL", "SCHN", "SCKT", "SCON", "SCOR", "SCPH", "SCPL", "SCSC", "SCVL", "SCWX", "SCYX", "SCZ", "SDC", "SDG", "SEAC", "SECO", "SEDG", "SEED", "SEEL", "SEIC", 
                   "SELB", "SELF", "SENEA", "SENEB", "SES", "SESN", "SFBC", "SFBS", "SFET", "SFIX", "SFM", "SFNC", "SFST", "SG", "SGA", "SGBX", "SGC", "SGEN", "SGH", "SGLB", "SGMA", "SGMO", "SGMS", 
                   "SGOC", "SGRP", "SGRY", "SHBI", "SHEN", "SHIP", "SHIPW", "SHLO", "SHOO", "SHOS", "SHSP", "SHV", "SHY", "SIBN", "SIC", "SIEB", "SIEN", "SIFY", "SIGA", "SIGI", "SILC", "SILK", "SIMO", 
                   "SINA", "SINO", "SINT", "SIRI", "SITO", "SIVB", "SKOR", "SKYS", "SKYW", "SKYY", "SLAB", "SLCT", "SLDB", "SLGG", "SLGL", "SLGN", "SLIM", "SLM", "SLMBP", "SLNO", "SLP", "SLQD", "SLRC", 
                   "SLRX", "SLS", "SLVO", "SMBC", "SMBK", "SMCP", "SMED", "SMIT", "SMMC", "SMMF", "SMMT", "SMPL", "SMRT", "SMSI", "SMTC", "SMTX", "SNBR", "SNCR", "SND", "SNDE", "SNDL", "SNDX", "SNES", 
                   "SNFCA", "SNGX", "SNH", "SNHNI", "SNHNL", "SNLN", "SNNA", "SNOA", "SNOAW", "SNPS", "SNSR", "SNSS", "SNY", "SOCL", "SOHO", "SOHOB", "SOHON", "SOHOO", "SOHU", "SOLO", "SOLOW", "SOLY", 
                   "SONA", "SONG", "SONGW", "SONM", "SONO", "SORL", "SOXX", "SP", "SPAR", "SPCB", "SPEX", "SPFI", "SPHS", "SPI", "SPKE", "SPKEP", "SPLK", "SPNE", "SPNS", "SPOK", "SPPI", "SPRO", "SPRT", 
                   "SPSC", "SPTN", "SPWH", "SPWR", "SQBG", "SQLV", "SQQQ", "SRAX", "SRCE", "SRCL", "SRDX", "SRET", "SREV", "SRNE", "SRPT", "SRRA", "SRRK", "SRTS", "SSB", "SSBI", "SSFN", "SSKN", "SSNC", 
                   "SSNT", "SSP", "SSPK", "SSPKU", "SSRM", "SSSS", "SSTI", "SSYS", "STAA", "STAF", "STAY", "STBA", "STCN", "STFC", "STIM", "STKL", "STKS", "STLD", "STML", "STMP", "STND", "STNE", "STNL", 
                   "STNLW", "STOK", "STRA", "STRL", "STRM", "STRO", "STRS", "STRT", "STSA", "STX", "STXB", "SUMR", "SUNS", "SUNW", "SUPN", "SURF", "SUSB", "SUSC", "SUSL", "SVBI", "SVC", "SVMK", "SVRA", 
                   "SVVC", "SWAV", "SWIR", "SWKS", "SWTX", "SXTC", "SY", "SYBT", "SYBX", "SYKE", "SYMC", "SYNA", "SYNC", "SYNH", "SYNL", "SYPR", "SYRS", "TA", "TACO", "TACOW", "TACT", "TAIT", "TANH", 
                   "TANNI", "TANNL", "TANNZ", "TAOP", "TAST", "TAYD", "TBBK", "TBIO", "TBK", "TBLT", "TBLTW", "TBNK", "TBPH", "TC", "TCBI", "TCBIL", "TCBIP", "TCBK", "TCCO", "TCDA", "TCF", "TCFC", 
                   "TCFCP", "TCGP", "TCMD", "TCON", "TCPC", "TCRD", "TCRR", "TCX", "TDACW", "TDIV", "TEAM", "TECD", "TECH", "TEDU", "TELL", "TENB", "TENX", "TER", "TERP", "TESS", "TEUM", "TFSL", "TGA", 
                   "TGEN", "TGLS", "TGTX", "TH", "THBRU", "THCA", "THCAU", "THCAW", "THCB", "THFF", "THOR", "THRM", "THWWW", "TIBR", "TIBRU", "TIBRW", "TIGO", "TIGR", "TILE", "TIPT", "TITN", "TIVO", 
                   "TKKS", "TKKSW", "TLC", "TLF", "TLGT", "TLND", "TLRY", "TLSA", "TLT", "TMCX", "TMCXW", "TMDI", "TMDX", "TMSR", "TMUS", "TNAV", "TNDM", "TNXP", "TOCA", "TOPS", "TORC", "TOTA", "TOTAW", 
                   "TOUR", "TOWN", "TPCO", "TPIC", "TPTX", "TQQQ", "TRCB", "TRCH", "TREE", "TRHC", "TRIB", "TRIL", "TRIP", "TRMB", "TRMD", "TRMK", "TRMT", "TRNS", "TRNX", "TROV", "TROW", "TRPX", "TRS", 
                   "TRST", "TRUE", "TRUP", "TRVG", "TRVI", "TRVN", "TSBK", "TSC", "TSCAP", "TSCBP", "TSCO", "TSEM", "TSG", "TSLA", "TSRI", "TTD", "TTEC", "TTEK", "TTGT", "TTMI", "TTNP", "TTOO", "TTPH", 
                   "TTS", "TTTN", "TTWO", "TUES", "TUR", "TURN", "TUSA", "TUSK", "TVIX", "TVTY", "TW", "TWIN", "TWMC", "TWNK", "TWNKW", "TWOU", "TWST", "TXG", "TXMD", "TXN", "TXRH", "TYHT", "TYME", 
                   "TYPE", "TZOO", "UAE", "UAL", "UBCP", "UBFO", "UBIO", "UBNK", "UBOH", "UBSI", "UBX", "UCBI", "UCFC", "UCTT", "UEIC", "UEPS", "UFCS", "UFPI", "UFPT", "UG", "UGLD", "UHAL", "UIHC", 
                   "ULBI", "ULH", "ULTA", "UMBF", "UMPQ", "UMRX", "UNB", "UNIT", "UNTY", "UONEK", "UPLD", "UPWK", "URBN", "URGN", "UROV", "USAK", "USAP", "USAU", "USCR", "USEG", "USIG", "USIO", "USLB", 
                   "USLM", "USLV", "USMC", "USOI", "USWS", "USWSW", "UTHR", "UTMD", "UTSI", "UVSP", "UXIN", "VALU", "VBIV", "VBLT", "VBTX", "VC", "VCEL", "VCIT", "VCLT", "VCNX", "VCSH", "VCTR", "VCYT", 
                   "VECO", "VEON", "VERB", "VERBW", "VERI", "VERU", "VFF", "VGIT", "VGLT", "VGSH", "VIA", "VIAB", "VIAV", "VICR", "VIGI", "VIIX", "VIOT", "VIRC", "VIRT", "VISL", "VIVE", "VIVO", "VKTX", 
                   "VLGEA", "VLRX", "VLY", "VLYPO", "VLYPP", "VMBS", "VMD", "VNDA", "VNET", "VNOM", "VNQI", "VOD", "VONE", "VONG", "VONV", "VOXX", "VRA", "VRAY", "VRCA", "VREX", "VRIG", "VRML", "VRNA", 
                   "VRNS", "VRNT", "VRRM", "VRSK", "VRSN", "VRTS", "VRTSP", "VRTU", "VRTX", "VSAT", "VSDA", "VSEC", "VSMV", "VSTM", "VTC", "VTGN", "VTHR", "VTIP", "VTNR", "VTSI", "VTVT", "VTWG", "VTWO", 
                   "VTWV", "VUZI", "VVPR", "VVUS", "VWOB", "VXRT", "VXUS", "VYGR", "VYMI", "WABC", "WAFD", "WAFU", "WASH", "WATT", "WB", "WBA", "WBND", "WCLD", "WDAY", "WDC", "WDFC", "WEN", "WERN", 
                   "WETF", "WEYS", "WHF", "WHFBZ", "WHLR", "WHLRD", "WHLRP", "WIFI", "WILC", "WINA", "WINC", "WING", "WINS", "WIRE", "WISA", "WIX", "WKHS", "WLDN", "WLFC", "WLTW", "WMGI", "WNEB", 
                   "WOOD", "WORX", "WPRT", "WRLD", "WRLS", "WRLSR", "WRLSU", "WRLSW", "WRTC", "WSBC", "WSBF", "WSC", "WSFS", "WSG", "WSTG", "WSTL", "WTBA", "WTER", "WTFC", "WTFCM", "WTRE", "WTREP", 
                   "WTRH", "WVE", "WVFC", "WVVI", "WVVIP", "WW", "WWD", "WWR", "WYNN", "XBIO", "XBIT", "XCUR", "XEL", "XELA", "XELB", "XENE", "XENT", "XERS", "XFOR", "XGN", "XLNX", "XLRN", "XNCR", 
                   "XNET", "XOG", "XOMA", "XON", "XONE", "XPEL", "XPER", "XRAY", "XSPA", "XT", "XTLB", "YGYI", "YGYIP", "YI", "YIN", "YJ", "YLCO", "YMAB", "YNDX", "YORW", "YRCW", "YTEN", "YTRA", "YVR", 
                   "YY", "Z", "ZAGG", "ZBIO", "ZBRA", "ZEAL", "ZEUS", "ZFGN", "ZG", "ZGNX", "ZION", "ZIOP", "ZIV", "ZIXI", "ZKIN", "ZLAB", "ZM", "ZN", "ZNGA", "ZS", "ZSAN", "ZUMZ", "ZVO", "ZYNE", "ZYXI")

av_api_key("")

for(i in 1:length(symbolsNASDAQ)){
  
  #getSomething <- function() alphavantager::av_get(symbol = symbolsNASDAQ[i], av_fun = "BBANDS", interval = "15min", time_period = 200, series_type = "open")
  #getSomething <- function() alphavantager::av_get(symbol = symbolsNASDAQ[i], av_fun = "MACD", interval = "15min", datatype="csv", series_type = "open")
  getSomething <- function() alphavantager::av_get(symbol = symbolsNASDAQ[i], av_fun = "MACD", interval = "15min", datatype="csv", series_type = "close")
  #getSomething <- function() alphavantager::av_get(symbol = symbolsNASDAQ[i], av_fun = "TIME_SERIES_INTRADAY", interval = "15min", outputsize = "full")
  #getSomething <- function() alphavantager::av_get(symbol = symbolsNASDAQ[i], av_fun = "STOCH", interval = "15min", datatype="csv") # default = (fastkperiod=5, slowkpariod=3, slowdperiod=3)
  badNews <- function() write(symbolsNASDAQ[i],"badSymbols.txt", append = T)
  
  tryCatch(
    {
      getSomething()
      #name <- paste0("NASDAQ_BBands_15min_",symbolsNASDAQ[i],".csv")
      #name <- paste0("NASDAQ_Intraday_15min_",symbolsNASDAQ[i],".csv")
      #name <- paste0("NASDAQ_MACD_High_15min_",symbolsNASDAQ[i],".csv")
      #name <- paste0("NASDAQ_MACD_Open_15min_",symbolsNASDAQ[i],".csv")
      name <- paste0("NASDAQ_MACD_Close_15min_",symbolsNASDAQ[i],".csv")
      write.csv(data.frame(getSomething(),symbolsNASDAQ[i]), name, row.names = F)
      #print(nameBands)
    },
    error = function(e)
    {
      badNews()
    }
  )
  Sys.sleep(3) #sleep the for loop for n.n seconds since max pull is once every n seconds
}

########################################################################################################
########################################################################################################
######################################### End NASDAQ Symbols ###########################################
########################################################################################################
########################################################################################################

########################################################################################################
########################################################################################################
######################################### Start NYSE Symbols ###########################################
########################################################################################################
########################################################################################################


symbolsNYSE <- c("A","AA","AAT","AB","ABC","ABEV","ABG","ABR","AC","ACA","ACB","ACC","ACH","ACRE","ACV","ADC","ADM","ADS","AEE","AEL","AEM","AEO","AEP","AES","AFB","AFC",
       "AFG","AFGB","AFGE","AFGH","AFI","AFT","AG","AGCO","AGI","AGM","AGN","AGO","AGR","AGS","AGX","AHH","AHT","AI","AIC","AIF","AIG","AIN","AIT","AIV","AIW","AIZ",
       "AIZP","AJG","AJX","AJXA","AKS","AL","ALB","ALC","ALE","ALEX","ALG","ALK","ALL","ALLE","ALLY","ALSN","ALV","ALX","AM","AMC","AMCR","AME","AMH","AMK","AMN",
       "AMOV","AMP","AMPY","AMRC","AMRX","AMT","AMX","AN","ANET","ANFI","ANH","ANTM","AON","AP","APA","APAM","APD","APH","APHA","APLE","APO","APRN","APTS","APTV",
       "APY","AQN","AQNA","AQNB","AQUA","AR","ARA","ARC","ARCH","ARCO","ARD","ARDC","ARE","ARES","ARGD","ARGO","ARI","ARL","ARLO","ARMK","ARNC","AROC","ARR","ARW",
       "ASA","ASB","ASC","ASG","ASGN","ASH","ASPN","ASR","ASX","AT","ATH","ATHM","ATI","ATKR","ATO","ATR","ATTO","ATUS","AU","AUY","AVA","AVAL","AVB","AVD","AVH",
       "AVLR","AVNS","AVP","AVTR","AVX","AVY","AVYA","AWF","AWI","AWK","AWR","AX","AXE","AXL","AXO","AXP","AXR","AXS","AXTA","AYR","AYX","AZN","AZO","AZRE","AZUL",
       "AZZ","B","BA","BABA","BAC","BAF","BAH","BAM","BANC","BAP","BAS","BAX","BB","BBAR","BBD","BBDC","BBDO","BBF","BBK","BBL","BBN","BBT","BBU","BBVA","BBW","BBX",
       "BBY","BC","BCC","BCE","BCEI","BCH","BCO","BCRH","BCS","BCSF","BCX","BDC","BDJ","BDN","BDX","BDXA","BE","BEDU","BEN","BEP","BERY","BEST","BFAM","BFK","BFO",
       "BFS","BFY","BFZ","BG","BGB","BGG","BGH","BGIO","BGR","BGS","BGT","BGX","BGY","BH","BHC","BHE","BHGE","BHK","BHLB","BHP","BHR","BHV","BHVN","BIF","BIG","BIO",
       "BIP","BIT","BITA","BJ","BK","BKD","BKE","BKH","BKI","BKK","BKN","BKT","BKU","BLD","BLE","BLK","BLL","BLW","BLX","BMA","BME","BMI","BMO","BMY","BNED","BNS",
       "BNY","BOE","BOH","BOOT","BORR","BOX","BP","BPL","BPMP","BPT","BQH","BR","BRC","BRFS","BRO","BRPM","BRT","BRX","BSA","BSAC","BSBR","BSD","BSE","BSIG","BSL",
       "BSM","BSMX","BST","BSTZ","BSX","BTA","BTE","BTI","BTO","BTT","BTU","BTZ","BUD","BUI","BURL","BV","BVN","BW","BWA","BWG","BWXT","BX","BXC","BXG","BXMT",
       "BXMX","BXP","BXS","BY","BYD","BYM","BZH","BZM","C","CAAP","CABO","CACI","CADE","CAE","CAF","CAG","CAH","CAI","CAJ","CAL","CALX","CANG","CAPL","CARS","CAT",
       "CATO","CB","CBB","CBD","CBH","CBL","CBM","CBO","CBPX","CBRE","CBS","CBT","CBU","CBX","CBZ","CC","CCC","CCEP","CCH","CCI","CCJ","CCK","CCL","CCM","CCO","CCR",
       "CCS","CCU","CCX","CCZ","CDAY","CDE","CDR","CE","CEA","CEE","CEIX","CEL","CELP","CEM","CEN","CEO","CEPU","CEQP","CF","CFG","CFR","CFX","CFXA","CGA","CGC",
       "CHA","CHAP","CHCT","CHD","CHE","CHGG","CHH","CHK","CHKR","CHL","CHMI","CHN","CHRA","CHS","CHT","CHU","CHWY","CI","CIA","CIB","CIEN","CIF","CIG","CII","CIM",
       "CINR","CIO","CIR","CISN","CIT","CJ","CKH","CL","CLB","CLDR","CLDT","CLF","CLGX","CLH","CLI","CLNC","CLNY","CLPR","CLR","CLS","CLW","CLX","CM","CMA","CMC",
       "CMCM","CMD","CMG","CMI","CMO","CMP","CMRE","CMS","CMSA","CMSC","CMSD","CMU","CNA","CNC","CNDT","CNF","CNHI","CNI","CNK","CNNE","CNO","CNP","CNQ","CNR","CNS",
       "CNX","CNXM","CO","CODI","COE","COF","COG","COLD","COO","COP","COR","CORR","COT","COTY","CP","CPA","CPAC","CPB","CPE","CPF","CPG","CPK","CPL","CPLG","CPRI",
       "CPS","CPT","CR","CRC","CRCM","CRH","CRI","CRK","CRL","CRM","CRR","CRS","CRT","CRY","CS","CSL","CSLT","CSS","CSTM","CSU","CSV","CTAA","CTB","CTBB","CTDD",
       "CTK","CTL","CTLT","CTR","CTRA","CTS","CTST","CTT","CTV","CTVA","CTY","CTZ","CUB","CUBE","CUBI","CUK","CULP","CURO","CUZ","CVA","CVE","CVEO","CVI",
       "CVIA","CVNA","CVS","CVX","CW","CWEN","CWH","CWK","CWT","CX","CXE","CXH","CXO","CXP","CXW","CYD","CYH","CZZ","D","DAC","DAL","DAN","DAR","DAVA","DB","DBD",
       "DBI","DBL","DCF","DCI","DCO","DCP","DCUE","DD","DDF","DDS","DDT","DE","DEA","DECK","DEI","DELL","DEO","DESP","DEX","DF","DFIN","DFP","DFS","DG","DGX","DHF",
       "DHI","DHR","DHT","DHX","DIAX","DIN","DIS","DK","DKL","DKS","DKT","DL","DLB","DLNG","DLPH","DLR","DLX","DMB","DMO","DNI","DNOW","DNP","DNR","DO","DOC","DOOR",
       "DOV","DOW","DPG","DPLO","DPZ","DQ","DRD","DRE","DRH","DRI","DRQ","DRUA","DS","DSE","DSL","DSM","DSSI","DSU","DSX","DT","DTE","DTF","DTJ","DTQ","DTW","DTY",
       "DUC","DUK","DUKB","DUKH","DVA","DVD","DVN","DX","DXB","DXC","DY","E","EAB","EAE","EAF","EAI","EARN","EAT","EB","EBF","EBR","EBS","EC","ECA","ECC","ECCA",
       "ECCB","ECCX","ECCY","ECL","ECOM","ECT","ED","EDD","EDF","EDI","EDN","EDU","EE","EEA","EEX","EFC","EFF","EFL","EFR","EFT","EFX","EGF","EGIF","EGO","EGP",
       "EGY","EHC","EHI","EHT","EIC","EIG","EIX","EL","ELAN","ELC","ELF","ELJ","ELP","ELS","ELU","ELVT","ELY","EMD","EME","EMF","EMN","EMO","EMP","EMR","ENB","ENBA",
       "ENBL","ENIA","ENIC","ENJ","ENLC","ENO","ENR","ENS","ENV","ENVA","ENZ","EOD","EOG","EOI","EOS","EOT","EPAM","EPC","EPD","EPR","EPRT","EQC","EQH","EQM","EQNR",
       "EQR","EQS","EQT","ERA","ERF","ERJ","EROS","ES","ESE","ESI","ESNT","ESRT","ESS","ESTC","ESTE","ET","ETB","ETG","ETH","ETJ","ETM","ETN","ETO","ETR","ETRN",
       "ETV","ETW","ETX","ETY","EURN","EV","EVA","EVC","EVF","EVG","EVH","EVN","EVR","EVRG","EVRI","EVT","EVTC","EW","EXD","EXG","EXK","EXP","EXPR","EXR","EXTN",
       "EZT","F","FAF","FAM","FBC","FBHS","FBK","FBM","FBP","FC","FCAU","FCF","FCN","FCPT","FCT","FCX","FDEU","FDP","FDS","FDX","FE","FEDU","FEI","FELP","FENG",
       "FEO","FET","FF","FFA","FFC","FFG","FG","FGB","FGP","FHN","FI","FICO","FIF","FII","FINS","FIS","FIT","FIV","FIX","FL","FLC","FLNG","FLO","FLOW","FLR","FLS",
       "FLT","FLY","FMC","FMN","FMO","FMS","FMX","FMY","FN","FNB","FND","FNF","FNV","FOE","FOF","FOR","FPAC","FPF","FPH","FPI","FPL","FR","FRA","FRAC","FRC","FRO",
       "FRT","FSB","FSD","FSK","FSLY","FSM","FSS","FT","FTAI","FTCH","FTI","FTK","FTS","FTSI","FTV","FUL","FUN","FVRR","G","GAB","GAM","GATX","GBAB","GBL","GBX",
       "GCAP","GCI","GCO","GCP","GCV","GD","GDDY","GDI","GDL","GDO","GDOT","GDV","GDV~$","GE","GEF","GEL","GEN","GEO","GER","GES","GF","GFF","GFI","GFY","GGB","GGG",
       "GGM","GGT","GGZ","GHC","GHG","GHL","GHM","GHY","GIB","GIG","GIG~","GIL","GIM","GIS","GIX","GIX~","GJH","GJO","GJP","GJR","GJS","GJT","GJV","GKOS","GL",
       "GLOB","GLOG","GLOP","GLP","GLT","GLW","GM","GME","GMED","GMRE","GMS","GMTA","GMZ","GNC","GNE","GNK","GNL","GNRC","GNT","GNW","GOF","GOL","GOLD","GOOS","GPC",
       "GPI","GPJA","GPK","GPM","GPMT","GPN","GPRK","GPS","GPX","GRA","GRAF","GRAM","GRC","GRUB","GRX","GS","GSAH","GSBD","GSH","GSK","GSL","GSX","GTES","GTN","GTS",
       "GTT","GTX","GTY","GUT","GVA","GWB","GWR","GWRE","GWW","GYB","GYC","H","HAE","HAL","HASI","HBB","HBI","HBM","HCA","HCC","HCFT","HCHC","HCI","HCP","HCR",
       "HCXY","HCXZ","HD","HDB","HE","HEI","HEP","HEQ","HES","HESM","HEXO","HFC","HFRO","HGH","HGLB","HGV","HHC","HHS","HI","HIE","HIG","HII","HIL","HIO","HIW",
       "HIX","HJV","HKIB","HL","HLF","HLI","HLT","HLX","HMC","HMI","HMLP","HMN","HMY","HNGR","HNI","HNP","HOG","HOME","HON","HOS","HOV","HP","HPE","HPF","HPI","HPP",
       "HPQ","HPR","HPS","HQH","HQL","HR","HRB","HRC","HRI","HRL","HRTG","HSBC","HSC","HST","HSY","HT","HTA","HTD","HTFA","HTGC","HTH","HTY","HTZ","HUBB","HUBS",
       "HUD","HUM","HUN","HUYA","HVT","HXL","HY","HYB","HYI","HYT","HZN","HZO","I","IAA","IAE","IAG","IBA","IBM","IBN","IBP","ICD","ICE","ICL","IDA","IDE","IDT",
       "IEX","IFF","IFFT","IFN","IFS","IGA","IGD","IGI","IGR","IGT","IHC","IHD","IHG","IHIT","IHTA","IID","IIF","IIM","IIPR","IMAX","INB","INF","INFO","INFY","ING",
       "INGR","INN","INSI","INSP","INST","INSW","INT","INVH","INXN","IO","IP","IPG","IPHI","IPI","IPOA","IQI","IQV","IR","IRET","IRL","IRM","IRR","IRS","IRT","ISD",
       "ISG","IT","ITCB","ITGR","ITT","ITUB","ITW","IVC","IVH","IVR","IVZ","IX","JAG","JAX","JBGS","JBK","JBL","JBN","JBR","JBT","JCAP","JCE","JCI","JCO","JCP",
       "JDD","JE","JEC","JEF","JELD","JEMD","JFR","JGH","JHAA","JHB","JHD","JHG","JHI","JHS","JHX","JHY","JILL","JKS","JLL","JLS","JMEI","JMF","JMIA","JMLP","JMM",
       "JMP","JMPD","JMPE","JMT","JNJ","JNPR","JOE","JOF","JP","JPC","JPI","JPM","JPS","JPT","JQC","JRI","JRO","JRS","JSD","JT","JTA","JTD","JWN","K","KAI","KAMN",
       "KAR","KB","KBH","KBR","KDMN","KDP","KEG","KEM","KEN","KEP","KEX","KEY","KEYS","KF","KFS","KFY","KGC","KIM","KIO","KKR","KL","KMB","KMF","KMI","KMPR","KMT",
       "KMX","KN","KNL","KNOP","KNX","KO","KODK","KOF","KOP","KOS","KR","KRA","KRC","KREF","KRG","KRO","KRP","KSM","KSS","KSU","KT","KTB","KTF","KTH","KTN","KTP",
       "KW","KWR","KYN","L","LAC","LAD","LADR","LAIX","LAZ","LB","LBRT","LC","LCI","LCII","LDL","LDOS","LDP","LEA","LEAF","LEE","LEG","LEJU","LEN","LEO","LEVI",
       "LFC","LGC","LGI","LH","LHC","LHX","LII","LIN","LINX","LITB","LKSD","LL","LLY","LM","LMHA","LMHB","LMT","LN","LNC","LND","LNN","LOMA","LOR","LOW","LPG","LPI",
       "LPL","LPT","LPX","LRN","LSI","LTC","LTHM","LTM","LUB","LUV","LVS","LW","LXFR","LXP","LXU","LYB","LYG","LYV","LZB","M","MA","MAA","MAC","MAIN","MAN","MANU",
       "MAS","MATX","MAV","MAXR","MBI","MBT","MC","MCA","MCB","MCC","MCD","MCI","MCK","MCN","MCO","MCR","MCRN","MCS","MCV","MCX","MCY","MD","MDC","MDLA","MDLQ",
       "MDLX","MDLY","MDP","MDR","MDT","MDU","MEC","MED","MEI","MEN","MET","MFA","MFAC","MFC","MFD","MFG","MFGP","MFL","MFM","MFO","MFT","MFV","MG","MGA","MGF",
       "MGM","MGP","MGU","MGY","MHD","MHE","MHF","MHI","MHK","MHLA","MHN","MHNC","MHO","MIC","MIE","MIN","MIXT","MIY","MKC","MKL","MLI","MLM","MLP","MLR","MMC",
       "MMD","MMI","MMP","MMS","MMT","MMU","MN","MNE","MNK","MNP","MNR","MNRL","MO","MOD","MODN","MOGU","MOH","MOS","MOSC","MOV","MPA","MPC","MPLX","MPV","MPW",
       "MPX","MQT","MQY","MR","MRC","MRK","MRO","MS","MSA","MSB","MSC","MSCI","MSD","MSG","MSGN","MSI","MSM","MT","MTB","MTD","MTDR","MTG","MTH","MTL","MTN","MTOR",
       "MTR","MTRN","MTT","MTW","MTX","MTZ","MUA","MUC","MUE","MUFG","MUH","MUI","MUJ","MUR","MUS","MUSA","MUX","MVC","MVCD","MVF","MVO","MVT","MWA","MX","MXE",
       "MXF","MXL","MYC","MYD","MYE","MYF","MYI","MYJ","MYN","MYOV","MZA","NAC","NAD","NAN","NAT","NAV","NAZ","NBB","NBHC","NBL","NBLX","NBR","NC","NCA","NCB","NCI",
       "NCLH","NCR","NCV","NCZ","NDP","NE","NEA","NEE","NEM","NEP","NET","NEU","NEV","NEW","NEWM","NEWR","NEXA","NFC","NFG","NFJ","NGG","NGL","NGS","NGVC","NGVT",
       "NHA","NHF","NHI","NI","NID","NIE","NIM","NINE","NIO","NIQ","NJR","NJV","NKE","NKG","NKX","NL","NLS","NLSN","NLY","NM","NMCO","NMFC","NMFX","NMI","NMM","NMR",
       "NMS","NMT","NMY","NMZ","NNA","NNC","NNI","NNN","NNY","NOA","NOAH","NOC","NOK","NOM","NOMD","NOV","NOVA","NOW","NP","NPK","NPN","NPO","NPTN","NPV","NQP","NR",
       "NRG","NRGX","NRK","NRP","NRT","NRUC","NRZ","NS","NSA","NSC","NSCO","NSL","NSP","NSS","NTB","NTC","NTG","NTP","NTR","NTX","NTZ","NUE","NUM","NUO",
       "NUS","NUV","NUW","NVG","NVGS","NVO","NVR","NVRO","NVS","NVST","NVT","NVTA","NWE","NWHM","NWN","NX","NXC","NXJ","NXN","NXP","NXQ","NXR","NXRT","NYCB","NYT",
       "NYV","NZF","O","OAC","OAS","OBE","OC","OCN","ODC","OEC","OFC","OFG","OGE","OGS","OHI","OI","OIA","OII","OIS","OKE","OLN","OLP","OMC","OMF","OMI","OMN",
       "OMP","ONDK","ONE","OOMA","OPP","OPY","OR","ORA","ORAN","ORC","ORCC","ORCL","ORI","ORN","OSB","OSG","OSK","OSLE","OUT","OXM","OXY","PAA","PAC","PACD","PACK",
       "PAG","PAGP","PAGS","PAI","PAM","PANW","PAR","PARR","PAYC","PB","PBA","PBB","PBC","PBF","PBFX","PBH","PBI","PBR","PBT","PBY","PCF","PCG","PCI","PCK","PCM",
       "PCN","PCQ","PD","PDI","PDM","PDS","PDT","PE","PEB","PEG","PEI","PEN","PER","PFD","PFE","PFGC","PFH","PFL","PFN","PFO","PFS","PFSI","PG","PGP","PGR","PGRE",
       "PGTI","PGZ","PH","PHD","PHG","PHI","PHK","PHM","PHR","PHT","PHX","PIC","PII","PIM","PING","PINS","PIR","PIY","PJC","PJH","PJT","PK","PKD","PKE","PKG","PKI",
       "PKO","PKX","PLAN","PLD","PLNT","PLOW","PLT","PM","PMF","PML","PMM","PMO","PMT","PMX","PNC","PNF","PNI","PNM","PNR","PNW","POL","POR","POST","PPDF","PPG",
       "PPL","PPR","PPT","PPX","PQG","PRA","PRGO","PRH","PRI","PRLB","PRO","PROS","PRS","PRSP","PRT","PRTY","PRU","PSA","PSB","PSF","PSN","PSO","PSTG","PSTL","PSV",
       "PSX","PSXP","PTR","PTY","PUK","PUMP","PVG","PVH","PVL","PVT","PVTL","PWR","PXD","PYN","PYS","PYT","PYX","PZC","PZN","QD","QEP","QES","QGEN","QHC","QSR",
       "QTS","QTWO","QUAD","QUOT","QVCD","R","RA","RACE","RAD","RAMP","RBA","RBC","RBS","RC","RCA","RCB","RCI","RCL","RCP","RCS","RCUS","RDN","RDY","RE","RELX",
       "RENN","RES","RESI","REV","REVG","REX","REXR","REZI","RF","RFI","RFP","RGA","RGR","RGS","RGT","RH","RHI","RHP","RIG","RIO","RIV","RJF","RL","RLGY","RLH",
       "RLI","RLJ","RM","RMAX","RMD","RMED","RMG","RMI","RMM","RMT","RNG","RNGR","RNP","RNR","ROAN","ROG","ROK","ROL","ROP","ROYT","RPAI","RPLA","RPM","RPT","RQI",
       "RRC","RRD","RRTS","RS","RSF","RSG","RST","RTEC","RTN","RTW","RUBI","RVI","RVLV","RVT","RWGE","RWT","RXN","RY","RYAM","RYB","RYI","RYN","RZA","RZB","S","SA",
       "SAB","SAF","SAFE","SAH","SAIC","SAIL","SALT","SAM","SAN","SAP","SAR","SAVE","SB","SBE","SBGL","SBH","SBI","SBNA","SBOW","SBR","SBS","SC","SCA","SCCO","SCD",
       "SCHW","SCI","SCL","SCM","SCPE","SCS","SCU","SCX","SD","SDR","SDRL","SDT","SE","SEAS","SEE","SEM","SEMG","SERV","SF","SFB","SFE","SFL","SFUN","SGU","SHAK",
       "SHG","SHI","SHLL","SHLX","SHO","SHOP","SHW","SID","SIG","SITC","SITE","SIX","SJI","SJIJ","SJIU","SJM","SJR","SJT","SJW","SKM","SKT","SKX","SKY","SLB","SLCA",
       "SLF","SLG","SM","SMAR","SMFG","SMG","SMHI","SMLP","SMM","SMP","SMTA","SNA","SNAP","SNDR","SNE","SNN","SNP","SNR","SNV","SNX","SO","SOGO","SOI","SOJA","SOJB",
       "SOJC","SOL","SOLN","SON","SOR","SPAQ","SPB","SPE","SPG","SPGI","SPH","SPLP","SPOT","SPR","SPXC","SPXX","SQ","SQM","SQNS","SR","SRC","SRE","SREA","SRF","SRG",
       "SRI","SRL","SRLP","SRT","SRV","SSD","SSI","SSL","SSTK","SSW","SSWA","ST","STAG","STAR","STC","STE","STG","STI","STK","STL","STM","STN","STNG","STON","STOR",
       "STT","STWD","STZ","SU","SUI","SUM","SUN","SUP","SUPV","SUZ","SWCH","SWI","SWJ","SWK","SWM","SWN","SWP","SWX","SWZ","SXC","SXI","SXT","SYF","SYK","SYX","SYY",
       "SZC","T","TAC","TAK","TAL","TALO","TAP","TARO","TBB","TBC","TBI","TCI","TCO","TCP","TCRW","TCRZ","TCS","TD","TDA","TDC","TDE","TDF","TDG","TDI","TDJ","TDOC",
       "TDS","TDW","TDY","TEAF","TECK","TEF","TEI","TEL","TEN","TEO","TEVA","TEX","TFX","TG","TGE","TGH","TGI","TGNA","TGP","TGS","TGT","THC","THG","THGA","THO",
       "THQ","THR","THS","THW","TIF","TISI","TJX","TK","TKC","TKR","TLI","TLK","TLRA","TLRD","TLYS","TM","TME","TMHC","TMO","TMST","TNC","TNET","TNK","TNP","TOL",
       "TOO","TOT","TPB","TPC","TPGH","TPH","TPL","TPR","TPRE","TPVG","TPVY","TPX","TPZ","TR","TRC","TREC","TREX","TRGP","TRI","TRN","TRNE","TRNO","TROX","TRP","TRQ",
       "TRTN","TRTX","TRU","TRV","TRWH","TS","TSE","TSI","TSLF","TSLX","TSM","TSN","TSQ","TSU","TTC","TTI","TTM","TTP","TU","TUFN","TUP","TV","TVC","TVE","TWI",
       "TWLO","TWN","TWO","TWTR","TX","TXT","TY","TYG","TYL","UA","UAA","UAN","UBA","UBER","UBP","UBS","UDR","UE","UFI","UFS","UGI","UGP","UHS","UHT","UI","UIS",
       "UL","UMC","UMH","UN","UNF","UNFI","UNH","UNM","UNMA","UNP","UNT","UNVR","UPS","URI","USA","USAC","USB","USDP","USFD","USM","USNA","USPH","USX","UTF","UTI",
       "UTL","UTX","UVE","UVV","UZA","UZB","UZC","V","VAC","VAL","VALE","VAM","VAPO","VAR","VBF","VCIF","VCRA","VCV","VEC","VEDL","VEEV","VER","VET","VFC","VG",
       "VGI","VGM","VGR","VHI","VICI","VIPS","VIST","VIV","VJET","VKQ","VLO","VLRS","VLT","VMC","VMI","VMO","VMW","VNCE","VNE","VNO","VNTR","VOC","VOYA","VPG","VPV",
       "VRS","VRTV","VSH","VSI","VSLR","VSM","VST","VSTO","VTA","VTN","VTR","VVI","VVR","VVV","VZ","W","WAAS","WAB","WAIR","WAL","WALA","WAT","WBC","WBK","WBS",
       "WBT","WCC","WCG","WCN","WD","WDR","WEA","WEC","WEI","WELL","WES","WEX","WF","WFC","WGO","WH","WHD","WHG","WHR","WIA","WIT","WIW","WK","WLH","WLK","WLKP",
       "WLL","WM","WMB","WMC","WMK","WMT","WNC","WNS","WOR","WORK","WOW","WPC","WPG","WPM","WPP","WPX","WRB","WRE","WRI","WRK","WSM","WSO","WSR","WST","WTI","WTM",
       "WTR","WTRU","WTS","WTTR","WU","WWE","WWW","WY","WYND","X","XAN","XEC","XFLT","XHR","XIN","XOM","XPO","XRF","XRX","XYF","XYL","Y","YELP","YETI","YEXT","YPF",
       "YRD","YUM","YUMC","ZAYO","ZBH","ZBK","ZEN","ZF","ZNH","ZTO","ZTR","ZTS","ZUO","ZYME")

setwd("./NYSE_MACD_Close_15min")

av_api_key("")

for(i in 1:length(symbolsNYSE)){

  #getSomething <- function() alphavantager::av_get(symbol = symbolsNYSE[i], av_fun = "STOCH", interval = "15min", datatype="csv") # default = (fastkperiod=5, slowkpariod=3, slowdperiod=3)
  getSomething <- function() alphavantager::av_get(symbol = symbolsNYSE[i], av_fun = "MACD", interval = "15min", datatype="csv", series_type = "close") #Moving Average Convergence/Divergence. Done open, now high
  #getSomething <- function() alphavantager::av_get(symbol = symbolsNYSE[i], av_fun = "BBANDS", interval = "15min", time_period = 200, series_type = "open")
  #getSomething <- function() alphavantager::av_get(symbol = symbolsNYSE[i], av_fun = "TIME_SERIES_DAILY", output_size = "full")
  badNews <- function() write(symbolsNYSE[i],"badSymbols.txt", append = T)
                                                
tryCatch(
   {
     getSomething()
     name <- paste0("NYSE_MACD_Close_15min_",symbolsNYSE[i],".csv")
     df <- data.frame(getSomething(),symbolsNYSE[i])
     colnames(df) <- c("times", "macd","macd_hist", "mkacd_signal", "symbolNYSE")
     write.csv(df, name, row.names = F)
   },
   error = function(e)
   {
     badNews()
   }
)
  Sys.sleep(3) #sleep the for loop for n.n seconds since max pull is once every n seconds
}
########################################################################################################################
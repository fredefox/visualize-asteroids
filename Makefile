URL="http://www.minorplanetcenter.net/iau/MPCORB/MPCORB.DAT.gz"

data :
	wget ${URL} -cP data
	gunzip -fk data/MPCORB.DAT.gz

URL="http://www.minorplanetcenter.net/iau/MPCORB/MPCORB.DAT.gz"

data :
	wget ${URL} -cP data
	gunzip -fk data/MPCORB.DAT.gz

sanitize : data
	tail -n+42 data/MPCORB.DAT | egrep '^\w{5}' > data/meteors

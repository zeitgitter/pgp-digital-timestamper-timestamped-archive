# --reject-regex ';' prevents Apache directory-listings to be downloaded
#   multiple times in different sort orders
WGET	= wget --recursive --no-clobber --reject-regex ';'

all:
	@echo "Please use 'make get-all' or 'make get-new-sigs'"

get-all:
	${WGET} http://www.itconsult.co.uk/index.htm
	${WGET} http://stamper.itconsult.co.uk/stamper-files/

get-new-sigs:
# Assume that only the indexes need updating, everything else will persist.
	${RM} stamper.itconsult.co.uk/index.html
	${RM} stamper.itconsult.co.uk/*/index.html
# Make sure that on January 1st, the previous year's sig*.txt is retrieved
# again.
	${RM} stamper.itconsult.co.uk/sig`date --date=yesterday +%Y`.txt
	${WGET} http://stamper.itconsult.co.uk/stamper-files/

cron:	get-new-sigs
	git add stamper.itconsult.co.uk/stamper-files/**
	git commit -m "Updated files on `date +%Y-%m-%d`"
	git timestamp --branch gitta-timestamps --server https://gitta.enotar.ch
	git push

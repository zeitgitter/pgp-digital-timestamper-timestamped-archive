# --reject-regex ';' prevents Apache directory-listings to be downloaded
#   multiple times in different sort orders
WGET	= wget --no-verbose --recursive --no-verbose --no-clobber --reject-regex ';'
SDIR	= stamper.itconsult.co.uk/stamper-files
SURL	= http://${SDIR}/

all:
	@echo "Please use 'make get-all' or 'make get-new-sigs'"

get-all:
	${WGET} http://www.itconsult.co.uk/index.htm ${SURL}

get-new-sigs:
# Assume that only the indexes need updating, everything else will persist
# or will be entirely new.
	${RM} ${SDIR}/index.html ${SDIR}/*/index.html
# Make sure that on January 1st, the previous year's sig*.txt is retrieved,
# as it is only complete then.
	${RM} ${SDIR}/sig`date --date=yesterday +%Y`.txt
	${WGET} ${SURL}

cron:	get-new-sigs
	git add ${SDIR}
	git commit -q -S -m "Added `date --date=yesterday +%Y-%m-%d` stamper signatures"
	git timestamp
	git push -q --all

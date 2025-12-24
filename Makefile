# --reject-regex ';' prevents Apache directory-listings to be downloaded
#   multiple times in different sort orders
WGET	= wget --recursive --quiet --no-clobber --reject-regex ';' --https-only
SDIR	= stamper.itconsult.co.uk/stamper-files
SURL	= https://${SDIR}/

all:
	@echo "Please use 'make get-all' or 'make get-new-sigs'"

get-all:
	${WGET} https://www.itconsult.co.uk/ ${SURL}

# Update under the following assumptions:
# - Indexes change daily
# - `sig*.txt` is appended throughout the current year
#   (i.e., on January 1st, fetch the previous year's file for the last time)
# - Everything else will not change once it has been written
get-new-sigs:
	${RM} ${SDIR}/index.html ${SDIR}/*/index.html
	${RM} ${SDIR}/sig`date --date=yesterday +%Y`.txt
	${WGET} ${SURL}

# `git timestamp` is configured with `git config timestamp.{server,interval,…}`
cron:	get-new-sigs
	git add ${SDIR}
	git commit -q -S -m "Added `date --date=yesterday +%Y-%m-%d` stamper signatures"
	git timestamp
	git push -q --all

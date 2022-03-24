EXTENSION = mintomax        # the extensions name
DATA = mintomax--0.0.1.sql  # script files to install
REGRESS = mintomax_test
# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

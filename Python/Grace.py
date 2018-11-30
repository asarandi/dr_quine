#!/usr/bin/env python3

import sys

#
# amazing grace
#

FT = exec
SELF = '#!/usr/bin/env python3%c%cimport sys%c%c#%c# amazing grace%c#%c%cFT = exec%cSELF = %c%s%c%cGRACE = %cf = open(%cGrace_kid.py%c, %cw%c); sys.stdout=f; print(SELF %% (10,10,10,10,10,10,10,10,10,39,SELF,39,10,39,34,34,34,34,39,10,10)); f.close();%c%c%cFT(GRACE)'
GRACE = 'f = open("Grace_kid.py", "w"); sys.stdout=f; print(SELF % (10,10,10,10,10,10,10,10,10,39,SELF,39,10,39,34,34,34,34,39,10,10)); f.close();'

FT(GRACE)

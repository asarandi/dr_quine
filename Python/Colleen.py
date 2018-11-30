#!/usr/bin/env python

#
# comment outside main
#

self = '#!/usr/bin/env python%c%c#%c# comment outside main%c#%c%cself = %c%s%c%c%cdef colleen():%c    print(self %% (10,10,10,10,10,10,39,self,39,10,10,10,10,10,39,39,10,10,10,10,10))%c%cif __name__ == %c__main__%c:%c%c#%c# comment inside main%c#%c    colleen()'

def colleen():
    print(self % (10,10,10,10,10,10,39,self,39,10,10,10,10,10,39,39,10,10,10,10,10))

if __name__ == '__main__':

#
# comment inside main
#
    colleen()

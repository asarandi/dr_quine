#!/bin/bash

#
# comment outside main
#

self='#!/bin/bash\n\n#\n# comment outside main\n#\n\nself=%c%s%c\n\nfunction main() {\n\n#\n# comment inside main\n#\n\n    Q=$(echo -e "\x27")\n    printf "$self" $Q "$self" $Q\n\n}\n\nmain\n'

function main() {

#
# comment inside main
#

    Q=$(echo -e "'")
    printf "$self" $Q "$self" $Q

}

main

#Script that should loop through a whitelist file of known good namespaces that can be deleted
#!/bin/bash
for i in `cat /var/tmp/whitelist.txt`
  do
    oc delete image $i;
done

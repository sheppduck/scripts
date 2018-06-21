Just dumping shit here related to this stuff

docker search zip --limit 100 | cut -d ' ' -f1 | grep -v NAME

Dump it to a file:
docker search zip --limit 100 | cut -d ' ' -f1 | grep -v NAME > /path/to/a/file.txt

this output file we can then feed to my oc-import-sed.sh


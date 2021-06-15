#!/bin/bash

# The script belongs to jrwashburn#0765.
# Redesigned for docker.
# ----------------------------------------
# First you need to install GCLOUD SDK.
# curl https://sdk.cloud.google.com | bash

echo "Exporting mina logs for $(hostname)"
sudo docker exec -it mina mina client export-logs
for GZLOGFILE in /root/.mina-config/exported_logs/*.tar.gz; do
  UPLOADFILENAME=$(hostname)$(echo _)$(basename $GZLOGFILE)
  echo "Uploading $GZLOGFILE to GCS $UPLOADFILENAME"
  gsutil cp $GZLOGFILE gs://YOUR_URL/$UPLOADFILENAME
  if [ $? = 0 ]; then
    rm $GZLOGFILE 
  else
    echo "Uploading $GZLOGFILE failed - will try again next cycle"
  fi
done

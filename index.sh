#! /bin/bash

BASE_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
FILE=$BASE_PATH/script.conf
if [ ! -f "$FILE" ]; then
    printf '%s\n' "Unable to locate configuration file." >&2 
    exit 1
fi

function installS3Cmd () {
    cd $DUMP_PATH
     curl -O -L https://github.com/s3tools/s3cmd/releases/download/v2.0.2/s3cmd-2.0.2.tar.gz
     tar xzf s3cmd-2.0.2.tar.gz
     cd s3cmd-2.0.2
     mkdir -p $LOCAL_BIN
     cp -R s3cmd S3 $LOCAL_BIN
}

function generateS3CmdConfig () {
   touch $LOCAL_BIN/.s3cfg

   cat > $LOCAL_BIN/.s3cfg << EOL
[default]
access_key = ${DO_ACCESS_KEY}
secret_key = ${DO_SECRET_KEY}
host_base = ${DO_ENDPOINT}
host_bucket = ${DO_BUCKET}
enable_multipart = True
multipart_chunk_size_mb = 15
use_https = True
EOL
}

#load config
. $FILE

LOCAL_BIN="$BASE_PATH/bin"
DUMP_PATH=$TMPDIR
TIMESTAMP=$(date +%s)

FILE_NAME="${TIMESTAMP}-${DB_NAME}.sql"
DUMP_FILE="${TMPDIR}/${FILE_NAME}"


# s3cmd config
if ! command -v s3cmd &> /dev/null
then
   if [ ! -f "$LOCAL_BIN/s3cmd" ]; then #check of there is locally installed s3cmd
     printf '%s\n' "Unable to locate s3cmd command, attempting to install.." >&2 
     installS3Cmd
     printf '%s\n' "Generating s3cmd config file.." >&2 
     generateS3CmdConfig
   fi
fi

# execute mysqldump
if ! command -v mysqldump &> /dev/null
then
    printf '%s\n' "Unable to locate mysqldump command, make sure that mysql client dependencies are installed on your system." >&2 
    exit 2
fi
mysqldump -u${DB_USER} -h${DB_HOST} -p${DB_PASS} ${DB_NAME} > $DUMP_FILE
${LOCAL_BIN}/s3cmd -c $LOCAL_BIN/.s3cfg put ${DUMP_FILE} s3://${DO_BUCKET}/${UPLOAD_PATH}/${FILE_NAME}
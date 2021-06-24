# dump-do-space
mysqldump with auto upload to digital ocean spaces
- Assumes mysql-client libraries are installed (mysqldump)
- Assumes Python2 is executable via $PATH
- WIll attempt to install version v2.0.2 of s3Cmd

Install by cloning the repo:

    $ git clone https://github.com/makmakulet/dump-do-space.git
    $ cd dump-do-space

Copy the sample config file:

    $ cp script.conf.sample script.conf

Provide your own configuration values:

DB_HOST=

DB_PORT=

DB_USER=

DB_PASS=

DB_NAME=

UPLOAD_PATH= #custom path after the bucket s3://my-bucket/${UPLOAD_PATH}

DO_ACCESS_KEY=

DO_SECRET_KEY=

DO_ENDPOINT=

DO_BUCKET=





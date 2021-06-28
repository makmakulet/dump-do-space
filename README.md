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

| Config Var      | Description                                                |
| --------------- | ---------------------------------------------------------- |
| DB_HOST         | Database Host                                              |
| DB_PORT         | Database Port                                              |
| DB_USER         | Database Username                                          |
| DB_PASS         | Database Password                                          |
| DB_NAME         | Database Name                                              |
| DB_NAME         | Database Name                                              |
| UPLOAD_PATH     | custom path after the bucket s3://my-bucket/${UPLOAD_PATH} |
| DO_ACCESS_KEY   | Digital Ocean Space Access Key                             |
| DO_SECRET_KEY   | Digital Ocean Space Secret Key                             |
| DO_ENDPOINT     | eg: sgp1.digitaloceanspaces.com                            |
| DO_BUCKET       | eg: [My-Bucket]                                            |
| ENABLE_TG_ALERT | True or False                                              |
| TG_TOKEN        | [tg-bot-token]                                             |
| TG_CHAT_ID      | [tg-chat-id]                                               |

Telegram Bot Resources:
[https://core.telegram.org/bots](https://core.telegram.org/bots)
[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

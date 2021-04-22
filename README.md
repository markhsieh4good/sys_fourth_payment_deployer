## Read Me

當前的啟動專案，是選擇 [ fourth_merge_payment_colorful  ] 

# ref.

nginx-php-fpm :
```
$ git clone https://github.com/wyveo/nginx-php-fpm.git
$ cd nginx-php-fpm
$ git checkout php74
$ vim nginx-php-fpm/Dockerfile

...
            git \
+           net-tools \
            libmemcached-dev \
...
```

改變需求

# deploy layout

```
$ sudo mkdir -p /home/mysql-payment
$ sudo docker create network --driver bridge payment-bridge
$ sudo docker-compose -f docker-compose build
$ sudo docker-compose -f docker-compose up -d
```

如果你需要避免有未知的資料沒有被使用，但又沒用到。
```
$ sudo docker system prune
(choice 'y')
```

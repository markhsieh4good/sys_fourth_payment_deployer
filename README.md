# Read Me

當前的啟動專案，是選擇 [ sys_fourth_payment_merge_colorful ] 

## ref.

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

## deploy layout

```
[linux]
$ sudo mkdir -p /home/mysql-payment
$ sed -i 's/.\/fourth_merge_payment_colorful\/full_system/.\/sys_fourth_payment_merge_colorful\/full_system/g' docker-compose.yml
$ sudo docker network create --driver bridge payment-bridge
$ sudo docker-compose -f docker-compose.yml build
$ sudo docker-compose -f docker-compose.yml up -d

[windows : git for windows or other command line]
> sed -i 's/\/home\/mysql-payment/.\/mysql-payment/g' docker-compose.yml
> sed -i 's/.\/fourth_merge_payment_colorful\/full_system/.\/sys_fourth_payment_merge_colorful\/full_system/g' docker-compose.yml
> mkdir -p ./mysql-payment
> docker network create --driver bridge payment-bridge
> docker-compose -f docker-compose.yml build
> docker-compose -f docker-compose.yml up -d
```

如果你需要避免有未知的資料沒有被使用，但又沒用到。
```
$ sudo docker system prune
(choice 'y')
```

## 正式機組
> 20210520
```
機組網際網路位置	35.221.194.147
域名              www.fcx1040.com
憑證有效期         90 days [https://manage.sslforfree.com/]
ssh auth.        centos@addr.ip, key: 4th_payment

主頁              https://www.fcx1040.com/
管理後臺           主頁+ admin/
代理後台           主頁+ agent/
資料庫後台         主頁+ db_adminer/
```
> db. login
```
系統:MySQL
伺服器:payment.db
帳密: root 123456
資料庫: 可以空白
```
> 管理後臺預設帳戶
```
管理後台：account
    name: admin
    password:  www.0766city.com
```

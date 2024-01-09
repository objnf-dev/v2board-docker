# v2board-docker
用于快速部署[v2board](https://github.com/v2board/v2board)。

## 使用方法

1. 按照需求，修改docker-compose.yml；
2. 使用Docker Compose启动容器；
3. 进入容器v2b-main的交互式命令行（`docker exec -it v2b-main bash`)
4. 删除已有的无效.env文件：`rm .env`
5. 执行：`php artisan v2board:install`，填写各信息；
6. 编辑新生成的`.env`：
	- 修改 `REDIS_HOST=v2b-redis`
	- 增加 `REDIS_CLIENT=predis`
6. 重启v2b-main容器，随后便可正常使用。

## FAQ

- Q：第4步时，出现“数据库连接失败”，该如何解决？
	- A：可以先在v2b-main容器内执行 `docker-php-ext-install pdo_mysql`，重启v2b-main容器，再重试第4步。
- Q：日志中仍然提示“Please make sure the PHP Redis extension is installed and enabled.”该如何解决？
	- A：在容器中执行 `php composer.phar require predis/predis`，重启容器即可。

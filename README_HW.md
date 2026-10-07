Задание 1. Yandex Cloud

Что нужно сделать

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

Бакет создани и доступен из интернета:

![kitten](kitten.png)

2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:
   Помогло внимательное чтение документации, раздел вопросов и ответов и добавление прав сервисному аккаунту:

![output](output.png)

![instance_group](instance_group.png)

![compute_instance](compute_instance.png)

![web-index](web-index.png)

3. Подключить группу к сетевому балансировщику:

![load_balancer](load_balancer.png)

![target-group-lb](target-group-lb.png)

# TinderDog
Проект на основе https://dog.ceo/dog-api
Пользователь просматривает разные изображения собак, добавляет понравившихся в галерею избранного, и имеет возможность узнать какие породы ему нравяться больше всего. 

## Реализация 
- От dog-api по запросу приходит JSON, из которого достаются ссылки на изображение. ### (URLSession)
- При сохранении изображении в "избранное", ссылка на картинку сохраняется как в галерее самого избранного, так и в памяти приложения. ###(CoreData)
- Само избранное созданно на основе TableView. Присутсвует возможность удаления изображения из избранного (и из базы) при тапе на него. ### (TableView)
- Система рекомендации, запоминает породы собак которых лайкал пользователь (незаивисимо от их наличия в избранном), и при нажатии на кнопку выводит название фаворита и запрашивает картинки именно этой породы. ### (CoreData)
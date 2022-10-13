# Tinderdog
Project based on https://dog.ceo/dog-api
The user browses through different images of dogs, adds the ones he likes to the favorites gallery, and has the opportunity to find out which breeds he likes the most.

## Implementation
- MVC with interface layout code. (MVC)
- JSON comes from dog-api upon request, from which links to the image are obtained. (URLSession)
- When saving an image to "favorites", a link to the image is saved both in the gallery of the favorite itself and in the application's memory. (core data)
- Favorites itself is based on TableView. There is an option to remove an image from favorites (and from the database) when you tap on it. (table view)
- The recommendation system remembers the breeds of dogs that the user likes (regardless of their presence in favorites), and when you click on the button, it displays the name of the favorite and requests pictures of this particular breed. It is possible to clear the base by pressing the corresponding button. (core data)

------------------------------------

Проект на основе https://dog.ceo/dog-api
Пользователь просматривает разные изображения собак, добавляет понравившихся в галерею избранного, и имеет возможность узнать какие породы ему нравятся больше всего. 

## Реализация 
- MVC с вёрсткой интерфейса кодом. (MVC)
- От dog-api по запросу приходит JSON, из которого достаются ссылки на изображение. (URLSession)
- При сохранении изображения в "избранное", ссылка на картинку сохраняется как в галерее самого избранного, так и в памяти приложения. (CoreData)
- Само избранное созданно на основе TableView. Присутсвует возможность удаления изображения из избранного (и из базы) при тапе на него. (TableView)
- Система рекомендации, запоминает породы собак которых лайкал пользователь (незаивисимо от их наличия в избранном), и при нажатии на кнопку выводит название фаворита и запрашивает картинки именно этой породы. Возможно очищение базы через нажатие на соответсвующую кнопку. (CoreData)


<img src="TinderDog/Application/Assets.xcassets/Screenshot1 1.imageset/Screenshot1.jpeg" width="256"/> <img src="TinderDog/Application/Assets.xcassets/Screenshot2 1.imageset/Screenshot2.jpeg" width="256"/> <img src="TinderDog/Application/Assets.xcassets/Screenshot3 1.imageset/Screenshot3.jpeg" width="256"/>

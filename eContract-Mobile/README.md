# eContract 
Ứng dụng hợp đồng điện tử


## Cấu trúc thư mục 

````
e_contract/
|-android
|-ios
|-lib
|-linux
|-macos
|-test
````
Cấu trúc thư mục trong thư mục source code dart 

````
lib/
|-constants: chứa các hằng số của toàn bộ app:theme, dimen, string, api enpoint
|-data: thư mục chứa tầng data của ứng dụng. Chứa code Repo, database, gọi backend, cache, sharedPref
|-stores: thư mục chứa các logic code connect giữa tầng data và ui.( có thể tạm hiểu chứa viewmode trong MVVM hoặc là
    bloc trong Bloc
|-ui: thư mục chứa toàn bộ code ui của ứng dụng 
|-utils: thư mục chưa những cái tiện ích chung 
|-widgets: thư mục chứa những custom giao diện dùng chung nhiều nơi: ví dụ: Buttons, Edittext ...
|-main.dart: lớp chính 
````


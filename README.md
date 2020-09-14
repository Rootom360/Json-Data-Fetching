# fetchingdatafromapi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

★ Json data Fetching with the help of News API, and made a News application.

Detailed overview :
1) First things first i searched for free News API which i finally got on this website : https://newsapi.org/ 

2) Then I made new project which name i set "fetchingdatafromapi" and after making the project i deleted my whole boiler codes.

2) Then I added http dependencies in my prubspec.yml file for making http requests in my app, and also i enables assets support in my project by uncomenting assets code after uncommenting code i add my images path to assets function :

assets:
   - assets/placeholder.png

Http => This package makes http requests for your app.

3) After that i configured my main.dart file and added MaterialApp for using material widget in our app :

void main() => runApp(MaterialApp(
     home: NewsListState(),
   ));

4) Then I made a model for converting json data to dart in my model folder and i set filename newsarticle.dart. Lets understand our code :

import 'dart:convert';
 
class NewsArticle {
 final String title;
 final String descrption;
 final String urlToImage;
 
 NewsArticle({this.title, this.descrption, this.urlToImage});
 
 factory NewsArticle.fromJson(Map<String, dynamic> json) {
   return NewsArticle(
       title: json['title'],
       descrption: json['description'],
       urlToImage:
           json['urlToImage'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL);
 }

In this newsarticle.dart file i made a class and in this class i made 3 constructors. After making constructors I made a Factory method, So first we understand what is Factory method and what he does => Factory method in a syntax of dart which makes our code more flexible short and faster if we want to create object and process related object then we use Factory method, in this method i made fromJson function which is gonna take data as argument and returns a new NewsArticle model as You can see in above code. Here is not the end of this model class. We need to make another class in this file but we will cover it after making some other essential files for this file.

5) Then i created Services folder and in this folder i created services.dart file and the code is like this : 

import 'package:http/http.dart' as http;
 
class Resource<T> {
 final String url;
 T Function(http.Response response) parse;
 
 Resource({this.url, this.parse});
}
 
class Webservice {
 Future<T> load<T>(Resource<T> resource) async {
   final response = await http.get(resource.url);
   if (200 == response.statusCode) {
     return resource.parse(response);
   } else if (400 == response.statusCode) {
     print("Bad request");
   } else {
     throw Exception("Failed to load Data");
   }
 }
}

In this file first I am importing the http.dart package as http then I created a Resources class which is gonna make a constructor for our url and response.

After that I made a webservice class which returns a Future method. Then I made an async method for getting my data. In flutter when we use async then we don't know how much time our task takes to get the data so we use Future method. Future allows us to run our synchronised tasks freely.

Then I made the await function, Await function blocks the execution of code when async is doing its work.

And at the end i write some if else statements.

6) Now again i am gonna add some code on my newsarticles.dart which is our model file so in this model file we are adding this code : 

static Resource<List<NewsArticle>> get all {
   return Resource(
       url: Constants.HEADLINE_NEWS_URL,
       parse: (response) {
         final result = json.decode(response.body);
         Iterable list = result['articles'];
         return list.map((model) => NewsArticle.fromJson(model)).toList();
       });
 }
}

In this code as you can see i made a Resource class which is gonna List our all NewsArticles in Listview. Then I made a result variable which is gonna return us json data to dart data. After that i used Iterable class for making a list variable, In dart Iterable is a collection of elements that can be accessed sequentially.

7) This is the last step. Now i am gonna make a UI for my HomeScreen where i want to show News Articles.

First i made UI folder and in this folder i made homescreen.dart file in this file i used statefulwidget because we want to catch the data. In this widget i made write some codes and methods : 

List<NewsArticle> _newsArticles = List<NewsArticle>();
 
 @override
 void initState() {
   super.initState();
   _populateNewsArticles();
 }
 
 void _populateNewsArticles() {
   Webservice().load(NewsArticle.all).then((newsArticles) => {
         setState(() => {_newsArticles = newsArticles})
       });
 }
 
 ListTile _buildItemsForListView(BuildContext context, int index) {
   return ListTile(
     title: _newsArticles[index].urlToImage == null
         ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL)
         : Image.network(_newsArticles[index].urlToImage),
     subtitle: Text(
       _newsArticles[index].title,
       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
     ),
   );
 }

In this code as you can see first i made _newArticles variable which is gonna returns us all our data.

Then I created the initstate method, Initstate is a method which is called once when we use stateful widget, generally we override this method if we need to do some sort of initialisation work like registering.

Then I created _populateNewsArticles method which is gonna call our Webservice and pass it a resource, which finally returns a list of the articles from the website.

At the end i used ListTile widget for getting our new in list view. In this ListTile i set title for getting new url Image and subtitle for getting title of the news.

API Link : https://newsapi.org/v2/top-headlines?country=in&apiKey=683acaca61ce49a9b8e38f63ed109912 

My Project on Github : https://github.com/Rootom360/Json-Data-Fetching 

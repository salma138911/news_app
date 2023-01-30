import 'package:flutter/material.dart';
import 'package:news_app/core/api/api_manager.dart';
import 'package:news_app/core/model/NewsReponse.dart';
import 'package:news_app/view/news/news_item.dart';

import '../../core/model/News.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "search";


  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen>
{
  String query = " ";
  List<News>newsList =[];
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            "assets/images/default_bg.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
    Scaffold(
    appBar: AppBar(
      elevation: 0,
    toolbarHeight: 70,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
    )),
      leading: const SizedBox(),
      leadingWidth: 10,
      title: Container(
        height: 60,
        padding: const EdgeInsets.all(10.0),
        margin:const EdgeInsets.all(10.0) ,
        child: TextFormField(
          onChanged: (String? value){
            print(value!);
            setState((){
              query = value;
            });
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.white),
            ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white),
              ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              onPressed:(){
                Navigator.pop(context);
              } ,
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
            prefixIcon: IconButton(
              onPressed:(){
                Navigator.pop(context);
              } ,
              icon: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
            hintText: "Search Artical",
            hintStyle: TextStyle(
            color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),
            contentPadding: const EdgeInsets.only(top: 10),
          ),
        ),
      ),
    ),
      body:ListView.builder(itemBuilder:(context,index)=>NewsItem(search().elementAt(index)),
      itemCount: search().length,) ,

    ),
      ],
    );

  }
  List search(){
    ApiManager.getNews(query:query ).then((newsReponse){

 newsList = newsReponse.newsList ?? [];
    }).catchError((error){
      debugPrint("error during call api$error");
    });
    return newsList;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/api/api_manager.dart';
import 'package:news_app/core/model/NewsReponse.dart';
import 'package:news_app/view/news/news_item.dart';

import '../../core/model/Source.dart';

class NewsList extends StatelessWidget {
Source source;
NewsList(this.source);
  @override
  Widget build(BuildContext context) {
    return Container(
child: FutureBuilder<NewsReponse>(
  future: ApiManager.getNews(sourceId:source.id??''),
  builder: (buildContext,snapshot){
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (snapshot.hasError) {
      return Center(
        child: Text('Error loading data${snapshot.error.toString()}'),
      );
    }
    if (snapshot.data?.status == 'error') {
      return Center(
        child: Text('Server Error${snapshot.data?.message}'),
      );
    }
    var newsList=snapshot.data?.newsList;
    return ListView.builder(itemBuilder:(_,index){
return NewsItem(newsList![index]);
    },itemCount: newsList?.length??0,);
  },
),
    );
  }
}

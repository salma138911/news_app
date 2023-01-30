import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/model/NewsReponse.dart';
import 'package:news_app/core/model/SourcesResponse.dart';

class ApiManager {
  static const String baseurl = 'newsapi.org';
  static const String apiKey = 'fc34849494d5419d943baa415c52e587';
  static Future<SourcesResponse> getSources(String categoryId) async {
    var url = Uri.https(baseurl, '/v2/top-headlines/sources',
        {'apiKey': apiKey, 'category': categoryId});
    var response = await http.get(url);
    return SourcesResponse.fromJson(jsonDecode(response.body));
  }
  //https://newsapi.org/v2/everything?apiKey=fff1911fb5fc4111bfc9ebcf79e42332&sources=bbc-sport
static Future<NewsReponse> getNews({String? sourceId, String? query})async{
    var url=Uri.https(baseurl,'v2/everything',
    {
      'apiKey':apiKey,
      'sources':sourceId,
      'q':query,
    });
    var response= await http.get(url);
    return NewsReponse.fromJson(jsonDecode(response.body));
}
}

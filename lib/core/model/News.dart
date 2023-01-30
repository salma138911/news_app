import 'Source.dart';

/// source : {"id":"bbc-news","name":"BBC News"}
/// author : null
/// title : "Leaders Gloucester-Hartpury maintain 100% start"
/// description : "Premier 15s leaders Gloucester-Hartpury continue their winning start with a ninth consecutive victory as the top four teams in the division all win."
/// url : "https://www.bbc.co.uk/sport/rugby-union/64439270"
/// urlToImage : "https://ichef.bbci.co.uk/live-experience/cps/624/cpsprodpb/CFAC/production/_128446135_ellierugman_getty.jpg"
/// publishedAt : "2023-01-28T18:20:41Z"
/// content : "Gloucester-Hartpury managed just nine wins in the Premier 15s last season\r\nLeaders Gloucester-Hartpury extended their winning start to the Premier 15s campaign to nine matches with a 41-7 victory at … [+2440 chars]"

class News {
  News({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,});

  News.fromJson(dynamic json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (source != null) {
      map['source'] = source?.toJson();
    }
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt;
    map['content'] = content;
    return map;
  }

}
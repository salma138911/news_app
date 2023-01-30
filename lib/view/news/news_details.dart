import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/model/News.dart';

class Newsdetails extends StatelessWidget {
  static const String routeName = "news details";
  const Newsdetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    News news = ModalRoute.of(context)!.settings.arguments as News;
    var publishedAt = DateTime.parse(news.publishedAt ?? "");
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
                title: Text("News Details"),
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ))),
            body: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: news.urlToImage ?? '',
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 200,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    news.author ?? "",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Color.fromARGB(121, 130, 139, 100)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    news.title ?? "",
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${showPublishedAt(news)}",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Color.fromARGB(163, 163, 163, 100)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 1,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          news.description ?? "",
                        ),
                        InkWell(
                          onTap: () {
                            _launchUrl(Uri.parse(news.url ?? ""));
                          },
                          child:  Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "View Full Artical",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(66, 80, 92, 100),
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Color.fromARGB(66, 80, 92, 100),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }

  showPublishedAt(News news) {
    var dateTimeNow = DateTime.now();
    var diffrence = dateTimeNow
        .difference(DateTime.parse(news.publishedAt ?? ""))
        .inMinutes;
    if (diffrence < 0) {
      diffrence = dateTimeNow
          .difference(DateTime.parse(news.publishedAt ?? ""))
          .inSeconds;
      return '$diffrence seconds ago';
    } else if (diffrence > 0 && diffrence < 60) {
      diffrence = dateTimeNow
          .difference(DateTime.parse(news.publishedAt ?? ""))
          .inMinutes;
      return '$diffrence minutes ago';
    } else if (diffrence > 60 && diffrence < 1440) {
      diffrence = dateTimeNow
          .difference(DateTime.parse(news.publishedAt ?? ""))
          .inHours;
      return '$diffrence hours ago';
    } else if (diffrence > 1440 && diffrence < 44640) {
      diffrence =
          dateTimeNow.difference(DateTime.parse(news.publishedAt ?? "")).inDays;
      return '$diffrence days ago';
    } else {
      return DateFormat.yMMMMd().format(DateTime.parse(news.publishedAt ?? ''));
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

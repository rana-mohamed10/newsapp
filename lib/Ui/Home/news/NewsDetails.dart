import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Model/NewsResponse/News.dart';
import 'package:newsapp/Ui/Home/news/NewsWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsDetails extends StatefulWidget {
  static const String routeName = 'NewsDetails';
  News? news;
  NewsDetails([this.news]);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  bool showFullArticle = false;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as NewsWidget;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('assets/images/pattern.png')),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.news_details ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Card(
          shadowColor: Colors.black,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                colors: [Colors.white, Color(0x3EB489)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: args.news.urlToImage ?? "",
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Text(
                      args.news.author ?? "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(args.news.title ?? "", textAlign: TextAlign.start),
                    Text(args.news.publishedAt ?? "", textAlign: TextAlign.end),
                    SizedBox(
                      height: 10,
                    ),
                    Text(args.news.content ?? "", textAlign: TextAlign.center),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showFullArticle = !showFullArticle;
                          });
                        },
                        child: showFullArticle
                            ? Text(
                                AppLocalizations.of(context)!.show_less,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : Text(
                                AppLocalizations.of(context)!.show_full_article,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    if (showFullArticle)
                      Text(
                        args.news.description ?? "",
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

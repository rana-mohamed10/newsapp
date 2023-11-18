import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Model/NewsResponse/News.dart';

class NewsWidget extends StatelessWidget {
  News news;
  NewsWidget(this.news);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(colors: [Colors.white,Color(0x3EB489)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                CachedNetworkImage(
                  imageUrl: news.urlToImage ??"" ,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
               ),
              Text(news.author??"",textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),),
              Text(news.title??"",textAlign: TextAlign.start),
              Text(news.publishedAt??"",textAlign: TextAlign.end)

              ],
          ),
        ),
      ),
    );
  }
}

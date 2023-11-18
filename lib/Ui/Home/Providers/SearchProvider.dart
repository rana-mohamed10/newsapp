import 'package:flutter/material.dart';
import 'package:newsapp/Model/NewsResponse/News.dart';
import 'package:newsapp/Model/NewsResponse/NewsResponse.dart';

class SearchProvider extends ChangeNotifier {
  List<News?> filteredNews = [];
  NewsResponse? news;
  String? search = '';

  List<News?> filterNews(String filter) {
    search = filter.toLowerCase();

    if (news?.articles != null) {

      filteredNews.addAll(news!.articles!.where((article) =>
      article.title?.toLowerCase().contains(search!) == true ||
          article.content?.toLowerCase().contains(search!) == true));
    }
    notifyListeners();

    return filteredNews;
  }


}

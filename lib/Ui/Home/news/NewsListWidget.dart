import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Model/SourcesResponse/Sources.dart';
import 'package:newsapp/Ui/Home/news/NewsDetails.dart';
import 'package:newsapp/Ui/Home/news/NewsDetailsViewModel.dart';
import 'package:newsapp/Ui/Home/news/NewsWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Model/NewsResponse/News.dart';



typedef void NewsListCallback();

class NewsListWidget extends StatefulWidget {
  Source source;
  int page =1;
  int count=0;
  int pageSize=5;
  var newsList = [];
  final NewsListCallback? onRefresh;

  NewsListWidget(this.source, {this.onRefresh,Key? key});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  var viewModel=NewsDetailsViewModel();
  final Scrollcontroller = ScrollController() ;
  bool nextPage = false;

  NewsListCallback? onRefresh;

  void setOnRefreshCallback(NewsListCallback callback) {
    onRefresh = callback;
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadNews(widget.source.id,widget.page);
    Scrollcontroller.addListener(() {
      if (Scrollcontroller.position.atEdge) {
        setState(() {
          widget.page++;
          widget.pageSize+=5;
          nextPage=true;
        });
        onRefresh?.call();
        viewModel.loadNews(widget.source.id, widget.page);
      }
    });
  }
  @override
  void didUpdateWidget(covariant NewsListWidget oldWidget) {
    print("didUpdateWidget");
    viewModel.loadNews(widget.source.id,widget.page);
    super.didUpdateWidget(oldWidget);
  }
  Future <void> MyRefresh()async {
    viewModel.loadNews(widget.source.id,widget.page);
}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsDetailsViewModel,NewsDetailsState>(
      bloc: viewModel,
      builder: (context, state){
      switch(state){
        case SuccessState():
          {
            var newsList = state.newsList;
            if (newsList!.isEmpty || nextPage) {
              List<News> tempList = List.from(newsList);
              newsList.clear();
              newsList.addAll(tempList);
              nextPage = false;
            }

            return RefreshIndicator(onRefresh: () => MyRefresh(),
              child: ListView.builder(
                  controller: Scrollcontroller,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            NewsDetails.routeName,
                            arguments: NewsWidget(newsList[index]),
                          );
                        },
                        child: NewsWidget(newsList[index]));
                  },
                  itemCount: newsList.length,
                ),
            );
            }
          case LoadingState():
          return Center(child: CircularProgressIndicator());
        case ErrorState():
          {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  ElevatedButton(onPressed: () {
                    viewModel.loadNews(widget.source.id,widget.page);
                  }, child: Text(AppLocalizations.of(context)!.try_again))
                ],
              ),
            );
          }
      }
    },);
  }
}
import 'package:flutter/material.dart';
import 'package:newsapp/Model/SourcesResponse/Sources.dart';
import 'package:newsapp/Ui/Home/news/NewsDetails.dart';
import 'package:newsapp/Ui/Home/news/NewsWidget.dart';
import 'package:newsapp/api/ApiManager.dart';


typedef void NewsListCallback();

class NewsListWidget extends StatefulWidget {
  Source source;
  int page =1;
  int count=0;
  var newsList = [];
  final NewsListCallback? onRefresh;

  NewsListWidget(this.source, {this.onRefresh,Key? key});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {

  final Scrollcontroller = ScrollController() ;
  bool nextPage = false;

  NewsListCallback? onRefresh;

  void setOnRefreshCallback(NewsListCallback callback) {
    onRefresh = callback;
  }

  @override
  void initState() {
    super.initState();
    Scrollcontroller.addListener(() {
      if (!Scrollcontroller.position.outOfRange &&
          Scrollcontroller.position.pixels ==
              Scrollcontroller.position.maxScrollExtent
          ) {
        setState(() {
          widget.page++;
          nextPage=true;
        });
        onRefresh?.call();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //call api
    return FutureBuilder(
      future: ApiManager.getNews(widget.source.id,page:widget.page ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && widget.newsList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data?.status == 'error') {
          return Center(
            child: Column(
              children: [
                Text(snapshot.data?.message ?? snapshot.error.toString()),
                ElevatedButton(onPressed: () {
                  ApiManager.getNews(widget.source.id,page:widget.page );}
                    , child: Text('Try Again')),
              ],
            ),
          );
        }
        print('${widget.page} nextttt $nextPage');
        if(widget.newsList.isEmpty || nextPage){
          widget.newsList.addAll(snapshot.data?.articles ??[]);
          print('ANA SPONGEBOB ${widget.newsList}');
          nextPage=false;
        }
        return ListView.builder(
          controller: Scrollcontroller,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(
                  NewsDetails.routeName,
                  arguments: NewsWidget(widget.newsList[index]),
                );
              },
                child: NewsWidget(widget.newsList[index]));
          },
          itemCount: widget.newsList.length,
        );
      },
    );
  }
}
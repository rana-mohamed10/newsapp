import 'package:flutter/material.dart';
import 'package:newsapp/Model/SourcesResponse/Sources.dart';
import 'package:newsapp/Ui/Home/CategoryDetails/Tabwidget.dart';
import 'package:newsapp/Ui/Home/news/NewsListWidget.dart';

class SourcesTabWidget extends StatefulWidget {
  List<Source> sources;
  int page=1;
  SourcesTabWidget(this.sources,{super.key});

  @override
  State<SourcesTabWidget> createState() => _SourcesTabWidgetState();
}

class _SourcesTabWidgetState extends State<SourcesTabWidget> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sources.length,
      child: Column(
        children: [
          SizedBox(height: 12,),
          TabBar(
            indicatorColor: Colors.transparent,
            onTap: (newIndex){
              selectedIndex=newIndex;
              setState((){
              });
            },
              isScrollable: true,
              tabs: widget.sources.map((source) => TabWidget(source,
                widget.sources.indexOf(source)==selectedIndex
              )).toList()
          ),
          Expanded(child: NewsListWidget(widget.sources[selectedIndex],))
        ],
      ),
    );
  }
}

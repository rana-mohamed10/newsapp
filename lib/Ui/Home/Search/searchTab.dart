import 'package:flutter/material.dart';
import 'package:newsapp/Model/SourcesResponse/Sources.dart';
import 'package:newsapp/Ui/Home/Providers/SearchProvider.dart';
import 'package:newsapp/Ui/Home/news/NewsWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../api/ApiManager.dart';
import '../news/NewsDetails.dart';

class searchTab extends StatefulWidget {
  static const String routeName = 'Search';
  Source? source;
  searchTab([this.source]);

  @override
  State<searchTab> createState() => _searchTabState();
}

class _searchTabState extends State<searchTab> {
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context);
    int page=1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 10),
          child: SizedBox(
            height: 45,
            child: TextFormField(
              onTap: () {},
              controller: controller,
              onChanged: (value) {
                print('value $value');
                searchProvider.filterNews(value);
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: const Color(0xffFFFFFF),
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF39A552),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                hintText: AppLocalizations.of(context)!.search,
                hintStyle: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF39A552),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiManager.getNews(widget.source?.id, query: controller.text,page:page),
              builder: (context, snapshot) {
                if (snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }
                else if(searchProvider.search!.isEmpty || controller.text.isEmpty){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.newspaper, size: 80, color: Color(0xFF39A552)),
                        Text(
                          AppLocalizations.of(context)?.no_news_found ?? "",
                          style: TextStyle(color: Color(0xFF39A552),
                              fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  );
                }
               else if (searchProvider.search!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data?.totalResults,
                    itemBuilder: (context, index) {
                      var article = snapshot.data?.articles;
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(
                            NewsDetails.routeName,
                            arguments: NewsWidget(article[index]),
                          );
                        },
                        child: NewsWidget(
                          article![index],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.newspaper, size: 80, color: Color(0xFF39A552)),
                        Text(
                          AppLocalizations.of(context)?.no_news_found ?? "",
                          style: TextStyle(color: Color(0xFF39A552,)
                              ,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

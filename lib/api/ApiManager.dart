import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Model/NewsResponse/NewsResponse.dart';
import 'package:newsapp/Model/SourcesResponse/SourcesResponse.dart';

//newApi : 95cf08f0a0944aed82c95acde9acd38e
//oldAPI: 78f70388f8354ed7b16ce8eace3d2ee4
//kotty: 1399683c36cd4cd7897abab28c11f791
class ApiManager {
  static const baseUrl='newsapi.org';
  static const apiKey="95cf08f0a0944aed82c95acde9acd38e";
 static Future<SourcesResponse> getSources (String categoryId) async{
    var uri=Uri.https(baseUrl,'v2/top-headlines/sources',
    {
      "apiKey":apiKey,
      "category" : categoryId
    });
  var response = await http.get(uri);
  print(response.body);
  var json= jsonDecode(response.body);
  var sourcesResponse=SourcesResponse.fromJson(json);
  return sourcesResponse;
  }

  static Future <NewsResponse> getNews (String? sourceId,{String? query,String? id,required int page}) async{
    var url= Uri.https(baseUrl,'v2/everything',
      {
        "apiKey":apiKey,
        "sources":sourceId,
        'q': query,
        "page":'$page',
        "pageSize":"5"
      });
    var response= await http.get(url);
    print(response.body);
    var json= jsonDecode(response.body);
    var newsResponse=NewsResponse.fromJson(json);
    return newsResponse;
  }
}
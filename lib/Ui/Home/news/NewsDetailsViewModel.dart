import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Model/NewsResponse/News.dart';
import 'package:newsapp/api/ApiManager.dart';



class NewsDetailsViewModel extends Cubit<NewsDetailsState>{
  NewsDetailsViewModel():super(LoadingState('Loading...'));
  void loadNews(String? sourceId,int page)async{
    emit(LoadingState('Loading...'));
    try{
      var response = await ApiManager.getNews(sourceId);
      if(response.status=='error'){
        emit(ErrorState(response.message??""));
      }else {
        emit(SuccessState(response.articles));
      }
    }catch(e){
      emit(ErrorState(e.toString()));
    }
  }
}



sealed class NewsDetailsState{}

class SuccessState extends NewsDetailsState{
  List<News>? newsList;
  SuccessState(this.newsList);
}


class LoadingState extends NewsDetailsState{
  String message;
  LoadingState(this.message);
}
class ErrorState extends NewsDetailsState{
  String errorMessage;
  ErrorState(this.errorMessage);
}
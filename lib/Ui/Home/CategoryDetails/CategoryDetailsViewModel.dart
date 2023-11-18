import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Model/SourcesResponse/Sources.dart';
import 'package:newsapp/api/ApiManager.dart';



class CategoryDetailsViewModel extends Cubit<CategoryDetailsState>{
  CategoryDetailsViewModel():super(LoadingState('Loading...'));

  void loadSources(String categoryId)async{
    emit(LoadingState('Loading...'));
    try{
      var response = await ApiManager.getSources(categoryId);
      if(response.status=='error'){
        emit(ErrorState(response.message??""));
      }else {
        emit(SuccessState(response.sources));
      }
    }catch(e){
      emit(ErrorState(e.toString()));
    }
  }
}



sealed class CategoryDetailsState{}

class SuccessState extends CategoryDetailsState{
  List<Source>? sourceList;
  SuccessState(this.sourceList);
}


class LoadingState extends CategoryDetailsState{
 String message;
  LoadingState(this.message);
}
class ErrorState extends CategoryDetailsState{
  String errorMessage;
  ErrorState(this.errorMessage);
}
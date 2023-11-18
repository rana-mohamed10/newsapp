import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Ui/Home/Categories/Category.dart';
import 'package:newsapp/Ui/Home/CategoryDetails/CategoryDetailsViewModel.dart';
import 'package:newsapp/Ui/Home/CategoryDetails/SourcesTabsWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CategoryDetails extends StatefulWidget {
  Category category;

  CategoryDetails(this.category,{super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var viewModel= CategoryDetailsViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.loadSources(widget.category.id);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsViewModel, CategoryDetailsState>
      (bloc: viewModel,
      builder: (context, state) {
        switch(state){

          case SuccessState():
            var sourcesList = state.sourceList;
            return SourcesTabWidget(sourcesList!);
          case LoadingState():
            {
              return Center(
                  child: Column(
                    children: [
                      Text(state.message),
                      CircularProgressIndicator(),
                    ],
                  ));
            }
          case ErrorState():
            {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.loadSources(widget.category.id);
                      },
                      child: Text(AppLocalizations.of(context)!.try_again))
                ],
              ),
            );
        }

        }
    },);

  }
}

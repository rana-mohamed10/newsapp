
import 'package:flutter/material.dart';

import 'package:newsapp/Ui/Home/Categories/Category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'CategoriesWidget.dart';

typedef OnCategoryClick = void Function(Category category);

class CategoriesFragment extends StatelessWidget {
  static const String routeName='Category';
  OnCategoryClick onCategoryClick;
  CategoriesFragment(this.onCategoryClick,{super.key});
  @override
  Widget build(BuildContext context) {
    List<Category> categories = Category.getAllCategories(context);

    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.pick_your_Category,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24 ,
                  crossAxisSpacing: 20
              ),
              itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    onCategoryClick(categories[index]);
                  },
                  child: CategoryItem(categories[index],index)),
              itemCount: categories.length,),
          )
        ],
      ),
    );
  }
}
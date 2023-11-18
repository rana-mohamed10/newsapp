
import 'package:flutter/material.dart';
import 'package:newsapp/Ui/Home/Categories/Category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


typedef OnMenuItemClick= void Function(MenuItem ClickedItemPos);
class HomeDrawer extends StatelessWidget{
  OnMenuItemClick onMenuItemClick;
  HomeDrawer(this.onMenuItemClick,{super.key});
  @override

  Widget build(BuildContext context) {
    List<Category> categories = Category.getAllCategories(context);

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical:48
              ),
              alignment: Alignment.center,
              color: Theme.of(context).primaryColor,
              child: Text(AppLocalizations.of(context)!.news_app,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),),
            ),
            InkWell(
              onTap: (){
                onMenuItemClick(MenuItem.categories);
              },
              child: Row(
                children: [
                  Icon(Icons.list,size: 32,),
                  Text(AppLocalizations.of(context)!.category,style:
                  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                onMenuItemClick(MenuItem.settings);
              },
              child: Row(
                children: [
                  Icon(Icons.settings,size: 32,),
                  Text(AppLocalizations.of(context)!.setting,style:
                  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}

enum MenuItem {
  categories,
  settings
}
import 'package:flutter/material.dart';
import 'package:newsapp/Ui/Home/Categories/CategoriesFragment.dart';
import 'package:newsapp/Ui/Home/Categories/Category.dart';
import 'package:newsapp/Ui/Home/CategoryDetails/CategoryDetails.dart';
import 'package:newsapp/Ui/Home/HomeDrawer.dart';
import 'package:newsapp/Ui/Home/Search/searchTab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newsapp/Ui/Home/Settings/Settings.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget selectedWidget;
  bool search = false;

  @override
  void initState() {
    super.initState();
    selectedWidget = CategoriesFragment(onCategoryItemClick);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('assets/images/pattern.png')),
      ),
      child: Scaffold(
        body: selectedWidget,
        drawer: HomeDrawer(onMenuItemClick),
        appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(AppLocalizations.of(context)!.news_app),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  search = true;
                  if (search) {
                    Navigator.pushNamed(context, searchTab.routeName);
                  }
                });
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }

  void onMenuItemClick(MenuItem item) {
    Navigator.pop(context);
    switch (item) {
      case MenuItem.categories:
        {
          setState(() {
            selectedWidget = CategoriesFragment(onCategoryItemClick);
          });
          break;
        }
      case MenuItem.settings:
        {
          setState(() {
            selectedWidget = SettingsTab(() {
              Navigator.of(context).pushNamed(SettingsTab.routeName);
            },);
          });
          break;
        }
    }
  }

  void onCategoryItemClick(Category category) {
    setState(() {
      selectedWidget = CategoryDetails(category);
    });
  }
}



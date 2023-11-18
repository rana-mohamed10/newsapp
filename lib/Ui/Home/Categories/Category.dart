import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class Category{
  String id;
  String title;
  Color color;
  String imageName;
  Category(this.id,this.title,this.imageName, this.color);

  static List<Category> getAllCategories(BuildContext context){
    return[
      Category('sports', AppLocalizations.of(context)!.sport, 'ball.png', Color(0xFFC91C22)),
      Category('general', AppLocalizations.of(context)!.general, 'Politics.png', Color(0xFF003E90)),
      Category('health', AppLocalizations.of(context)!.health, 'health.png', Color(0xFFED1E79)),
      Category('business', AppLocalizations.of(context)!.business, 'bussines.png', Color(0xFFCF7E48)),
      Category('technology', AppLocalizations.of(context)!.technology, 'environment.png', Color(0xFF4882CF)),
      Category('science',AppLocalizations.of(context)!.science, 'science.png', Color(0xFFF2D352)),

    ];
  }
}
import 'package:flutter/material.dart';
import 'package:newsapp/Ui/Home/Providers/SettingsProvider.dart';
import 'package:newsapp/Ui/Home/Settings/LanguageBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


typedef OnSettingClick = void Function();

class SettingsTab extends StatefulWidget {
  static const String routeName='Setting';
  OnSettingClick onSettingClick;
  SettingsTab(this.onSettingClick);
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SettingProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 64,
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,style:
          TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              ShowLanguageBottomSheet();
            },
            child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  provider.currentLocale=='ar'
                      ?'العربية'
                      :'English',
                  style: TextStyle(fontSize: 18,
                      color:Colors.black),
                  textAlign: TextAlign.start,
                ),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color:Colors.white,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                )),
          ),
        ],
      ),
    );
  }

  void ShowLanguageBottomSheet() {
    var provider=Provider.of<SettingProvider>(context, listen: false);

    showModalBottomSheet(

      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFFA1D2B3),
          child: Column(
            children: [LanguageBottomSheet()],
          ),
          // child: ,
        );
      },
    );
  }
}
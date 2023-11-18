import 'package:flutter/material.dart';
import 'package:newsapp/Ui/Home/Providers/SettingsProvider.dart';
import 'package:provider/provider.dart';


class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SettingProvider>(context);
    return Container(
      padding: EdgeInsets.all(18),
      color:  Color(0xFFA1D2B3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                provider.changeLang("ar");
              },
              child: provider.currentLocale == 'ar'
                  ? getSelectedItem("العربية")
                  : getUnSelectedItem("العربية")),
          InkWell(
              onTap: () {
                provider.changeLang('en');
              },
              child: provider.currentLocale == 'en'
                  ? getSelectedItem("English")
                  : getUnSelectedItem("English"))
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        Icon(
          Icons.check,
          color:  Colors.black,
        ),
      ],
    );
  }

  Widget getUnSelectedItem(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
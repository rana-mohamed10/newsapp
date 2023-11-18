import 'package:flutter/material.dart';
import 'package:newsapp/SplashScreen.dart';
import 'package:newsapp/Ui/Home/HomeScreen.dart';
import 'package:newsapp/Ui/Home/Providers/SearchProvider.dart';
import 'package:newsapp/Ui/Home/Providers/SettingsProvider.dart';
import 'package:newsapp/Ui/Home/Search/searchTab.dart';
import 'package:newsapp/Ui/Home/news/NewsDetails.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SettingProvider settingProvider = SettingProvider();
  await settingProvider.loadLocale(); // Call loadLocale here
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingProvider),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider=Provider.of<SettingProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: Locale(settingProvider.currentLocale),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: const Color(0xFF39A552),
            iconTheme: IconThemeData(
                color: Colors.white
            ),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 22
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)
                )
            )
        ),
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF39A552),
            primary: const Color(0xFF39A552) ),
        useMaterial3: true,
      ),
      routes: {
        searchTab.routeName : (_)=>searchTab(),
        NewsDetails.routeName : (_)=>NewsDetails(),
        SplashScreen.routeName : (_)=>SplashScreen(),
        HomeScreen.routeName : (_)=>HomeScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
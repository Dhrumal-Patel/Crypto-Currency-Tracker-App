import 'package:cryptocurrency_tracker/constants/Themes.dart';
import 'package:cryptocurrency_tracker/models/LocalStorage.dart';
import 'package:cryptocurrency_tracker/pages/HomePage.dart';
import 'package:cryptocurrency_tracker/providers/market_provider.dart';
import 'package:cryptocurrency_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({Key? key,required this.theme}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(create: ((context) => ThemeProvider(theme)))
        ],
        child:Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
            themeMode:themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: HomePage(),
        );
        }),);

        // 
        
  }
}

import 'package:cryptocurrency_tracker/models/CryptoCurrency.dart';
import 'package:cryptocurrency_tracker/pages/DetailsPage.dart';
import 'package:cryptocurrency_tracker/pages/Favourites.dart';
import 'package:cryptocurrency_tracker/pages/Markets.dart';
import 'package:cryptocurrency_tracker/providers/market_provider.dart';
import 'package:cryptocurrency_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Crypto Currency Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: (themeProvider.themeMode == ThemeMode.light)
                ? Icon(Icons.dark_mode,color: Colors.white,)
                : Icon(Icons.light_mode),
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          controller: tabController, tabs: [
                Tab(
                  child: Text(
                    "Markets",
                    
                  ),
                ),
                Tab(
                  child: Text(
                    "Favourites",
                    
                  ),
                )
              ]),
      ),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 0),
          child: Column(
            children: [
              
              Expanded(
                child: TabBarView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: tabController,
                    children: [Markets(), Favourites()]),
              )
            ],
          ),
        ),
      )),
    );
  }
}

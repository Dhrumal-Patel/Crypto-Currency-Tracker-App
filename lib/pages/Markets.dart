import 'package:cryptocurrency_tracker/Widgets/CryptoListtile.dart';
import 'package:cryptocurrency_tracker/models/CryptoCurrency.dart';
import 'package:cryptocurrency_tracker/pages/DetailsPage.dart';
import 'package:cryptocurrency_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(child: Consumer<MarketProvider>(
                  builder: (context, marketProvider, child) {
                if (marketProvider.isLoading == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (marketProvider.markets.length > 0) {
                    return RefreshIndicator(
                      onRefresh: () async{
                        await marketProvider.fetchData();
                      },
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index) {
                            CryptoCurrency currentCrypto =
                                marketProvider.markets[index];
                            return CryptoListTile(currentCrypto: currentCrypto);
                          },
                          itemCount: marketProvider.markets.length),
                    );
                  } else {
                    return Text("Data not found");
                  }
                }
              }));
  }
}
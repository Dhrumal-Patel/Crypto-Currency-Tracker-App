import 'package:cryptocurrency_tracker/Widgets/CryptoListtile.dart';
import 'package:cryptocurrency_tracker/models/CryptoCurrency.dart';
import 'package:cryptocurrency_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: ((context, marketProvider, child) {
      
      List<CryptoCurrency> favourites = marketProvider.markets.where((element) => element.isFavourite == true).toList();
      if (favourites.length > 0) {
        
      
      return ListView.builder(itemCount: favourites.length, itemBuilder: (context,index){
        CryptoCurrency currentCrypto = favourites[index];
        return CryptoListTile(currentCrypto: currentCrypto);
      });
      }else{
        return Center(child: Text("No Favourite Yet",style: TextStyle(color: Colors.grey,fontSize: 20),),);
      }
    }));
       
      //Container(
    //     child: Text("Favourites will show up here"),
    //   ),
    // );
  }
}
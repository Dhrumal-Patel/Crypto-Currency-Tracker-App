import 'dart:async';

import 'package:cryptocurrency_tracker/models/API.dart';
import 'package:cryptocurrency_tracker/models/CryptoCurrency.dart';
import 'package:cryptocurrency_tracker/models/LocalStorage.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier{
bool isLoading = true;
  List<CryptoCurrency> markets = [];  

  MarketProvider(){
    fetchData();
  }

  Future <void> fetchData() async{
   List<dynamic> _market = await API.getMarket();
   List<String> favourites = await LocalStorage.fetchFavourites();

  List<CryptoCurrency> temp = [];
   for (var market in _market) {
     CryptoCurrency newCrypto = CryptoCurrency.fromJson(market);

    if (favourites.contains(newCrypto.id!)) {
      newCrypto.isFavourite=true;
    }

     temp.add(newCrypto);
   }
   markets=temp;
   isLoading=false;
   notifyListeners();

   
  }

   CryptoCurrency fetchCryptoById(String id){
    CryptoCurrency crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
   }
  
    void addFavourite(CryptoCurrency crypto) async{
      int indexOfCrypto = markets.indexOf(crypto);
      markets[indexOfCrypto].isFavourite = true;
      await LocalStorage.addFavourite(crypto.id!);
      notifyListeners();
    }

     void removeFavourite(CryptoCurrency crypto)async{
      int indexOfCrypto = markets.indexOf(crypto);
      markets[indexOfCrypto].isFavourite = false;
      await LocalStorage.removeFavourite(crypto.id!);
      notifyListeners();
    }
}
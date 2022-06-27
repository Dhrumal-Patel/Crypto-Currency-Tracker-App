import 'package:cryptocurrency_tracker/models/CryptoCurrency.dart';
import 'package:cryptocurrency_tracker/pages/DetailsPage.dart';
import 'package:cryptocurrency_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CryptoListTile extends StatelessWidget {

  final CryptoCurrency currentCrypto;

  const CryptoListTile({Key? key,required this.currentCrypto}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {

    MarketProvider marketProvider = Provider.of<MarketProvider>(context,listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      id: currentCrypto.id!,
                    )));
      },
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Text(currentCrypto.name!),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
            style: TextStyle(
              color: Color(0xff0395eb),
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          Builder(builder: (context) {
            double priceChange = currentCrypto.priceChange24!;
            double priceChangePercentage =
                currentCrypto.priceChangePercentage24!;
            if (priceChange < 0) {
              //negative
              return Text(
                "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                style: TextStyle(color: Colors.red),
              );
            } else {
              //positive
              return Text(
                "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                style: TextStyle(color: Colors.green),
              );
            }
          }),
        ],
      ),
    );
  }
}

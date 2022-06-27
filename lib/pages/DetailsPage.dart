import 'package:cryptocurrency_tracker/constants/Themes.dart';
import 'package:cryptocurrency_tracker/models/CryptoCurrency.dart';
import 'package:cryptocurrency_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  late ThemeMode themeMode;
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment,) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17,color: (themeMode == ThemeMode.light)?Colors.black:Colors.white),
        ),
        Text(detail,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17,color:Colors.grey))
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (() {
          Navigator.of(context).pop();
        }), icon: Icon(Icons.arrow_back),color: Colors.white,),
        title:Text("Currency Detail",style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20
          ),
          child: Consumer<MarketProvider>(
              builder: (context, marketProvider, child) {
            CryptoCurrency currentCrypto =
                marketProvider.fetchCryptoById(widget.id);
            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await marketProvider.fetchData();
                    },
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(currentCrypto.image!),
                          ),
                          title: Text(
                            currentCrypto.name! +
                                "(${currentCrypto.symbol!.toUpperCase()})",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            "₹" + currentCrypto.currentPrice.toString(),
                            style: TextStyle(
                                color: Color(0xff0395eb),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: 
                          (currentCrypto.isFavourite == false)?GestureDetector(onTap: () {
                            marketProvider.addFavourite(currentCrypto);
                          },
                          child: Icon(Icons.favorite_border,color: Colors.pink,),):GestureDetector(onTap: () {
                            marketProvider.removeFavourite(currentCrypto);
                          },
                          child: Icon(Icons.favorite,color: Colors.pink,),),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                  
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price Change (24h)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              Builder(builder: (context){
                                double priceChange = currentCrypto.priceChange24!;
                                    double priceChangePercentage = currentCrypto.priceChangePercentage24!;
                                    if (priceChange < 0) {
                                      //negative
                                      return Text("${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                      style: TextStyle(color: Colors.red,fontSize: 20),);
                                    }
                                    else{
                                      //positive
                                      return Text("+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                      style: TextStyle(color: Colors.green,fontSize: 20),);
                  
                                    }
                              }),
                            ],
                          ),
                         SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleAndDetail(
                                    "Market Cap Rank",
                                    "#" + currentCrypto.marketCapRank!.toString(),
                                    CrossAxisAlignment.start),
                            SizedBox(
                          height: 10,
                        ),  
                            
                          
                            titleAndDetail(
                                "Market Cap ",
                                "₹" + currentCrypto.marketCap!.toString(),
                                CrossAxisAlignment.end),
                           ], ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[ titleAndDetail(
                                  "High 24h",
                                  "" + currentCrypto.high24!.toStringAsFixed(4),
                                 CrossAxisAlignment.start),
                            SizedBox(
                          height: 10,
                        ),
                           
                            titleAndDetail(
                                "Low 24h",
                                "" + currentCrypto.low24!.toStringAsFixed(4),
                                CrossAxisAlignment.end),
                                 ], ),
                                  SizedBox(
                              height: 20,
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[ titleAndDetail(
                                  "Price Change in 24h",
                                  "" + currentCrypto.priceChange24!.toStringAsFixed(4),
                                  CrossAxisAlignment.start),
                             SizedBox(
                          height: 10,
                        ),
                                
                            titleAndDetail(
                                "Price change in %",
                                "" + currentCrypto.priceChangePercentage24!.toStringAsFixed(4),
                                CrossAxisAlignment.end),
                                 ], ),
                                  SizedBox(
                              height: 20,
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleAndDetail(
                                    "Circulating Supply",
                                    "" + currentCrypto.circulatingSupply!.toInt().toString(),
                                   CrossAxisAlignment.start),
                              SizedBox(
                          height: 10,
                        ),
                              
                            titleAndDetail(
                                "All Time Low",
                                "" + currentCrypto.atl!.toStringAsFixed(4),
                                CrossAxisAlignment.end),
                                 ], ),
                                  SizedBox(
                              height: 20,
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleAndDetail(
                                    "All Time High",
                                    "" + currentCrypto.ath!.toStringAsFixed(4),
                                    CrossAxisAlignment.start),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     titleAndDetail("High 24h","" +currentCrypto.high24!.toStringAsFixed(4),CrossAxisAlignment.start),
                  
                        //      titleAndDetail("Low 24h","" +currentCrypto.low24!.toStringAsFixed(4),CrossAxisAlignment.end),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

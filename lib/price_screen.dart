import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'networking.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = "USD";

  String apiKey = "62CF00A8-C54A-49DF-9251-5D65E231217A";

  String selectedCrypto = "BTC";

  var rate = 0.0;

  Future<dynamic> urlCoinApi() async {
    var url =  "https://rest.coinapi.io/v1/exchangerate/$selectedCrypto/$selectedCurrency?apikey=$apiKey";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var coinData = await networkHelper.getData();
    print(coinData['rate']);
    rate = coinData['rate'];
    return coinData;
  }

  @override
  void initState() {
    super.initState();
    urlCoinApi();
  }

  DropdownButton<String> dropdownPicker(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownitems = [];
    currenciesList.forEach((element) {
      var newItem =  DropdownMenuItem(
          child: Text(
            element,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0
          ),
          ),
      value: element);

       dropdownitems.add(newItem);

    });

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownitems,
      onChanged: (value){
        setState(() {
          selectedCurrency = value;
        });
      },
    );

  }

  List<Text> listOfCurrencyText(BuildContext context) {
    List<Text> currencyItems = [];

    print(urlCoinApi());
    currenciesList.forEach((currency) {

      var newItem = Text(
          currency,
        style: TextStyle(
            color: Colors.white,
            fontSize: 25.0
        ),
      );
      currencyItems.add(newItem);
    });
    return currencyItems;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate? $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS  ?  buildCupertinoPicker(context) : dropdownPicker(context)
          ),
        ],
      ),
    );
  }

  CupertinoPicker buildCupertinoPicker(BuildContext context) {
    return CupertinoPicker(
            backgroundColor: Colors.lightBlue,
            itemExtent: 32.0,
            onSelectedItemChanged: (selectedIndex){

              setState(() {
                selectedCurrency = currenciesList[selectedIndex];
              });



            },
            children: listOfCurrencyText(context),
          );
  }
}

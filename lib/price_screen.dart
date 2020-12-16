
import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
//  final coinData;
//
//  PriceScreen({this.coinData});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedValue = 'USD';
  double coinValue;
  String coin;
  String coinType;
  String stringValue;
  Map<String,String> map = {};
  bool isWaiting = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('state is initiated!!');
    updateUI();
//    fillItem();
//    print(itemArr);
  }

  void updateUI() async{
    isWaiting = true;
    Map<String,String> coinData = await CoinData().getCoinData(selectedValue);
    isWaiting = false;
    setState(() {
      if(coinData != null){
        print("THis is coinData ====> $coinData");
        map = coinData;
        print(map);
      }else{
        print("coin data is empty");
        //coinData[''] = 0.0;
      }
    });
  }


  DropdownButton<String> androidPicker(){
    List<DropdownMenuItem<String>> itemArr = [];
    for(String currency in currenciesList){
      itemArr.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedValue,
      items: itemArr,
      onChanged: (value){
        setState(() {
          selectedValue = value;
          print(selectedValue);
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iosPicker(){

    List<Text> pickerItems = [];

    for(String currency in currenciesList){
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlueAccent,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedValue){
        print(selectedValue);
      },
      children: pickerItems,
    );
  }

  Widget getPicker(){
    if(Platform.isIOS){
      return iosPicker();
    }else if(Platform.isAndroid){
      return androidPicker();
    }
  }

  Widget getAllCoins(){
    final containers = [];
    List<CryptoCard> cryptoCards = [];

    for(int i = 0; i < cryptoList.length; i++){
      cryptoCards.add(
        CryptoCard(coin: cryptoList[i],
            stringValue: isWaiting ? '?' : map[cryptoList[i]],
            coinType: selectedValue)
      );
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cryptoCards,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getAllCoins(),
          //CryptoCard(coin: coin, stringValue: stringValue, coinType: coinType),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    @required this.coin,
    @required this.stringValue,
    @required this.coinType,
  });

  final String coin;
  final String stringValue;
  final String coinType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        //elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coin = $stringValue $coinType',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

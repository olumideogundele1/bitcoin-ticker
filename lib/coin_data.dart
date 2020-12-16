

import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const url = "http://rest.coinapi.io/v1/exchangerate/BTC/";
const url2 = "http://rest.coinapi.io/v1/exchangerate/";
const apiKey = "369EA023-1199-4EC2-BCE1-771C753CE090";
class CoinData {

 Future<Map<String,String>> getCoinData(String currency) async{
   Map<String,String> coinValues = {};
   for(String crypto in cryptoList){
     try{
       http.Response response = await http.get(url2 + crypto+ "/"+ currency +"?apikey=" +apiKey);
       if(response.statusCode == 200){
         print("Response is =====> "+response.body);
         var data = response.body;
         double coinValue = jsonDecode(data)['rate'];
         coinValues[crypto] = coinValue.toStringAsFixed(0);
         //print(response.body);
         //return jsonDecode(data);
       }else
         print("Response gotten in else ===> ${response.statusCode}" );
     }catch(e){
       print("Exception gotten ====> " + e.toString());
     }
   }
    return coinValues;
  }

  loadCoinData() async{
   //var getData = await getCoinData();

  }
}

import 'dart:convert';

import 'package:bitcoin_ticker_flutter/data/networking/credentials.dart';
import 'package:http/http.dart' as http;

class CoinApiService {
  static const String host = 'https://rest.coinapi.io/v1/exchangerate/';

  Future<double?> getExchangeRate(String cCurrency, String nCurrency) async {
    Uri uri =
        Uri.https('rest.coinapi.io', '/v1/exchangerate/$cCurrency/$nCurrency');
    final response = await http.get(uri, headers: {'X-CoinAPI-Key': apiKey});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rate'];
    }

    return null;
  }
}

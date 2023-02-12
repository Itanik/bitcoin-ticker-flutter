import 'dart:convert';

import 'package:bitcoin_ticker_flutter/data/dto/exchange_request.dart';
import 'package:bitcoin_ticker_flutter/data/networking/credetials.dart';
import 'package:http/http.dart' as http;

import '../dto/exchange_response.dart';

class CoinApiService {
  static const String host = 'https://rest.coinapi.io/v1/exchangerate/';

  Future<ExchangeResponse> getExchangeRate(ExchangeRequest data) async {
    Uri uri = Uri.https('rest.coinapi.io',
        '/v1/exchangerate/${data.cryptoCurrency}/${data.naturalCurrency}');
    final response = await http.get(uri, headers: {'X-CoinAPI-Key': apiKey});

    if (response.statusCode == 200) {
      return ExchangeResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Unable to load exchange rate');
  }
}

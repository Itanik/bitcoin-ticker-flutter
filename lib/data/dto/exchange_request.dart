import 'package:bitcoin_ticker_flutter/data/dto/exchange_response.dart';

class ExchangeRequest{
  final String cryptoCurrency;
  final String naturalCurrency;

  ExchangeRequest(
      {required this.cryptoCurrency, required this.naturalCurrency});
}
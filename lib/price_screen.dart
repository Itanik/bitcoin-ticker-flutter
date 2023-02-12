import 'dart:io' show Platform;

import 'package:bitcoin_ticker_flutter/data/coin_data.dart';
import 'package:bitcoin_ticker_flutter/data/networking/coin_api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = currenciesList.first;
  final Map<String, double?> _exchangeRates = {
    for (var item in cryptoList) item: null
  };
  final Color _bottomContainerColor = Colors.lightBlue;
  final apiService = CoinApiService();

  @override
  void initState() {
    super.initState();
    updateExchangeRates();
  }

  void updateExchangeRates() {
    _exchangeRates.updateAll((key, value) => null);
    for (var cCurrency in cryptoList) {
      apiService
          .getExchangeRate(cCurrency, _selectedCurrency)
          .then((rate) => setState(() => _exchangeRates[cCurrency] = rate))
          .onError((error, stackTrace) => debugPrint(error.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cryptoList
                  .map((cryptoName) => Padding(
                        padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                        child: Card(
                          color: Colors.lightBlueAccent,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 28.0),
                            child: Text(
                              '1 $cryptoName = ${_exchangeRates[cryptoName]?.toStringAsFixed(2) ?? '?'} $_selectedCurrency',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: _bottomContainerColor,
              child: _getCurrencyPicker(
                currenciesList,
                (newValue) => setState(() {
                  _selectedCurrency = newValue ?? currenciesList.first;
                  updateExchangeRates();
                }),
              ),
            ),
          ]),
    );
  }

  Widget _getCurrencyPicker(
      List<String> listOfCurrency, Function(String?) onChanged) {
    if (Platform.isIOS) {
      return CupertinoPicker(
        backgroundColor: _bottomContainerColor,
        itemExtent: 32.0,
        onSelectedItemChanged: (curIndex) =>
            onChanged(listOfCurrency[curIndex]),
        children:
            listOfCurrency.map((curName) => _getPickerItem(curName)).toList(),
      );
    } else {
      return DropdownButton<String>(
        value: _selectedCurrency,
        iconEnabledColor: Colors.white,
        dropdownColor: Colors.black,
        items: currenciesList
            .map((curName) => DropdownMenuItem(
                  value: curName,
                  child: _getPickerItem(curName),
                ))
            .toList(),
        onChanged: onChanged,
      );
    }
  }

  Widget _getPickerItem(String itemText) {
    return Text(
      itemText,
      style: const TextStyle(color: Colors.white),
    );
  }
}

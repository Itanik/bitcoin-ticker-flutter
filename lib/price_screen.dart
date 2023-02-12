import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? _selectedCurrency;

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
                              '1 $cryptoName = ? ${_selectedCurrency ?? currenciesList.first}',
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
              color: Colors.lightBlue,
              child: DropdownButton<String>(
                value: _selectedCurrency,
                iconEnabledColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.black,
                items: currenciesList
                    .map((curName) => DropdownMenuItem(
                          value: curName,
                          child: Text(curName),
                        ))
                    .toList(),
                onChanged: (newValue) => setState(() {
                  _selectedCurrency = newValue;
                }),
              ),
            ),
          ]),
    );
  }
}

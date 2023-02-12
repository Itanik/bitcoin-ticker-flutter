class ExchangeResponse {
  final double exchangeRate;

  ExchangeResponse({required this.exchangeRate});

  factory ExchangeResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeResponse(exchangeRate: json['rate']);
  }
}

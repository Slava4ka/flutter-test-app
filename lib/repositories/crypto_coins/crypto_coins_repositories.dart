import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'models/models.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    try {
      final List<CryptoCoin> coinsList = await _fetchCoinsListFromApi();

      final coinsMap = {for (var e in coinsList) e.name: e};

      // [#13 Этот метод перетерает старые данные]
      await cryptoCoinsBox.putAll(coinsMap);

      return coinsList;
    } on Exception catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return cryptoCoinsBox.values.toList();
    }
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);

      return CryptoCoin(
        name: e.key,
        details: details,
      );
    }).toList();
    return coinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetails(currencyCode);

      cryptoCoinsBox.put(currencyCode, coin);

      return coin;
    } on Exception catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      // [#14] ! - игнор типизации
      return cryptoCoinsBox.get(currencyCode)!;

      /*  if (cryptoCoinsBox.containsKey(currencyCode)) {
        return cryptoCoinsBox.get(currencyCode)!;
      } */
    }
  }

  Future<CryptoCoin> _fetchCoinDetails(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);

    return CryptoCoin(
      name: currencyCode,
      details: details,
    );
  }
}

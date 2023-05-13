import 'package:flutter/material.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:crypto_coins_list/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrenciesListApp',
      theme: darkTheme,
      routes: routes,
      // initialRoute: '/coins-list', дефолтная страница
      // home: const CryptoListScreen(title: 'CryptoCurrenciesListApp'), - когда приписываем роуты - не прописываем home
      // Логирование роутинга
      navigatorObservers: [TalkerRouteObserver(GetIt.I<Talker>())],
    );
  }
}
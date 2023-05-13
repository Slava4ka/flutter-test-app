import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

import '../features/crypto_coin/crypto_coin.dart';
import '../features/crypto_list/crypto_list.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // [#15] path: '/' initial page
        AutoRoute(
          page: CryptoListRoute.page,
          path: '/',
        ),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}

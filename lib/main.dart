import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_coins_list/crypto_coins_list_app.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'firebase_options.dart';
import 'repositories/crypto_coins/crypto_coins.dart';

const CryptoCoinsBoxName = 'crypto_coins_box';

void main() async {
  final talker = TalkerFlutter.init();

  // [#14 Add NoSql]
  await Hive.initFlutter();
  // [#14 Регистрация адаптеров]
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  // [#14 Тут будут храниться данные]
  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(CryptoCoinsBoxName);

  // [#12 Add Firebase]
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // I - instance

  // [#11 LOGS]
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().good('Application started');

  // Dio - A powerful Http client for Dart, which supports Interceptors
  final Dio dio = Dio();

  // [#11 LOGS] логирование запросов
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      // [#11 LOGS] тут можно настраивать данные для вывода
      settings: const TalkerDioLoggerSettings(printResponseData: false),
    ),
  );

  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinsRepository(
            dio: dio,
            cryptoCoinsBox: cryptoCoinsBox,
          ));

  // [#11 LOGS] логирование операций в state приложения
  Bloc.observer = TalkerBlocObserver(
      talker: talker, settings: const TalkerBlocLoggerSettings());

  // [#11 LOGS] Отлов (вывод в консоль) ошибок flutter (верстки)
  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  // [#11 LOGS] PlatformDispatcher.instance.onError ошибки при взаимодействии с платформой (ios)

  runZonedGuarded(() => runApp(const CryptoCurrenciesListApp()),
      (error, stackTrace) => GetIt.I<Talker>().handle(error, stackTrace));
}

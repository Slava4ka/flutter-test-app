import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'crypto_coin.g.dart';

// [Equatable] Being able to compare objects in Dart often involves having to override the == operator as well as hashCode.
@HiveType(typeId: 2)
class CryptoCoin extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoCoinDetail details;

  const CryptoCoin({required this.name, required this.details});

  @override
  List<Object?> get props => [name, details];
}

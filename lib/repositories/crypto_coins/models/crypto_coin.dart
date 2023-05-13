import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'package:equatable/equatable.dart';

// [Equatable] Being able to compare objects in Dart often involves having to override the == operator as well as hashCode.
class CryptoCoin extends Equatable {
  final String name;
  final CryptoCoinDetail details;

  const CryptoCoin({required this.name, required this.details});

  @override
  List<Object?> get props => [name, details];
}

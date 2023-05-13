import 'package:crypto_coins_list/repositories/crypto_coins/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// генерируемый файл - g
part 'crypto_coin_details.g.dart';

// команда для генерации flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.priceinUSD,
    required this.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.hight24Hour,
    required this.low24Hours,
  });

  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @JsonKey(
    name: 'LASTUPDATE',
    toJson: _dateTimeToJson,
    fromJson: _dateTimeFromJson,
  )
  final DateTime lastUpdate;

  @JsonKey(name: 'HIGH24HOUR')
  final double hight24Hour;

  @JsonKey(name: 'LOW24HOUR')
  final double low24Hours;

  @JsonKey(name: 'PRICE')
  final double priceinUSD;

  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';

  /// Connect the generated [_$CryptoCoinDetailFromJson] function to the `fromJson`
  /// factory.
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  static int _dateTimeToJson(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);

  /// Connect the generated [_$CryptoCoinDetailToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props =>
      [toSymbol, lastUpdate, hight24Hour, low24Hours, priceinUSD, imageUrl];
}

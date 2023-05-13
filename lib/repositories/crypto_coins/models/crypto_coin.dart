import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String name;
  final double priceinUSD;
  final String imageUrl;

  const CryptoCoin(
      {required this.name, required this.priceinUSD, required this.imageUrl});

  @override
  List<Object?> get props => [name, priceinUSD, imageUrl];
}

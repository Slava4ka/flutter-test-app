part of 'crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  final List<CryptoCoin> coinsList;

  // Calling toList() copies the list.
  // The .. is to get a reference to the list itself since sort() is a void function.
  List<CryptoCoin> get sortedCoinsList => coinsList.toList()
    ..sort((a, b) => b.details.priceinUSD.compareTo(a.details.priceinUSD));

  CryptoListLoaded({required this.coinsList});

  @override
  List<Object?> get props => [coinsList];
}

class CryptoListLoadingFailure extends CryptoListState {
  final Object? exception;

  CryptoListLoadingFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

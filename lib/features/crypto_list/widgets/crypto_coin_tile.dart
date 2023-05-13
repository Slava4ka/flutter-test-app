import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);

    return ListTile(
      /* leading: SvgPicture.asset(
        'assets/svg/bitcoin-btc-logo.svg',
        height: 30,
        width: 30,
      ), */
      leading: Image.network(
        coin.details.fullImageUrl,
        width: 64,
        height: 64,
      ),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${coin.details.priceinUSD}\$',
        style: theme.textTheme.labelSmall,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        AutoRouter.of(context).push(CryptoCoinRoute(coin: coin));
      },
    );
  }
}

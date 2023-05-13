import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
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
        coin.imageUrl,
        width: 64,
        height: 64,
      ),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${coin.priceinUSD}\$',
        style: theme.textTheme.labelSmall,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // navigator.push(
        //     MaterialPageRoute(builder: (context) => CryptoCoinsScreen()));
        navigator.pushNamed('/coin', arguments: coin);
      },
    );
  }
}

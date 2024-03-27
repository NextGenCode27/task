import 'package:flutter/material.dart';
import 'package:task/core/global/widgets/logo_dice.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            LogoDice(
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              lable: 'T',
            ),
            const SizedBox(
              width: 5,
            ),
            LogoDice(
              backgroundColor: Theme.of(context).colorScheme.primary,
              lable: 'A',
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            LogoDice(
              backgroundColor: Theme.of(context).primaryColor,
              lable: 'S',
            ),
            const SizedBox(
              width: 5,
            ),
            LogoDice(
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              lable: 'K',
            ),
          ],
        ),
      ],
    );
  }
}

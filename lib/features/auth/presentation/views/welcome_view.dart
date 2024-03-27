import 'package:flutter/material.dart';
import 'package:task/core/global/widgets/app_logo.dart';
import 'package:task/core/global/widgets/custom_button.dart';
import 'package:task/features/auth/presentation/views/login_view.dart';
import 'package:task/features/auth/presentation/views/register_view.dart';

class WelcomeView extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const WelcomeView());
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(size.width * 0.10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLogoWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to the\nTask App',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'New level task feature with new task app',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomButton(
                          size: size,
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          lable: 'LOG IN',
                          onPressed: () {
                            Navigator.of(context).push(LoginView.route());
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                          size: size,
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          lable: '?',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    size: size,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    lable: 'BECOME A CLIENT',
                    onPressed: () {
                      Navigator.of(context).push(RegisterView.route());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

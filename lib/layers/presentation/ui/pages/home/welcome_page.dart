import 'package:biolo_app/layers/presentation/components/colors_const.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem Vindo!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Image(
              image: AssetImage(
                "assets/img/logo.png",
              ),
              height: 370,
              alignment: Alignment.centerLeft,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsConst.sunstColor6,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register_page');
                  },
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(
                      color: ColorsConst.sunstColor8,
                    ),
                  )),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsConst.sunstColor6,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/login_page');
                },
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: ColorsConst.sunstColor8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

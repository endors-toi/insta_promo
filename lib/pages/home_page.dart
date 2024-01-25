import 'package:flutter/material.dart';
import 'package:insta_promo/pages/form_page.dart';
import 'package:insta_promo/pages/usuarios_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          children: [
            FormPage(),
            UsuariosPage(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insta_promo/utils.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:insta_promo/usuarios_service.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController _ctlr = TextEditingController();
  bool _disabledBtn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.2),
              Colors.transparent,
              Colors.transparent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  flex: 2,
                  child: Image.asset('assets/images/logo-textless.png')),
              Container(
                child: TextFormField(
                  controller: _ctlr,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    hintText: 'Usuario de Instagram',
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _disabledBtn = value.isEmpty;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: NiceButtons(
                  child: Text(
                    "Canjear",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ]),
                  ),
                  startColor: _disabledBtn
                      ? Colors.grey
                      : Color.fromARGB(255, 250, 180, 28),
                  endColor: _disabledBtn
                      ? const Color.fromARGB(255, 73, 73, 73)
                      : Color.fromARGB(255, 172, 97, 0),
                  borderColor: Color.fromARGB(255, 66, 54, 0),
                  borderRadius: 30,
                  disabled: _disabledBtn,
                  onTap: (finish) {
                    toggleButton();
                    _revisarUsuario(_ctlr.text).then((_) => toggleButton());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _revisarUsuario(String user) async {
    String error = "";

    if (user.isEmpty) {
      error = "????? ta vacío";
    } else if (user.length > 30) {
      error = "usuario inválido 👨‍🦽\n(muy largo, máx 30)";
    } else if (!RegExp(r'^[a-zA-Z0-9.]+$').hasMatch(user)) {
      error = "usuario inválido 👨‍🦽\n(sólo letras, números, puntos)";
    }

    if (error.isNotEmpty) {
      showMsg(
        context,
        title: error,
        success: 2,
      );
      return;
    }

    bool usuarioPresent = await UsuariosService.exists(user);

    if (usuarioPresent) {
      showMsg(
        context,
        title: "@$user ya canjeó :-(",
        success: 1,
      );
    } else {
      await UsuariosService.add(user);
      showMsg(
        context,
        title: "Felicidades @$user :-)",
      );
    }

    _ctlr.clear();
  }

  toggleButton() {
    setState(() {
      _disabledBtn = !_disabledBtn;
    });
  }
}

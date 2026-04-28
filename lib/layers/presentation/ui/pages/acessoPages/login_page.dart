import 'dart:convert';
import 'package:biolo_app/layers/data/datasources/remote/pegar_user_login.dart';
import 'package:biolo_app/layers/data/dto/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/colors_const.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _txtLoginController = TextEditingController();
  final TextEditingController _txtSenhaController = TextEditingController();

  bool _obscureText = true;
  bool _rememberMe = false;
  bool _loading = false;

  String _resolverRotaPorTipoUsuario(String tipoUsuario) {
    final tipoNormalizado = tipoUsuario.trim().toLowerCase();

    if (tipoNormalizado == '2' ||
        tipoNormalizado == 'proprietario' ||
        tipoNormalizado == 'proprietário') {
      return '/proprietario';
    }

    return '/principal';
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleCheckbox() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  void _confirmLogin() async {
    setState(() {
      _loading = true;
    });
    try {
      print('[LOGIN PAGE] Tentando logar');
      print('[LOGIN PAGE] login="${_txtLoginController.text.trim()}"');
      final auth = GetIt.I.get<PegarUserLogin>();
      final result = await auth.apiLoginUser(
        _txtLoginController.text.trim(),
        _txtSenhaController.text,
      );
      print('[LOGIN PAGE] Retorno do datasource: $result');
      final token = result['token'] as String? ?? '';
      final user = result['user'] as UserDto;
      print('[LOGIN PAGE] Token final: $token');
      print('[LOGIN PAGE] User final: $user');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('current_user', jsonEncode(user.toJson()));
      if (_rememberMe) {
        await prefs.setString('remember_login', _txtLoginController.text.trim());
      }
      if (!mounted) return;
      final rotaDestino = _resolverRotaPorTipoUsuario(user.tipoUsuario);
      Navigator.of(context).pushNamed(rotaDestino);
    } catch (e) {
      print('[LOGIN PAGE][ERRO] $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Falha no login: $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _validateAndLogin() {
    if (_txtLoginController.text.isEmpty || _txtSenhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos"),
          backgroundColor: Colors.orangeAccent,
        ),
      );
    } else {
      _confirmLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using media query for responsive sizing if needed, though simple padding usually suffices.
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Logo Section
                Center(
                  child: Image.asset(
                    "assets/img/logo.png",
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Title Section
                Text(
                  "Bem-vindo de volta!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorsConst.sunstColor1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Entre com a sua conta para continuar",
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorsConst.sunstColor9,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Input Fields
                TextFormField(
                  controller: _txtLoginController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email ou telefone",
                    prefixIcon: Icon(Icons.person_outline, color: ColorsConst.sunstColor1),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ColorsConst.sunstColor1, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _txtSenhaController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    prefixIcon: Icon(Icons.lock_outline, color: ColorsConst.sunstColor1),
                    suffixIcon: IconButton(
                      onPressed: _toggleVisibility,
                      icon: Icon(
                        _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: ColorsConst.sunstColor9,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ColorsConst.sunstColor1, width: 2),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Remember Me & Create Account Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) => _toggleCheckbox(),
                          activeColor: ColorsConst.sunstColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          "Lembrar-me",
                          style: TextStyle(color: ColorsConst.sunstColor6),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                         Navigator.of(context).pushNamed("/acessNewRegisterPage");
                      },
                      child: Text(
                        "Criar conta",
                        style: TextStyle(
                          color: ColorsConst.sunstColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  onPressed: _loading ? null : _validateAndLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsConst.sunstColor1,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          "ENTRAR",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                ),

                const SizedBox(height: 30),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Ou",
                        style: TextStyle(color: ColorsConst.sunstColor9),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 30),

                // Google Login Button
                OutlinedButton(
                  onPressed: () {
                    // Implement Google Login Logic
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/icon/icon_google.png",
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Entrar com o Google",
                        style: TextStyle(
                          color: ColorsConst.sunstColor6,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

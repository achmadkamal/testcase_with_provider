import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcase_with_provider/pages/movies_page.dart';
import 'package:testcase_with_provider/providers/auth_provider.dart';
import 'package:testcase_with_provider/providers/global_provider.dart';
import '../constant.dart';
import '../widgets/button_widget.dart';
import '../widgets/textform_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future _login() async {
    await context
        .read<AuthProvider>()
        .login(email: _emailController.text, password: _passwordController.text)
        .then(
      (value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login berhasil'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MoviesPage()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login gagal'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text('Silahkan login terlebih dahulu'),
              const SizedBox(height: 15),
              TextFormWidget(
                label: 'Email *',
                hintText: 'example@mail.com',
                controller: _emailController,
                validator: (value) {
                  RegExp regExp = RegExp(kRegExpEmail.toString());
                  if (value!.isEmpty) {
                    return 'Email harus diisi';
                  } else if (!regExp.hasMatch(value)) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              Consumer<GlobalProvider>(
                builder: (context, globalProvider, _) => TextFormWidget(
                  label: 'Password *',
                  hintText: 'password',
                  controller: _passwordController,
                  obscureText: !globalProvider.getHidePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email harus diisi';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      globalProvider.setHidePassword =
                          !globalProvider.getHidePassword;
                    },
                    icon: Icon(
                      globalProvider.getHidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ButtonWidget(
                text: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

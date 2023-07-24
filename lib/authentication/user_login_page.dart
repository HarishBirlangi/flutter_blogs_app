import 'package:flutter/material.dart';
import 'package:flutter_blogs_app/authentication/firebase_authentication.dart';
import 'package:flutter_blogs_app/common_files/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  bool loginPageCheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text(
          "Blogs App",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/images/app_logo.jpeg'),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter some value";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        email = newValue!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter some value";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        password = newValue!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            loginPageCheck ? loginSection() : registerSection()
          ],
        ),
      ),
    );
  }

  Widget loginSection() {
    return Column(children: [
      ElevatedButton(
        onPressed: () {
          final form = _formKey.currentState;
          if (form!.validate()) {
            form.save();
          }
          print('Email: $email');
          print('Password: $password');
          AuthImplementation().userLoginUsingFirebase(email, password);
          Navigator.of(context)
              .pushReplacementNamed(Routes().blogsHomePageRoute);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
      TextButton(
          onPressed: () {
            setState(() {
              loginPageCheck = false;
            });
            _formKey.currentState?.reset();
          },
          child: const Text("Don't have an account, Register here"))
    ]);
  }

  Widget registerSection() {
    return Column(children: [
      ElevatedButton(
        onPressed: () {
          final form = _formKey.currentState;
          if (form!.validate()) {
            form.save();
          }
          print('Email: $email');
          print('Password: $password');
          AuthImplementation().userRegistrationUsingFirebase(email, password);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child:
            const Text('Create Account', style: TextStyle(color: Colors.white)),
      ),
      TextButton(
          onPressed: () {
            setState(() {
              loginPageCheck = true;
            });
            _formKey.currentState?.reset();
          },
          child: const Text("Already have an account, Login here"))
    ]);
  }
}

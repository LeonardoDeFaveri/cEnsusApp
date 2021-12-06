import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  final String title = "Login";

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email;
  String? _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (String? email) => _email = email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: "Email",
                  ),
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (String? password) => _password = password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    helperText: "Password",
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    "Hai dimenticato la password?",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text("Registrati"),
                      onPressed: () => {},
                    ),
                    ElevatedButton(
                      child: const Text("Accedi"),
                      onPressed: () => _tryLogin(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: form,
      ),
    );
  }

  void _tryLogin() {
    if (_email != null && _password != null) {
      //String encoded = encode(_password!);
      //Utente credentials = Utente(_email!, encoded);
    }
  }
}

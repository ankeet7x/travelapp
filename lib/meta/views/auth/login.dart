import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/core/providers/authprovider.dart';
import 'package:travelapp/meta/widgets/loginsignupcover.dart';
import 'package:travelapp/meta/widgets/namefields.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  _exitTheApp() async {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _exitTheApp(),
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<AuthProvider>(context).loading,
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  CoverStack(
                    size: size,
                    guideText: "Login",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  NameFields(
                      size: size,
                      fieldController: _username,
                      hintText: "username"),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: size.width * 0.85,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Consumer<AuthProvider>(
                      builder: (context, authState, child) => Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _password,
                              obscureText: authState.obscureText,
                              validator: (val) {
                                if (val!.length < 8) {
                                  return "Password mustn't be less than 8 characters";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.only(left: 10),
                                  hintText: "Password"),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              authState.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue,
                            ),
                            onPressed: () => authState.changeBool(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        final _loginProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        if (await _loginProvider.loginUser(
                                _username.text, _password.text) ==
                            'userLoggedIn') {
                          Navigator.pushNamed(context, '/');
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                      content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Auth Failed"),
                                      TextButton(
                                        child: Text("Ok"),
                                        onPressed: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(),
                                      )
                                    ],
                                  )));
                        }
                      }
                    },
                    child: Container(
                      width: size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("Don't have an account ?"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

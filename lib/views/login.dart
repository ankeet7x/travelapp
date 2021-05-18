import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/providers/authprovider.dart';
import 'package:travelapp/ui/loginsignupcover.dart';
import 'package:travelapp/ui/namefields.dart';
import 'package:travelapp/views/home.dart';
import 'package:travelapp/views/signup.dart';

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
        body: SingleChildScrollView(
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
                    builder: (context, authState, child) => TextFormField(
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
                          suffixIcon: IconButton(
                            icon: Icon(authState.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () => authState.changeBool(),
                          ),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "Password"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Consumer<AuthProvider>(
                  builder: (context, authState, child) => GestureDetector(
                    child: Container(
                      width: size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: authState.loading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SpinKitThreeBounce(
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Logging In",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )
                              : Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                )),
                    ),
                    onTap: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        final _loginProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        if (await _loginProvider.loginUser(
                                _username.text, _password.text) ==
                            'userLoggedIn') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Auth Failed"),
                          ));
                        }
                      }
                    },
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
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupView())),
                  child: Container(
                      width: size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "Signup Page",
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

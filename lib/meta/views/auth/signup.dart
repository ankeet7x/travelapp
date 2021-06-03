import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/core/providers/authprovider.dart';
import 'package:travelapp/meta/views/auth/login.dart';
import 'package:travelapp/meta/widgets/loginsignupcover.dart';
import 'package:travelapp/meta/widgets/namefields.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          key: _formKey,
          child: Column(
            children: [
              CoverStack(
                size: size,
                guideText: "Sign up",
              ),
              SizedBox(
                height: 15,
              ),
              NameFields(
                  size: size, fieldController: _userName, hintText: "Username"),
              SizedBox(
                height: 15,
              ),
              NameFields(
                  size: size,
                  fieldController: _firstName,
                  hintText: "First name"),
              SizedBox(
                height: 15,
              ),
              NameFields(
                  size: size,
                  fieldController: _lastName,
                  hintText: "Last Name"),
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
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  controller: _phoneNumber,
                  validator: (val) {
                    if (val!.length != 10) {
                      return "Phone number should be equal to 10 characters";
                    } else if (!val.startsWith("98")) {
                      return "Phone number should start with 98";
                    } else {
                      return null;
                    }
                  },
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "Phone Number"),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final signUpProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    if (await signUpProvider.signUpUser(
                            _userName.text,
                            _firstName.text,
                            _lastName.text,
                            _password.text,
                            _phoneNumber.text) ==
                        'userCreated') {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      print('Try changing username or password');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Change Username or Phone Number"),
                      ));
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
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text("Already have an account ?"),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: Text("Log In",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)))
            ],
          ),
        )),
      ),
    );
  }
}

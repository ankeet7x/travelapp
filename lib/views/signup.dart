import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/providers/authprovider.dart';
import 'package:travelapp/ui/loginsignupcover.dart';
import 'package:travelapp/ui/namefields.dart';
import 'package:travelapp/views/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                size: size, fieldController: _lastName, hintText: "Last Name"),
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
                                  "Signing up",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          : Text(
                              "Sign up",
                              style: TextStyle(color: Colors.white),
                            )),
                ),
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    // signUp(_userName.text, _firstName.text, _lastName.text,
                    //     _password.text, _phoneNumber.text);

                    final signUpProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    if (await signUpProvider.signUpUser(
                            _userName.text,
                            _firstName.text,
                            _lastName.text,
                            _password.text,
                            _phoneNumber.text) ==
                        'userCreated') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    } else {
                      print('Try changing username or password');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Change Username or Phone Number"),
                      ));
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView())),
              child: Container(
                width: size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  "Login Page",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

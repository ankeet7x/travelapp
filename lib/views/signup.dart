import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/providers/authprovider.dart';
import 'package:travelapp/ui/namefields.dart';
import 'package:travelapp/views/login.dart';

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

  void signUp(username, firstname, lastname, password, phoneNo) async {
    final signUpProvider = Provider.of<AuthProvider>(context, listen: false);
    if (await signUpProvider.signUpUser(
            username, firstname, lastname, password, phoneNo) ==
        'userCreated') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    } else {
      print('User already exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(55, 20),
                        bottomRight: Radius.elliptical(55, 20)),
                    child: Image.asset(
                      'assets/cover.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  height: size.height / 2.75,
                ),
                Positioned(
                    top: size.height * 0.275,
                    left: size.width * 0.10,
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ))
              ],
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
            OutlinedButton(
              child: Text("Sign up"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signUp(_userName.text, _firstName.text, _lastName.text,
                      _password.text, _phoneNumber.text);
                }
              },
            )
          ],
        ),
      )),
    );
  }
}

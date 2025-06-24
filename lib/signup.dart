import 'package:flutter/material.dart';
import 'package:todo_list/final.dart';
import 'package:todo_list/main.dart';

void main() {
  runApp(signup());
}

class signup extends StatefulWidget {
  _signup createState() => _signup();
}

TextEditingController email = new TextEditingController();
TextEditingController password = new TextEditingController();

class _signup extends State<signup> {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              //Image.network("https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTAyL3Jhd3BpeGVsX29mZmljZV8yNF9ibGFja19hbmRfd2hpdGVfYWVzdGhldGljX3Bob3RvZ3JhcGh5X29mX2ZhYl81M2JkZDc2NS0zNzNkLTQzMzMtYWRjNy0zNGNmMmUzNzIxMGNfMS5qcGc.jpg"),
              Image.asset('assets/back.jpg'),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 550,
                    width: 450,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Image(
                              image: AssetImage('assets/todo.png'),
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // Email Field
                                  TextFormField(
                                    controller: email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
                                          .hasMatch(value)) {
                                        return 'Enter valid email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  // Password Field
                                  TextFormField(
                                    controller: password,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required';
                                      }
                                      if (value.length <= 8) {
                                        return 'Password must be more than 8 characters';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  // Confirm Password Field
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirm your password';
                                      }
                                      if (value != password.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Confirm Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 30, right: 15, left: 15),
                            width: 400,
                            height: 80,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => todo()));
                                  }
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 5),
                                child: Text(
                                  "Already have an account ?",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

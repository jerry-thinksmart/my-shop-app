import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Map<String, String> _authData = {'email': '', 'password': ''};
  Future<void> submitForm() async {
    final isValid = _formkey.currentState?.validate() ?? false;
    if (isValid) {
      _formkey.currentState?.save();
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(
          context,
          listen: false,
        ).signUp(_authData['email']!, _authData['password']!);

        Navigator.pushReplacementNamed(context, '/dashboard-screen');
        // SnackBar snackBar = SnackBar(
        //   content: Text('Sign Up Successful'),
        //   duration: Duration(seconds: 2),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // setState(() {
        //   isLoading = false;
        // });
      } catch (error) {
        // SnackBar snackBar = SnackBar(
        //   content: Text('Sign Up Failed'),
        //   duration: Duration(seconds: 2),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        throw error;
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: 500,
          height: 500,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.grey[100],
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text('Sign Up Screen'),
                  SizedBox(height: 20),
                  TextFormField(
                    // onChanged: (value) {
                    //   // Save the username value
                    // },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Please check what you enter, and try again';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please check what you enter, and try again';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Please check what you enter, and try again';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    // validator: (value) {
                    //   if (value != passwordController.value) {
                    //     return 'Password not match';
                    //   }
                    // },
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            textStyle: TextStyle(fontSize: 16),
                          ),
                          onPressed: submitForm,
                          child: Text('Sign Up'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nookienation_tictactoe_calc/Helper/constant.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmDeleteController = TextEditingController();

  bool _isSureToDelete = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmDeleteController.dispose();
    super.dispose();
  }

  void _deleteAccount() {
    if (_formKey.currentState!.validate() && _isSureToDelete) {
      Fluttertoast.showToast(
        msg: "Account deletion in progress...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
      _formKey.currentState!.reset();
      setState(() {
        _isSureToDelete = false;
      });
    } else if (!_isSureToDelete) {
      Fluttertoast.showToast(
        msg: "Please confirm that you are sure to delete the account",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:/* AppBar(
        title: Text("Delete Account"),
        backgroundColor: Colors.red,
      ),*/ PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,80),
        child: AppBar(
            elevation: 3,
            centerTitle: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0,),
              child: Image.asset(
                "assets/images/nookienation.png",
                height: 344,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(appName,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _isSureToDelete,
                    onChanged: (value) {
                      setState(() {
                        _isSureToDelete = value ?? false;
                      });
                    },
                  ),
                  Text("Are you sure to delete the account?"),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _deleteAccount,
                child: Text("Delete Account",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 60), // Set minimum size with desired height
                  maximumSize: Size(MediaQuery.of(context).size.width, 100), // Set maximum size
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

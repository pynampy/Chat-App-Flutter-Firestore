import 'package:chat_app/widgets/picker/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();

  final void Function(String email, String password, String userName, File image, bool isLogin, BuildContext ctx) submitFn;  
  bool isLoading;
  AuthForm(this.submitFn, this.isLoading);
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File userImageFile;

  void _pickedImage(File image){
    userImageFile = image;
  }   


  void _trySubit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(userImageFile == null && !_isLogin){
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Please pick an Image"),
        backgroundColor: Theme.of(context).errorColor,
        )
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();

      widget.submitFn(_userEmail.trim(), _userPassword, _userName, userImageFile, _isLogin, context,);
      print(_userPassword);
      print(_userEmail);
      print(_userName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child:

                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                       
                       if(!_isLogin)
                        UserImagePicker(_pickedImage),
                    TextFormField(
                      
                      key: ValueKey("Email"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                      ),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid Email Address !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey("UserName"),
                        decoration: InputDecoration(labelText: "UserName"),
                        validator: (value) {
                          if (value.length < 4) {
                            return "Please enter atleast 4 characters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey("password"),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return "Password must be atleast 7 characters long";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if(widget.isLoading)
                    CircularProgressIndicator(),
                    if(!widget.isLoading)
                    RaisedButton(
                        child: Text(_isLogin ? "Login" : "Sign Up"),
                        onPressed: () {
                          _trySubit();
                        }),
                        if(!widget.isLoading)
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? "Create New Account!"
                            : "I already have an account")),
                  ])),
            ),
          )),
    );
  }
}

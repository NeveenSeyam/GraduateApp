import 'package:flutter/material.dart';
import 'package:hogo_app/provider/auth_provider.dart';
import 'package:hogo_app/screen/home_page_screen.dart';
import 'package:hogo_app/screen/http_excaption.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const roudName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 255, 236, 32).withOpacity(0.7),
                  const Color.fromARGB(255, 27, 14, 0).withOpacity(1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: deviceSize.height * 0.04,
              left: 0,
              right: 0,
              child: Center(
                  child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () async {
                  Navigator.of(context).pushNamed(HomePageScreen.roudName);
                },
                child: const Text(
                  "Login As Guest",
                  style: TextStyle(color: Colors.black),
                ),
              )))
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController? _controller;
  Animation<Offset>? _slidAnimation;
  Animation<double>? _opscityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _slidAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));
    _opscityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeIn));
    // _heightAnmiation.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  void _showErrorrDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: const Text(' Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in

        await Provider.of<Auth>(context, listen: false)
            .singin(_authData['email'], _authData['password'])
            .then((value) {
          if (value) {
            Navigator.of(context).pushReplacementNamed(HomePageScreen.roudName);
          }
        });
      } else {
        if (_authData['email']!.contains("@admin")) {
          _showErrorrDialog("Admin account is not allowed to create");
          setState(() {
            _isLoading = false;
          });
          return;
        }

        // Sign user up
        await Provider.of<Auth>(context, listen: false)
            .singup(_authData['email'], _authData['password'])
            .then((value) {
          if (value) {
            Navigator.of(context).pushReplacementNamed(HomePageScreen.roudName);
          }
        });
      }
    } on HttpException catch (error) {
      var errorrMasseage = 'Authenticate failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorrMasseage = "This email addrees is already in use,";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorrMasseage = " This is not a valid email address";
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorrMasseage = 'This password is to weak .';
      } else if (error.toString().contains('RMAIL_NOT_FOUND')) {
        errorrMasseage = 'Could not found a user with that email .';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorrMasseage = 'Invakid password .';
      }
      _showErrorrDialog(errorrMasseage);
    } catch (error) {
      print(error.toString());
      const errorrMasseage =
          "Could not authenticate you. Please try again later.";
      _showErrorrDialog(errorrMasseage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: _authMode == AuthMode.Signup ? 260 : 260,
          //   height: _heightAnmiation.value.height,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.Signup ? 320 : 260),
          //    BoxConstraints(minHeight: _heightAnmiation.value.height),
          width: deviceSize.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    AnimatedContainer(
                      curve: Curves.easeIn,
                      constraints: BoxConstraints(
                          minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                          maxHeight: _authMode == AuthMode.Signup ? 120 : 60),
                      duration: const Duration(milliseconds: 300),
                      child: FadeTransition(
                        opacity: _opscityAnimation!,
                        child: SlideTransition(
                          position: _slidAnimation!,
                          child: TextFormField(
                            enabled: _authMode == AuthMode.Signup,
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: _authMode == AuthMode.Signup
                                ? (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match!';
                                    }
                                    return null;
                                  }
                                : null,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                    ),
                  // FlatButton(
                  //   child: Text(
                  //       '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  //   onPressed: _switchAuthMode,
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 30.0, vertical: 4),
                  //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //   textColor: Theme.of(context).primaryColor,
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}

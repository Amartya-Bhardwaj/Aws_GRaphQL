import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:graph_ql/Screens/CodeConfirm.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginData _data;
  bool _isSignedIn = false;

  Future<String> _onLogin(BuildContext context, LoginData data) async {
    try {
      final res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );

      _isSignedIn = res.isSignedIn;
    } on AuthException catch (e) {
      if (e.message.contains('already a user which is signed in')) {
        await Amplify.Auth.signOut();
        return 'Problem logging in. Please try again.';
      }

      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<String> _onSignup(BuildContext context, LoginData data) async {
    try{
      await Amplify.Auth.signUp(
        username: data.name,
        password: data.password,
        options: CognitoSignUpOptions(
          userAttributes: {
            'email': data.name,
          }
        )
      );
    } on AuthException catch(e){}
  }
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'TODO',
      onLogin: (LoginData data) => _onLogin(context, data),
      onRecoverPassword: (_) => Future.value(''),
      onSignup: (LoginData data) =>_onSignup(context, data),
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
      ),
      onSubmitAnimationCompleted: (){
        Navigator.pushNamed(context, Code.id);
      },
    );
  }
}

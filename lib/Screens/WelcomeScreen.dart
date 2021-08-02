import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:graph_ql/amplifyconfiguration.dart';
import 'login.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final amplify = Amplify;
  bool _amplifyConfigured = false;


  @override
  void initState(){
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async{
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    try {
      await amplify.addPlugins([authPlugin, analyticsPlugin]);
      await amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    }catch(e){
      print("Try again");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _amplifyConfigured ? Login() : CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:doc_connect/views/registration/login_signup_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class LoginSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginSignUpViewModel>.reactive(
      viewModelBuilder: () => LoginSignUpViewModel(),
      onModelReady: (m) => m.instantiate(context),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('Login'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: model.goToRegistrationScreen,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlutterLogo(
                  size: 150.0,
                ),
                SizedBox(height: 16.0),
                ToggleSelectionButton(
                  isLogin: model.isLogin,
                  onChecked: (bool isLogin) {
                    model.isLogin = isLogin;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: model.emailController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    hintText: 'user@example.com',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: model.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.vpn_key),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32.0),
                AppPlatformButton(
                  height: 50.0,
                  borderRadius: 8.0,
                  width: double.infinity,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                  text: model.isLogin ? 'LOGIN' : 'SIGNUP',
                  color: Colors.greenAccent,
                  onPressed: model.authenticate,
                  elevation: 8.0,
                ),
                SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

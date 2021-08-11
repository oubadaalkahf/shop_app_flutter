import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/screens/homeScreen/homeScreen.dart';

import 'package:shop_app/screens/login/cubit/cubit.dart';
import 'package:shop_app/screens/login/cubit/states.dart';
import 'package:shop_app/screens/register/registerScreen.dart';
import 'package:shop_app/shared/TformField.dart';
import 'package:shop_app/shared/components.dart';

import 'package:shop_app/shared/defaultButton.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObsecure = true;

  final _formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            if (state.loginModel.status != null) {
              print(state.loginModel.message);
              navigateAndFinish(context, HomeScreen());
            } else
              print(state.loginModel.message);

            showToast(message: state.loginModel.message);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text("Login now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey)),
                      SizedBox(
                        height: 30.0,
                      ),
                      newDefaultText(
                        keyboardType: TextInputType.emailAddress,
                        submitText: 'Email most not be Empty',
                        text: 'email',
                        controller: emailController,
                        isObsecure: false,
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      newDefaultText(
                          keyboardType: TextInputType.text,
                          submitText: 'Password most not be Empty',
                          isPassword: true,
                          prefix: Icons.lock,
                          isObsecure: isObsecure,
                          controller: passwordController,
                          text: 'Password',
                          suffix: isObsecure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ShopLoginLoadingStates,
                          widgetBuilder: (context) => defaultButton(
                                text: 'Login',
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator())),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RegisterScreen.id);
                              },
                              child: Text(
                                'Register Here',
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

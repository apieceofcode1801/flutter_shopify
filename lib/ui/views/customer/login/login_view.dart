import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/customer/login/login_viewmodel.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:flutter_shopify/ui/widgets/common_button.dart';
import 'package:flutter_shopify/ui/widgets/common_text_button.dart';
import 'package:flutter_shopify/ui/widgets/form_input_views.dart';

class LoginView extends StatelessWidget {
  final _model = LoginViewModel();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: BaseView<LoginViewModel>(
        builder: (context, model, child) => Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormInputField(
                      item: CustomFormItem(
                          title: 'Email',
                          controller: model.emailController,
                          canBeEmpty: false)),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormInputField(
                      item: CustomFormItem(
                          title: 'Password',
                          controller: model.passwordController,
                          canBeEmpty: false,
                          obscureText: true)),
                  const SizedBox(
                    height: 8,
                  ),
                  CommonTextButton(
                    onPressed: () {
                      model.forgotPassword(context);
                    },
                    title: 'Forgot your password',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CommonButton(
                    'Sign in',
                    action: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        model.login(context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonTextButton(
                        onPressed: () {
                          model.register(context);
                        },
                        title: 'Create an account',
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        model: _model,
      ),
    );
  }
}

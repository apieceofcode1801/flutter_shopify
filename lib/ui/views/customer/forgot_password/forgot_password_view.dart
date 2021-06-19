import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/customer/forgot_password/forgot_password_viewmodel.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:flutter_shopify/ui/widgets/common_button.dart';
import 'package:flutter_shopify/ui/widgets/form_input_views.dart';

class ForgotPasswordView extends StatelessWidget {
  final _model = ForgotPasswordViewModel();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: BaseView<ForgotPasswordViewModel>(
        model: _model,
        builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please enter your email address below to receive a password reset link.',
                      style: TextStyles.content,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormInputField(
                        item: CustomFormItem(
                            title: 'Email',
                            controller: model.emailController,
                            canBeEmpty: false)),
                    const SizedBox(
                      height: 24,
                    ),
                    CommonButton('Reset my password', action: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        model.resetPassword();
                      }
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

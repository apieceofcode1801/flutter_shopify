import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/customer/register/register_viewmodel.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:flutter_shopify/ui/widgets/common_button.dart';
import 'package:flutter_shopify/ui/widgets/form_input_views.dart';

class RegisterView extends StatelessWidget {
  final _model = RegisterViewModel();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: BaseView<RegisterViewModel>(
        model: _model,
        builder: (context, model, child) => Container(
          padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleView('Personal Information'),
                  TextFormInputField(
                      item: CustomFormItem(
                          title: 'First name',
                          controller: model.firstNameController,
                          canBeEmpty: false,
                          placeholder: 'Enter yout first name')),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormInputField(
                      item: CustomFormItem(
                          title: 'Last name',
                          controller: model.lastNameController,
                          canBeEmpty: false,
                          placeholder: 'Enter yout last name')),
                  _titleView('Sign-in Information'),
                  TextFormInputField(
                      item: CustomFormItem(
                          title: 'Email address',
                          controller: model.emailNameController,
                          canBeEmpty: false,
                          placeholder: 'Enter email address')),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormInputField(
                    item: CustomFormItem(
                        title: 'Password',
                        controller: model.passwordNameController,
                        canBeEmpty: false,
                        placeholder: 'Enter password',
                        obscureText: true),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CommonButton('Create an account', action: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      model.createAnAccount();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleView(String title) => Container(
        height: 64,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyles.titleBold,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      );
}

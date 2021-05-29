import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/new_address/new_address_viewmodel.dart';

class NewAddressView extends StatelessWidget {
  final viewModel = NewAddressViewModel();
  @override
  Widget build(BuildContext context) {
    return BaseView<NewAddressViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Address'),
        ),
        body: CustomForm(
          items: [
            CustomFormItem(
                title: 'Email',
                controller: model.emailController,
                canBeEmpty: false),
            CustomFormItem(
                title: 'First name',
                controller: model.firstNameController,
                canBeEmpty: false),
            CustomFormItem(
                title: 'Last name',
                controller: model.lastNameController,
                canBeEmpty: false),
            CustomFormItem(
                title: 'Address 1',
                controller: model.address1Controller,
                canBeEmpty: false),
            CustomFormItem(
                title: 'Address 2',
                controller: model.address2Controller,
                canBeEmpty: false),
            CustomFormItem(
                title: 'City',
                controller: model.cityController,
                canBeEmpty: false),
            CustomFormItem(
                title: 'State',
                controller: model.stateController,
                canBeEmpty: false),
            CustomFormItem(
                title: 'Country',
                controller: model.countryController,
                canBeEmpty: false),
            CustomFormItem(
                title: 'Zip Code',
                controller: model.zipCodeController,
                canBeEmpty: false),
          ],
          submitAction: () {},
        ),
      ),
      model: viewModel,
    );
  }
}

class CustomForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List<CustomFormItem> items;
  final Function() submitAction;
  CustomForm({required this.items, required this.submitAction});
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                for (final item in items) TextFormInputField(item: item),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitAction();
                        }
                      },
                      child: Text('Submit'),
                    )),
              ],
            )
          ],
        ));
  }
}

class TextFormInputField extends StatelessWidget {
  final CustomFormItem item;
  const TextFormInputField({required this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.title),
        TextFormField(
          validator: (text) {
            if (!item.canBeEmpty) {
              if (text?.isEmpty ?? false) {
                return 'Can not be empty';
              }
            }
            return item.validator != null ? item.validator!(text) : null;
          },
          decoration: InputDecoration(hintText: item.placeholder),
        )
      ],
    );
  }
}

class CustomFormItem {
  final String title;
  final String placeholder;
  final bool canBeEmpty;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CustomFormItem(
      {required this.title,
      this.placeholder = '',
      this.canBeEmpty = true,
      this.validator,
      required this.controller});
}

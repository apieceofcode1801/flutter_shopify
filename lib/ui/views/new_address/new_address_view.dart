import 'package:flutter/material.dart';
import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/ui/views/new_address/new_address_viewmodel.dart';
import 'package:flutter_shopify/ui/widgets/loading.dart';

class NewAddressView extends StatelessWidget {
  final String actionTitle;
  final void Function(CheckoutAddress address) action;
  final _model = NewAddressViewModel();
  final _formKey = GlobalKey<FormState>();
  NewAddressView({required this.actionTitle, required this.action});
  @override
  Widget build(BuildContext context) {
    final countries = _model.countries;
    final currentCountry = _model.currentCountry;
    return BaseView<NewAddressViewModel>(
      builder: (context, model, child) => Stack(
        children: [
          model.state == ViewState.Initial
              ? LoadingView()
              : Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          TextFormInputField(
                            item: CustomFormItem(
                                title: 'First Name',
                                controller: _model.firstNameController,
                                canBeEmpty: false),
                          ),
                          TextFormInputField(
                            item: CustomFormItem(
                                title: 'Last Name',
                                controller: _model.lastNameController,
                                canBeEmpty: false),
                          ),
                          TextFormInputField(
                            item: CustomFormItem(
                                title: 'Address 1',
                                controller: _model.address1Controller,
                                canBeEmpty: false),
                          ),
                          TextFormInputField(
                            item: CustomFormItem(
                                title: 'Address 2',
                                controller: _model.address2Controller,
                                canBeEmpty: false),
                          ),
                          TextFormInputField(
                            item: CustomFormItem(
                                title: 'City',
                                controller: _model.cityController,
                                canBeEmpty: false),
                          ),
                          currentCountry != null &&
                                  currentCountry.provinces.length > 0
                              ? SelectionInputField(
                                  selections: currentCountry.provinces
                                      .map((e) => SelectionInputItem(
                                          text: e.name, value: e.code))
                                      .toList(),
                                  title: 'Province',
                                  placeholder: 'Select province',
                                  validator: (value) => value?.isEmpty ?? false
                                      ? 'Cannot be empty'
                                      : null,
                                  selectedIndex: _model.currentProvinceIndex,
                                  onChanged: (value) {
                                    if (value != null) {
                                      _model.setCurrentProvince(code: value);
                                    }
                                  },
                                )
                              : SizedBox.shrink(),
                          countries.isNotEmpty
                              ? SelectionInputField(
                                  selections: countries
                                      .map((e) => SelectionInputItem(
                                          text: e.name, value: e.code))
                                      .toList(),
                                  title: 'Country',
                                  placeholder: 'Select country',
                                  validator: (value) => value?.isEmpty ?? false
                                      ? 'Cannot be empty'
                                      : null,
                                  selectedIndex: _model.currentCountryIndex,
                                  onChanged: (value) {
                                    if (value != null) {
                                      _model.setCurrentCountry(code: value);
                                    }
                                  },
                                )
                              : SizedBox.shrink(),
                          TextFormInputField(
                            item: CustomFormItem(
                                title: 'Zip Code',
                                controller: _model.zipCodeController,
                                canBeEmpty: false),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    action(_model.address);
                                  }
                                },
                                child: Text(actionTitle),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
          model.state == ViewState.Busy ? LoadingView() : Container()
        ],
      ),
      model: _model,
      onModelFetchData: (model) {
        model.loadData();
      },
    );
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
          enabled: item.onTap == null,
          validator: (text) {
            if (!item.canBeEmpty) {
              if (text?.isEmpty ?? false) {
                return 'Can not be empty';
              }
            }
            return item.validator != null ? item.validator!(text) : null;
          },
          decoration: InputDecoration(hintText: item.placeholder),
          controller: item.controller,
        ),
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
  final void Function()? onTap;

  const CustomFormItem(
      {required this.title,
      this.placeholder = '',
      this.canBeEmpty = true,
      this.validator,
      this.onTap,
      required this.controller});
}

class SelectionInputItem {
  final String value;
  final String text;
  const SelectionInputItem({required this.value, required this.text});
}

class SelectionInputField extends StatelessWidget {
  final List<SelectionInputItem> selections;
  final int? selectedIndex;
  final String? placeholder;
  final String? title;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  const SelectionInputField(
      {required this.selections,
      this.title,
      this.placeholder,
      this.selectedIndex,
      this.validator,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null ? Text(title!) : SizedBox.shrink(),
            InputDecorator(
              decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: placeholder,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              isEmpty: selectedIndex == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedIndex != null
                      ? selections[selectedIndex!].value
                      : null,
                  isDense: true,
                  onChanged: onChanged,
                  items: selections.map((item) {
                    return DropdownMenuItem<String>(
                      value: item.value,
                      child: Text(item.text),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

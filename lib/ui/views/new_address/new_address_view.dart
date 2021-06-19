import 'package:flutter/material.dart';
import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/ui/views/new_address/new_address_viewmodel.dart';
import 'package:flutter_shopify/ui/widgets/common_button.dart';
import 'package:flutter_shopify/ui/widgets/form_input_views.dart';
import 'package:flutter_shopify/ui/widgets/loading.dart';

class NewAddressView extends StatelessWidget {
  final String actionTitle;
  final void Function(CheckoutAddress address) action;
  final _model = NewAddressViewModel();
  final _formKey = GlobalKey<FormState>();
  NewAddressView({required this.actionTitle, required this.action});

  @override
  Widget build(BuildContext context) {
    return BaseView<NewAddressViewModel>(
      builder: (context, model, child) => Stack(
        children: [
          model.state == ViewState.Initial
              ? LoadingView()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormInputField(
                            item: CustomFormItem(
                                title: 'First Name',
                                controller: _model.firstNameController,
                                canBeEmpty: false),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormInputField(
                            item: CustomFormItem(
                                title: 'Last Name',
                                controller: _model.lastNameController,
                                canBeEmpty: false),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormInputField(
                            item: CustomFormItem(
                                title: 'Address 1',
                                controller: _model.address1Controller,
                                canBeEmpty: false),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormInputField(
                            item: CustomFormItem(
                                title: 'Address 2',
                                controller: _model.address2Controller,
                                canBeEmpty: false),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormInputField(
                            item: CustomFormItem(
                                title: 'City',
                                controller: _model.cityController,
                                canBeEmpty: false),
                          ),
                        ),
                        _model.currentCountry != null &&
                                _model.currentCountry!.provinces.length > 0
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: SelectionInputField(
                                  selections: _model.currentCountry!.provinces
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
                                ),
                              )
                            : SizedBox.shrink(),
                        _model.countries.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: SelectionInputField(
                                  selections: _model.countries
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
                                ),
                              )
                            : SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormInputField(
                            item: CustomFormItem(
                                title: 'Zip Code',
                                controller: _model.zipCodeController,
                                canBeEmpty: false),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CommonButton(actionTitle, action: () {
                          if (_formKey.currentState!.validate()) {
                            action(_model.address);
                          }
                        }),
                      ],
                    ),
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

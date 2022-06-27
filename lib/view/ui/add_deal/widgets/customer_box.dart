import 'package:bigsize_management_staff/blocs/order_bloc.dart';
import 'package:bigsize_management_staff/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';
//import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import '../../../resources/styles_manager.dart';

class CustomerBox extends StatefulWidget {
  const CustomerBox({Key? key}) : super(key: key);

  @override
  _CustomerBox createState() => _CustomerBox();
}

// ignore: must_be_immutable
class _CustomerBox extends State<CustomerBox> {
  final OrderBloc _orderBloc = OrderBloc();

  final TextEditingController nameCus = TextEditingController();
  final TextEditingController phoneCus = TextEditingController();
  final TextEditingController addressCus = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String countryValue;
  late String stateValue;
  late String cityValue;

  bool isHaveCusPhone = false;
  bool isCustomer = false;

  Customer? customer;

  Future<Customer>? getCustomer(String cusPhone) async {
    return await _orderBloc.getCustomer(cusPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: !isHaveCusPhone
          ? Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: StyleManager.shadow,
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: StyleManager.border),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: StyleManager.border,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: DefaultFormField(
                      border: true,
                      controller: phoneCus,
                      prefix: Icons.phone_android_rounded,
                      title: 'SDT',
                      keyboardType: TextInputType.phone,
                      onChange: (value) {
                        //phoneCus.text = value;
                      },
                      onFieldSubmitted: (value) async {
                        customer = await _orderBloc
                            .getCustomer(phoneCus.text.toString());
                        if (customer!.isSuccess!) {
                          nameCus.text = customer!.content!.fullname.toString();
                          isHaveCusPhone = true;
                          isCustomer = true;
                          setState(() {
                            isHaveCusPhone = true;
                            isCustomer = true;
                          });
                        } else {
                          isHaveCusPhone = true;
                          isCustomer = false;
                          setState(() {
                            isHaveCusPhone = true;
                            isCustomer = false;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ))
          : Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: StyleManager.shadow,
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: StyleManager.border),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: StyleManager.border,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: DefaultFormField(
                      border: true,
                      controller: phoneCus,
                      prefix: Icons.phone_android_rounded,
                      title: 'Số điện thoại',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: StyleManager.border,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: DefaultFormField(
                      border: true,
                      controller: nameCus,
                      prefix: Icons.account_circle_rounded,
                      title: 'Tên khách hàng',
                      keyboardType: TextInputType.phone,
                      readOnly: isCustomer,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: StyleManager.border,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: DefaultFormField(
                      border: true,
                      controller: addressCus,
                      prefix: Icons.location_pin,
                      title: 'Địa chỉ',
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      CSCPicker(
                        showStates: true,
                        showCities: true,
                        defaultCountry: DefaultCountry.Vietnam,
                        flagState: CountryFlag.DISABLE,
                        countryDropdownLabel: "Country",
                        stateDropdownLabel: "Province/City",
                        cityDropdownLabel: "District",
                        selectedItemStyle: const TextStyle(
                          fontFamily: "QuickSandBold",
                          fontSize: 15,
                          color: Color(0xFF00ADFF),
                        ),
                        dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          //color: Colors.black,
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 2,
                            color: const Color(0xFF00ADFF),
                          ),
                        ),
                        disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          //color: Colors.black,
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        onCountryChanged: (value) {
                          setState(() {
                            //store value in country variable
                            countryValue = value;
                          });
                        },
                        //triggers once state selected in dropdown
                        onStateChanged: (value) {
                          setState(() {
                            //store value in state variable
                            if (value != null) stateValue = value;
                          });
                        },
                        //triggers once city selected in dropdown
                        onCityChanged: (value) {
                          setState(() {
                            //store value in city variable
                            if (value != null) cityValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )),
    );
  }
}

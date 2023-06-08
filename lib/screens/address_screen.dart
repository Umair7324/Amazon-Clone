// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/constants/user_api_call.dart';
import 'package:amazon_clone/services/error_handling.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/providers/user_provider.dart';

import '../constants/global_variables.dart';
import '../widgets/text_field.dart';

class AddressScreen extends StatefulWidget {
  final String totalSum;
  const AddressScreen({
    Key? key,
    required this.totalSum,
  }) : super(key: key);

  static const routeName = '/address-screen';

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController aFieldcontroller = TextEditingController();
  final TextEditingController bFieldcontroller = TextEditingController();
  final TextEditingController cFieldcontroller = TextEditingController();
  final TextEditingController dFieldcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String addresstoBeUSed = '';

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalSum,
        label: 'Total Amount',
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    aFieldcontroller.dispose();
    bFieldcontroller.dispose();
    cFieldcontroller.dispose();
    dFieldcontroller.dispose();
  }

  void payPressedAddress(String addressFromProvider) {
    addresstoBeUSed = '';
    bool isForm = aFieldcontroller.text.isNotEmpty ||
        bFieldcontroller.text.isNotEmpty ||
        cFieldcontroller.text.isNotEmpty ||
        dFieldcontroller.text.isNotEmpty;
    if (isForm) {
      if (formKey.currentState!.validate()) {
        setState(() {
          addresstoBeUSed =
              '${aFieldcontroller.text} ,${bFieldcontroller.text}, ${cFieldcontroller.text}-${dFieldcontroller.text}';
        });
      } else {
        throw Exception('Enter all the values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      setState(() {
        addresstoBeUSed = addressFromProvider;
      });
    } else {
      showSnackBar(context, 'Please enter all the fields');
    }
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      UserApiCall().saveUSerAddress(context, addresstoBeUSed);
      UserApiCall().placeAnOrder(
          context, addresstoBeUSed, double.parse(widget.totalSum));
      setState(() {});
    }
  }

  void onApplePayResult(res) {}

  void onGooglePAyResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      UserApiCall().saveUSerAddress(context, addresstoBeUSed);
      UserApiCall().placeAnOrder(
          context, addresstoBeUSed, double.parse(widget.totalSum));
    }
  }

  @override
  Widget build(BuildContext context) {
    var userAddress =
        Provider.of<UserProvider>(context, listen: false).user.address;
    var address = '101 street address';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            if (userAddress.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        userAddress,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: aFieldcontroller,
                        text: 'Flat House no, Building'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: bFieldcontroller, text: 'Area, Street'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: cFieldcontroller, text: 'Pin Code'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: dFieldcontroller, text: 'Town/City'),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            ApplePayButton(
              paymentConfigurationAsset: 'applepay.json',
              onPaymentResult: onApplePayResult,
              paymentItems: paymentItems,
              height: 50,
              margin: EdgeInsets.only(top: 15),
              style: ApplePayButtonStyle.white,
              type: ApplePayButtonType.buy,
            ),
            const SizedBox(
              height: 20,
            ),
            GooglePayButton(
              onPaymentResult: onGooglePAyResult,
              paymentItems: paymentItems,
              paymentConfigurationAsset: 'gpay.json',
              width: double.infinity,
              type: GooglePayButtonType.buy,
              height: 50,
              onPressed: () => payPressedAddress(userAddress),
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              ontap: () => payPressedAddress(userAddress),
              text: 'Order Now',
            )
          ],
        ),
      ),
    );
  }
}

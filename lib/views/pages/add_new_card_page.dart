import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:e_commerce/views/widgets/label_with_textfield_new_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _cardExpireDateController = TextEditingController();
  final TextEditingController _ccvCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = PaymentMethodsCubit();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Add New Card", style: Theme.of(context).textTheme.titleLarge)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWithTextfieldNewCardWidget(
                  label: "Card Number",
                  fieldLabel: "Enter Card Number",
                  controller: _cardNumberController,
                  icon: CupertinoIcons.creditcard,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                LabelWithTextfieldNewCardWidget(
                  label: "Card Holder Name",
                  fieldLabel: "Enter Card Holder Name",
                  controller: _cardHolderNameController,
                  icon: CupertinoIcons.person,
                  inputType: TextInputType.name,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z ]*$'))],
                ),
                LabelWithTextfieldNewCardWidget(
                  label: "Expired",
                  fieldLabel: "MM/YY",
                  controller: _cardExpireDateController,
                  icon: CupertinoIcons.calendar,
                  inputType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    LengthLimitingTextInputFormatter(5),
                  ],
                ),
                LabelWithTextfieldNewCardWidget(
                  label: "CVV",
                  fieldLabel: "Enter CVV",
                  controller: _ccvCodeController,
                  icon: CupertinoIcons.lock,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}$'))],
                ),

                const Expanded(child: SizedBox()),

                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.066,
                  child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                    listener: (context, state) {
                      if (state is AddNewCardSuccess) {
                          Navigator.of(context).pop();
                        
                      } else if (state is AddNewCardFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Error: ${state.error}")));
                      }
                    },
                    listenWhen: (previous, current) =>
                        current is AddNewCardSuccess || current is AddNewCardFailure,

                    buildWhen: (previous, current) =>
                        current is AddNewCardLoading ||
                        current is AddNewCardSuccess ||
                        current is AddNewCardFailure,
                    builder: (context, state) {

                      if (state is AddNewCardLoading) { // ! loading
                        return ElevatedButton(
                          onPressed: () {
                            null;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(color: AppColors.white),
                          ),
                        );

                      } else if (state is AddNewCardSuccess) { // ! Success
                        return ElevatedButton(
                          onPressed: () {
                            null;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grey,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Center(child: Icon(Icons.check)),
                        );

                      } else if (state is AddNewCardFailure) { // ! Failure
                        return Center(
                          child: Text(
                            "Error: ${state.error}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          // Handle adding card action
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<PaymentMethodsCubit>(context).addNewCard(
                              cardNumber: _cardNumberController.text,
                              cardHolderName: _cardHolderNameController.text,
                              cardExpireDate: _cardExpireDateController.text,
                              ccvCode: _ccvCodeController.text,
                            );
                          }

                          // Process data.
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                        ),
                        child: Text(
                          "Add Card",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

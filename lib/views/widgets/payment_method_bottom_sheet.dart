import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: Center(
              child: Text(
                "Available Payment Cards",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
              buildWhen: (previous, current) =>
                  current is FetchedPaymentMethods ||
                  current is FetchingPaymentMethods ||
                  current is FetchingPaymentMethodsFailure,
              builder: (context, state) {
                if (state is FetchingPaymentMethods) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FetchedPaymentMethods) {
                  final paymentCards = state.paymentCards;
                  if (paymentCards.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                          child: Text("No Payment Methods Available"),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentCards.length,
                    itemBuilder: (context, index) {
                      final card = paymentCards[index];
                      return ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(30),
                        child: Card(
                          elevation: 0,
                          child: ListTile(
                            onTap: () {
                              BlocProvider.of<PaymentMethodsCubit>(
                                context,
                              ).changePaymentMethod(card.id);
                            },
                            leading: CachedNetworkImage(
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/11378/11378185.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                            title: Text(card.cardNumber),
                            subtitle: Text(card.cardHolderName),
                            tileColor: Colors.grey.shade100,
                            trailing: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                              buildWhen: (previous, current) => current is PaymentMethodChosen,
                              builder: (context, state) {
                                if (state is PaymentMethodChosen) {
                                  final chosenPaymentMethod = state.chosenPaymentMethod;
                                  return Radio<String>(
                                    value: card.id,
                                    groupValue: chosenPaymentMethod.id,
                                    onChanged: (value) {},
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FetchingPaymentMethodsFailure) {
                  return Center(
                    child: Text(state.error, style: const TextStyle(color: Colors.red)),
                  );
                }
                return ListView.builder(
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                          child: Text("No Payment Methods Available"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(30),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.addNewCardRoute);
                      },
                      leading: const Icon(
                        CupertinoIcons.plus_circled,
                        color: AppColors.primary,
                        size: 30,
                      ),
                      title: const Text("Add New Card"),
                      tileColor: AppColors.grey.shade100,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                  buildWhen: (previous, current) =>
                      current is PaymentMethodConfirmLoading ||
                      current is PaymentMethodConfirmed ||
                      current is PaymentMethodConfirmFailure,
                  builder: (context, state) {
                    if (state is PaymentMethodConfirmLoading) {
                      return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    );
                    } else if (state is PaymentMethodConfirmFailure) {
                      return Center(
                        child: Text(state.error, style: const TextStyle(color: Colors.red)),
                      );
                    } else if (state is PaymentMethodConfirmed) {
                      Navigator.of(context).pop();
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<PaymentMethodsCubit>(context).confirmPaymentMethod();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Confirm Payment"),
                      ),
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

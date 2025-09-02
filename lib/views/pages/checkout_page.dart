import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/location_item_model.dart';
import 'package:e_commerce/models/payment_card_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:e_commerce/views/widgets/checkout_headlines.dart';
import 'package:e_commerce/views/widgets/empty_shipping_payment.dart';
import 'package:e_commerce/views/widgets/payment_method_bottom_sheet.dart';
import 'package:e_commerce/views/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  final double totalAmount;
  const CheckoutPage({super.key, required this.totalAmount});

  Widget _buildPaymentMethodItem(context, {required PaymentCardModel? chosenCard}) {
    final CheckoutCubit checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    if (chosenCard == null) {
      return EmptyShippingPayment(
        title: "Add a Payment Method",
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.addNewCardRoute).then((value) async => await checkoutCubit.getCheckoutItems());
        },
      );
    } else {
      return PaymentMethodItem(
        paymentCard: chosenCard,
        onItemTapped: () {
          showModalBottomSheet<void>(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              return BlocProvider(
                create: (context) {
                  final cubit = PaymentMethodsCubit();
                  cubit.fetchPaymentCards();
                  return cubit;
                },
                child: const PaymentMethodBottomSheet(),
              );
            },
          ).then((value) async => await checkoutCubit.getCheckoutItems());
        },
      );
    }
  }

  Widget _buildShippingItem(context, {required LocationItemModel? chosenLocation}) {
    if (chosenLocation == null) {
      return EmptyShippingPayment(
        title: 'Add a Shipping Address',
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.addNewAddressRoute);
        },
      );
    } else {
      return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CachedNetworkImage(imageUrl: chosenLocation.imgUrl, width: 80, height: 80),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chosenLocation.city, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: 8),
              Text(
                "${chosenLocation.city}, ${chosenLocation.country}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckoutCubit();
        cubit.getCheckoutItems();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Checkout"), backgroundColor: Colors.white),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              buildWhen: (previous, current) =>
                  current is CheckoutLoaded ||
                  current is CheckoutLoading ||
                  current is CheckoutError,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                } else if (state is CheckoutError) {
                  return const Center(child: Text("Something went wrong!"));
                } else if (state is CheckoutLoaded) {
                  if (state.cartItems.isEmpty) {
                    return const Center(child: Text("Your cart is empty, you can't visit the checkout page"));
                  }
                  final chosenLocation = state.shippingAddress;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CheckoutHeadlines(
                            title: 'Address',
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.addNewAddressRoute)
                                  .then(
                                    (value) async =>
                                        await BlocProvider.of<CheckoutCubit>(context).getCheckoutItems(),
                                  );
                            },
                          ),
                          _buildShippingItem(context, chosenLocation: chosenLocation),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          CheckoutHeadlines(title: 'Products', numOfProducts: state.numOfProducts),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.cartItems.length,
                            itemBuilder: (context, index) => LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12.0),
                                            child: CachedNetworkImage(
                                              imageUrl: state.cartItems[index].product.imgUrl,
                                              width: constraints.maxWidth * 0.3,
                                              height: constraints.maxWidth * 0.3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.cartItems[index].product.name,
                                                  style: Theme.of(context).textTheme.titleMedium!
                                                      .copyWith(fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Size: ',
                                                      style: Theme.of(context).textTheme.bodyMedium!
                                                          .copyWith(color: Colors.grey),
                                                    ),
                                                    Text(
                                                      state.cartItems[index].size.name,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Quantity: ',
                                                      style: Theme.of(context).textTheme.bodyMedium!
                                                          .copyWith(color: Colors.grey),
                                                    ),
                                                    Text(
                                                      state.cartItems[index].quantity.toString(),
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "\$ ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                            fontWeight: FontWeight.bold,
                                                            color: AppColors.primary,
                                                          ),
                                                    ),
                                                    Text(
                                                      (state.cartItems[index].product.price *
                                                              state.cartItems[index].quantity)
                                                          .toStringAsFixed(1),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Divider(thickness: 0.9, color: AppColors.grey2),
                                  ],
                                );
                              },
                            ),
                          ),

                          const CheckoutHeadlines(title: "Payment Methods"),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          _buildPaymentMethodItem(context, chosenCard: state.chosenPaymentCard),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total: ",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                              ),
                              Text(
                                "\$${totalAmount.toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle checkout action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text("Proceed to Buy"),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text("Unknown state"));
                }
              },
            );
          },
        ),
      ),
    );
  }
}

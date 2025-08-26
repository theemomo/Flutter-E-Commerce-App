import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/views/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _promoCodeController = TextEditingController();
    double discount = 0.0;

    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartItems();
        return cubit;
      },
      child: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) =>
            current is CartLoading ||
            current is CartLoaded ||
            current is CartError ||
            current is CartQuantityUpdated,
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CartLoaded) {
            
            if (state.cartItems.isEmpty) {
              return const Center(child: Text("Your cart is empty"));
            } else {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined),
                        onPressed: () {
                          debugPrint("Cart Icon Pressed");
                          showModalBottomSheet<void>(
                            useSafeArea: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                            ),
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height * 0.4,
                                child: Column(
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
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                            validator: (value) => value == null || value.isEmpty
                                                ? "Please Enter a Promo Code"
                                                : null,
                                            controller: _promoCodeController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.discount,
                                                color: AppColors.grey.withValues(alpha: 0.8),
                                              ),
                                              fillColor: AppColors.grey.withValues(alpha: 0.1),
                                              filled: true,
                                              hintText: "Enter Promo Code",
                                              hintStyle: TextStyle(
                                                color: AppColors.grey.withValues(alpha: 0.8),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                                borderSide: const BorderSide(color: AppColors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    totalAndSubTotalWidget(
                                      context,
                                      title: "Subtotal",
                                      amount: state.subtotal - discount * 100,
                                    ),
                                    totalAndSubTotalWidget(context, title: "Shipping", amount: 20),
                                    Dash(
                                      dashColor: AppColors.grey.shade300,
                                      length: MediaQuery.of(context).size.width - 52,
                                    ),
                                    totalAndSubTotalWidget(
                                      context,
                                      title: "Total Amount",
                                      amount: state.subtotal + 20 - discount * 100,
                                    ),

                                    const SizedBox(height: 20.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.height * 0.06,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Handle checkout action
                                            Navigator.pushNamed(context, AppRoutes.checkoutRoute);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text("Checkout"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = state.cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 26.0),
                            child: CartItemWidget(
                              cartItem: cartItem,
                              counterValue: state.cartItems[index].quantity,
                              cubit: context.read<CartCubit>(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          } else if (state is CartError) {
            return const Center(child: Text("Something went wrong"));
          }
          return const Center(child: Text("Something went wrong!!"));
        },
      ),
    );
  }

  Widget totalAndSubTotalWidget(
    BuildContext context, {
    required String title,
    required double amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 26.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grey.shade600),
          ),
          Text("\$${amount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}

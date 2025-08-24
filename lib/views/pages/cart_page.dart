import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/views/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                debugPrint("Cart Icon Pressed");
              },
            ),
          ),
        ],
      ),
      body: BlocProvider(
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
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is CartLoaded) {
              if (state.cartItems.isEmpty) {
                return Center(child: Text("Your cart is empty"));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = state.cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 9.0,
                              horizontal: 26.0,
                            ),
                            child: CartItemWidget(
                              cartItem: cartItem,
                              counterValue: state.cartItems[index].quantity,
                              cubit: context.read<CartCubit>(),
                            ),
                          );
                        },
                      ),
                      totalAndSubTotalWidget(context, title: "Subtotal", amount: state.subtotal),
                      totalAndSubTotalWidget(context, title: "Shipping", amount: 20),
                      Dash(
                        dashColor: AppColors.grey.shade300,
                        length: MediaQuery.of(context).size.width - 52,
                      ),
                      totalAndSubTotalWidget(context, title: "Total Amount", amount: state.subtotal + 20),
                      const SizedBox(height: 20.0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox(
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
                            child: Text("Checkout"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else if (state is CartError) {
              return Center(child: Text("Something went wrong"));
            }
            return Center(child: Text("Something went wrong!!"));
          },
        ),
      ),
    );

    
  }
  Widget totalAndSubTotalWidget(BuildContext context, {required String title, required double amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 26.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grey.shade600),),
          Text("\$${amount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}

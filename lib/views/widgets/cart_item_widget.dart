import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/views/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  final int counterValue;
  final dynamic cubit;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.counterValue,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: cartItem.product.imgUrl,
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxWidth * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product.name,
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
                            cartItem.size.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                            cartItem.quantity.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<CartCubit, CartState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is CartLoaded,
                            builder: (context, state) {
                              if (state is CartLoaded) {
                                return Counter(
                                  counterValue: counterValue,
                                  productId: cartItem.product.id,
                                  cubit: cubit,
                                );
                              } else {
                                return Counter(
                                  counterValue: counterValue,
                                  productId: cartItem.product.id,
                                  cubit: cubit,
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$ ",style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
                              ),
                              Text(
                                (cartItem.product.price * cartItem.quantity)
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
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(thickness: 0.9, color: AppColors.grey2),
          ],
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesProductItem extends StatelessWidget {
  final ProductItemModel product;
  const FavoritesProductItem({super.key, required this.product});

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
                    imageUrl: product.imgUrl,
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxWidth * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                (product.price).toStringAsFixed(1),
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BlocConsumer<FavoriteCubit, FavoriteState>(
                  listenWhen: (previous, current) =>
                      (current is FavoriteRemovingError && product.id == current.productId),
                  listener: (context, state) {
                    if (state is FavoriteRemovingError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message.toString())));
                    }
                  },
                  buildWhen: (previous, current) =>
                      (current is FavoriteRemoving && product.id == current.productId) ||
                      (current is FavoriteRemoved && product.id == current.productId),
                  builder: (context, state) {
                    if (state is FavoriteRemoving) {
                      return const Center(child:  CircularProgressIndicator.adaptive());
                    } else if (state is FavoriteRemoved) {
                      return IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.primary),
                        onPressed: () async {
                          await BlocProvider.of<FavoriteCubit>(context).removeFavorite(product.id);
                        },
                      );
                    }
                    return IconButton(
                      icon: const Icon(Icons.delete, color: AppColors.primary),
                      onPressed: () async {
                        await BlocProvider.of<FavoriteCubit>(context).removeFavorite(product.id);
                        // debugPrint("Delete: ${product.name}");
                      },
                    );
                  },
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductGridItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        children: [
          Stack(
            children: [
              Container(
                height: constrains.maxHeight * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: productItem.imgUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),

              Positioned(
                top: orientation == Orientation.portrait ? 5 : 0,
                right: orientation == Orientation.portrait ? 0 : 20,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    buildWhen: (previous, current) =>
                        (current is SetFavLoading && current.productId == productItem.id) ||
                        (current is SetFavSuccess && current.productId == productItem.id) ||
                        (current is SetFavError && current.productId == productItem.id),
                    builder: (context, state) {
                      if (state is SetFavLoading) {
                        // return const Center(child: CircularProgressIndicator.adaptive());
                      } else if (state is SetFavSuccess) {
                        return state.isFavorite
                            ? SizedBox(
                                height: orientation == Orientation.portrait
                                    ? constrains.maxHeight * 0.1
                                    : constrains.maxHeight * 0.13,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white54,
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      await homeCubit.setFavorite(productItem);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.heart_fill,
                                      size: constrains.maxHeight * 0.05,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: orientation == Orientation.portrait
                                    ? constrains.maxHeight * 0.1
                                    : constrains.maxHeight * 0.13,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      await homeCubit.setFavorite(productItem);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.heart,
                                      size: constrains.maxHeight * 0.05,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                      }
                      return SizedBox(
                        height: orientation == Orientation.portrait
                            ? constrains.maxHeight * 0.1
                            : constrains.maxHeight * 0.13,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: productItem.isFav ? Colors.white54 : Colors.grey,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await homeCubit.setFavorite(productItem);
                              // debugPrint(productItem.isFav.toString()); // always false !!
                            },
                            icon: productItem.isFav
                                ? Icon(
                                    CupertinoIcons.heart_fill,
                                    size: constrains.maxHeight * 0.05,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    CupertinoIcons.heart,
                                    size: constrains.maxHeight * 0.05,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            productItem.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800),
          ),
          Text(
            productItem.category,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
          ),
          Text(
            "\$ ${productItem.price}",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

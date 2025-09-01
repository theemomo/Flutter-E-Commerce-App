import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:e_commerce/views/widgets/favorites_product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = FavoriteCubit();
        cubit.getFavoriteProducts();
        return cubit;
      },
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        buildWhen: (previous, current) =>
            current is FavoriteLoading ||
            current is FavoriteLoaded ||
            current is FavoriteLoadingError,
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FavoriteLoadingError) {
            return Text(state.message);
          } else if (state is FavoriteLoaded) {
            if (state.favoriteProducts.isEmpty) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () async {
                      await BlocProvider.of<FavoriteCubit>(context).getFavoriteProducts();
                    },
                    icon: const Icon(CupertinoIcons.refresh_thick),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.heart),
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                body: const Center(child: Text("Your wishlist is empty")),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () async {
                      await BlocProvider.of<FavoriteCubit>(context).getFavoriteProducts();
                    },
                    icon: const Icon(CupertinoIcons.refresh_thick),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.heart),
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                body: RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: AppColors.primary,
                  onRefresh: () async {
                    await BlocProvider.of<FavoriteCubit>(context).getFavoriteProducts();
                  },
                  child: ListView.builder(
                    itemCount: state.favoriteProducts.length,
                    itemBuilder: (context, index) {
                      final product = state.favoriteProducts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 26.0),
                        child: FavoritesProductItem(product: product),
                      );
                    },
                  ),
                ),
              );
            }
          }
          // this will never happens
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}

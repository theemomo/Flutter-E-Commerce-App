import 'package:e_commerce/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:e_commerce/views/widgets/favorites_product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: BlocProvider(
        create: (context) {
          final cubit = FavoriteCubit();
          cubit.getFavoriteProducts();
          return cubit;
        },
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is FavoriteLoadingError) {
              return Text(state.message);
            } else if (state is FavoriteLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = state.favoriteProducts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 26.0),
                          child: FavoritesProductItem(product: product),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

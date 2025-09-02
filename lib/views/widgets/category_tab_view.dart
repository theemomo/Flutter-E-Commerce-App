import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getCategoriesData();
        return cubit;
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (current, previeos) =>
            current is CategoryLoading ||
            current is CategoryLoaded ||
            current is CategoryLoadingError,
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CategoryLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(category.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            category.name,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${category.productsCount} Products",
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is CategoryLoadingError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }

          // return ListView.builder(
          //   itemCount: dummyCategories.length,
          //   itemBuilder: (context, index) {
          //     final category = dummyCategories[index];
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 6.0),
          //       child: DecoratedBox(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(11),
          //           image: DecorationImage(
          //             image: CachedNetworkImageProvider(category.imageUrl),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         child: Container(
          //           padding: const EdgeInsets.all(30.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(11),
          //             color: Colors.black.withOpacity(0.3),
          //           ),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Text(
          //                 category.name,
          //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //                   color: AppColors.white,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //               Text(
          //                 "${category.productsCount} Products",
          //                 style: Theme.of(
          //                   context,
          //                 ).textTheme.titleSmall!.copyWith(color: AppColors.white),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/widgets/product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                FlutterCarousel.builder(
                  itemCount: state.carouselItems.length,
                  options: FlutterCarouselOptions(
                    viewportFraction: 1,
                    height: size.height * 0.2,
                    autoPlay: true,
                    slideIndicator: CircularWaveSlideIndicator(
                      slideIndicatorOptions: const SlideIndicatorOptions(
                        currentIndicatorColor: Colors.deepPurple,
                        indicatorBackgroundColor: Colors.grey,
                        indicatorRadius: 4,
                        itemSpacing: 15,
                      ),
                    ),
                    showIndicator: true,
                    floatingIndicator: false,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(11),
                        child: CachedNetworkImage(
                          imageUrl: state.carouselItems[itemIndex].imgUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error, color: Colors.red)),
                        ),
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrivals 🔥",
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See All",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        // onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                    childAspectRatio: orientation == Orientation.portrait ? 0.6 : 0.5,
                  ),
                  itemCount: state.arrivalProducts.length,
                  itemBuilder: (context, index) => InkWell(
                    child: ProductGridItem(productItem: state.arrivalProducts[index]),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(
                            AppRoutes.productDetailsRoute,
                            arguments: state.arrivalProducts[index].id,
                          )
                          .then((value) {
                            // BlocProvider.of<CartCubit>(this.context).getCartItems();
                          });
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message, style: Theme.of(context).textTheme.labelLarge));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

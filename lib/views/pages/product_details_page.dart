import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_colors.dart';
import '../widgets/counter.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    // ! creating the BlocProvider
    return BlocProvider(
      create: (context) {
        final cubit = ProductDetailsCubit();
        cubit.getProductDetailsPage(productId);
        return cubit;
      },
      // ! creating the BlocBuilder
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        buildWhen: (previous, current) =>
            current is ProductDetailsLoading ||
            current is ProductDetailsLoaded ||
            current is ProductDetailsError,
        builder: (context, state) {
          // ! when the page is loading
          if (state is ProductDetailsLoading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
            // ! when page have loaded
          } else if (state is ProductDetailsLoaded) {
            final productItem = state.product;
            // ! the product image section
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: Text(
                  "Product Details",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.heart,
                      color: AppColors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
                leading: IconButton(
                  icon: Icon(
                    CupertinoIcons.chevron_back,
                    color: AppColors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Stack(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(productItem.imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      height: size.height * 0.59,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.55),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      // ! the product details section
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(29.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    productItem.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  // ! creating he BlocBuilder for the counter
                                  BlocBuilder<
                                    ProductDetailsCubit,
                                    ProductDetailsState
                                  >(
                                    buildWhen: (previous, current) =>
                                        current is QuantityCounterLoaded ||
                                        current is ProductDetailsLoaded,
                                    builder: (context, state) {
                                      if (state is QuantityCounterLoaded) {
                                        return Counter(
                                          counterValue: state.value,
                                          productId: productId,
                                          cubit:
                                              BlocProvider.of<
                                                ProductDetailsCubit
                                              >(context),
                                        );
                                      } else if (state
                                          is ProductDetailsLoaded) {
                                        return Counter(
                                          counterValue: 1,
                                          productId: productId,
                                          cubit:
                                              BlocProvider.of<
                                                ProductDetailsCubit
                                              >(context),
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.009),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "4.5 ",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelLarge,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  Text("Available in stock"),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "Size",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              // ! creating the BlocBuilder for size selection
                              BlocBuilder<
                                ProductDetailsCubit,
                                ProductDetailsState
                              >(
                                bloc: BlocProvider.of<ProductDetailsCubit>(
                                  context,
                                ),
                                buildWhen: (previous, current) =>
                                    current is SizeSelected ||
                                    current is ProductDetailsLoaded,
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: ProductSize.values
                                        .map(
                                          (size) => InkWell(
                                            onTap: () {
                                                BlocProvider.of<
                                                      ProductDetailsCubit
                                                    >(context)
                                                    .selectSize(size);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                4.0,
                                              ),
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    state is SizeSelected &&
                                                        state.size == size
                                                    ? AppColors.primary
                                                    : AppColors.grey2,

                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12,
                                                  ),
                                                  child: Text(
                                                    size.name,
                                                    style:
                                                        state is SizeSelected &&
                                                            state.size == size
                                                        ? Theme.of(context)
                                                              .textTheme
                                                              .labelMedium!
                                                              .copyWith(
                                                                color: Colors
                                                                    .white,
                                                              )
                                                        : Theme.of(context)
                                                              .textTheme
                                                              .labelMedium!
                                                              .copyWith(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                              // ! Discretion section
                              SizedBox(height: size.height * 0.02),
                              Text(
                                productItem.description,
                                style: Theme.of(context).textTheme.labelMedium!
                                    .copyWith(color: Colors.black54),
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "\$",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(
                                                  context,
                                                ).primaryColor,
                                              ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' ${productItem.price.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ! Add to cart button
                                  BlocBuilder<
                                    ProductDetailsCubit,
                                    ProductDetailsState
                                  >(
                                    // bloc: BlocProvider.of<ProductDetailsCubit>(context),
                                    buildWhen: (previous, current) =>
                                        current is ProductAddedToCart ||
                                        current is ProductAddingToCart,
                                    builder: (context, state) {
                                      if (state is ProductAddingToCart) {
                                        return ElevatedButton.icon(
                                          onPressed: () {
                                            null;
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(
                                              context,
                                            ).primaryColor,
                                            foregroundColor: AppColors.white,
                                            minimumSize: Size(180, 60),
                                          ),
                                          icon: Center(
                                            child:
                                                CircularProgressIndicator.adaptive(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(AppColors.white),
                                                  strokeWidth: 3,
                                                  constraints: BoxConstraints(
                                                    minWidth: 24,
                                                    minHeight: 24,
                                                  ),
                                                ),
                                          ),
                                          label: Text(
                                            "Add to cart",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: AppColors.white,
                                                ),
                                          ),
                                        );
                                      } else if (state is ProductAddedToCart) {
                                        return ElevatedButton.icon(
                                          onPressed: () {
                                            null;
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.grey,
                                            foregroundColor: AppColors.white,
                                            minimumSize: Size(180, 60),
                                          ),
                                          icon: Icon(
                                            Icons.done,
                                            size:
                                                orientation ==
                                                    Orientation.portrait
                                                ? size.height * 0.03
                                                : size.height * 0.06,
                                          ),
                                          label: Text(
                                            "Added to cart",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: AppColors.white,
                                                ),
                                          ),
                                        );
                                      } else {
                                        return ElevatedButton.icon(
                                          onPressed: () {
                                            final cubit = BlocProvider.of<ProductDetailsCubit>(context);
                                            if (cubit.selectedSize != null) {
                                              cubit.addToCart(productId);
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Please select a size",
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(
                                              context,
                                            ).primaryColor,
                                            foregroundColor: AppColors.white,
                                            minimumSize: Size(180, 60),
                                          ),
                                          icon: Icon(
                                            Icons.shopping_bag_outlined,
                                            size:
                                                orientation ==
                                                    Orientation.portrait
                                                ? size.height * 0.03
                                                : size.height * 0.06,
                                          ),
                                          label: Text(
                                            "Add to cart",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: AppColors.white,
                                                ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductDetailsError) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else {
            return Scaffold(body: Center(child: Text("Page Not Found")));
          }
        },
      ),
    );
  }
}

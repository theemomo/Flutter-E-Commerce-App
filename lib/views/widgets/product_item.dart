import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                ),
              ),

              Positioned(
                top: orientation == Orientation.portrait ? 5 : 0,
                right: orientation == Orientation.portrait ? 0 : 20,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, ),
                  child: SizedBox(
                    height: orientation == Orientation.portrait ? constrains.maxHeight * 0.1 : constrains.maxHeight * 0.13,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.heart,
                          size: constrains.maxHeight * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            productItem.name,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800),
          ),
          Text(
            productItem.category,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Colors.grey),
          ),
          Text(
            "\$ ${productItem.price}",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

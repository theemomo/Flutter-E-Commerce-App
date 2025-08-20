import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constrains) => Column(
          children: [
            Stack(
              children: [
                Container(
                  height: constrains.maxHeight * 0.6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade200
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Image.network(
                      productItem.imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
      
                Positioned(
                  top: 3,
                  right: 2,
                  child: IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      height: constrains.maxHeight * 0.08,
                      width: constrains.maxWidth *0.15,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Icon(CupertinoIcons.heart, size: constrains.maxHeight * 0.05, color: Colors.white,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Text(productItem.name, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800)),
            Text(
              productItem.category,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.grey),
            ),
            Text("\$ ${productItem.price}", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800) ),
          ],
        ),
      );
  }
}

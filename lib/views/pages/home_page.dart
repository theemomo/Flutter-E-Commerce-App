import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/views/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/9408/9408175.png",
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Mohammad Moustafa",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Let's go shopping",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                    const Icon(CupertinoIcons.search),
                    const SizedBox(width: 15),
                    const Icon(CupertinoIcons.bell),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrivals 🔥",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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
                SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.5
                  ),
                  itemCount: dummyProducts.length,
                  itemBuilder: (context, index) => ProductItem(productItem: dummyProducts[index]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

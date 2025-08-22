import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int counterValue;
  final String productId;
  final dynamic cubit;
  const Counter({
    super.key,
    required this.counterValue,
    required this.productId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: 100,
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Icon(Icons.add, size: 20),
                onTap: () => cubit.incrementCounter(productId),
              ),
              Text(counterValue.toString()),
              InkWell(
                child: Icon(Icons.remove, size: 20),
                onTap: () {
                  if(counterValue != 0){
                    cubit.decrementCounter(productId);
                  }
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

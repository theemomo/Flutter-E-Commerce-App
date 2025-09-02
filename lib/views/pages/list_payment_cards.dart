import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPaymentCards extends StatelessWidget {
  const ListPaymentCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Cards"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.addNewCardRoute);
            },
            icon: const Icon(Icons.add, size: 30),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) {
          final cubit = PaymentMethodsCubit();
          cubit.fetchPaymentCards();
          return cubit;
        },
        child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
          buildWhen: (previous, current) =>
              current is FetchingPaymentMethods ||
              current is FetchedPaymentMethods ||
              current is FetchingPaymentMethodsFailure,
          builder: (context, state) {
            if (state is FetchedPaymentMethods) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: RefreshIndicator(
                  onRefresh: () =>
                      BlocProvider.of<PaymentMethodsCubit>(context).fetchPaymentCards(),
                  child: ListView.builder(
                    itemCount: state.paymentCards.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.5), // border color
                            width: 1, // border thickness
                          ),
                        ),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: 'https://cdn-icons-png.flaticon.com/512/11378/11378185.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          title: Text(state.paymentCards[index].cardHolderName),
                          subtitle: Text(
                            state.paymentCards[index].cardNumber,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              await BlocProvider.of<PaymentMethodsCubit>(
                                context,
                              ).deletePaymentCard(state.paymentCards[index].id);
                            },
                            icon: const Icon(Icons.delete, size: 20, color: AppColors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

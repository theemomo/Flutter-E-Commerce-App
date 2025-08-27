import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/location_cubit/location_cubit.dart';
import 'package:e_commerce/views/widgets/location_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatelessWidget {
  const ChooseLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    return BlocProvider(
      create: (context) {
        final cubit = LocationCubit();
        cubit.fetchLocations();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Address")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your location",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "let's find your unforgettable event. Choose a location below to get started.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      CupertinoIcons.location_solid,
                      color: AppColors.grey.withValues(alpha: 0.8),
                    ),
                    suffixIcon: BlocConsumer<LocationCubit, LocationState>(
                      listenWhen: (previous, current) =>
                          current is LocationAdded || current is LocationConfirmed,
                      listener: (context, state) {
                        if (state is LocationAdded) {
                          locationController.clear();
                        } else if (state is LocationConfirmed) {
                          Navigator.of(context).pop();
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is LocationAdding ||
                          current is LocationAdded ||
                          current is LocationAddingError ||
                          current is LocationConfirmed,
                      builder: (context, state) {
                        if (state is LocationAdding) {
                          return IconButton(
                            icon: const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(AppColors.grey),
                              ),
                            ),
                            color: AppColors.grey.withValues(alpha: 0.8),
                            onPressed: () {},
                          );
                        } else if (state is LocationAdded) {
                          return IconButton(
                            icon: const Icon(CupertinoIcons.check_mark),
                            color: AppColors.grey.withValues(alpha: 0.8),
                            onPressed: () {},
                          );
                        } else if (state is LocationAddingError) {
                          return IconButton(
                            icon: const Icon(CupertinoIcons.exclamationmark_circle),
                            color: AppColors.grey.withValues(alpha: 0.8),
                            onPressed: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(state.message)));
                            },
                          );
                        }

                        return IconButton(
                          icon: const Icon(CupertinoIcons.plus_circle),
                          color: AppColors.grey.withValues(alpha: 0.8),
                          onPressed: () {
                            // Handle the plus icon press
                            if (locationController.text.isNotEmpty) {
                              BlocProvider.of<LocationCubit>(
                                context,
                              ).addLocation(locationController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please enter a location")),
                              );
                            }
                          },
                        );
                      },
                    ),
                    fillColor: AppColors.grey.withValues(alpha: 0.1),
                    filled: true,
                    hintText: "Write your location: city, country",
                    hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.8)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Select location",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                BlocBuilder<LocationCubit, LocationState>(
                  buildWhen: (previous, current) =>
                      current is LocationFetched ||
                      current is LocationFetchingError ||
                      current is LocationFetching ||
                      current is LocationAdded,
                  builder: (context, state) {
                    if (state is LocationFetched) {
                      final locations = state.locations;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: BlocBuilder<LocationCubit, LocationState>(
                              buildWhen: (previous, current) => current is LocationSelected,
                              builder: (context, state) {
                                if (state is LocationSelected) {
                                  final chosenLocation = state.chosenLocation;
                                  return LocationItemWidget(
                                    location: locations[index],
                                    borderColor: chosenLocation.id == locations[index].id
                                        ? AppColors.primary
                                        : AppColors.grey,
                                  );
                                }
                                return LocationItemWidget(location: locations[index]);
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is LocationFetching) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LocationFetchingError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: BlocBuilder<LocationCubit, LocationState>(
                    buildWhen: (previous, current) =>
                        current is LocationConfirming ||
                        current is LocationConfirmed ||
                        current is LocationConfirmingError,
                    builder: (context, state) {
                      if (state is LocationConfirming) {
                        return const Center(
                          child: CircularProgressIndicator(color: AppColors.primary),
                        );
                      } else if (state is LocationConfirmingError) {
                        return ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(state.message)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Confirm Address"),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LocationCubit>(context).confirmLocation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Confirm Address"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

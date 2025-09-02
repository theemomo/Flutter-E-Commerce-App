import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/location_cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListLocationsPage extends StatelessWidget {
  const ListLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = LocationCubit();
        cubit.fetchLocations();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Locations"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.addNewAddressRoute,
                );
              },
              icon: const Icon(Icons.add, size: 30),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocBuilder<LocationCubit, LocationState>(
            buildWhen: (previous, current) =>
                current is LocationFetched ||
                current is LocationFetchingError ||
                current is LocationFetching ||
                current is LocationAdded,
            builder: (context, state) {
              if (state is LocationFetched) {
                final locations = state.locations;
                if (locations.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: ()=> BlocProvider.of<LocationCubit>(context).fetchLocations(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<LocationCubit>(
                                        context,
                                      ).deleteLocation(locations[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 245, 45, 30),
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          locations[index].city,
                                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${locations[index].city}, ${locations[index].country}",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const CircleAvatar(radius: 39, backgroundColor: AppColors.grey),
                                      CircleAvatar(
                                        radius: 35,
                                        child: CachedNetworkImage(
                                          imageUrl: locations[index].imgUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: "https://cdn-icons-png.flaticon.com/512/15449/15449386.png",
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        Center(
                          child: Text(
                            "No locations Found",
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(color: AppColors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else if (state is LocationFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LocationFetchingError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

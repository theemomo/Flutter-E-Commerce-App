import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/location_item_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/location_cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationItemWidget extends StatelessWidget {
  final LocationItemModel location;
  final Color borderColor;
  const LocationItemWidget({super.key, required this.location, this.borderColor = AppColors.grey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<LocationCubit>(context).selectLocation(location.id);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.city,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${location.city}, ${location.country}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(radius: 39, backgroundColor: borderColor),
                  CircleAvatar(
                    radius: 35,
                    child: CachedNetworkImage(imageUrl: location.imgUrl, fit: BoxFit.contain),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:coffee_shop/src/features/map/bloc/map_bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapBottomSheet extends StatelessWidget {
  final LocationModel location;
  const MapBottomSheet({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 20.0, top: 10.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            height: 4,
            width: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.greyIcon,
                borderRadius: BorderRadius.circular(2.0),
              ),
            )),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location.address,
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            context.read<MapBloc>().add(ChooseCurrentLocationEvent(location));
            Navigator.pop(context, true);
          },
          child: SizedBox(
            width: double.infinity,
            height: 56.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).choose,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

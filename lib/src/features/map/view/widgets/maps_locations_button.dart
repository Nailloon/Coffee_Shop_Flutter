import 'package:coffee_shop/src/features/map/bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/map/view/locations_list_screen.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapsLocationsButton extends StatelessWidget {
  const MapsLocationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
        heroTag: 'locations',
        backgroundColor: AppColors.white,
        child: const Icon(Icons.map_outlined,
            size: 20.0, color: AppColors.realBlack),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<MapBloc>(),
                  child: const LocationsListScreen(),
                ),
              ));
        });
  }
}

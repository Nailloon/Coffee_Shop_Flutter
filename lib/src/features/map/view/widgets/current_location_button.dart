import 'package:coffee_shop/src/features/map/bloc/map_bloc.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      if (state is MapInitial && state.current != null) {
        return Row(children: [
          const Icon(Icons.location_on_outlined,
              color: AppColors.blue, size: 24),
              const SizedBox(width: 10,),
          Text(
            state.current!.address,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ]);
      } else {
        throw Exception('MapBloc Issue');
      }
    });
  }
}

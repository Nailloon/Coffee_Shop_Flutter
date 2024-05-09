import 'package:coffee_shop/src/features/map/bloc/map_bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/map/bloc/permission_bloc/permission_bloc.dart';
import 'package:coffee_shop/src/features/map/view/map_screen.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      if (state is! MapError) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<MapBloc>(),
                  child: BlocProvider.value(
                    value: context.read<PermissionBloc>(),
                    child: const MapScreen(),
                  ),
                ),
              ),
            );
          },
          child: Row(children: [
            const Icon(Icons.location_on_outlined,
                color: AppColors.blue, size: 24),
            const SizedBox(
              width: 10,
            ),
            Text(
              state.current!.address,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ]),
        );
      } else {
        return Row(children: [
          const Icon(Icons.location_on_outlined,
              color: AppColors.blue, size: 24),
          const SizedBox(
            width: 10,
          ),
          Text(
            AppLocalizations.of(context).error_in_loading_locations,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ]);
      }
    });
  }
}

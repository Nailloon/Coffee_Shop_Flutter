import 'package:coffee_shop/src/features/map/bloc/map_bloc/map_bloc.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationsListScreen extends StatelessWidget {
  const LocationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.realBlack,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(AppLocalizations.of(context).our_locations,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 20.0, color: AppColors.realBlack),
                          title: Text(state.locations[index].address),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          onTap: () {
                            context.read<MapBloc>().add(
                                ChooseCurrentLocationEvent(
                                    state.locations[index]));
                            Navigator.pop(context, true);
                          },
                        );
                      },
                      itemCount: state.locations.length,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

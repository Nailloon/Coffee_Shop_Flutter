import 'package:coffee_shop/src/features/map/bloc/map_bloc.dart';
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
        return SizedBox(
            height: 20,
            child: Row(
              children: [
                Icon(Icons.location_pin),
                Text(state.current!.address)
              ],
            ));
      } else {
        throw Exception('MapBloc Issue');
      }
    });
  }
}

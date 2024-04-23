import 'package:coffee_shop/src/features/map/bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapBottomSheet extends StatelessWidget {
  final LocationModel location;
  const MapBottomSheet({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(location.address, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text(
          '${location.latitude}, ${location.longitude}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              context.read<MapBloc>().add(ChooseCurrentLocationEvent(location));
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
            child: Text('Выбрать'))
      ]),
    );
  }
}

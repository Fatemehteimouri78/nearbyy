import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearby/cubit/maps_cubit.dart';
import 'package:nearby/utils/coordinates.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;


  @override
  void dispose() {
    super.dispose();
  }

  //MapsCubit instance
  final MapsCubit _mapsCubit = MapsCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildGoogleMap(),
            buildPositionedWidget(),
          ],
        ),
      ),
    );
  }

  Positioned buildPositionedWidget() {
    return Positioned(
      left: 20,
      top: 10,
      right: 20,
      child: ElevatedButton(
        onPressed: () {
          //move camera to center
          _mapsCubit.moveCameraToCenter(mapController);
          //show nearby restaurant
          _mapsCubit.getNearbyRestaurants();
        },
        child: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Icon(Icons.place, color: Colors.redAccent),
            SizedBox(
              width: 10,
            ),
            Text("Show Route and Nearby Restaurants"),
          ],
        ),
      ),
    );
  }

  buildGoogleMap() {
    Map<MarkerId, Marker> markers = {};
    Map<PolylineId, Polyline> polylines = {};

    return BlocBuilder(
      cubit: _mapsCubit,
      builder: (context, state) {
        if (state is PolylinesLoadedState) {
          markers = state.markers;
          polylines = state.polylines;
        }
        return GoogleMap(
          onTap: (cordinate) {
            _mapsCubit.animateCamera(mapController, cordinate);
          },
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(originLatitude, originLongitude),
            zoom: 8.4746,
          ),
          onMapCreated: _onMapCreated,

          //To Do here
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
          compassEnabled: true,
          tiltGesturesEnabled: false,
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    print("\n\nMap ready.\n\n");
  }
}

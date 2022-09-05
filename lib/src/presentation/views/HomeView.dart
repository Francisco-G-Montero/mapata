import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeState.dart';
import 'package:mapata/src/presentation/blocs/home/HomeEvent.dart';
import 'package:mapata/src/presentation/views/MainView.dart';
import 'package:mapata/src/presentation/widgets/CustomButton.dart';

import '../widgets/AppBarWidget.dart';

import '../../data/util/Constants.dart';

class HomeView extends StatelessWidget {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  LatLng _myLocation = const LatLng(-34.9191509, -57.9710679);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    print("Tab actual: home");
    return BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
      if (state is HomeLoading) {
        _.read<HomeBloc>().add(InitializeMap());
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is HomeError) {
        return Center(
          child: Text(kGenericError),
        );
      }
      if (state is HomeDone) {
        if (state.homeUiModel.currentLocation != null) {
          _myLocation = LatLng(
              state.homeUiModel.currentLocation!.latitude,
              state.homeUiModel.currentLocation!.longitude
          );
        }
        return Stack(
          children: [
            Container(
              height: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: _myLocation,
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
                zoomControlsEnabled: false,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(8),
              child: CustomButton((){}, Icons.camera_alt, "Reportar mascota"),
            )
          ]
        );
      }
      return Center(
        child: Text("Algo inesperado ha ocurrido"),
      );
    });
  }
}

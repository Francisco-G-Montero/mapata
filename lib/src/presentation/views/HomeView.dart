import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeState.dart';
import 'package:mapata/src/presentation/blocs/home/HomeEvent.dart';
import 'package:mapata/src/presentation/views/MainView.dart';
import 'package:mapata/src/presentation/widgets/CustomButton.dart';
import 'package:mapata/src/presentation/widgets/ItemLegend.dart';

import '../../data/util/MapsStyling.dart';
import '../widgets/AppBarWidget.dart';

import '../../data/util/Constants.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GoogleMapController mapController;

  final Completer<GoogleMapController> _mapController = Completer();

  late StreamSubscription locationSubscription;

  LatLng _myLocation = const LatLng(-34.9191509, -57.9710679);

  var isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
                  _setMapStyle(controller);
                },
                zoomControlsEnabled: false,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(8),
              child: CustomButton(
                      (){
                        setState(() {
                          isVisible = !isVisible;
                        });
                        },
                  Icons.camera_alt,
                  "Reportar mascota"),
            ),
            Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.topRight,
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: Colors.black12),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(child: Text("Leyenda", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                      AnimatedSwitcher(
                          duration: Duration(milliseconds: 100),
                        child: isVisible ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          key: Key("isVisible"),
                          children: [
                            Container(height: 1, color: Colors.black12, width: 100,),
                            ItemLegend("Animales perdidos", Colors.redAccent),
                            ItemLegend("Animales en transito", Colors.yellowAccent),
                            ItemLegend("Refugios", Colors.greenAccent),
                          ],
                        ) : Column(),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ]
        );
      }
      return Center(
        child: Text("Algo inesperado ha ocurrido"),
      );
    });
  }

  void _setMapStyle(GoogleMapController controller) {
    controller.setMapStyle(kMapsStyleConfig);
  }
}

import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapata/src/data/datasource/remote/MarkersDatabase.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeState.dart';
import 'package:mapata/src/presentation/blocs/home/HomeEvent.dart';
import 'package:mapata/src/presentation/navigation/PostViewArguments.dart';
import 'package:mapata/src/presentation/widgets/CustomButton.dart';
import 'package:mapata/src/presentation/widgets/ItemLegend.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/util/MapsStyling.dart';

import '../../data/util/Constants.dart';
import '../blocs/createPost/CreatePostBloc.dart';
import '../blocs/createPost/CreatePostEvent.dart';
import '../blocs/viewPost/PostBloc.dart';
import '../blocs/viewPost/PostEvent.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GoogleMapController mapController;

  final Completer<GoogleMapController> _mapController = Completer();

  late StreamSubscription locationSubscription;

  LatLng _myLocation = const LatLng(-34.9187523, -57.9599422);

  var isVisible = true;

  var markerCounter = 0;

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _updateMarker(AnimalMarker animalMarker) async {
    markers.remove(animalMarker);
    if (mounted) {
      setState(() {
        markers;
      });
    }
    Uint8List markerbitmap = await getBytesFromAsset(animalMarker.imageUrl, 100);
    markers.add(Marker(
      //add start location marker
        markerId: MarkerId(animalMarker.id),
        position: LatLng(animalMarker.lat, animalMarker.lng),
        infoWindow: InfoWindow(
          title: animalMarker.title,
          snippet: animalMarker.description,
          onTap: () {
            context.read<PostBloc>().add(RenderPost(animalMarker.postId));
            Navigator.pushNamed(context, kRouteViewPost,
                arguments: PostViewArguments(animalMarker, animalMarker.postId, null));
          },
        ),
        icon: BitmapDescriptor.fromBytes(markerbitmap)));
    if (mounted) {
      setState(() {
        markers;
      });
    }
  }

  _removeMarker(AnimalMarker animalMarker) async {
    markers;
    animalMarker.id;
    markers.removeWhere((element) => element.infoWindow.title == animalMarker.title);
    if (mounted) {
      setState(() {
        markers;
      });
    }
    print("Contadoooor: ${markers.length}");
  }

  _drawMarkers(List<AnimalMarker> animalMarkerList) async {
    animalMarkerList.forEach((animalMarker) async {
      Uint8List markerbitmap = await getBytesFromAsset(animalMarker.imageUrl, 100);
      markers.add(Marker(
          //add start location marker
          markerId: MarkerId(animalMarker.id),
          position: LatLng(animalMarker.lat, animalMarker.lng),
          infoWindow: InfoWindow(
            title: animalMarker.title,
            snippet: animalMarker.description,
            onTap: () {
              context.read<PostBloc>().add(RenderPost(animalMarker.postId));
              Navigator.pushNamed(context, kRouteViewPost,
                  arguments: PostViewArguments(animalMarker, animalMarker.postId, null));
            },
          ),
          icon: BitmapDescriptor.fromBytes(markerbitmap)));
    });
    if (mounted) {
      setState(() {
        markers;
      });
    }
  }

  Widget _buildBody() {
    final locale = AppLocalizations.of(context)!;
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: ((previous, current) {
        if (previous is HomeDone && current is HomeDone) {
          return previous.homeUiModel.animalMarkerList != current.homeUiModel.animalMarkerList;
        } else {
          return previous.toString() != current.toString();
        }
      }),
      listener: (_, state) {
        if (state is HomeDone) {
          _drawMarkers(state.homeUiModel.animalMarkerList);
          if (state.streamController != null) {
            state.streamController!.stream.listen((event) {
              final changeEvent = (event as AnimalMarkerChangeEvent);
              if(changeEvent.event == 1) {
                _removeMarker(changeEvent.animalMarker);
              } else {
                _updateMarker(changeEvent.animalMarker);
              }
            });
          }
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
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
          _determinePosition();
          _.read<HomeBloc>().add(LoadMarkers());
          if (state.homeUiModel.currentLocation != null) {
            _myLocation = LatLng(state.homeUiModel.currentLocation!.latitude,
                state.homeUiModel.currentLocation!.longitude);
          }
          return Stack(children: [
            SizedBox(
              height: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: _myLocation,
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                  _setMapStyle(controller);
                },
                zoomControlsEnabled: false,
                markers: markers.toSet(),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(12),
              child: CustomButton(() {
                context.read<CreatePostBloc>().add(RenderCreatePost());
                Navigator.pushNamed(context, kRouteCreatePost,
                    arguments: PostViewArguments(null, null, null));
              }, Icons.camera_alt, locale.homeview_report_pet),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.topLeft,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.black45),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                            child: Text(
                          locale.homeview_legend,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 100),
                          child: isVisible
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  key: Key(isVisible.toString()),
                                  children: [
                                    Container(
                                      height: 1,
                                      color: Colors.black12,
                                      width: 100,
                                    ),
                                    ItemLegend(locale.homeview_lost_pet, Colors.redAccent),
                                    ItemLegend(locale.homeview_transito_pet, Colors.yellowAccent),
                                    ItemLegend(locale.homeview_shelters, Colors.greenAccent),
                                  ],
                                )
                              : Column(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]);
        }
        return Center(
          child: Text(locale.global_generic_error),
        );
      }),
    );
  }

  void _setMapStyle(GoogleMapController controller) {
    controller.setMapStyle(kMapsStyleConfig);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    _myLocation = LatLng(position.latitude, position.longitude);
    if (mounted) {
      setState(() {
        _myLocation;
      });
    }
    return position;
  }
}

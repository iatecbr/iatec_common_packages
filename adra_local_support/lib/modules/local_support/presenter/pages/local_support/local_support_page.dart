import 'dart:async';

import 'package:adra_design_system/adra_design_system.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iatec_localization/iatec_localization.dart';
import '../../widgets/list_support_bottom.dart';
import '../../widgets/selected_local_widget.dart';
import 'local_support_controller.dart';

class LocalSupportPage extends StatefulWidget {
  final LocationData myPosition;

  const LocalSupportPage({Key key, this.myPosition}) : super(key: key);

  @override
  _LocalSupportPageState createState() => _LocalSupportPageState();
}

class _LocalSupportPageState extends ModularState<LocalSupportPage, LocalSupportController> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMapsWithLocalSupportsWidget(
          googleMapsController: _controller,
          controller: controller,
          myPosition: widget.myPosition,
        ),
        Observer(
          builder: (context) {
            if (controller.mapStates != MapStates.fill && controller.selectedLocalSupport != null) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SelectedLocalWidget(
                  localSupport: controller.selectedLocalSupport,
                  close: () {
                    controller.changeSelectedLocalSuport(null);
                  },
                ),
              );
            }

            if (controller.mapStates == MapStates.showLocalNationalSupport && controller.selectedLocalSupport == null) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ListSupportBottom(
                  localSupports: controller.localSupports,
                  nationalSupport: controller.nationalSupport,
                  height: MediaQuery.of(context).size.height * .3,
                  navigateToLocalSupport: (
                    LocalSupport _localSupport,
                  ) async {
                    if (controller.mapsController != null) {
                      controller.mapsController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(_localSupport.latitude, _localSupport.longitude),
                            zoom: 19.151926040649414,
                          ),
                        ),
                      );

                      controller.changeSelectedLocalSuport(_localSupport);
                    }
                  },
                ),
              );
            }

            return Container();
          },
        ),
        Observer(
          builder: (context) {
            if (controller.mapStates != MapStates.fill) {
              return Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: AppBarCustom(
                  title: 'localSupportPage.localSupport'.i18n(),
                  leading: () {
                    Modular.to.pop();
                  },
                ),
              );
            }

            return Container();
          },
        )
      ],
    );
  }
}

class GoogleMapsWithLocalSupportsWidget extends StatefulWidget {
  final LocalSupportController controller;
  final LocationData myPosition;
  final Completer<GoogleMapController> googleMapsController;
  const GoogleMapsWithLocalSupportsWidget({
    Key key,
    @required this.googleMapsController,
    @required this.controller,
    this.myPosition,
  }) : super(key: key);

  @override
  _GoogleMapsWithLocalSupportsWidgetState createState() => _GoogleMapsWithLocalSupportsWidgetState();
}

class _GoogleMapsWithLocalSupportsWidgetState extends State<GoogleMapsWithLocalSupportsWidget> {
  BitmapDescriptor _markerIcon;

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size.square(48));
      var result = await BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/pin/pin_map.png');
      setState(() {
        _markerIcon = result;
      });
    }
  }

  Set<Marker> _createMarkers(BuildContext context, LocationData myLocation) {
    return widget.controller.localSupports.map((localSupport) {
      return Marker(
        markerId: MarkerId(localSupport.name),
        position: LatLng(localSupport.latitude, localSupport.longitude),
        onTap: () {
          widget.controller.changeSelectedLocalSuport(localSupport);
        },
        icon: _markerIcon,
      );
    }).toSet()
      ..add(Marker(
        markerId: MarkerId('localSupportPage.myLocation'),
        position: LatLng(myLocation.latitude, myLocation.longitude),
      ));
  }

  Future<LocationData> getPosition() async {
    var location = widget.myPosition;
    if (location == null) {
      Location locationService = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          AdraSnackbar.error('Sem permissao para acessar o Location Service');
        }
      }

      _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          AdraSnackbar.error('Sem permissao para acessar o Localizacao');
        }
      }

      location = await locationService.getLocation();
    }

    await widget.controller.getAllSupports(location.latitude, location.longitude);

    return location;
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return FutureBuilder<LocationData>(
        future: getPosition(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              Observer(
                builder: (context) {
                  if (widget.controller.localSupports == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        snapshot.data.latitude,
                        snapshot.data.longitude,
                      ),
                      zoom: 14.4746,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController _controller) {
                      if (widget.googleMapsController.isCompleted) {
                        widget.googleMapsController.complete(_controller);
                      }
                      widget.controller.setGoogleController(_controller);
                    },
                    zoomControlsEnabled: false,
                    markers: _createMarkers(context, snapshot.data),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return Positioned(
                    right: 20,
                    top: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.controller.mapStates != MapStates.fill)
                          FloatingActionWidget(
                              action: () {
                                widget.controller.changeMapState(MapStates.fill);
                              },
                              icon: Icons.fullscreen),
                        if (widget.controller.mapStates == MapStates.fill)
                          FloatingActionWidget(
                            action: () {
                              widget.controller.changeMapState(MapStates.showLocalNationalSupport);
                            },
                            icon: Icons.fullscreen_exit_outlined,
                          ),
                        const SizedBox(height: 10),
                        FloatingActionWidget(
                          action: () async {
                            var result = await Modular.to.pushNamed("/local_support/filter");
                            widget.controller.setCategories(result);
                          },
                          icon: Icons.filter_alt,
                        ),
                        const SizedBox(height: 10),
                        FloatingActionWidget(
                          action: () {
                            widget.controller.mapsController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(snapshot.data.latitude, snapshot.data.longitude),
                                  zoom: 19.151926040649414,
                                ),
                              ),
                            );
                            widget.controller.changeSelectedLocalSuport(null);
                          },
                          icon: Icons.person,
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        });
  }
}

class FloatingActionWidget extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;

  const FloatingActionWidget({
    Key key,
    this.action,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 6,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:map_picker/map_picker.dart';
// import 'package:upwork_app/constants.dart';

// import '../current_location.dart';

// class MapPickerPage extends StatefulWidget {
//   static const roudName = "/MapPickerPage";

//   const MapPickerPage({Key? key}) : super(key: key);

//   @override
//   _MapPickerPageState createState() => _MapPickerPageState();
// }

// class _MapPickerPageState extends State<MapPickerPage> {
//   final _controller = Completer<GoogleMapController>();
//   Position? position;
//   bool showData = false;
//   MapPickerController mapPickerController = MapPickerController();
//   CameraPosition cameraPosition = const CameraPosition(
//     target: LatLng(24.6604525, 46.6801928),
//     zoom: 25.4746,
//   );
//   var textController = TextEditingController();
//   getCurretnLocation() async {
//     position = await CurrentLocation.fetch();
//     setState(() {
//       showData = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: showData
//           ? Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 MapPicker(
//                   iconWidget: SvgPicture.asset(
//                     "assets/icons/location_icon.svg",
//                     height: 60,
//                     color: kPrimaryColor,
//                   ),
//                   //add map picker controller
//                   mapPickerController: mapPickerController,
//                   child: GoogleMap(
//                     myLocationEnabled: true,
//                     zoomControlsEnabled: false,
//                     // hide location button
//                     myLocationButtonEnabled: false,
//                     mapType: MapType.normal,
//                     //  camera position
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(position!.latitude, position!.longitude),
//                       zoom: 11,
//                     ),
//                     onMapCreated: (GoogleMapController controller) {
//                       _controller.complete(controller);
//                     },
//                     onCameraMoveStarted: () {
//                       // notify map is moving
//                       mapPickerController.mapMoving!();
//                       // textController.text = '';
//                     },
//                     onCameraMove: (cameraPosition) {
//                       this.cameraPosition = cameraPosition;
//                     },
//                     onCameraIdle: () async {
//                       // notify map stopped moving
//                       mapPickerController.mapFinishedMoving!();
//                       //get address name from camera position
//                       List<Placemark> placeMarks =
//                           await placemarkFromCoordinates(
//                         cameraPosition.target.latitude,
//                         cameraPosition.target.longitude,
//                       );
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   left: 20,
//                   right: 20,
//                   child: ElevatedButton(
//                     child: Text("Submit"),
//                     onPressed: () async {
//                       List<Placemark> placeMarks =
//                           await placemarkFromCoordinates(
//                         cameraPosition.target.latitude,
//                         cameraPosition.target.longitude,
//                       );
//                     },
//                   ),
//                 )
//               ],
//             )
//           : Text("loding..."),
//     );
//   }
// }

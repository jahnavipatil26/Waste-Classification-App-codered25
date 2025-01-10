import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_demo/consts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

const String googleMapsApiKey = "<api-key>";
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(13.135577744666424, 77.56929524409935);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng _currentLocation = LatLng(0, 0);

  // LatLng? _currentLocation;
  // Map<String, BitmapDescriptor> customIcons = {};
  // List<List<Map<String, dynamic>>> collectionCenters = [];

  Map<PolylineId, Polyline> polylines = {};

// void _addMarkers() {
  List<List<Map<String, dynamic>>> collectionCenters = [
  // Batteries
  [
    {"location": LatLng(13.135577744666424, 77.56929524409935), "name": "Dhanalakshmi Batteries"},
    {"location": LatLng(13.129840651236446, 77.5718329377759), "name": "Sri Manjunath Scrap and Old Paper Mart"},
    {"location": LatLng(13.13286604488612, 77.57215948195521), "name": "Hindustan battery house"},
  ],
  // Clothes
  [
    {"location": LatLng(12.86210651880126, 77.58936489544274), "name": "Textile Recovery Facility - Saahas Zero Waste"},
    {"location": LatLng(13.0348355923084, 77.58915868195342), "name": "Shivashakthi Mahila Sangha"},
    {"location": LatLng(12.943951691579972, 77.47652001173782), "name": "Aaraike Charitable Trust"},
  ],
  // Ewaste
  [
    {"location": LatLng(13.032649146923923, 77.5987628377741), "name": "Bangalore Ewaste Recyle center(scrap pickup)"},
    {"location": LatLng(13.008624471038873, 77.49831801174577), "name": "Escrappy Recyclers E waste"},
    {"location": LatLng(12.946804533718263, 77.59605378010087), "name": "Ewaste Hub"},
  ],
  // organic
  [
    {"location": LatLng(13.07696486322476, 77.52979851965634), "name": "RITEWAYS ENVIRO PVT LTD"},
    {"location": LatLng(13.027144061718648, 77.5383569107891), "name": "Bhuyantra Waste Management Pvt. Ltd"},
    {"location": LatLng(12.884883861198151, 77.55034608195074), "name": "Soil & Health Solutions"},
  ],
  // paper
  [
    {"location": LatLng(13.10958495503249, 77.57613903055068), "name": "Sri Lakshmi Narasimha Old paper mart"},
    {"location": LatLng(13.146140825691715, 77.56805340143683), "name": "Sri Manjunath Scrap and Old Paper Mart"},
    {"location": LatLng(13.010989926982989, 77.54312471698192), "name": "Sri ganesha old paper and e -waste mart"},
  ],
  // plastic
  [
    {"location": LatLng(13.084934945179105, 77.56130100893922), "name": "Swachha Eco Solutions Private Limited"},
    {"location": LatLng(13.10958495503249, 77.57613903055068), "name": "Sri Lakshmi Narasimha Old paper mart"},
    {"location": LatLng(13.08485134302656, 77.5614082972977), "name": "Swachha Eco Solutions Private Limited"},
  ],
];




  List<LatLng> selectedCenters = [];
  LatLng? _currentP = null;

  @override
  void initState(){
    super.initState();
    // _loadCustomIcons();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
          generatePolyLineFromPoints(coordinates),
        }),
      },
    );
    
  }
  

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: _currentP == null? const Center(child: Text("Loading..."),) : GoogleMap(
  //       onMapCreated: ((GoogleMapController controller) => _mapController.complete(controller)),
  //       initialCameraPosition: CameraPosition(
  //         target: _pGooglePlex, 
  //         zoom: 13,
  //       ),
  //       markers: {
  //         Marker(
  //             markerId: MarkerId("_currentLocation"), 
  //             icon: BitmapDescriptor.defaultMarker, 
  //             position: _currentP!,
  //           ),
  //         Marker(
  //             markerId: MarkerId("_sourceLocation"), 
  //             icon: BitmapDescriptor.defaultMarker, 
  //             position: _pGooglePlex
  //           ),
  //           Marker(
  //             markerId: MarkerId("_trialLocation"), 
  //             icon: BitmapDescriptor.defaultMarker, 
  //             position: _pGooglePlex
  //           ),
  //         Marker(
  //             markerId: MarkerId("_destinationLocation"), 
  //             icon: BitmapDescriptor.defaultMarker, 
  //             position: _pApplePark
  //           )
  //       },
  //       polylines: Set<Polyline>.of(polylines.values),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
  return Scaffold(
    body: _currentP == null
        ? const Center(
            child: Text("Loading..."),
          )
        : GoogleMap(
            onMapCreated: (GoogleMapController controller) =>
                _mapController.complete(controller),
            initialCameraPosition: CameraPosition(
              target: _pGooglePlex,
              zoom: 13,
            ),
            markers: _generateMarkers(),
            polylines: Set<Polyline>.of(polylines.values),
          ),
  );
}

// Method to generate markers dynamically
// Set<Marker> _generateMarkers() {
//   Set<Marker> markers = {
//     // Add a marker for the current location
//     Marker(
//       markerId: const MarkerId("_currentLocation"),
//       icon: BitmapDescriptor.defaultMarker,
//       position: _currentP!,
//     ),
//   };



//   Set<Marker> _generateMarkers() {
//   Set<Marker> markers = {
//     // Add a marker for the current location
//     Marker(
//       markerId: const MarkerId("_currentLocation"),
//       icon: BitmapDescriptor.defaultMarker,
//       position: _currentP!,
//       infoWindow: const InfoWindow(
//         title: "Current Location",
//       ),
//     ),
//   };

//   // Add markers for each location in the collectionCenters list
//   for (int i = 0; i < collectionCenters.length; i++) {
//     for (int j = 0; j < collectionCenters[i].length; j++) {
//       markers.add(
//         Marker(
//           markerId: MarkerId("category_${i}_location_$j"),
//           position: collectionCenters[i][j],
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//             _getMarkerColor(i), // Assign color based on category
//           ),
//           infoWindow: InfoWindow(
//             title: "Category ${i + 1} - Location ${j + 1}",
//           ),
//         ),
//       );
//     }
//   }
//   return markers;
// }




Set<Marker> _generateMarkers() {
  Set<Marker> markers = {
    // Add a marker for the current location
    Marker(
      markerId: const MarkerId("_currentLocation"),
      icon: BitmapDescriptor.defaultMarker,
      position: _currentP!,
      infoWindow: const InfoWindow(
        title: "Current Location",
      ),
    ),
  };

  // Add markers for each location in the collectionCenters list
  for (int i = 0; i < collectionCenters.length; i++) {
    for (int j = 0; j < collectionCenters[i].length; j++) {
      Map<String, dynamic> center = collectionCenters[i][j];
      markers.add(
        Marker(
          markerId: MarkerId("category_${i}_location_$j"),
          position: center["location"],
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _getMarkerColor(i), // Assign color based on category
          ),
          infoWindow: InfoWindow(
            title: center["name"], // Name of the center
            snippet: "Category ${i + 1} - Location ${j + 1}", // Optional additional info
          ),
        ),
      );
    }
  }
  return markers;
}




  // for (int i = 0; i < collectionCenters.length; i++) {
  //   for (int j = 0; j < collectionCenters[i].length; j++) {
  //     Map<String, dynamic> center = collectionCenters[i][j];
  //     markers.add(
  //       Marker(
  //         markerId: MarkerId("category_${i}_location_$j"),
  //         position: center["location"],
  //         icon: BitmapDescriptor.defaultMarkerWithHue(
  //           _getMarkerColor(i), // Assign color based on category
  //         ),
  //         infoWindow: InfoWindow(
  //           title: center["name"], // Name of the center
  //           snippet: "Category ${i + 1} - Location ${j + 1}", // Optional additional info
  //         ),
  //       ),
  //     );
  //   }
  // }
  

// Define a unique color for each category
double _getMarkerColor(int categoryIndex) {
  List<double> colors = [
    BitmapDescriptor.hueBlue,   // Batteries
    BitmapDescriptor.hueGreen, // Clothes
    BitmapDescriptor.hueOrange, // Dustbins
    BitmapDescriptor.hueRed,    // E-waste
    BitmapDescriptor.hueCyan, // Dustbins
    BitmapDescriptor.hueViolet,
  ];
  return colors[categoryIndex % colors.length];
}


  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13,); 
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition),);
  }

  Future<void> getLocationUpdates() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();

    if(_serviceEnabled){
      _serviceEnabled = await _locationController.requestService();
    } else{
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await _locationController.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation){
      if(currentLocation.latitude != null && currentLocation.longitude != null){
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
    
  }

  Future<List<LatLng>> getPolylinePoints() async{
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleMapsApiKey,
        request: PolylineRequest(
        origin: PointLatLng(_pGooglePlex.latitude,_pGooglePlex.longitude),
        destination: PointLatLng(_pApplePark.latitude,_pApplePark.longitude),
        mode: TravelMode.driving,
        ),
    );
    
    
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else{
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8);

    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    final userLocation = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
    });
  }
  
  double _calculateDistance(LatLng start, LatLng end) {
    const earthRadius = 6371; // Radius in kilometers
    final latDiff = (end.latitude - start.latitude) * pi / 180;
    final lngDiff = (end.longitude - start.longitude) * pi / 180;

    final a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(start.latitude * pi / 180) *
            cos(end.latitude * pi / 180) *
            sin(lngDiff / 2) *
            sin(lngDiff / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }
  LatLng _getNearestCenter(List<LatLng> centers) {
    double minDistance = double.infinity;
    LatLng nearestCenter = centers.first;

    for (var center in centers) {
      final distance = _calculateDistance(_currentLocation, center);
      if (distance < minDistance) {
        minDistance = distance;
        nearestCenter = center;
      }
    }
    return nearestCenter;
  }
  // void _showCategory(int categoryIndex) {
  //   final centers = collectionCenters[categoryIndex];
  //   final nearestCenter = _getNearestCenter(centers);
  //   setState(() {
  //     selectedCenters = centers;
  //   });

  //   _mapController.animateCamera(
  //     CameraUpdate.newLatLngZoom(nearestCenter, 12),
  //   );
  // }
}

extension on Completer<GoogleMapController> {
  void animateCamera(CameraUpdate newLatLngZoom) {}
}





















































// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';
// const String googleMapsApiKey = "AIzaSyBHLoJ_BT_xEKK4_EBq2fu7WEVz4qNtC3Y";

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Location _locationController = Location();
//   final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

//   // static const LatLng _pGooglePlex = LatLng(13.135577744666424, 77.56929524409935);
//   // static const LatLng _pApplePark = LatLng(37.3346, -122.0090);

//   LatLng? _currentLocation;
//   LatLng? _nearestCenter;

//   Map<String, BitmapDescriptor> customIcons = {};
//   List<List<Map<String, dynamic>>> collectionCenters = [];

//   Map<PolylineId, Polyline> polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadCustomIcons().then((_) {
//       _initializeCollectionCenters();
//       getLocationUpdates();
//       // getPolylinePoints().then((coordinates) => generatePolyLineFromPoints(coordinates));
//     });
//   }

//   Future<void> _loadCustomIcons() async {
//     customIcons = {
//       "battery": await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(60, 60)),
//         'assets/battery.png',
//       ),
//       "clothes": await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(60, 60)),
//         'assets/cloths.jpg',
//       ),
//       "ewaste": await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(60, 60)),
//         'assets/ewaste.jpg',
//       ),
//       "organic": await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(60,60)),
//         'assets/organic.jpg',
//       ),
//       "paper": await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(60,60)),
//         'assets/paper.jpg',
//       ),
//       "plastic": await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(60,60)),
//         'assets/plastic.png',
//       ),
//     };
//     setState(() {});
//   }

//   void _initializeCollectionCenters() {
//     collectionCenters = [
//       // Batteries
//       [
//         {"location": LatLng(13.135577744666424, 77.56929524409935), "name": "Dhanalakshmi Batteries", "icon": customIcons["battery"]},
//         {"location": LatLng(13.129840651236446, 77.5718329377759), "name": "Sri Manjunath Scrap and Old Paper Mart", "icon": customIcons["battery"]},
//         {"location": LatLng(13.13286604488612, 77.57215948195521), "name": "Hindustan battery house", "icon": customIcons["battery"]},
//       ],
//       // Clothes
//       [
//         {"location": LatLng(12.86210651880126, 77.58936489544274), "name": "Textile Recovery Facility - Saahas Zero Waste", "icon": customIcons["clothes"]},
//         {"location": LatLng(13.0348355923084, 77.58915868195342), "name": "Shivashakthi Mahila Sangha", "icon": customIcons["clothes"]},
//         {"location": LatLng(12.943951691579972, 77.47652001173782), "name": "Aaraike Charitable Trust", "icon": customIcons["clothes"]},
//       ],
//       // Ewaste
//       [
//         {"location": LatLng(13.032649146923923, 77.5987628377741), "name": "Bangalore Ewaste Recycle Center", "icon": customIcons["ewaste"]},
//         {"location": LatLng(13.008624471038873, 77.49831801174577), "name": "Escrappy Recyclers E waste", "icon": customIcons["ewaste"]},
//         {"location": LatLng(12.946804533718263, 77.59605378010087), "name": "Ewaste Hub", "icon": customIcons["ewaste"]},
//       ],
//       // Organic
//       [
//         {"location": LatLng(13.07696486322476, 77.52979851965634), "name": "RITEWAYS ENVIRO PVT LTD", "icon": customIcons["organic"]},
//         {"location": LatLng(13.027144061718648, 77.5383569107891), "name": "Bhuyantra Waste Management Pvt. Ltd", "icon": customIcons["organic"]},
//         {"location": LatLng(12.884883861198151, 77.55034608195074), "name": "Soil & Health Solutions", "icon": customIcons["organic"]},
//       ],
//       // Paper
//       [
//         {"location": LatLng(13.10958495503249, 77.57613903055068), "name": "Sri Lakshmi Narasimha Old paper mart", "icon": customIcons["paper"]},
//         {"location": LatLng(13.146140825691715, 77.56805340143683), "name": "Sri Manjunath Scrap and Old Paper Mart", "icon": customIcons["paper"]},
//         {"location": LatLng(13.010989926982989, 77.54312471698192), "name": "Sri Ganesha Old Paper and E-waste Mart", "icon": customIcons["paper"]},
//       ],
//       // Plastic
//       [
//         {"location": LatLng(13.084934945179105, 77.56130100893922), "name": "Swachha Eco Solutions Private Limited", "icon": customIcons["plastic"]},
//         {"location": LatLng(13.10958495503249, 77.57613903055068), "name": "Sri Lakshmi Narasimha Old paper mart", "icon": customIcons["plastic"]},
//         {"location": LatLng(13.08485134302656, 77.5614082972977), "name": "Swachha Eco Solutions Private Limited", "icon": customIcons["plastic"]},
//       ],
//     ];
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentLocation == null
//           ? const Center(child: Text("Loading..."))
//           : GoogleMap(
//               onMapCreated: (GoogleMapController controller) => _mapController.complete(controller),
//               initialCameraPosition: CameraPosition(
//                 target: _currentLocation!,
//                 zoom: 13,
//               ),
//               markers: _generateMarkers(),
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Set<Marker> _generateMarkers() {
//     Set<Marker> markers = {
//       if (_currentLocation != null)
//         Marker(
//           markerId: const MarkerId("_currentLocation"),
//           icon: BitmapDescriptor.defaultMarker,
//           position: _currentLocation!,
//           infoWindow: const InfoWindow(title: "Current Location"),
//         ),
//     };

//     for (int i = 0; i < collectionCenters.length; i++) {
//       for (var center in collectionCenters[i]) {
//         markers.add(
//           Marker(
//             markerId: MarkerId("category_${i}_location_${center["name"]}"),
//             position: center["location"],
//             icon: center["icon"] ?? BitmapDescriptor.defaultMarker,
//             infoWindow: InfoWindow(
//               title: center["name"],
//               snippet: "Category ${i + 1}",
//             ),
//           ),
//         );
//       }
//     }
//     return markers;
//   }

//   Future<void> getLocationUpdates() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//       if (!_serviceEnabled) return;
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) return;
//     }

//     _locationController.onLocationChanged.listen((LocationData currentLocation) async {
//       if (currentLocation.latitude != null && currentLocation.longitude != null) {
//         LatLng userLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         LatLng nearestCenter = findNearestCenter(userLocation);
//         setState(() {
//           // _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           _currentLocation = userLocation;
//           _nearestCenter = nearestCenter;
//         });
//         if (_nearestCenter != null) {
//           List<LatLng> polylineCoordinates = await getPolylinePoints(_currentLocation!, _nearestCenter!);
//           generatePolyLineFromPoints(polylineCoordinates);
//         }
//       }
//     });
//   }

//   LatLng findNearestCenter(LatLng userLocation) {
//     double calculateDistance(LatLng point1, LatLng point2) {
//       const double R = 6371; // Radius of the Earth in km
//       double dLat = (point2.latitude - point1.latitude) * pi / 180.0;
//       double dLon = (point2.longitude - point1.longitude) * pi / 180.0;
//       double a = sin(dLat / 2) * sin(dLat / 2) +
//           cos(point1.latitude * pi / 180.0) * cos(point2.latitude * pi / 180.0) *
//               sin(dLon / 2) * sin(dLon / 2);
//       double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//       return R * c;
//     }

//     LatLng nearestCenter = collectionCenters[0][0]["location"];
//     double minDistance = double.infinity;

//     for (var category in collectionCenters) {
//       for (var center in category) {
//         double distance = calculateDistance(userLocation, center["location"]);
//         if (distance < minDistance) {
//           minDistance = distance;
//           nearestCenter = center["location"];
//         }
//       }
//     }
//     return nearestCenter;
//   }


//   // Future<List<LatLng>> getPolylinePoints() async {
//   //   List<LatLng> polylineCoordinates = [];
//   //   PolylinePoints polylinePoints = PolylinePoints();

//   //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//   //     googleApiKey: googleMapsApiKey,
//   //     request: PolylineRequest(
//   //       origin: PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
//   //       destination: PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
//   //       mode: TravelMode.driving,
//   //     ),
//   //   );
//   Future<List<LatLng>> getPolylinePoints(LatLng origin, LatLng destination) async {
//     List<LatLng> polylineCoordinates = [];
//     PolylinePoints polylinePoints = PolylinePoints();

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleApiKey: googleMapsApiKey,
//       request: PolylineRequest(
//         origin: PointLatLng(origin.latitude, origin.longitude),
//         destination: PointLatLng(destination.latitude, destination.longitude),
//         mode: TravelMode.driving,
//       ),
//     );
    

    

//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//       print("Successfully retrieved ${result.points.length} polyline points.");
//     } else {
//       print("Failed to retrieve polyline points: ${result.errorMessage}");
//     }
//     return polylineCoordinates;
//   }

//   void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) {
//     if (polylineCoordinates.isEmpty) {
//     print("Polyline coordinates are empty!");
//     return;
//     }
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.black,
//       points: polylineCoordinates,
//       width: 5,
//     );
          

//     setState(() {
//       polylines[id] = polyline;
//     });
//      print("Polyline added with ${polylineCoordinates.length} points.");
//   }

//   Future<void> moveCameraToPolyline(LatLng origin, LatLng destination) async {
//   final GoogleMapController controller = await _mapController.future;
//   LatLngBounds bounds = LatLngBounds(
//     southwest: LatLng(
//       min(origin.latitude, destination.latitude),
//       min(origin.longitude, destination.longitude),
//     ),
//     northeast: LatLng(
//       max(origin.latitude, destination.latitude),
//       max(origin.longitude, destination.longitude),
//     ),
//   );
//   controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
// }

// }

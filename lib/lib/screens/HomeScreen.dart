// import 'dart:io';
// import 'package:deep_waste/components/alert.dart';
// import 'package:deep_waste/components/categories.dart';
// import 'package:deep_waste/components/display_picture.dart';
// import 'package:deep_waste/components/history.dart';
// import 'package:deep_waste/components/home_header.dart';
// import 'package:deep_waste/components/progress.dart';
// import 'package:deep_waste/constants/app_properties.dart';
// import 'package:deep_waste/constants/size_config.dart';
// import 'package:deep_waste/database_manager.dart';
// import 'package:deep_waste/models/Item.dart';
// import 'package:deep_waste/models/User.dart';
// import 'package:deep_waste/screens/UserScreen.dart';
// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:deep_waste/waste_classifier.dart';
//
// class HomeScreen extends StatefulWidget {
//   static String routeName = "/home_screen";
//
//   HomeScreen({Key? key, this.title}) : super(key: key); // Updated for null safety
//   final String? title;  // Updated for null safety
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   File? _image;  // Make _image nullable
//   List<Item> items = [];
//   bool isLoading = false;
//   User? user;  // Make user nullable
//
//   ImagePicker imagePicker = ImagePicker();
//
//   // Fixing the image picking method for null safety
//   _imageFromCamera() async {
//     try {
//       final XFile? capturedImage = await imagePicker.pickImage(source: ImageSource.camera);  // Use pickImage
//       if (capturedImage == null) {
//         showAlert(
//             bContext: context,
//             title: "Error choosing file",
//             content: "No file was selected");
//       } else {
//         setState(() {
//           _image = File(capturedImage.path); // Update to handle XFile
//         });
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     DisplayPicture(image: _image!, items: items))); // Force unwrap as it's guaranteed to be non-null after check
//       }
//     } catch (e) {
//       showAlert(
//           bContext: context, title: "Error capturing image file", content: e.toString());
//     }
//   }
//
//   _imageFromGallery() async {
//     final XFile? uploadedImage = await imagePicker.pickImage(source: ImageSource.gallery); // Use pickImage
//     if (uploadedImage == null) {
//       showAlert(
//           bContext: context,
//           title: "Error choosing file",
//           content: "No file was selected");
//     } else {
//       setState(() {
//         _image = File(uploadedImage.path); // Update to handle XFile
//       });
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   DisplayPicture(image: _image!, items: items))); // Force unwrap as it's guaranteed to be non-null after check
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getItems();
//     getUserInfo();
//   }
//
//   Future getUserInfo() async {
//     setState(() => isLoading = true);
//     user = await DatabaseManager.instance.getUser();
//     setState(() => isLoading = false);
//   }
//
//   Future getItems() async {
//     setState(() => isLoading = true);
//     items = await DatabaseManager.instance.getItems();
//     setState(() => isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       backgroundColor: white,
//       floatingActionButton: FabCircularMenu(
//         ringDiameter: getProportionateScreenWidth(130.0),
//         ringColor: Color(0xff69c0dc),
//         ringWidth: getProportionateScreenWidth(40.0),
//         fabSize: getProportionateScreenWidth(44.0),
//         fabElevation: getProportionateScreenWidth(8.0),
//         fabCloseIcon: Icon(Icons.close),
//         fabOpenIcon: Icon(Icons.photo),
//         children: <Widget>[
//           IconButton(
//               icon: Icon(Icons.camera_alt_outlined),
//               onPressed: () async {
//                 if (user == null) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UserScreen()));
//                 } else {
//                   _imageFromCamera();
//                 }
//               }),
//           IconButton(
//               icon: Icon(Icons.folder),
//               onPressed: () async {
//                 if (user == null) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UserScreen()));
//                 } else {
//                   _imageFromGallery();
//                 }
//               })
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               HomeHeader(user: user),  // Safe to pass user as nullable
//               SizedBox(height: getProportionateScreenHeight(15)),
//               Categories(),
//               SizedBox(height: getProportionateScreenHeight(20)),
//               Progress(items: items),
//               SizedBox(height: getProportionateScreenHeight(20)),
//               History(),
//               SizedBox(width: getProportionateScreenWidth(20)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:deep_waste/components/alert.dart';
// import 'package:deep_waste/components/categories.dart';
// import 'package:deep_waste/components/display_picture.dart';
// import 'package:deep_waste/components/history.dart';
// import 'package:deep_waste/components/home_header.dart';
// import 'package:deep_waste/components/progress.dart';
// import 'package:deep_waste/constants/app_properties.dart';
// import 'package:deep_waste/constants/size_config.dart';
// import 'package:deep_waste/database_manager.dart';
// import 'package:deep_waste/models/Item.dart';
// import 'package:deep_waste/models/User.dart';
// import 'package:deep_waste/screens/UserScreen.dart';
// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:deep_waste/waste_classifier.dart'; // Import WasteClassifier
//
// class HomeScreen extends StatefulWidget {
//   static String routeName = "/home_screen";
//
//   HomeScreen({Key? key, this.title}) : super(key: key); // Updated for null safety
//   final String? title;  // Updated for null safety
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   File? _image;  // Make _image nullable
//   List<Item> items = [];
//   bool isLoading = false;
//   User? user;  // Make user nullable
//
//   ImagePicker imagePicker = ImagePicker();
//
//   // Fixing the image picking method for null safety
//   _imageFromCamera() async {
//     try {
//       final XFile? capturedImage = await imagePicker.pickImage(source: ImageSource.camera);  // Use pickImage
//       if (capturedImage == null) {
//         showAlert(
//             bContext: context,
//             title: "Error choosing file",
//             content: "No file was selected");
//       } else {
//         setState(() {
//           _image = File(capturedImage.path); // Update to handle XFile
//         });
//         if (_image != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     DisplayPicture(image: _image!, items: items)), // Safe to use _image! now
//           );
//         } else {
//           showAlert(
//             bContext: context,
//             title: "Error",
//             content: "No image captured. Please try again.",
//           );
//         }
//       }
//     } catch (e) {
//       showAlert(
//           bContext: context, title: "Error capturing image file", content: e.toString());
//     }
//   }
//
//   _imageFromGallery() async {
//     final XFile? uploadedImage = await imagePicker.pickImage(source: ImageSource.gallery); // Use pickImage
//     if (uploadedImage == null) {
//       showAlert(
//           bContext: context,
//           title: "Error choosing file",
//           content: "No file was selected");
//     } else {
//       setState(() {
//         _image = File(uploadedImage.path); // Update to handle XFile
//       });
//       if (_image != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   DisplayPicture(image: _image!, items: items)), // Safe to use _image! now
//         );
//       } else {
//         showAlert(
//           bContext: context,
//           title: "Error",
//           content: "No image selected. Please try again.",
//         );
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getItems();
//     getUserInfo();
//   }
//
//   Future getUserInfo() async {
//     setState(() => isLoading = true);
//     user = await DatabaseManager.instance.getUser();
//     setState(() => isLoading = false);
//   }
//
//   Future getItems() async {
//     setState(() => isLoading = true);
//     items = await DatabaseManager.instance.getItems();
//     setState(() => isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       backgroundColor: white,
//       floatingActionButton: FabCircularMenu(
//         ringDiameter: getProportionateScreenWidth(130.0),
//         ringColor: Color(0xff69c0dc),
//         ringWidth: getProportionateScreenWidth(40.0),
//         fabSize: getProportionateScreenWidth(44.0),
//         fabElevation: getProportionateScreenWidth(8.0),
//         fabCloseIcon: Icon(Icons.close),
//         fabOpenIcon: Icon(Icons.photo),
//         children: <Widget>[
//           IconButton(
//               icon: Icon(Icons.camera_alt_outlined),
//               onPressed: () async {
//                 if (user == null) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UserScreen()));
//                 } else {
//                   _imageFromCamera();
//                 }
//               }),
//           IconButton(
//               icon: Icon(Icons.folder),
//               onPressed: () async {
//                 if (user == null) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UserScreen()));
//                 } else {
//                   _imageFromGallery();
//                 }
//               })
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               HomeHeader(user: user ?? User.defaultUser()),  // Safe to pass user as nullable
//               SizedBox(height: getProportionateScreenHeight(15)),
//               Categories(),
//               SizedBox(height: getProportionateScreenHeight(20)),
//               Progress(items: items),
//               SizedBox(height: getProportionateScreenHeight(20)),
//               // Add the button to navigate to WasteClassifier
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => WasteClassifier()), // Navigate to WasteClassifier
//                   );
//                 },
//                 child: Text('Go to Waste Classifier'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff69c0dc), // Button color
//                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                   textStyle: TextStyle(fontSize: 16),
//                 ),
//               ),
//               SizedBox(width: getProportionateScreenWidth(20)),
//               History(),
//               SizedBox(width: getProportionateScreenWidth(20)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:deep_waste/components/alert.dart';
import 'package:deep_waste/components/categories.dart';
import 'package:deep_waste/components/display_picture.dart';
import 'package:deep_waste/components/history.dart';
import 'package:deep_waste/components/home_header.dart';
import 'package:deep_waste/components/progress.dart';
import 'package:deep_waste/constants/app_properties.dart';
import 'package:deep_waste/constants/size_config.dart';
import 'package:deep_waste/database_manager.dart';
import 'package:deep_waste/models/Item.dart';
import 'package:deep_waste/models/User.dart';
import 'package:deep_waste/screens/UserScreen.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:deep_waste/waste_classifier.dart'; // Import WasteClassifier

class HomeScreen extends StatefulWidget {
  static String routeName = "/home_screen";

  HomeScreen({Key? key, this.title}) : super(key: key); // Updated for null safety
  final String? title;  // Updated for null safety

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;  // Make _image nullable
  List<Item> items = [];
  bool isLoading = false;
  User? user;  // Make user nullable

  ImagePicker imagePicker = ImagePicker();

  // Fixing the image picking method for null safety
  _imageFromCamera() async {
    try {
      final XFile? capturedImage = await imagePicker.pickImage(source: ImageSource.camera);  // Use pickImage
      if (capturedImage == null) {
        showAlert(
            bContext: context,
            title: "Error choosing file",
            content: "No file was selected");
      } else {
        setState(() {
          _image = File(capturedImage.path); // Update to handle XFile
        });
        if (_image != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DisplayPicture(image: _image!, items: items)), // Safe to use _image! now
          );
        } else {
          showAlert(
            bContext: context,
            title: "Error",
            content: "No image captured. Please try again.",
          );
        }
      }
    } catch (e) {
      showAlert(
          bContext: context, title: "Error capturing image file", content: e.toString());
    }
  }

  _imageFromGallery() async {
    final XFile? uploadedImage = await imagePicker.pickImage(source: ImageSource.gallery); // Use pickImage
    if (uploadedImage == null) {
      showAlert(
          bContext: context,
          title: "Error choosing file",
          content: "No file was selected");
    } else {
      setState(() {
        _image = File(uploadedImage.path); // Update to handle XFile
      });
      if (_image != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DisplayPicture(image: _image!, items: items)), // Safe to use _image! now
        );
      } else {
        showAlert(
          bContext: context,
          title: "Error",
          content: "No image selected. Please try again.",
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getItems();
    getUserInfo();
  }

  Future getUserInfo() async {
    setState(() => isLoading = true);
    user = await DatabaseManager.instance.getUser();
    setState(() => isLoading = false);
  }

  Future getItems() async {
    setState(() => isLoading = true);
    items = await DatabaseManager.instance.getItems();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: white,
      // floatingActionButton: FabCircularMenu(
      //   ringDiameter: getProportionateScreenWidth(130.0),
      //   ringColor: Color(0xff69c0dc),
      //   ringWidth: getProportionateScreenWidth(40.0),
      //   fabSize: getProportionateScreenWidth(44.0),
      //   fabElevation: getProportionateScreenWidth(8.0),
      //   fabCloseIcon: Icon(Icons.close),
      //   fabOpenIcon: Icon(Icons.photo),
      //   children: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.camera_alt_outlined),
      //         onPressed: () async {
      //           if (user == null) {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => UserScreen()));
      //           } else {
      //             _imageFromCamera();
      //           }
      //         }),
      //     IconButton(
      //         icon: Icon(Icons.folder),
      //         onPressed: () async {
      //           if (user == null) {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => UserScreen()));
      //           } else {
      //             _imageFromGallery();
      //           }
      //         })
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(user: user ?? User.defaultUser()),  // Safe to pass user as nullable
              SizedBox(height: getProportionateScreenHeight(15)),
              Categories(),
              SizedBox(height: getProportionateScreenHeight(20)),
              Progress(items: items),
              SizedBox(height: getProportionateScreenHeight(20)),
              // Add the button to navigate to WasteClassifier
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WasteClassifier()), // Navigate to WasteClassifier
                  );
                },
                child: Text('Go to Waste Classifier'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF355E3B),foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              History(),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ),
    );
  }
}


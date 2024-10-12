// Flutter imports:
import "package:flutter/material.dart";

// Package imports:
import 'package:get/get.dart';

// ignore: unused_import
class THelperFunctions {
  static Color ? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } 
    else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Purple') {
      return Colors.purple;
    } 
    else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Cyan') {
      return Colors.cyan;
    } else if (value == 'Lime') {
      return Colors.lime;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else if (value == 'Teal') {
      return Colors.teal;
    }
  
  
  else if (value == 'Red') {
      return Colors.red;
    } 
    else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Purple') {
      return Colors.purple;
    } 
    else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Cyan') {
      return Colors.cyan;
    } else if (value == 'Lime') {
      return Colors.lime;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else if (value == 'Teal') {
      return Colors.teal;
    }
    else {
      return Colors.black; // Default color
    }
  }
  static void showAlert(String title, String message) {
   showDialog(context: Get.context!, builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
    
  }
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

}

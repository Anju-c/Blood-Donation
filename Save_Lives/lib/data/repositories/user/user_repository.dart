
import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bloodapp/features/personalization/models/user_models.dart';
import 'package:bloodapp/utilis/exceptions/firebase_exceptions.dart';
import 'package:bloodapp/utilis/exceptions/format_exceptions.dart';
import 'package:bloodapp/utilis/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  // Define your variables and methods here
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  

  // Example method to update userName
 Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
       throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message; 
    } catch (e) {
      throw 'Something went wrong.Please try again';
    }
  }

  

  
}
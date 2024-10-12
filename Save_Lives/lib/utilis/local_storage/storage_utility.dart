// Package imports:
import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();

  TLocalStorage._internal();

  factory TLocalStorage() {
    return _instance;
  }

  final _storage = GetStorage();

  // Save data to local storage
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Read data from local storage
   T? readData<T>(String key)  {
    return _storage.read<T>(key);
  }

  // Remove data from local storage
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }
  //clear all data from local storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}

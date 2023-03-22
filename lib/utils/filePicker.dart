import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

pickASingleFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    if (kDebugMode) {
      print(file.name);
      print(file.size);
      print(file.bytes);
      print(file.extension);
      print(file.path);
      print(file.identifier);
    }
  } else {
    if (kDebugMode) {
      print("Gowa Mara Kha");
    }
  }
}

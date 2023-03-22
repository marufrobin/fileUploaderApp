import 'package:dio/dio.dart';

class CustomHttp {
  final dio = Dio();
  String uploadUrl = "https://api.cloudinary.com/v1_1/djwjyopfv/image/upload";
  uploadFile(String filePath) async {
    final fromData = FormData.fromMap({
      "file": await MultipartFile.fromFile("$filePath", filename: '$filePath'),
      "upload_preset": "cndirnd5"
    });
    final responce = await dio.post(
      uploadUrl,
      data: fromData,
      onSendProgress: (int sent, int total) {
        print("Upload: ${sent}, Total: ${total}");
      },
    );
    print("Responce::::${responce}");
  }
}

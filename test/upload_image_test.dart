import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perguntando/src/shared/utils/constants.dart';

main() {
  test('Test upload de imagem', () async {
    final imageFile = File('test/upload_image_test.png');
    final _nameFile = imageFile.path.split('/').last;
    FormData _data = new FormData.from({
      'file': UploadFileInfo(imageFile, _nameFile),
    });
    final _dio = Dio();
    Response response = await _dio.post(
      '$API_URL/auth/v1/upload',
      data: _data,
    );
    print(response.data);
  });
}

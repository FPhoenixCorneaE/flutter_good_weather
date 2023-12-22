import 'package:flutter/services.dart';
import 'package:flutter_good_weather/util/toast_util.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void savaAssetImage(String imgPath, {String? name, int quality = 100}) async {
  ByteData bytes = await rootBundle.load(imgPath);
  Uint8List imageBytes = bytes.buffer.asUint8List();
  dynamic result = await ImageGallerySaver.saveImage(imageBytes, name: name, quality: quality);
  if ((result?["isSuccess"] as bool) == true) {
    showBottomToast("图片保存成功");
  } else {
    showBottomToast("图片保存失败");
  }
}

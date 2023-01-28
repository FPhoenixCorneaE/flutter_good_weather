/// 获取天气图标名称
String getWeatherIconName(int? code) {
  int iconNameSuffix;
  switch (code) {
    // 晴
    case 100:
      iconNameSuffix = 100;
      break;
    // 多云
    case 101:
      iconNameSuffix = 101;
      break;
    // 少云
    case 102:
      iconNameSuffix = 102;
      break;
    // 晴间多云
    case 103:
      iconNameSuffix = 103;
      break;
    // 阴 V7
    case 104:
      iconNameSuffix = 104;
      break;
    // 晴 晚上  V7
    case 150:
      iconNameSuffix = 150;
      break;
    // 晴间多云 晚上  V7
    case 151: // 新增
    case 152: // 新增
    case 153:
      iconNameSuffix = 153;
      break;
    // 阴 晚上  V7
    case 154:
      iconNameSuffix = 154;
      break;
    // 有风
    case 200:
    // 微风
    case 202:
    // 和风
    case 203:
    // 清风
    case 204:
      // 因为这几个状态的图标是一样的
      iconNameSuffix = 200;
      break;
    // 平静
    case 201:
      iconNameSuffix = 201;
      break;
    // 强风/劲风
    case 205:
    // 疾风
    case 206:
    // 大风
    case 207:
      // 因为这几个状态的图标是一样的
      iconNameSuffix = 205;
      break;
    // 烈风
    case 208:
    // 风暴
    case 209:
    // 狂爆风
    case 210:
    // 飓风
    case 211:
    // 龙卷风
    case 212:
    // 热带风暴
    case 213:
      // 因为这几个状态的图标是一样的
      iconNameSuffix = 208;
      break;
    // 阵雨
    case 300:
      iconNameSuffix = 300;
      break;
    // 强阵雨
    case 301:
      iconNameSuffix = 301;
      break;
    // 雷阵雨
    case 302:
      iconNameSuffix = 302;
      break;
    // 强雷阵雨
    case 303:
      iconNameSuffix = 303;
      break;
    // 雷阵雨伴有冰雹
    case 304:
      iconNameSuffix = 304;
      break;
    // 小雨
    case 305:
      iconNameSuffix = 305;
      break;
    // 中雨
    case 306:
      iconNameSuffix = 306;
      break;
    // 大雨
    case 307:
      iconNameSuffix = 307;
      break;
    // 极端降雨
    case 308:
      iconNameSuffix = 312;
      break;
    // 毛毛雨/细雨
    case 309:
      iconNameSuffix = 309;
      break;
    // 暴雨
    case 310:
      iconNameSuffix = 310;
      break;
    // 大暴雨
    case 311:
      iconNameSuffix = 311;
      break;
    // 特大暴雨
    case 312:
      iconNameSuffix = 312;
      break;
    // 冻雨
    case 313:
      iconNameSuffix = 313;
      break;
    // 小到中雨
    case 314:
      iconNameSuffix = 306;
      break;
    // 中到大雨
    case 315:
      iconNameSuffix = 307;
      break;
    // 大到暴雨
    case 316:
      iconNameSuffix = 310;
      break;
    // 大暴雨到特大暴雨
    case 317:
      iconNameSuffix = 312;
      break;
    // 雨
    case 399:
      iconNameSuffix = 399;
      break;
    // 小雪
    case 400:
      iconNameSuffix = 400;
      break;
    // 中雪
    case 401:
      iconNameSuffix = 401;
      break;
    // 大雪
    case 402:
      iconNameSuffix = 402;
      break;
    // 暴雪
    case 403:
      iconNameSuffix = 403;
      break;
    // 雨夹雪
    case 404:
      iconNameSuffix = 404;
      break;
    // 雨雪天气
    case 405:
      iconNameSuffix = 405;
      break;
    // 阵雨夹雪
    case 406:
      iconNameSuffix = 406;
      break;
    // 阵雪
    case 407:
      iconNameSuffix = 407;
      break;
    // 小到中雪
    case 408:
      iconNameSuffix = 408;
      break;
    // 中到大雪
    case 409:
      iconNameSuffix = 409;
      break;
    // 大到暴雪
    case 410:
      iconNameSuffix = 410;
      break;
    // 雪
    case 499:
      iconNameSuffix = 499;
      break;
    // 薄雾
    case 500:
      iconNameSuffix = 500;
      break;
    // 雾
    case 501:
      iconNameSuffix = 501;
      break;
    // 霾
    case 502:
      iconNameSuffix = 502;
      break;
    // 扬沙
    case 503:
      iconNameSuffix = 503;
      break;
    // 扬沙
    case 504:
      iconNameSuffix = 504;
      break;
    // 沙尘暴
    case 507:
      iconNameSuffix = 507;
      break;
    // 强沙尘暴
    case 508:
      iconNameSuffix = 508;
      break;
    // 浓雾
    case 509:
    // 强浓雾
    case 510:
    // 大雾
    case 514:
    // 特强浓雾
    case 515:
      iconNameSuffix = 509;
      break;
    // 中度霾
    case 511:
      iconNameSuffix = 511;
      break;
    // 重度霾
    case 512:
      iconNameSuffix = 512;
      break;
    // 严重霾
    case 513:
      iconNameSuffix = 513;
      break;
    // 热
    case 900:
      iconNameSuffix = 900;
      break;
    // 冷
    case 901:
      iconNameSuffix = 901;
      break;
    // 未知
    default:
      iconNameSuffix = 999;
      break;
  }
  return "ic_weather_$iconNameSuffix.png";
}

/// 获取风力等级
String getWindScale(int? scale) {
  String windScale;
  if (scale == null) {
    windScale = "无风";
    return windScale;
  }
  switch (scale) {
    case 0:
      windScale = "无风";
      break;
    case 1:
      windScale = "软风";
      break;
    case 2:
      windScale = "轻风";
      break;
    case 3:
      windScale = "微风";
      break;
    case 4:
      windScale = "和风";
      break;
    case 5:
      windScale = "清风";
      break;
    case 6:
      windScale = "强风";
      break;
    case 7:
      windScale = "疾风";
      break;
    case 8:
      windScale = "大风";
      break;
    case 9:
      windScale = "烈风";
      break;
    case 10:
      windScale = "狂风";
      break;
    case 11:
      windScale = "暴风";
      break;
    case 12:
      windScale = "飓风";
      break;
    case 13:
      windScale = "台风";
      break;
    case 14:
    case 15:
      windScale = "强台风";
      break;
    default:
      windScale = "超强台风";
  }
  return windScale;
}

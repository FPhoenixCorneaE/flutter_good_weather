/// 日期工具类
class DateUtil {
  /// 获取星期几
  static String getTodayOfWeek() {
    int weekday = DateTime.now().weekday;
    return [
      "",
      "星期一",
      "星期二",
      "星期三",
      "星期四",
      "星期五",
      "星期六",
      "星期日",
    ][weekday];
  }

  /// 早中晚时间段划分
  static String timeDivision(String? timeData) {
    String periods;
    if (timeData == null) {
      periods = "";
      return periods;
    }
    int hour = int.parse(timeData.trim().substring(0, 2));
    if (hour >= 0 && hour <= 6) {
      periods = "凌晨";
    } else if (hour > 6 && hour <= 12) {
      periods = "上午";
    } else if (hour == 13) {
      periods = "中午";
    } else if (hour > 13 && hour <= 18) {
      periods = "下午";
    } else if (hour > 18 && hour <= 24) {
      periods = "晚上";
    } else {
      periods = "未知";
    }
    return periods + timeData;
  }
}

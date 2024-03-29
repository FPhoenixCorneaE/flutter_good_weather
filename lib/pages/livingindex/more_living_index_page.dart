import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/living_index_bean.dart';
import 'package:flutter_good_weather/http/api/api.dart';
import 'package:flutter_good_weather/widget/wallpaper_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_grid/grouped_grid.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../constant/constant.dart';
import '../../util/screen_util.dart';
import '../../widget/interval_progress_bar.dart';
import '../../widget/title_bar.dart';

class MoreLivingIndexPage extends StatefulWidget {
  final String? location;
  final String? locationId;

  const MoreLivingIndexPage(this.location, this.locationId, {super.key});

  @override
  State<MoreLivingIndexPage> createState() => _MoreLivingIndexPageState();
}

class _MoreLivingIndexPageState extends State<MoreLivingIndexPage> {
  LivingIndexBean? livingIndexBean;

  @override
  void initState() {
    super.initState();
    Api.livingIndex(widget.locationId ?? "", days: "3d", callback: (data) {
      setState(() {
        livingIndexBean = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: TitleBar(
        "${widget.location}未来3天生活指数",
        backgroundColor: Colors.transparent,
        titleColor: Colors.white,
        leftImgName: "ic_back_black.svg",
        leftImgColor: Colors.white,
      ),
      body: Stack(children: <Widget>[
        const Positioned.fill(child: WallpaperImage()),
        Positioned.fill(
          left: 12.w,
          top: navigationBarHeight,
          right: 12.w,
          bottom: 20.h,
          child: GroupedGridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.w,
                mainAxisSpacing: 4.h,
                childAspectRatio: 2,
              ),
              groupKeys: livingIndexBean?.daily?.map((e) => e.date ?? "").toSet() ?? <dynamic>{},
              groupStickyHeaders: false,
              groupHeaderBuilder: (context, group) {
                return Padding(
                  padding: EdgeInsets.all(4.h),
                  child: Text(
                    group,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.bold),
                  ),
                );
              },
              itemBuilder: (context, group) {
                Daily? element =
                    livingIndexBean?.daily?.where((element) => element.date == group.key).toList()[group.itemIndex];
                return Card(
                  color: const Color(0x66000000),
                  elevation: 8.h,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            element?.name ?? "",
                            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Text("等级：", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                            Expanded(
                              child: IntervalProgressBar(
                                  direction: IntervalProgressDirection.horizontal,
                                  max: getLivingIndexMaxLevelByType(element?.type),
                                  progress: int.parse(element?.level ?? "1"),
                                  intervalSize: 2,
                                  size: Size(double.infinity, 8.h),
                                  highlightColor: Colors.blue,
                                  defaultColor: Colors.grey,
                                  intervalColor: Colors.transparent,
                                  intervalHighlightColor: Colors.transparent,
                                  reverse: false,
                                  radius: 0),
                            ),
                          ],
                        ),
                        Text("级别：${element?.category ?? ""}", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                        Expanded(
                          child: Text(
                            "建议：${element?.text ?? ""}",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCountForGroup: (key) => livingIndexBean?.daily?.where((element) => element.date == key).length ?? 0),
        )
      ]),
    );
  }

  /// 根据生活指数类型获取生活指数预报最大等级等级
  getLivingIndexMaxLevelByType(String? type) {
    int max = 3;
    switch (type) {
      case "1":
      case "4":
        max = 3;
        break;
      case "2":
      case "9":
      case "11":
        max = 4;
        break;
      case "3":
      case "8":
        max = 7;
        break;
      case "5":
      case "6":
      case "7":
      case "10":
      case "12":
      case "15":
      case "16":
        max = 5;
        break;
      case "13":
        max = 8;
        break;
      case "14":
        max = 6;
        break;
    }
    return max;
  }

  GroupedListView<Daily, String> buildGroupedListView() {
    return GroupedListView<Daily, String>(
      elements: livingIndexBean?.daily ?? [],
      groupBy: (element) => element.date ?? "",
      groupComparator: (value1, value2) => value1.compareTo(value2),
      order: GroupedListOrder.ASC,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (String value) => Padding(
        padding: EdgeInsets.all(4.h),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          color: const Color(0x66000000),
          elevation: 8.h,
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                Text(
                  element.name ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Text("建议：${element.text ?? ""}", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ],
            ),
          ),
        );
      },
    );
  }
}

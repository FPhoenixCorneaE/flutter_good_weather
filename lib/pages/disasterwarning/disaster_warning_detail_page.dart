import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/disaster_warning_bean.dart';
import 'package:flutter_good_weather/util/date_util.dart';
import 'package:flutter_good_weather/widget/title_bar.dart';
import 'package:flutter_good_weather/widget/wallpaper_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/constant.dart';

class DisasterWarningDetailPage extends StatefulWidget {
  final DisasterWarningBean? disasterWarningBean;

  const DisasterWarningDetailPage(this.disasterWarningBean, {super.key});

  @override
  State<DisasterWarningDetailPage> createState() => _DisasterWarningDetailPageState();
}

class _DisasterWarningDetailPageState extends State<DisasterWarningDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: const TitleBar(
        "灾害预警详情",
        backgroundColor: Colors.transparent,
        titleColor: Colors.white,
        leftImgName: "ic_back_black.svg",
        leftImgColor: Colors.white,
      ),
      body: Stack(children: <Widget>[
        const Positioned.fill(child: WallpaperImage()),
        Positioned.fill(
          top: 12.h,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0x66000000),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.disasterWarningBean?.warning?[index].sender ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "${widget.disasterWarningBean?.warning?[index].typeName ?? ""}${widget.disasterWarningBean?.warning?[index].level ?? ""}预警",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.disasterWarningBean?.warning?[index].text ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "预警发布时间：${divideTime(updateTime(widget.disasterWarningBean?.warning?[index].pubTime))}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8.h);
            },
            itemCount: widget.disasterWarningBean?.warning?.length ?? 0,
          ),
        ),
      ]),
    );
  }
}

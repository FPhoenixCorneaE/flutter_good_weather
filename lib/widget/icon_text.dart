import 'package:flutter/material.dart';

/// icon text
class IconText extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final double? iconSize;
  final Axis direction;

  /// icon padding
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool afterIcon;
  final GestureTapCallback? onTap;

  const IconText(
    this.text, {
    Key? key,
    this.icon,
    this.iconSize,
    this.direction = Axis.horizontal,
    this.style,
    this.maxLines,
    this.softWrap,
    this.padding,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.afterIcon = true,
    this.onTap,
  })  : assert(overflow != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style.merge(style);
    return InkWell(
      child: icon == null
          ? Text(text ?? '', style: textStyle)
          : text == null || text!.isEmpty
              ? (padding == null ? icon! : Padding(padding: padding!, child: icon))
              : RichText(
                  text: TextSpan(
                    style: textStyle,
                    children: buildIconTextSpan(textStyle),
                  ),
                  maxLines: maxLines,
                  softWrap: softWrap ?? true,
                  overflow: overflow ?? TextOverflow.clip,
                  textAlign: textAlign ?? (direction == Axis.horizontal ? TextAlign.start : TextAlign.center),
                ),
      onTap: () {
        onTap?.call();
      },
    );
  }

  List<InlineSpan> buildIconTextSpan(TextStyle textStyle) {
    var iconTextSpans = [
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: IconTheme(
          data: IconThemeData(
            size: iconSize ?? (textStyle.fontSize == null ? 16 : (textStyle.fontSize ?? 0) + 1),
            color: textStyle.color,
          ),
          child: padding == null ? icon! : Padding(padding: padding!, child: icon),
        ),
      ),
      TextSpan(text: direction == Axis.horizontal ? text : "\n$text"),
    ];
    if (!afterIcon) {
      iconTextSpans = iconTextSpans.reversed.toList();
    }
    return iconTextSpans;
  }
}

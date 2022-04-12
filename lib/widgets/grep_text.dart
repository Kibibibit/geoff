import 'package:flutter/material.dart';

/// A text widget that uses a [RichText] with [TextSpan]s to highlight parts of [text]
/// based on [searchTerm]. The highlighted text will use the style [highlightStyle], everything else will use [textStyle].
///
/// The rest of the paramters are the same as in [RichText]
class GrepText extends StatelessWidget {
  final String? text;
  final String? searchTerm;
  final TextStyle? textStyle;
  final TextStyle? highlightStyle;

  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const GrepText(
    this.text, {
    Key? key,
    this.searchTerm,
    this.textStyle,
    this.highlightStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _text = text ?? "";

    TextStyle style = textStyle ?? (Theme.of(context).textTheme.bodyText2 ?? const TextStyle()).apply(color: Colors.black);

    TextStyle highlight = highlightStyle ??
        (Theme.of(context).textTheme.bodyText2 ?? const TextStyle())
            .apply(fontWeightDelta: 700, color: Colors.red);

    List<String> _array = [];
    List<InlineSpan> _spans = [];
    if (searchTerm != null) {
      _array = _text.split(searchTerm!);

      int i = 0;

      for (String split in _array) {
        _spans.add(TextSpan(
          text: split,
          style: textStyle,
          locale: locale,
        ));

        i++;

        if (i < _array.length) {
          _spans.add(TextSpan(
            text: searchTerm,
            style: highlight,
            locale: locale,
          ));
        }
      }
    }

    return RichText(
      text: _array.isEmpty
          ? TextSpan(text: _text, style: textStyle)
          : TextSpan(children: _spans),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

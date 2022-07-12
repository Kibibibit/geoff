import 'package:flutter/material.dart';

import '../utils/string/split_with_delim.dart';

class RichTextBlock {
  List<RichTextBlock>? children;
  String? tag;
  String? text;

  static final RegExp _regExp = RegExp(
    r"<(?<tag>([a-z]*))>(?<content>(.*))<\/\k<tag>>",
    multiLine: true,
    dotAll: true,
  );

  static RichTextBlock generate(String inText, [String? tag]) {
    List<RegExpMatch> matches = _regExp.allMatches(inText).toList();

    if (matches.isEmpty) {
      return RichTextBlock._(text: inText, tag: tag);
    } else {
      List<RichTextBlock> children = [];

      List<String> split = splitWithDelim(inText, _regExp);
      for (String item in split) {
        if (matches.map((e) => e.group(0)).toList().contains(item)) {
          RegExpMatch match = matches.firstWhere((e) => e.group(0) == item);
          String tag = match.namedGroup("tag") ?? "p";
          String content = match.namedGroup("content") ?? "";
          children.add(RichTextBlock.generate(content, tag));
        } else {
          children.add(RichTextBlock.generate(item, tag));
        }
      }

      return RichTextBlock._(children: children, tag: tag);
    }
  }

  RichTextBlock._({this.children, this.tag, this.text});

  static TextStyle _getTextStyle(RichTextBlock block, TextStyle? style) {
    FontWeight? fontWeight;
    FontStyle? fontStyle;
    TextDecoration? textDecoration;

    if (block.tag != null) {
      if (block.tag == "b") {
        fontWeight = FontWeight.bold;
      }
      if (block.tag == "i") {
        fontStyle = FontStyle.italic;
      }
      if (block.tag == "u") {
        textDecoration = TextDecoration.underline;
      }
    }
    return TextStyle(
        fontWeight: fontWeight ?? style?.fontWeight,
        fontStyle: fontStyle ?? style?.fontStyle,
        decoration: textDecoration ?? style?.decoration,
        color: style?.color,
        backgroundColor: style?.backgroundColor,
        background: style?.background,
        fontSize: style?.fontSize,
        letterSpacing: style?.letterSpacing,
        wordSpacing: style?.wordSpacing,
        textBaseline: style?.textBaseline,
        height: style?.height,
        leadingDistribution: style?.leadingDistribution,
        locale: style?.locale,
        foreground: style?.foreground,
        shadows: style?.shadows,
        fontFeatures: style?.fontFeatures,
        decorationColor: style?.decorationColor,
        decorationStyle: style?.decorationStyle,
        decorationThickness: style?.decorationThickness,
        debugLabel: style?.debugLabel,
        fontFamily: style?.fontFamily,
        fontFamilyFallback: style?.fontFamilyFallback,
        overflow: style?.overflow
      );
  }

  TextSpan toTextSpans([TextStyle? style, String? parentTag, int? childNum]) {
    TextStyle s = _getTextStyle(this, style);
    if (children != null) {
      int i = 1;
      return TextSpan(
        children: children!.map((e) {
          TextSpan span = e.toTextSpans(_getTextStyle(e, s), tag, i++);
          return span;
        }).toList(),
        style: s,
      );
    } else {
      String t = text ?? "";
      if (tag == "p" || tag == "li") {
        t = t + "\n";
        if (tag == "li") {
          if (parentTag == "ol") {
            t = "$childNum. $t";
          } else if (parentTag == "ul") {
            t = "• $t";
          }
        }
      }
      return TextSpan(text: t, style: _getTextStyle(this, style));
    }
  }

  String getRenderedString() {
    if (children != null) {
      return children!.map((e) => e.getRenderedString()).join();
    } else {
      return text ?? "";
    }
  }
}

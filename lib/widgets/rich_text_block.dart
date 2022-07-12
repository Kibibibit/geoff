import 'package:flutter/material.dart';

import '../utils/string/split_with_delim.dart';

class RichTextBlock {
  List<RichTextBlock>? children;
  String? tag;
  String? text;

  static final RegExp _regExp = RegExp(
    r"<(?<tag>(.*))>(?<content>(.+))<\/\k<tag>>",
    multiLine: true,
    dotAll: true,
  );

  static RichTextBlock generate(String inText) {
    RegExp open = RegExp(r"<(?<tag>([a-z]*))>");
    RegExp close = RegExp(r"<\/(?<tag>([a-z]*))>");

    Map<String, int> count = {};
    Map<String, int> closeCount = {};
    Set<String> closed = {};

    String text = inText;

    for (int i = 0; i < inText.length; i++) {
      String s = inText.substring(i);
      if (s.startsWith(open)) {
        RegExpMatch m = open.firstMatch(s)!;
        String t = m.namedGroup("tag")!;
        if (!count.containsKey(t)) {
          count[t] = 0;
          closeCount[t] = 0;
        }
        count[t] = count[t]! + 1;
        closeCount[t] = count[t]!;
        text = text.replaceFirst(open, "<$t:${count[t]}>",i);
      }
      if (s.startsWith(close)) {
        RegExpMatch m = close.firstMatch(s)!;
        String t = m.namedGroup("tag")!;
        if (closeCount.containsKey(t)) {

          while(closed.contains("$t:${closeCount[t]}")) {
            closeCount[t] = closeCount[t]! - 1;
          }
          text = text.replaceFirst(close, "</$t:${closeCount[t]}>",i);
          closed.add("$t:${closeCount[t]}");
        }
      }
    }

    return RichTextBlock._generate(text);
  }

  static RichTextBlock _generate(String inText, [String? tag]) {
    List<RegExpMatch> matches = _regExp.allMatches(inText).toList();

    if (matches.isEmpty) {
      return RichTextBlock._(text: inText, tag: tag);
    } else {
      List<RichTextBlock> children = [];

      List<String> split = splitWithDelim(inText, _regExp);
      for (String item in split) {
        if (matches.map((e) => e.group(0)).toList().contains(item)) {
          RegExpMatch match = matches.firstWhere((e) => e.group(0) == item);
          String tag = (match.namedGroup("tag") ?? "p").replaceAll(RegExp(r":[0-9]"), "");
          String content = match.namedGroup("content") ?? "";
          children.add(RichTextBlock._generate(content, tag));
        } else {
          children.add(RichTextBlock._generate(item, tag));
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
      int i = 0;
      return TextSpan(
        children: children!.map((e) {
          if (tag == "ol" && e.tag == "li") {
            i++;
          }
          TextSpan span = e.toTextSpans(_getTextStyle(e, s), tag, i);
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
            print("$childNum. $t");
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

import 'package:flutter/material.dart';

import '../utils/string/split_with_delim.dart';

/// This component takes a string in through [RichTextBlock.generate] and
/// recursively creates a tree of [RichTextBlock]s. This can then
/// be converted into [TextSpan]s with [toTextSpans]
class RichTextBlock {
  final List<RichTextBlock>? _children;
  final String? _tag;
  final String? _text;

  static final RegExp _regExp = RegExp(
    r"<(?<tag>(.*))>(?<content>(.*))<\/\k<tag>>",
    multiLine: true,
    dotAll: true,
  );

  /// Generates the tree of [RichTextBlock]s from [inText]
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
      return RichTextBlock._(null, tag, inText);
    } else {
      List<RichTextBlock> children = [];

      List<String> split = splitWithDelim(inText, _regExp);
      for (String item in split) {
        if (matches.map((e) => e.group(0)).toList().contains(item)) {
          RegExpMatch match = matches.firstWhere((e) => e.group(0) == item);
          String tag = (match.namedGroup("tag") ?? "p").replaceAll(RegExp(r":[0-9]*"), "");
          String content = match.namedGroup("content") ?? "";
          children.add(RichTextBlock._generate(content, tag));
        } else {
          children.add(RichTextBlock._generate(item, tag));
        }
      }

      return RichTextBlock._(children, tag, null);
    }
  }


  RichTextBlock._(this._children, this._tag, this._text);

  static TextStyle _getTextStyle(RichTextBlock block, TextStyle? style) {
    FontWeight? fontWeight;
    FontStyle? fontStyle;
    TextDecoration? textDecoration;

    if (block._tag != null) {
      if (block._tag == "b") {
        fontWeight = FontWeight.bold;
      }
      if (block._tag == "i") {
        fontStyle = FontStyle.italic;
      }
      if (block._tag == "u") {
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

  /// Returns a text span based on this rich text
  TextSpan toTextSpans([TextStyle? style = const TextStyle(color: Colors.black)]) {
    return _toTextSpans(style);
  }

  TextSpan _toTextSpans([TextStyle? style, String? parentTag, int? childNum]) {
    TextStyle s = _getTextStyle(this, style);
    if (_children != null) {
      int i = 0;
      return TextSpan(
        children: _children!.map((e) {
          if (_tag == "ol" && e._tag == "li") {
            i++;
          }
          TextSpan span = e._toTextSpans(_getTextStyle(e, s), _tag, i);
          return span;
        }).toList(),
        style: s,
      );
    } else {
      String t = _text ?? "";
      if (_tag == "p" || _tag == "li") {
        t = t + "\n";
        if (_tag == "li") {
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

  /// Returns a string of what would be rendered by this block
  String getRenderedString() {
    if (_children != null) {
      return _children!.map((e) => e.getRenderedString()).join();
    } else {
      return _text ?? "";
    }
  }
}

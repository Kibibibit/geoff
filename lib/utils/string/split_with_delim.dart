List<String> splitWithDelim(String input, Pattern pattern, [int start = 0]) {
  var result = <String>[];
    for (var match in pattern.allMatches(input, start)) {
      result.add(input.substring(start, match.start));
      result.add(match[0]!);
      start = match.end;
    }
    result.add(input.substring(start));
    return result;
}
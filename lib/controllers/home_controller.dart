import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<List<String>> grid = <List<String>>[].obs;
  TextEditingController numRowsController = TextEditingController();
  TextEditingController numColsController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxString search = "".obs;
  RxString resultText = "".obs;

  void createGrid() {
    int numRows = int.tryParse(numRowsController.text) ?? 3;
    int numCols = int.tryParse(numColsController.text) ?? 3;

    grid.value = [];
    Random random = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));

    for (int i = 0; i < numRows; i++) {
      List<String> row = [];
      for (int j = 0; j < numCols; j++) {
        row.add(getRandomString(3));
      }
      grid.add(row);
    }

    resultText.value = "";
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}

import 'package:flutter/material.dart';

import '../../network/results.dart';

abstract class LocalDatasource {
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
}
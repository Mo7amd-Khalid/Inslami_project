import 'package:flutter/material.dart';

import '../../data/network/results.dart';

abstract class RepositoryContract{
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);

}
import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = "/filters-screen";
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtter"),
      ),
      body: Center(
        child: Text("Ok"),
      ),
      drawer: MainDrawer(),
    );
  }
}

import 'package:flutter/material.dart';

class DraftsListPage extends StatefulWidget {
  const DraftsListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrafsListPageState();
}

class _DrafsListPageState extends State<DraftsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista bozze"),
      ),
      body: const Center(
        child: Text("Lista bozze"),
      ),
    );
  }
}

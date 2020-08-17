import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
        create: (_) => Data(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(Provider.of<Data>(context, listen: false).data),
            ),
            body: Level2(),
          );
        });
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Level3(),
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              context.read<Data>().setData(value);
            },
          ),
          Text(context.watch<Data>().data),
        ],
      ),
    );
  }
}

class Data extends ChangeNotifier {
  String data = 'Welcome';

  void setData(String data) {
    this.data = data;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mangement_provieer/model/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => changePder(),
      child: const MaterialApp(
        title: "State mangement class 2",
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "State Mangement class 2",
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: CheapWidget()),
              Expanded(child: ExpensesWidget()),
            ],
          ),
          UpdateWidget(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<changePder>().stop();
                },
                child: Text("Stop"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<changePder>().start();
                },
                child: Text("Play"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CheapWidget extends StatelessWidget {
  const CheapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.select<changePder, Cheap>((chp) => chp.cheap);
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Cheap Widget"), Text(controller.current.toString())],
      ),
    );
  }
}

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        context.select<changePder, Expenses>((exp) => exp.expense);
    return Container(
      height: 100,
      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cheap Widget"),
          Text(controller.lastUpdate.toString())
        ],
      ),
    );
  }
}

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<changePder>();
    return Container(
      height: 100,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Widget Id"), Text(controller.id.toString())],
      ),
    );
  }
}

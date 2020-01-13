import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HelloYou(),
    );
  }
}

class HelloYou extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelloYouState();
}

class _HelloYouState extends State<HelloYou> {
  String name = '';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final _currencies = ['Dollars', 'Euro', 'Pounds', 'Rupees'];
  String _currency = 'Dollars';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text("APP"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'e.g. 124',
                          labelText: 'Distance',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      keyboardType: TextInputType.number,
                      controller: distanceController,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'e.g. 124',
                        labelText: 'Distance per Unit',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    keyboardType: TextInputType.number,
                    controller: avgController,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          hintText: 'e.g. 1.24',
                          labelText: 'Price',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.number,
                      controller: priceController,
                    )),
                    Container(width: 5.0 * 5),
                    Expanded(
                        child: DropdownButton(
                      items: _currencies
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currency,
                      onChanged: (String value) {
                        setState(() {
                          this._currency = value;
                        });
                      },
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        setState(() {
                          name = calculate();
                        });
                      },
                      child: Text('Submit', style: TextStyle(fontSize: 20)),
                    )),
                    Container(width: 5.0 * 5),
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).primaryColorDark,
                      onPressed: () {
                        reset();
                      },
                      child: Text('Reset', style: TextStyle(fontSize: 20)),
                    )),
                  ],
                ),
                Text(name)
              ],
            )));
  }

  String calculate() {
    double d = double.parse(distanceController.text);
    double fc = double.parse(avgController.text);
    double c = double.parse(priceController.text);
    double total = (d / c) * fc;
    return "The Total cost of the trip is " +
        total.toStringAsFixed(2) +
        ' ' +
        _currency;
  }

  void reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
  }
}

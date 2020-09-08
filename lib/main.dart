import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      accentColor: Colors.greenAccent,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Ponds'];
  final _minPadding = 5.0;
  var _currentSelectedItems = '';

  @override
  void initState() {
    super.initState();
    _currentSelectedItems = _currencies[0];
  }

  var displayResult = '';

  TextEditingController principleControler = TextEditingController();
  TextEditingController roiControler = TextEditingController();
  TextEditingController termControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Intrest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              getImageAssets(),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: principleControler,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter principle amount';
                    }
                  },
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: _minPadding * 3,
                      ),
                      labelText: 'Principle',
                      hintText: 'Enter Principle eg. 18000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: roiControler,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter ROIntrest';
                    }
                  },
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: _minPadding * 3,
                      ),
                      labelText: 'Rate of Intrest',
                      hintText: 'In percent',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter term';
                          }
                        },
                        controller: termControler,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          labelText: 'Term',
                          hintText: 'Time in year',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(_minPadding),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentSelectedItems,
                        onChanged: (String newValueSelected) {
                          _onDropItemSelected(newValueSelected);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.5,
                          ),
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              this.displayResult = _calculateTotal();
                            }
                            setState(() {
                              this.displayResult = _calculateTotal();
                            });
                          }),
                    ),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                      child: RaisedButton(
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            _reset();
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minPadding * 2),
                child: Text(
                  this.displayResult,
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/home_curr.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 3),
    );
  }

  void _onDropItemSelected(String newValueSelected) {
    setState(() {
      this._currentSelectedItems = newValueSelected;
    });
  }

  String _calculateTotal() {
    double principle = double.parse(principleControler.text);
    double roi = double.parse(roiControler.text);
    double term = double.parse(termControler.text);

    double totalAmountPay = principle + (principle * roi * term) / 100;

    String result =
        'After $term years, your invesment will be worth $totalAmountPay $_currentSelectedItems';

    return result;
  }

  void _reset() {
    principleControler.text = '';
    roiControler.text = '';
    termControler.text = '';
    displayResult = '';

    _currentSelectedItems = _currencies[0];
  }
}

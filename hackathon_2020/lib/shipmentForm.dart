import "dart:io";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hackathon_2020/models/shipment.dart';
import 'package:hackathon_2020/checklist.dart';
import 'package:hackathon_2020/ListQuotes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:hackathon_2020/models/shipmentrequest.dart';
import 'package:hackathon_2020/models/shipmentresponse.dart';
import 'liveAnimalDisplay.dart';

class ShipmentDetailsCaptureForm extends StatefulWidget {
  final Shipment shipmentState;

  ShipmentDetailsCaptureForm({Key key, this.shipmentState}) : super(key: key);

  @override
  ShipmentDetailsState createState() =>
      ShipmentDetailsState(this.shipmentState);
}

class ShipmentDetailsState extends State<ShipmentDetailsCaptureForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Shipment shipmentFormData = new Shipment("", "", "", "", 0, "KG", 0, "",
      DateTime.now(), 0, 0, 0, "CM", "MC", 0, "");
  String commodity = "GEN";
  File pickedImage;
  String type = '';

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      pickedImage = image;
    });
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    // ImageLabeler cloudLabeler = FirebaseVision.instance.cloudImageLabeler();
    List<ImageLabel> labels = await labeler.processImage(visionImage);
    // List<ImageLabel> cloudLabels = await cloudLabeler.processImage(visionImage);
    for (ImageLabel label in labels) {
      String text = label.text;
      String entityId = label.entityId;
      double confidence = label.confidence;
      setState(() {
        type = type + text + ' ';
      });
    }
    labeler.close();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LiveAnimalDisplay(image: pickedImage, type: type.split(" ")[0])),
    );
  }

  ShipmentDetailsState(Shipment shipment) {
    shipmentFormData = shipment;
  }

  showCheckListPopOver(BuildContext context, Shipment shipment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
          titleTextStyle: new TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.black26),
          title: new Text("CheckSheet for " + shipmentFormData.commodity),
            content: new CheckListWidget(shipmentState: shipmentFormData),
            actions: [
            new FlatButton(
                color: Colors.yellowAccent,
                child: const Text("Close"),
              onPressed: () {
                  Navigator.of(context).pop(context);
              },
            ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff120c40),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff13378d),
        toolbarHeight: 70,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(65),
                bottomRight: Radius.circular(65))),
        title: new Text('Shipping Your Cargo '),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'date': DateTime.now(),
                'accept_terms': false,
              },
              autovalidate: true,
              child: Column(
                children: [
                  Row(children: [
                    Flexible(
                        child: FormBuilderTextField(
                      attribute: "commodity",
                            style: TextStyle(color: Color(0xff10c6eb)),
                      decoration: InputDecoration(
                                labelText: "What would you like to ship?",
                                labelStyle: TextStyle(
                                    fontSize: 20  ,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffb0b5b1))),
                      initialValue: shipmentFormData.commodity,
                      onChanged: (commodity) {
                        shipmentFormData.commodity = commodity;
                        widget.shipmentState.commodity= commodity;
                            })),
                  IconButton(
                      onPressed: getImage,
                      tooltip: "Capture Commodity",
                      icon: Icon(
                        Icons.photo_camera,
                        color: Colors.blue,
                        size: 30.0,
                        ))
                  ]),
                  FormBuilderDateTimePicker(
                    attribute: "date",
                    inputType: InputType.date,
                    style: TextStyle(color: Color(0xff10c6eb)),
                    initialValue: shipmentFormData.shippingDate,
                    format: DateFormat("yyyy-MM-dd"),
                    onChanged: (date) {
                      shipmentFormData.shippingDate = date;
                      widget.shipmentState.shippingDate=date;
                    },
                    decoration: InputDecoration(
                        labelText: "When do you want to ship ?",
                        labelStyle: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffb0b5b1))),
                  ),
                  Row(children: [
                    new Text('How big is your shipment??',style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Color(0xffb0b5b1))),
                  IconButton(
                      tooltip: "Capture Dimensions",
                      icon: Icon(
                    Icons.photo_camera,
                    color: Colors.blue,
                    size: 30.0,
                        ))
                  ]),
                  Row(children: [
                    Flexible(
                        child: FormBuilderTextField(
                      attribute: "length",
                            style: TextStyle(color: Color(0xff10c6eb)),
                      initialValue: shipmentFormData.length.toString(),
                            decoration: InputDecoration(
                                labelText: "L",
                                labelStyle: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffb0b5b1))),
                      onChanged: (length) {
                        shipmentFormData.length = length;
                            })),
                    Flexible(
                        child: FormBuilderTextField(
                      attribute: "width",
                            style: TextStyle(color: Color(0xff10c6eb)),
                      initialValue: shipmentFormData.width.toString(),
                            decoration: InputDecoration(
                                labelText: "B",
                                labelStyle: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffb0b5b1))),
                      onChanged: (width) {
                        shipmentFormData.width = width;
                            })),
                    Flexible(
                        child: FormBuilderTextField(
                      attribute: "height",
                            style: TextStyle(color: Color(0xff10c6eb)),
                      initialValue: shipmentFormData.height.toString(),
                            decoration: InputDecoration(
                                labelText: "H",
                                labelStyle: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffb0b5b1))),
                      onChanged: (height) {
                        shipmentFormData.height = height;
                            })),
                  ]),
                  FormBuilderTextField(
                      attribute: "weight",
                      style: TextStyle(color: Color(0xff10c6eb)),
                      initialValue: shipmentFormData.weight.toString(),
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelText: "How heavy is your shipment ?",
                          labelStyle: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              color: Color(0xffb0b5b1))),
                      onChanged: (weight) {
                        print(weight);
                        shipmentFormData.weight = weight;
                        widget.shipmentState.weight=weight;
                      }),
                  Row(children: [
                    Flexible(
                        child: FormBuilderTextField(
                      attribute: "origin",
                            style: TextStyle(color: Color(0xff10c6eb)),
                      initialValue: shipmentFormData.origin,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                                labelText: "Origin",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffb0b5b1))),
                      onChanged: (origin) {
                        shipmentFormData.origin = origin;
                            })),
                    Flexible(
                        child: FormBuilderTextField(
                      attribute: "destination",
                            style: TextStyle(color: Color(0xff10c6eb)),
                      initialValue: shipmentFormData.destination,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                                labelText: "Destination",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffb0b5b1))),
                      onChanged: (destination) {
                        shipmentFormData.destination = destination;
                            }))
                  ])
                ],
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  child: const Text('Show Checksheet'),
                  color: Color(0xff13378d),
                  textColor: Colors.grey,
                  onPressed: () {
                    showCheckListPopOver(context, shipmentFormData);
                  },
                ),
                MaterialButton(
                  child: Text("Get Flights"),
                  color: Colors.white,
                  onPressed: () {
                    /*if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                    }*/
                    if (_fbKey.currentState.saveAndValidate()) {
                      createShipment(context, shipmentFormData);
                    }
                    // Navigate to second route when tapped.
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new FlightList(
                                shipmentInfo: shipmentFormData,
                              )),
                    );*/
                  },
                ),
                MaterialButton(
                  child: Text("Reset"),
                  color: Colors.yellowAccent,
                  onPressed: () {
                    _fbKey.currentState.reset();
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void createShipment(BuildContext context,Shipment shipmentObj) async {
    print(widget.shipmentState.weight);
    print(widget.shipmentState.shippingDate);
    print(widget.shipmentState.weight);
    print('createShipment');
    var auth = 'Basic ' +
        base64Encode(utf8.encode('4mm5rp9f598ew2tzk4kgz7n8:zYqnNTmVy5'));
    final responseAuth = await http.post(
      'https://api-ute2-ext.airfranceklm.com/cargo/oauth/oauthcust/oauth/token',
      headers: <String, String>{
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": auth
      },
      body: <String, String>{"grant_type": "client_credentials"},
    );

    if (responseAuth.statusCode == 200) {
      print(responseAuth.body);
      Map<String, dynamic> map = json.decode(responseAuth.body);
      String access_token=map["access_token"];
      print(access_token);
      LooseDetail looseShipment = new LooseDetail(
          shipmentObj.pieces,
          shipmentObj.height,
          shipmentObj.length,
          shipmentObj.width,
          true,
          true,
          shipmentObj.weight,
          shipmentObj.dimensionUnit);
      List<dynamic> looseShipmentList = [looseShipment];
      ShipmentDetail shipmentDetails = new ShipmentDetail(
          1, 1, shipmentObj.volumneUnit, 1, shipmentObj.weightUnit, null);
      ShipmentRequest request = new ShipmentRequest(
          shipmentObj.origin, shipmentObj.destination, "G01", shipmentDetails);
      print(jsonEncode(request));
      final response = await http.post(
        'https://api-ute2-ext.airfranceklm.com/cargo/customers/86873/shipments',
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer "+access_token
        },
        body: jsonEncode(request),
      );
      ShipmentResponse shipmentResponse;
      if (response.statusCode == 200) {
        shipmentResponse =
            ShipmentResponse.fromJson(json.decode(response.body));
        shipmentObj.shipmentId = shipmentResponse.id;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new FlightQuotes(
                shipmentInfo: shipmentObj,
                access_token:access_token,
              )),
        );
      } else {
        print(response.body);
      }
      print('complted create shipment save');
    }
  }
}

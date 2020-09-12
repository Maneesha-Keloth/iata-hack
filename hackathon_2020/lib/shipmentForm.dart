import "dart:io";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hackathon_2020/models/shipment.dart';
import 'package:hackathon_2020/checksheet.dart';
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
          backgroundColor: Colors.blue,
          titleTextStyle: new TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.black26),
          title: new Text("CheckSheet for " + shipmentFormData.commodity),
            //content: new CheckListWidget(shipmentState: shipmentFormData),
            actions: [
            new FlatButton(
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
                children: <Widget>[
                  FormBuilderTextField(
                      attribute: "commodity",
                      decoration: InputDecoration(
                          labelText: "What would you like to ship?"),
                      initialValue: shipmentFormData.commodity,
                      onChanged: (commodity) {
                        shipmentFormData.commodity = commodity;
                      }),
                  IconButton(
                      onPressed: getImage,
                      tooltip: "Capture Commodity",
                      icon: Icon(
                        Icons.photo_camera,
                        color: Colors.blue,
                        size: 30.0,
                      )),
                  FormBuilderDateTimePicker(
                    attribute: "date",
                    inputType: InputType.date,
                    initialValue: shipmentFormData.shippingDate,
                    format: DateFormat("yyyy-MM-dd"),
                    onChanged: (date) {
                      shipmentFormData.shippingDate = date;
                    },
                    decoration: InputDecoration(
                        labelText: "When do you want to ship ?"),
                  ),
                  new Text('How big ??'),
                  IconButton(
                      tooltip: "Capture Dimensions",
                      icon: Icon(
                    Icons.photo_camera,
                    color: Colors.blue,
                    size: 30.0,
                  )),
                  FormBuilderTextField(
                      attribute: "length",
                      initialValue: shipmentFormData.length.toString(),
                      decoration: InputDecoration(labelText: "L"),
                      onChanged: (length) {
                        shipmentFormData.length = length;
                      }),
                  FormBuilderTextField(
                      attribute: "width",
                      initialValue: shipmentFormData.width.toString(),
                      decoration: InputDecoration(labelText: "B"),
                      onChanged: (width) {
                        shipmentFormData.width = width;
                      }),
                  FormBuilderTextField(
                      attribute: "height",
                      initialValue: shipmentFormData.height.toString(),
                      decoration: InputDecoration(labelText: "H"),
                      onChanged: (height) {
                        shipmentFormData.height = height;
                      }),
                  FormBuilderTextField(
                      attribute: "weight",
                      initialValue: shipmentFormData.weight.toString(),
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelText: "How heavy is your shipment ?"),
                      onChanged: (weight) {
                        shipmentFormData.weight = weight;
                      }),
                  FormBuilderTextField(
                      attribute: "origin",
                      initialValue: shipmentFormData.origin,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelText: "Where are you shipping it from ?"),
                      onChanged: (origin) {
                        shipmentFormData.origin = origin;
                      }),
                  FormBuilderTextField(
                      attribute: "destination",
                      initialValue: shipmentFormData.destination,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelText: "Where do you want to ship to ?"),
                      onChanged: (destination) {
                        shipmentFormData.destination = destination;
                      })
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

  void createShipment(BuildContext context, Shipment shipmentObj) async {
    print('createShipment');
    var auth = 'Basic ' +
        base64Encode(utf8.encode('4mm5rp9f598ew2tzk4kgz7n8:zYqnNTmVy5'));
    final responseAuth = await http.post(
      'https://api-ute2-ext.airfranceklm.com/cargo/oauth/oauthcust/oauth/token',
      headers: <String, String>{
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": auth
      },
      body: <String, String>{
        "grant_type": "client_credentials"
      },
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
          1,
          1,
          shipmentObj.volumneUnit,
          1,
          shipmentObj.weightUnit,
          null);
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
              builder: (context) =>
              new FlightQuotes(
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

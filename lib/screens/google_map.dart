// @dart=2.9
import 'dart:async';

import 'package:authenticator_app/assistants/assistantMethods.dart';
import 'package:authenticator_app/dataHandler/appData.dart';
import 'package:authenticator_app/dest.dart';
import 'package:authenticator_app/divider.dart';
import 'package:authenticator_app/home.dart';
import 'package:authenticator_app/searchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
// import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../directions_model.dart';
import '../directions_repository.dart';

class Google extends StatefulWidget {
  const Google({Key key}) : super(key: key);

  @override
  _GoogleState createState() => _GoogleState();
}

class _GoogleState extends State<Google> {

   List<LatLng> pLineCoordinates=[];
   Set<Polyline> polylineSet={};

  double bottomPaddingOfMap=0.0;
  GoogleMapController _controller;
  //Location currentLocation = Location();
  Set<Marker> _markers={};

  Set<Marker> markerSet={};
  Set<Circle> circleSet={};



  // void getLocation() async{
  //   var _locationData= await currentLocation.getLocation();
  //
  //
  //
  //
  //   LatLng latLngPosition=LatLng(_locationData.latitude,_locationData.longitude);
  //
  //     CameraPosition cameraPosition=new CameraPosition(target: latLngPosition,zoom: 14);
  //     newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //
  //
  //
  //
  //
  //   // String address=await AssistantMethods.searchCoordinateAddress(location,context);
  //   // print("This is your Address ::" + address);
  // }

   void geoLocator=Geolocator();
   Position currentPosition;
   // Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;

   void getLocation() async{
     Position position = await Geolocator.getCurrentPosition(forceAndroidLocationManager: true,desiredAccuracy: LocationAccuracy.low);
     currentPosition=position;


     LatLng latLngPosition=LatLng(position.latitude,position.longitude);

     CameraPosition cameraPosition=new CameraPosition(target: latLngPosition,zoom: 14);
     newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
   }




  // @override
  // void initState(){
  //   super.initState();
  //
  //
  //     setState(() {
  //       getLocation();
  //     });
  //
  // }
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  static  const _initialPosition=CameraPosition(target: LatLng(22.5448131,88.3403691)
      ,zoom: 15);
  // Set<Marker> _marker={};
  // void _onMapCreated(GoogleMapController controller){
  //   setState(() {
  //     _marker.add(const Marker(markerId: MarkerId('id-1'),position: LatLng(22.5448131,88.3403691),infoWindow: InfoWindow(
  //       title: 'Victoria Memorial',
  //       snippet: 'A Historical Place'
  //     )));
  //   });
  // }
 var _origin;
 var _destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false);
          },
          icon: const Icon(Icons.home_outlined,color: Colors.black,),
        ),
        title: const Text(
          "Google Map",style: TextStyle(color: Colors.black),
        )
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,

            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            polylines: polylineSet,
            markers: markerSet,
            circles: circleSet,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController=controller;
              getLocation();
              setState(() {
                bottomPaddingOfMap=300.0;
              });

            },







              ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 60,
              width: 60,
              padding: EdgeInsets.all(10.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                heroTag: 'recenterr',
                onPressed: () {
                  getLocation();
                },
                child: Icon(
                  Icons.my_location,
                  color: Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Color(0xFFECEDF1))),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 250.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6.0),
                    const Text("Hi there, ", style: TextStyle(fontSize: 20.0), ),
                    // const Text("Where to? ", style: TextStyle(fontSize: 20.0,fontFamily: "Brand-Bold"), ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchScreen()));

                      },

                      child: Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            )
                          ],
                        ),
                        child: Padding(
                            padding:const EdgeInsets.all(16.0),

                            child:Row(
                              children: [
                                Icon(Icons.search, color: Colors.blueAccent,),
                                SizedBox(width: 10.0),

                                Text(
                                  _origin!=null?_origin:"Where From?"
                                )
                              ],
                            )
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () async{
                         var res=await Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dest()));
                         print(res);

                         if(res=="obtainDirection"){
                           await getPlaceDirection();
                         }



                      },
                      child:Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            )
                          ],
                        ),
                        child: Padding(
                            padding:const EdgeInsets.all(16.0),
                            child:Row(
                              children:[
                                Icon(Icons.search, color: Colors.blueAccent,),
                                SizedBox(width: 10.0),
                                Text(
                                  _destination!=null?_destination:"Where To?"
                                )
                              ],
                            )
                        ),
                      ),
                    )


                    // SizedBox(height: 24.0),
                    // Row(
                    //   children: [
                    //     Icon(Icons.home,color: Colors.grey,),
                    //     SizedBox(width: 12.0),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text("Add Home"),
                    //         SizedBox(height: 4.0,),
                    //         Text("Your Living Home Address",style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                    //       ],
                    //     )
                    //   ],
                    // ),


                    // SizedBox(height: 10.0),
                    //
                    // DividerWidget(),
                    //
                    //
                    // SizedBox(height: 16.0,),
                    // Row(
                    //   children: [
                    //     Icon(Icons.work,color: Colors.grey,),
                    //     SizedBox(width: 12.0),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text("Add Work"),
                    //         SizedBox(height: 4.0,),
                    //         Text("Your Office Address",style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                    //       ],
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),


        ],
      ),




    );
  }
  Future<void> getPlaceDirection() async
  {
    var initialPos=Provider.of<AppData>(context,listen: false).originLocation;
    var finalPos= Provider.of<AppData>(context,listen: false).destLocation;

    _origin=initialPos.placeName;
    _destination=finalPos.placeName;

    var originLatLng=LatLng(initialPos.latitude, initialPos.longitude);
    var destLatLng=LatLng(finalPos.latitude, finalPos.longitude);

    var details=await AssistantMethods.obtainPlaceDirectionDetails(originLatLng, destLatLng);

    //Navigator.pop(context);

    print("This is encoded points-----------------------------------");
    print(details.encodedPoints);

    PolylinePoints polylinePoints=PolylinePoints();

    List<PointLatLng> decodedPolyLinePointsResult=polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();
    if(decodedPolyLinePointsResult.isNotEmpty){
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng){
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();
    setState(() {
      Polyline polyline=Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        geodesic: true,
      );
      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if(originLatLng.latitude>destLatLng.latitude && originLatLng.longitude>destLatLng.longitude)
      {
        latLngBounds=LatLngBounds(southwest: destLatLng, northeast: originLatLng);

      }
    else if(originLatLng.longitude > destLatLng.longitude)
    {
      latLngBounds=LatLngBounds(southwest: LatLng(originLatLng.latitude,destLatLng.longitude), northeast:LatLng(destLatLng.latitude,originLatLng.longitude));
    }
    else if(originLatLng.latitude > destLatLng.latitude)
      {
        latLngBounds=LatLngBounds(southwest: LatLng(destLatLng.latitude,originLatLng.longitude), northeast:LatLng(originLatLng.latitude,destLatLng.longitude));
      }
    else{
      latLngBounds=LatLngBounds(southwest: originLatLng, northeast: destLatLng);
    }

    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker originMarker=Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: initialPos.placeName,snippet: "Origin"),
      position: originLatLng,
      markerId: MarkerId("Origin"),
    );
    Marker destMarker=Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: finalPos.placeName,snippet: "Destination"),
      position: destLatLng,
      markerId: MarkerId("Dest"),
    );
    
    setState(() {
      markerSet.add(originMarker);
      markerSet.add(destMarker);

    });

    Circle originCircle=Circle(
      fillColor: Colors.yellow,
      center: originLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.yellowAccent,
      circleId: CircleId("orginID")
    );
    Circle destCircle=Circle(
        fillColor: Colors.red,
        center: destLatLng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.purple,
        circleId: CircleId("destID")
    );

    setState(() {
      circleSet.add(originCircle);
      circleSet.add(destCircle);
    });





  }


}



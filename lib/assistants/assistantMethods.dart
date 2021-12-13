import 'package:authenticator_app/.env.dart';
import 'package:authenticator_app/assistants/requestAssistants.dart';
import 'package:authenticator_app/dataHandler/appData.dart';
import 'package:authenticator_app/directionsDetails.dart';
import 'package:authenticator_app/models/address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:provider/provider.dart';
class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position,context) async{
    String placeAddress="";
    String url="https://maps.googleapis.com/maps/api/geocode/jsonlatlng=${position.latitude},${position.longitude}?&key=${mapKey}";
    String st1,st2,st3,st4;
    var response = await RequestAssistant.getRequest(url);

    if(response!="failed")
      {
        //placeAddress=response["results"][0]['formatted_address'];
        st1=response["results"][0]["address_components"][3]["long_name"];
        st2=response["results"][0]["address_components"][4]["long_name"];
        st3=response["results"][0]["address_components"][5]["long_name"];
        st4=response["results"][0]["address_components"][6]["long_name"];

        placeAddress=st1+", "+st2+", "+st3+", "+st4;

        Address userOriginAdress=new Address();
        userOriginAdress.longitude=position.longitude;
        userOriginAdress.latitude=position.latitude;
        userOriginAdress.placeName=placeAddress;

        Provider.of<AppData>(context,listen: false).updateOriginLocationAddress(userOriginAdress);



      }
    return placeAddress;
  }

  static Future<DirectionDetails?> obtainPlaceDirectionDetails(LatLng initialPosition,LatLng finalPosition) async
  {
    String directionUrl="https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res=await RequestAssistant.getRequest(directionUrl);

    if(res=="failed")
      {
        return null;
      }

    DirectionDetails directionDetails =DirectionDetails();

    directionDetails.encodedPoints=res["routes"][0]["overview_polyline"]["points"];


    directionDetails.distanceText=res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue=res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText=res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.durationValue=res["routes"][0]["legs"][0]["distance"]["value"];

    return directionDetails;



  }
}
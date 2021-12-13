//@dart=2.9
import 'package:authenticator_app/models/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier{
Address originLocation, destLocation;

void updateOriginLocationAddress(Address originAddress)
{
  originLocation=originAddress;
  notifyListeners();
}

void updateDestLocationAddress(Address destAddress)
{
  destLocation=destAddress;
  notifyListeners();
}
}
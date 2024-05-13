import 'package:geolocator/geolocator.dart';
class Location {
  double latitude = 0.00;
  double longitude = 0.00;
  bool servicePermission = false;
  late LocationPermission permission;
  Future<void> getCurrentLocation() async{
    try {
      servicePermission = await Geolocator.isLocationServiceEnabled();
      if (!servicePermission) {
        print("Service is not enabled");
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch(e){
    print(e);}
  }
}
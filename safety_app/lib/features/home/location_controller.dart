import 'package:flutter/material.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  RxString cityName = ''.obs;
  RxBool isLoading = false.obs;
  var locationString = ''.obs;
  RxString locationError = ''.obs; // Error state

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    isLoading.value = true;
    locationError.value = ''; // Clear previous error

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationError.value =
            'Location services are disabled. Please enable them.';
        await showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return CustomValidationPopup(message: locationError.value);
          },
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationError.value = 'Location permission denied.';
          await showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return CustomValidationPopup(message: locationError.value);
            },
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationError.value =
            'Location permission permanently denied. Enable it from settings.';
        await showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return CustomValidationPopup(message: locationError.value);
          },
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      final newLocation = LatLng(position.latitude, position.longitude);
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      // locationString.value = '${position.latitude},${position.longitude}';

      // Print the comma-separated latitude and longitude string
      print(locationString);

      if (currentLocation.value != newLocation) {
        currentLocation.value = newLocation;
        await _getCityName(newLocation);
        locationString.value =
            '${cityName.value}, ${position.latitude}, ${position.longitude}';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getCityName(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Combine subLocality and locality (e.g., Baner, Pune)
        String formattedCity = '';
        if (place.subLocality != null &&
            place.subLocality!.isNotEmpty &&
            place.locality != null &&
            place.locality!.isNotEmpty) {
          formattedCity = '${place.subLocality}, ${place.locality}';
        } else if (place.locality != null && place.locality!.isNotEmpty) {
          formattedCity = place.locality!;
        } else {
          formattedCity = 'Unknown';
        }

        cityName.value = formattedCity;
        print('City: $formattedCity');
      } else {
        print('No placemarks found');
        cityName.value = 'Unknown';
      }
    } catch (e) {
      print('Failed to get city name: $e');
      cityName.value = 'Unknown';
    }
  }

  Future<void> openSettingsIfNeeded() async {
    await Geolocator.openLocationSettings();
  }
}

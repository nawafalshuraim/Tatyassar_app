import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  // final String name;
  // final String phoneNumber;
  final String street;
  final String city;
  final String postalCode;

  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    // required this.name,
    // required this.phoneNumber,
    required this.street,
    required this.city,
    required this.postalCode,
    this.dateTime,
    this.selectedAddress = true,
  });

  //String get formattedPhoneNo => CFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(id: '', street: '', city: '', postalCode: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      //'Name': name,
      //'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'PostalCode': postalCode,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      // name: data['Name'] as String,
      // phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      postalCode: data['PostalCode'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  // Factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    
    return AddressModel(
      id: snapshot.id,
      //name: data['Name'] ?? '',
     // phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $postalCode,';
  }
}
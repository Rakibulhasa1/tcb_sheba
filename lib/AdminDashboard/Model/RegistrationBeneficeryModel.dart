import 'dart:io';

class RegistrationBeneficeryModel{

  final String smartCardNid;
  final String oldNid;
  final String fulName;
  final String phone;
  final String dateOfBirth;
  final String fullData;
  final String barthNo;
  final String gender;
  final String marrigialStatus;
  final String motherName;
  final String fatherName;
  final String spouseName;
  final String ocupation;
  final String currentAddress;
  final String roadNo;
  final String houseHolding;
  final File profileImage;
  final File nidImage;
  final File nid2Image;

  final String spouseNid;
  final String spouseDob;
  final String spouseSmartCard;

  final int genderType;

  RegistrationBeneficeryModel(
      {
        required this.phone,
        required this.oldNid,
        required this.smartCardNid,
        required this.dateOfBirth,
        required this.gender,
        required this.marrigialStatus,
        required this.ocupation,
        required this.currentAddress,
        required this.roadNo,
        required this.houseHolding,
        required this.profileImage,
        required this.nidImage,
        required this.nid2Image,
        required this.barthNo,
        required this.fatherName,
        required this.fullData,
        required this.fulName,
        required this.motherName,
        required this.spouseName,
        required this.spouseNid,
        required this.spouseDob,
        required this.spouseSmartCard,
        required this.genderType,
      }
    );
}
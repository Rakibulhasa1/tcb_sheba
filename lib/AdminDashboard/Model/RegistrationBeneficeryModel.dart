import 'dart:io';

class RegistrationBeneficeryModel{

  final String nid;
  final String oldNid;
  final String name;
  final String phone;
  final String dateOfBirth;
  final String gender;
  final String marrigialStatus;
  final String gardianName;
  final String ocupation;
  final String currentAddress;
  final String roadNo;
  final String houseHolding;
  final File profileImage;
  final File nidImage;
  final int grnderReq;
  final int marrigeReq;

  RegistrationBeneficeryModel(
      {
        required this.marrigeReq,
        required this.phone,
        required this.oldNid,
        required this.nid,
        required this.name,
        required this.dateOfBirth,
        required this.gender,
        required this.marrigialStatus,
        required this.grnderReq,
        required this.gardianName,
        required this.ocupation,
        required this.currentAddress,
        required this.roadNo,
        required this.houseHolding,
        required this.profileImage,
        required this.nidImage,
      }
    );
}
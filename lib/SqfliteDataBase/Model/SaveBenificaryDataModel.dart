// ignore_for_file: file_names

class SaveBenificaryDataModel{

  final int? id;
  final String userName;
  final String nidNumber;
  final int isPaid;

  SaveBenificaryDataModel({ this.id,required this.userName,required this.nidNumber,required this.isPaid});


  SaveBenificaryDataModel.fromMap(Map<String, dynamic> res):

        id = res['id'],
        userName = res['userName'],
        nidNumber = res['nidNumber'],
        isPaid = res['isPaid'];

  Map<String,Object> toMap(){
    return {
      'userName' : userName,
      'nidNumber' : nidNumber,
      'isPaid' : isPaid,
    };
  }
}
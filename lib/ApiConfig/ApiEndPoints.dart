
// ignore_for_file: file_names

class ApiEndPoints{
  // final String baseUrl = 'https://tcb.spectrum.com.bd/api/';
  // final String imageBaseUrl = 'https://tcb.spectrum.com.bd/images/';

  //
  //final String baseUrl = 'http://185.209.228.191/api/';
  //final String imageBaseUrl = 'http://185.209.228.191/images/';

  final String baseUrl = 'http://upokari.com/api/';
  final String imageBaseUrl = 'http://upokari.com/images/';

  // final String baseUrl = 'https://tcbone.spectrum.com.bd/api/';
  // final String imageBaseUrl = 'https://tcbone.spectrum.com.bd/images/';

  final String login = 'login';
  final String qrCodeSearch = 'qr-code-search';
  final String getOTP = 'receive-info-save';
  final String otpVerification = 'otp-verification';
  final String dashboard = 'dashboard-info';
  final String beneficiaryList = 'beneficiary-list';
  final String beneficiaryReceiveList = 'beneficiary-receiver-list';

  ///Admin Dashboard

  final String getAreaData = 'area-wise-pie-chart-data';
  final String divisionList = 'division-list';
  final String districtList = 'district-list';
  final String upazilaList = 'upazila-list';
  final String unionList = 'union-list';
  final String wordList = 'word-list';
  final String stepList = 'step-list';



  final String beneficiaryAllInfo = 'beneficiary-all-info';



  final String saveNid = 'save_nid';
  final String profileUpdate = 'profile-update';
  final String changePassword = 'change-password-update';

}


String nullConverter(dynamic data){
  if(data!=null){
    return data.toString();
  }else{
    return "-";
  }
}

String nameConverter(dynamic data){
  if(data!=null){
    String stringData = data.toString();
    if(stringData.length<4){
      return stringData;
    }else{
      try{
        return '${stringData.substring(0,4)}:';
      }catch(e){
        return '-';
      }
    }
  }else{
    return "-";
  }
}
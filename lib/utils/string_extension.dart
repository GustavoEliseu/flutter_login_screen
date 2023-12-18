import 'package:binary/binary.dart';

extension PasswordEncoding on String {
  String toPasswordBinarySafeEncodedString()  { //Simple encoding of the password string before sending it through any api... the deconding must be done on the api
    if(isNotEmpty){
      String binPass = toBinaryString();
      return binPass.encodeStringPassword();
    }else{
      return "";
    }
  }

  String toBinaryString(){ //It would be way better to encode using user UID as a key before sending it. And always using https of course.
    return codeUnits.map((int x) => x.toBinaryPadded(8)).join(" ");
  }
  
  String binaryToText(){
    return String.fromCharCodes(split(" ").map((v) => int.parse(v, radix: 2)));
  }

  String encodeStringPassword() {
    List<String> splitList = List.empty( growable: true);
    List<String> splitted = split('');

    for(int x = 0; x< length; x++){
      if(splitted.isNotEmpty){
        splitList.insert(0,splitted.first);
        splitted.removeAt(0);
      }
      if(splitted.isNotEmpty){
        splitList.add(splitted.last);
        splitted.removeLast();
      }else{
        break;
      }
    }
    return splitList.join();
  }

  String decodeEncodedStringPassword(){
    List<String> splitList = List.empty( growable: true);
    List<String> splitted = split('');

    for(int x = 0; x< length; x++){
      if(splitted.isNotEmpty){
        splitList.add(splitted.first);
        splitted.removeAt(0);
      }
      if(splitted.isNotEmpty){
        splitList.insert(0,splitted.last);
        splitted.removeLast();
      }else{
        break;
      }
  }
  return splitList.reversed.join();
  }
}
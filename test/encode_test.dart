
import 'package:flutter_login_screen/utils/string_extension.dart';
import 'package:test/test.dart';

void main() {
  //passwords
  String oddPassword = "Teste";
  String evenPassword = "Testes";
  String numberPassword = "Te5st2e1";
  String shortPassword = "Tes";
  String longPassword = "ReallyLongPasswordToTestIfTherePrecision";
  //binaries
  String binaryOddPassword = "01010100 01100101 01110011 01110100 01100101";
  String binaryEvenPassword = "01010100 01100101 01110011 01110100 01100101 01110011";
  String binaryNumberPassword = "01010100 01100101 00110101 01110011 01110100 00110010 01100101 00110001";
  String binaryShortPassword = "01010100 01100101 01110011";
  String binaryLongPassword = "01010010 01100101 01100001 01101100 01101100 01111001 01001100 01101111 01101110 01100111 01010000 01100001 01110011 01110011 01110111 01101111 01110010 01100100 01010100 01101111 01010100 01100101 01110011 01110100 01001001 01100110 01010100 01101000 01100101 01110010 01100101 01010000 01110010 01100101 01100011 01101001 01110011 01101001 01101111 01101110";
  
  test('Simple Encode Decode password test', () {
      String encoded = oddPassword.encodeStringPassword();
      String decoded = encoded.decodeEncodedStringPassword();

      expect(decoded, oddPassword);
      
      encoded = evenPassword.encodeStringPassword();
      decoded = encoded.decodeEncodedStringPassword();

      expect(decoded, evenPassword);
      
      encoded = longPassword.encodeStringPassword();
      decoded = encoded.decodeEncodedStringPassword();

      expect(decoded, longPassword);
      
      encoded = shortPassword.encodeStringPassword();
      decoded = encoded.decodeEncodedStringPassword();

      expect(decoded, shortPassword);
      
      encoded = numberPassword.encodeStringPassword();
      decoded = encoded.decodeEncodedStringPassword();

      expect(decoded, numberPassword);

      encoded = binaryOddPassword.encodeStringPassword();
      decoded = encoded.decodeEncodedStringPassword();

      expect(decoded, binaryOddPassword);
      
      encoded = binaryLongPassword.encodeStringPassword();
      decoded = encoded.decodeEncodedStringPassword();

      expect(decoded, binaryLongPassword);
  });

  test('Strint to BinaryString test', () {

      String encoded = oddPassword.toBinaryString();
      expect(encoded,binaryOddPassword);
      
      encoded = evenPassword.toBinaryString();
      expect(encoded,binaryEvenPassword);
      
      encoded = longPassword.toBinaryString();
      expect(encoded,binaryLongPassword);
      
      encoded = shortPassword.toBinaryString();
      expect(encoded,binaryShortPassword);
      
      encoded = numberPassword.toBinaryString();
      expect(encoded,binaryNumberPassword);
  });

  test('binary to text test',(){
      String decoded = binaryOddPassword.binaryToText();
      expect(oddPassword, decoded);
      
      decoded = binaryEvenPassword.binaryToText();
      expect(evenPassword, decoded);
      
      decoded = binaryLongPassword.binaryToText();
      expect(longPassword, decoded);
      
      decoded = binaryShortPassword.binaryToText();
      expect(shortPassword, decoded);
      
      decoded = binaryNumberPassword.binaryToText();
      expect(numberPassword, decoded);

  });

  test('encode and decode passwords test', (){
      String result = oddPassword.toPasswordBinarySafeEncodedString().decodeEncodedStringPassword().binaryToText();
      expect(oddPassword,result);
  });
}

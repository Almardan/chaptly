import 'dart:math';

class OTPUtil {
  static String generateOTP() {
    
    Random random = Random();
    String otp = '';
    for (int i = 0; i < 4; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }
}
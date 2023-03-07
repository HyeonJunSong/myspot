import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart' as kakao;
import 'package:myspot/models/user.dart';

Future<User?> getKakaoUser() async {
  User? user;
  kakao.User kuser;
  try {
    kuser = await kakao.UserApi.instance.me();
    debugPrint('사용자 정보 요청 성공'
        '\n이메일: ${kuser.kakaoAccount?.email}'
        '\n닉네임: ${kuser.kakaoAccount?.profile?.nickname}');

    user?.email = kuser.kakaoAccount?.email;
    user?.nickname = kuser.kakaoAccount?.profile?.nickname;

    return user;

    // if (await checkUser(user)) {
    //   //사용자가 존재하지 않으면
    //   //디비에 사용자 추가
    //   CollectionReference users =
    //       FirebaseFirestore.instance.collection('users');
    //   users
    //       .add({
    //         'id': user.id,
    //         'nickname': user.kakaoAccount?.profile?.nickname,
    //         'profile_img': user.kakaoAccount?.profile?.profileImageUrl,
    //       })
    //       .then((value) => debugPrint("User Added"))
    //       .catchError((error) => debugPrint("Failed to add user: $error"));
    // }
  } catch (error) {
    debugPrint('사용자 정보 요청 실패 $error');
    return null;
  }
}

// Future<bool> checkUser(User user) async {
//   var snapshot = FirebaseFirestore.instance
//       .collection('users')
//       .where('id', isEqualTo: user.id)
//       .snapshots();

//   if (await snapshot.isEmpty) {
//     debugPrint("사용자가 존재하지 않습니다.");
//     return true;
//   } else {
//     debugPrint("사용자가 이미 존재합니다.");
//     return false;
//   }
// }

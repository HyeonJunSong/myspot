import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    user?.email = kuser.kakaoAccount!.email!;
    user?.nickname = kuser.kakaoAccount!.profile!.nickname!;

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

Future<User> kakaoLogin() async {
  // 카카오톡 실행 가능 여부 확인
  // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await kakao.isKakaoTalkInstalled()) {
    try {
      await kakao.UserApi.instance.loginWithKakaoTalk();
      debugPrint('카카오톡으로 로그인 성공');
      //홈으로 이동
      User u = await getKakaoUser() as User;
      return u;
    } catch (error) {
      debugPrint('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return User.nullInit();
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await kakao.UserApi.instance.loginWithKakaoAccount();
        debugPrint('카카오계정으로 로그인 성공');
        //홈으로 이동
        User u = await getKakaoUser() as User;
        return u;
      } catch (error) {
        debugPrint('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await kakao.UserApi.instance.loginWithKakaoAccount();
      debugPrint('카카오계정으로 로그인 성공');
      //홈으로 이동
      User u = await getKakaoUser() as User;
      return u;
    } catch (error) {
      debugPrint('카카오계정으로 로그인 실패 $error');
    }
  }
  return User.nullInit();
}
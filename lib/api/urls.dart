class Urls {
//  static const String baseURL = "http://10.0.2.2:3000/api/v1/";

//  static const String baseURL = "http://192.168.43.170:3000/api/v1/";

  static const String baseURL = "https://doc-connect-v1.herokuapp.com/api/v1/";

  static get host => baseURL.replaceAll("api/v1/", "");

  ///-------------------- Register and login
  static const String register = "auth/register";
  static const String fbAuth = "auth/fb";
  static const String googleAuth = "auth/google";
  static const String login = "auth/login";
  static const String fcmId = "auth/fcm/token";

  /// Refresh token
  static const String token = "auth/token";

  /// forgot password
  static const String forgotPassword = "auth/sendPasswordResetCode";
  static const String resetPassword = "auth/resetPassword";
  static const String changePassword = "auth/changePassword";

  /// TODO: DONE add a button to handle resending of Email verification token it is valid for 1 hour
  static const String resendVerificationToken = "auth/resendVerificationToken";

  ///---------------------- dashboard ------------------------------------------
  static const String dashboard = "dashboard";

  /// --------------------- user -----------------------------------------------
  static const String user = "user";
  static const String getNearbyDoctors = "user/nearby/doctors";
  static const String getNearbyPatients = "user/nearby/patients";
  static const String uploadImage = "user/pp";
  static const String searchDoctors = "user/search/doctor";

  ///---------------------- Forum ----------------------------------------------
  static const String forum = "forum";
  static const String forumResponse = "forum/response";
  static const String upVoteForumResponse = "forum/upvote/response";
  static const String downVoteForumResponse = "forum/upvote/response";
  static const String upVoteForumQuestion = "forum/upvote";
  static const String downVoteForumQuestion = "forum/downvote";

  ///---------------------- Appointment ----------------------------------------
  static const String appointment = "appointment";
  static const String cancelAppointment = "appointment/cancel";
  static const String acceptAppointmentReqOff = "appointment/accept";
  static const String rejectAppointmentReqOff = "appointment/reject";

  ///----------------------- Medical report ------------------------------------
  static const String medicalReport = "mr";

  ///---------------------- notifications --------------------------------------
  static const String notifications = "notification";

  /// --------------------- Sockets NSP ----------------------------------------
  static final String forumsNSP = baseURL.replaceAll("api/v1/", "") + "forums";

  ///---------------------- chat -----------------------------------------------
  static const String getChatRoomId = "chat/id";
  static const String getChats = "chat";
  static const String acceptChatRequest = "chat/accept";
  static const String rejectChatRequest = "chat/reject";
  static final String chatsNSP = baseURL.replaceAll("api/v1/", "") + "chats";

  ///-----------------------------------------------------------------------------

  static const defHeaders = {"Content-Type": "application/json"};

  static Map<String, String> getHeadersWithToken() {
    return {
      "Content-Type": "application/json",
      // SharedPrefConstants.authToken: Session.getAuthToken()
    };
  }

  static Map<String, String> getHeadersWithRefreshToken() {
    return {
      "Content-Type": "application/json",
//      SharedPrefConstants.authToken: Session.getAuthToken(),
//      SharedPrefConstants.refreshToken: Session.getRefreshToken(),
    };
  }
}
/*
keytool \
>     -exportcert \
>     -alias key \
>     -storepass docconnect \
>     -keystore app_key.jks | openssl sha1 -binary | openssl base64


twJe1mILG3OoNUmdyJzXuPOhIXY=
twJe1mILG3OoNUmdyJzXuPOhlXY=
twJe1mlLG3OoNUmdyJzXuPOhlXY=
twJe1mlLG3OoNUmdyJzXuPOhIXY=

 */

/*
For key

keytool -genkey -v -keystore doc_connect.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
Enter keystore password:
Re-enter new password:
What is your first and last name?
  [Unknown]:  Mohammad Fayaz
What is the name of your organizational unit?
  [Unknown]:  StackInFlow
What is the name of your organization?
  [Unknown]:  StackInFlow
What is the name of your City or Locality?
  [Unknown]:  Hyderabad
What is the name of your State or Province?
  [Unknown]:  Telangana
What is the two-letter country code for this unit?
  [Unknown]:  IN
Is CN=Mohammad Fayaz, OU=StackInFlow, O=StackInFlow, L=Hyderabad, ST=Telangana, C=IN correct?
  [no]:  yes

Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10,000 days
        for: CN=Mohammad Fayaz, OU=StackInFlow, O=StackInFlow, L=Hyderabad, ST=Telangana, C=IN
Enter key password for <key>
        (RETURN if same as keystore password):
[Storing doc_connect.jks]

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore doc_connect.jks -destkeystore doc_connect.jks -deststoretype pkcs12".
fayaz@hp:~/doc_connect$ keytool -importkeystore -srckeystore doc_connect.jks -destkeystore doc_connect.jks -deststoretype pkcs12
Enter source keystore password:
Entry for alias key successfully imported.
Import command completed:  1 entries successfully imported, 0 entries failed or cancelled

Warning:
Migrated "doc_connect.jks" to Non JKS/JCEKS. The JKS keystore is backed up as "doc_connect.jks.old".


keytool -importkeystore -srckeystore doc_connect.jks -destkeystore doc_connect.jks -deststoretype pkcs12

*/

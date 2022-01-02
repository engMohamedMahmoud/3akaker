import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:aakaker/screens/Orders/Order_List/Components/EmptyOrder/emptyOrders.dart';
import 'package:aakaker/screens/Conection/conection_screen.dart';
import 'package:aakaker/screens/Empty_cart/empty_screen.dart';
import 'package:aakaker/screens/Notifications/notification_screen.dart';
import 'package:aakaker/screens/Orders/Order_List/details.dart';
import 'package:aakaker/screens/Orders/Order_List/order_screen.dart';
import 'package:aakaker/screens/Splash0/splash_0_screen.dart';
import 'package:aakaker/screens/cart/cart_screen.dart';
import 'package:aakaker/screens/complete_map/complete_map_details.dart';
import 'package:aakaker/screens/complete_profile/complete_profile_screen.dart';
import 'package:aakaker/screens/details/details_screen.dart';
import 'package:aakaker/screens/forgot_password/Otp_forgetPassword/otp_forget_password_home.dart';
import 'package:aakaker/screens/forgot_password/forgot_password_screen.dart';
import 'package:aakaker/screens/home/components/Bannar/fullscreen_image.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:aakaker/screens/login_success/login_success_screen.dart';
import 'package:aakaker/screens/map/map_screen.dart';
import 'package:aakaker/screens/otp/otp_screen.dart';
import 'package:aakaker/screens/payment/payment_screen.dart';
import 'package:aakaker/screens/profile/profile_screen.dart';
import 'package:aakaker/screens/rest_password/Change_Password/change_user_password_screen.dart';
import 'package:aakaker/screens/rest_password/rest_password.dart';
import 'package:aakaker/screens/search_and_see_all/components/Normal%20Status/displayAllProducts.dart';
import 'package:aakaker/screens/search_and_see_all/search_see_all_screen.dart';
import 'package:aakaker/screens/send_prescision_image/Roshata_Map/Details/completeMapDetailsRoshata.dart';
import 'package:aakaker/screens/send_prescision_image/Roshata_Map/Main/mainScreenHome.dart';
import 'package:aakaker/screens/send_prescision_image/send_prescription_image_screen.dart';
import 'package:aakaker/screens/sign_in/sign_in_screen.dart';
import 'package:aakaker/screens/splash/splash_screen.dart';
import 'package:aakaker/screens/Settings/settings_screen.dart';
import 'package:aakaker/screens/Prescription/prescription.dart';
import 'screens/PhramysNames/HomeNames.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'package:aakaker/screens/Phone_Account/phone_account_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen0.routeName: (context) => SplashScreen0(),
  SplashScreen1.routeName: (context) => SplashScreen1(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  RestPasswordScreen.routeName: (context) => RestPasswordScreen(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
  MySettingsScreen.routeName: (context) => MySettingsScreen(),
  PrescriptionScreen.routeName: (context) => PrescriptionScreen(),
  SendPrescriptionImageScreen.routeName: (context) => SendPrescriptionImageScreen(),
  NotificationsScreen.routeName: (context) => NotificationsScreen(),
  MaptScreen.routeName: (context) => MaptScreen(),
  SeeAllSearchScreen.routeName: (context) => SeeAllSearchScreen(),
  ConectionScreen.routeName: (context) => ConectionScreen(),
  MapDetailsScreen.routeName: (context) => MapDetailsScreen(),
  EmptyCartScreen.routeName: (context) => EmptyCartScreen(),
  PhoneACCountScreen.routeName: (context) => PhoneACCountScreen(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  OrderDetailssScreen.routeName: (context) => OrderDetailssScreen(),
  OtpForgetPasswordScreen.routeName: (context) => OrderDetailssScreen(),
  RestUserPasswordScreen.routeName: (context) => RestUserPasswordScreen(),
  MapMainRoshataScreen.routeName: (context) => MapMainRoshataScreen(),
  MapDetailsRoshataScreen.routeName: (context) => MapDetailsRoshataScreen(),
  EmptyOrdersScreen.routeName: (context) => EmptyOrdersScreen(),
  DisplayAllSearchScreen.routeName: (context) => DisplayAllSearchScreen(),
  NamesScreen.routeName: (context) => NamesScreen(),





};

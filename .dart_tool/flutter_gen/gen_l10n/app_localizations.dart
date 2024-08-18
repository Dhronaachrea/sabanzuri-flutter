import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @copyrightText.
  ///
  /// In en, this message translates to:
  /// **'Sabanzuri Lotto © Copyright 2021'**
  String get copyrightText;

  /// No description provided for @splashText.
  ///
  /// In en, this message translates to:
  /// **'SKILROCK TECHNOLOGIES ©2023'**
  String get splashText;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @myTickets.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get myTickets;

  /// No description provided for @myWallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get myWallet;

  /// No description provided for @myTransactions.
  ///
  /// In en, this message translates to:
  /// **'My Transactions'**
  String get myTransactions;

  /// No description provided for @inbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// No description provided for @referAFriend.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend'**
  String get referAFriend;

  /// No description provided for @quickLinks.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get quickLinks;

  /// No description provided for @drawGamesResults.
  ///
  /// In en, this message translates to:
  /// **'Draw Games Results'**
  String get drawGamesResults;

  /// No description provided for @myDrawGameTickets.
  ///
  /// In en, this message translates to:
  /// **'My Draw Game Tickets'**
  String get myDrawGameTickets;

  /// No description provided for @myBonuses.
  ///
  /// In en, this message translates to:
  /// **'My Bonuses'**
  String get myBonuses;

  /// No description provided for @howToPlay.
  ///
  /// In en, this message translates to:
  /// **'How To Play'**
  String get howToPlay;

  /// No description provided for @sabanzuriLotto.
  ///
  /// In en, this message translates to:
  /// **'6/42 Sabanzuri Lotto'**
  String get sabanzuriLotto;

  /// No description provided for @luckyTwelve.
  ///
  /// In en, this message translates to:
  /// **'12/24 Lucky Twelve'**
  String get luckyTwelve;

  /// No description provided for @treasureHunt.
  ///
  /// In en, this message translates to:
  /// **'Treasure Hunt'**
  String get treasureHunt;

  /// No description provided for @ticTacToe.
  ///
  /// In en, this message translates to:
  /// **'Tic Tac Toe'**
  String get ticTacToe;

  /// No description provided for @moneyBee.
  ///
  /// In en, this message translates to:
  /// **'Money Bee'**
  String get moneyBee;

  /// No description provided for @bigFive.
  ///
  /// In en, this message translates to:
  /// **'Big 5'**
  String get bigFive;

  /// No description provided for @funTime.
  ///
  /// In en, this message translates to:
  /// **'Fun Time'**
  String get funTime;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @switchToLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch To Light Theme'**
  String get switchToLightTheme;

  /// No description provided for @switchToDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch To Dark Theme'**
  String get switchToDarkTheme;

  /// No description provided for @moreLinks.
  ///
  /// In en, this message translates to:
  /// **'More Links'**
  String get moreLinks;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'faq'**
  String get faq;

  /// No description provided for @responsibleGaming.
  ///
  /// In en, this message translates to:
  /// **'Responsible Gaming'**
  String get responsibleGaming;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @loginOrSignup.
  ///
  /// In en, this message translates to:
  /// **'Login / SignUp'**
  String get loginOrSignup;

  /// No description provided for @jackpot.
  ///
  /// In en, this message translates to:
  /// **'JACKPOT'**
  String get jackpot;

  /// No description provided for @playNow.
  ///
  /// In en, this message translates to:
  /// **'PLAY NOW'**
  String get playNow;

  /// No description provided for @winUpTo.
  ///
  /// In en, this message translates to:
  /// **'WIN UP TO'**
  String get winUpTo;

  /// No description provided for @instantGames.
  ///
  /// In en, this message translates to:
  /// **'Instant Games'**
  String get instantGames;

  /// No description provided for @remainingTime.
  ///
  /// In en, this message translates to:
  /// **'Remaining Time'**
  String get remainingTime;

  /// No description provided for @kes.
  ///
  /// In en, this message translates to:
  /// **'KES'**
  String get kes;

  /// No description provided for @d.
  ///
  /// In en, this message translates to:
  /// **'d'**
  String get d;

  /// No description provided for @h.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get h;

  /// No description provided for @m.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get m;

  /// No description provided for @s.
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get s;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @mobHintText.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number (+254)'**
  String get mobHintText;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @confPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confPassword;

  /// No description provided for @juvenileConfText.
  ///
  /// In en, this message translates to:
  /// **'By creating an Account and playing any Games, you confirm that you are above 18 years of age and agree to be fully bound by the term and conditions'**
  String get juvenileConfText;

  /// No description provided for @termsAndCondition.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndCondition;

  /// No description provided for @generateOtp.
  ///
  /// In en, this message translates to:
  /// **'Generate Otp'**
  String get generateOtp;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send Otp'**
  String get sendOtp;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get enterMobileNumber;

  /// No description provided for @enterValidMobNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Valid Mobile Number'**
  String get enterValidMobNumber;

  /// No description provided for @mobileNumberMustStart.
  ///
  /// In en, this message translates to:
  /// **'Mobile number must start with 7,1 or 0'**
  String get mobileNumberMustStart;

  /// No description provided for @passWordLengthValidationText.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least 3 characters'**
  String get passWordLengthValidationText;

  /// No description provided for @passMatchError.
  ///
  /// In en, this message translates to:
  /// **'Password Don\'t match'**
  String get passMatchError;

  /// No description provided for @otpNotification.
  ///
  /// In en, this message translates to:
  /// **'Your OTP for verification is {otp}. Don\'t share it with anyone.'**
  String otpNotification(Object otp);

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP *'**
  String get enterOtp;

  /// No description provided for @pleaseEnterOtpOn.
  ///
  /// In en, this message translates to:
  /// **'Please enter 6 digit OTP received on'**
  String get pleaseEnterOtpOn;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login Error'**
  String get loginError;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @registrationError.
  ///
  /// In en, this message translates to:
  /// **'Registration Error'**
  String get registrationError;

  /// No description provided for @otpError.
  ///
  /// In en, this message translates to:
  /// **'OtpError'**
  String get otpError;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'UpdateNow'**
  String get updateNow;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'Id'**
  String get id;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'update'**
  String get update;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'dob'**
  String get dob;

  /// No description provided for @updateSuccessText.
  ///
  /// In en, this message translates to:
  /// **'Account details updated successfully'**
  String get updateSuccessText;

  /// No description provided for @pickOption.
  ///
  /// In en, this message translates to:
  /// **'Pick Option'**
  String get pickOption;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @avatarUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Image Updated Successfully'**
  String get avatarUpdatedSuccessfully;

  /// No description provided for @avatarUpdatingError.
  ///
  /// In en, this message translates to:
  /// **'Image Update Unsuccessful, Please try again'**
  String get avatarUpdatingError;

  /// No description provided for @balanceUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Balance Updated Successfully'**
  String get balanceUpdatedSuccessfully;

  /// No description provided for @myTicket.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get myTicket;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @txnId.
  ///
  /// In en, this message translates to:
  /// **'Txn Id'**
  String get txnId;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @selectAC.
  ///
  /// In en, this message translates to:
  /// **'Select a/c'**
  String get selectAC;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Amount Suggestions'**
  String get amountSuggestions;

  /// No description provided for @cost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get cost;

  /// No description provided for @mobileMoney.
  ///
  /// In en, this message translates to:
  /// **'Mobile Money'**
  String get mobileMoney;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @depositConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Deposit Confirmation'**
  String get depositConfirmation;

  /// No description provided for @areYouSureToDeposit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to deposit'**
  String get areYouSureToDeposit;

  /// No description provided for @using.
  ///
  /// In en, this message translates to:
  /// **'using'**
  String get using;

  /// No description provided for @toYourWallet.
  ///
  /// In en, this message translates to:
  /// **'to your wallet?'**
  String get toYourWallet;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get done;

  /// No description provided for @withdrawalConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Confirmation'**
  String get withdrawalConfirmation;

  /// No description provided for @areYouSureToWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to Withdrawal'**
  String get areYouSureToWithdrawal;

  /// No description provided for @fromYourWallet.
  ///
  /// In en, this message translates to:
  /// **'from your Wallet'**
  String get fromYourWallet;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @wager.
  ///
  /// In en, this message translates to:
  /// **'Wager'**
  String get wager;

  /// No description provided for @winning.
  ///
  /// In en, this message translates to:
  /// **'Winning'**
  String get winning;

  /// No description provided for @cashIn.
  ///
  /// In en, this message translates to:
  /// **'cash In'**
  String get cashIn;

  /// No description provided for @cashOut.
  ///
  /// In en, this message translates to:
  /// **'cash Out'**
  String get cashOut;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @debit.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get debit;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'Na'**
  String get na;

  /// No description provided for @myTransactionError.
  ///
  /// In en, this message translates to:
  /// **'My transaction error'**
  String get myTransactionError;

  /// No description provided for @noTransactionFound.
  ///
  /// In en, this message translates to:
  /// **'No transaction found'**
  String get noTransactionFound;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @searchYourMessageHere.
  ///
  /// In en, this message translates to:
  /// **'Search Your message here'**
  String get searchYourMessageHere;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @deleteConfirmationText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you wish to delete this item?'**
  String get deleteConfirmationText;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @deletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Deleted Successfully'**
  String get deletedSuccessfully;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be of minimum 3 characters.'**
  String get passwordMinLength;

  /// No description provided for @passwordConfirmationFailed.
  ///
  /// In en, this message translates to:
  /// **'New password and confirm password should be same.'**
  String get passwordConfirmationFailed;

  /// No description provided for @newPasswordNotMatched.
  ///
  /// In en, this message translates to:
  /// **'New password and confirm password is not same.'**
  String get newPasswordNotMatched;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @oneTimePassword.
  ///
  /// In en, this message translates to:
  /// **'One Time Password'**
  String get oneTimePassword;

  /// No description provided for @otpSuccessfullySentTo.
  ///
  /// In en, this message translates to:
  /// **'Otp successfully sent to'**
  String get otpSuccessfullySentTo;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password Changed Successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @referenceInformation.
  ///
  /// In en, this message translates to:
  /// **'Share the referral code or link with your friends to refer and earn referral benefits.'**
  String get referenceInformation;

  /// No description provided for @copyReferralCode.
  ///
  /// In en, this message translates to:
  /// **'Copy referral code.'**
  String get copyReferralCode;

  /// No description provided for @chooseHowToInvite.
  ///
  /// In en, this message translates to:
  /// **'Choose how you would like to invite.'**
  String get chooseHowToInvite;

  /// No description provided for @inviteManually.
  ///
  /// In en, this message translates to:
  /// **'Invite Manually'**
  String get inviteManually;

  /// No description provided for @nameOfFriend.
  ///
  /// In en, this message translates to:
  /// **'Friend\'s Name'**
  String get nameOfFriend;

  /// No description provided for @emailOfFriend.
  ///
  /// In en, this message translates to:
  /// **'Friend\'s Email id'**
  String get emailOfFriend;

  /// No description provided for @addMore.
  ///
  /// In en, this message translates to:
  /// **'Add More'**
  String get addMore;

  /// No description provided for @inviteNow.
  ///
  /// In en, this message translates to:
  /// **'Invite Now'**
  String get inviteNow;

  /// No description provided for @bonusEligibilityText.
  ///
  /// In en, this message translates to:
  /// **'To be eligible for the bonus, please ensure that the friends you invite use the link located in the invitation sent to them. This is the only way they can be linked to your account.'**
  String get bonusEligibilityText;

  /// No description provided for @howToShareText.
  ///
  /// In en, this message translates to:
  /// **'Just choose your email provider or social networking site(s) and invite your friends to join Sabanzuri. Please be informed that no information shall be shared with anyone, please read our privacy policy to gain more understanding in this respect.'**
  String get howToShareText;

  /// No description provided for @trackStatus.
  ///
  /// In en, this message translates to:
  /// **'Track Status'**
  String get trackStatus;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @gmail.
  ///
  /// In en, this message translates to:
  /// **'gmail'**
  String get gmail;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'facebook'**
  String get facebook;

  /// No description provided for @twitter.
  ///
  /// In en, this message translates to:
  /// **'twitter'**
  String get twitter;

  /// No description provided for @trackStatusInformationText.
  ///
  /// In en, this message translates to:
  /// **'Below is the list of invitations sent by you & there status. If you wish to send a reminder, select the friends & click on \'send reminder\' button.'**
  String get trackStatusInformationText;

  /// No description provided for @referDetails.
  ///
  /// In en, this message translates to:
  /// **'Refer Details'**
  String get referDetails;

  /// No description provided for @addCash.
  ///
  /// In en, this message translates to:
  /// **'Add Cash'**
  String get addCash;

  /// No description provided for @myTicketError.
  ///
  /// In en, this message translates to:
  /// **'My Ticket Error'**
  String get myTicketError;

  /// No description provided for @mobHintTextInfinitiLotto.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number *'**
  String get mobHintTextInfinitiLotto;

  /// No description provided for @pleaseEnter4DigitOtpReceivedOnMsg.
  ///
  /// In en, this message translates to:
  /// **'Please enter 4 digit OTP received on'**
  String get pleaseEnter4DigitOtpReceivedOnMsg;

  /// No description provided for @noTransactionAvailableMsg.
  ///
  /// In en, this message translates to:
  /// **'No transaction available'**
  String get noTransactionAvailableMsg;

  /// No description provided for @pleaseCheckForAnotherDates.
  ///
  /// In en, this message translates to:
  /// **'Please check for another dates.'**
  String get pleaseCheckForAnotherDates;

  /// No description provided for @validEmailText.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email Id'**
  String get validEmailText;

  /// No description provided for @validNameText.
  ///
  /// In en, this message translates to:
  /// **'Please enter Friend\'s Name'**
  String get validNameText;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @bonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get bonus;

  /// No description provided for @wagerRefund.
  ///
  /// In en, this message translates to:
  /// **'Wager Refund'**
  String get wagerRefund;

  /// No description provided for @withdrawalCancel.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Cancel'**
  String get withdrawalCancel;

  /// No description provided for @noOrderToTrack.
  ///
  /// In en, this message translates to:
  /// **'No track status found'**
  String get noOrderToTrack;

  /// No description provided for @inboxError.
  ///
  /// In en, this message translates to:
  /// **'Inbox Error'**
  String get inboxError;

  /// No description provided for @get_otp.
  ///
  /// In en, this message translates to:
  /// **'Get Otp'**
  String get get_otp;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enter_password;

  /// No description provided for @enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm Password'**
  String get enter_confirm_password;

  /// No description provided for @get_pin.
  ///
  /// In en, this message translates to:
  /// **'get pin'**
  String get get_pin;

  /// No description provided for @otp_sent_successfully.
  ///
  /// In en, this message translates to:
  /// **'Otp Sent Successfully'**
  String get otp_sent_successfully;

  /// No description provided for @no_payment_options_available.
  ///
  /// In en, this message translates to:
  /// **'No Payment Options Available'**
  String get no_payment_options_available;

  /// No description provided for @printing_success.
  ///
  /// In en, this message translates to:
  /// **'Printing Success'**
  String get printing_success;

  /// No description provided for @printing_failed.
  ///
  /// In en, this message translates to:
  /// **'Printing Failed'**
  String get printing_failed;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

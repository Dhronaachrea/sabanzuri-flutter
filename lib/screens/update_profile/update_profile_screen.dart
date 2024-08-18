import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/user/user.dart';
import 'package:sabanzuri/screens/initiate_withdraw/WithdrawalOtpDialog.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/screens/update_profile/bloc/gender/update_gender_bloc.dart';
import 'package:sabanzuri/screens/update_profile/update_profile_widget/confirm_password_field.dart';
import 'package:sabanzuri/screens/update_profile/update_profile_widget/password_field.dart';
import 'package:sabanzuri/screens/update_profile/update_profile_widget/update_phone_no.dart';
import 'package:sabanzuri/screens/update_profile/update_profile_widget/update_profile_widget.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/update_profile_bloc.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final fnController = TextEditingController();
  final mnController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();
  final lnController = TextEditingController();
  final eController = TextEditingController();
  final dobController = TextEditingController();
  final addController = TextEditingController();
  final cController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var autoValidate   = AutovalidateMode.disabled;
  bool isUpdateLoading = false;
  List<String> requiredFieldList = [];

  @override
  void initState() {
    fnController.text   = context.read<AuthBloc>().firstName    ?? UserInfo.firstName;
    lnController.text   = context.read<AuthBloc>().lastName     ?? UserInfo.lastName;
    eController.text    = context.read<AuthBloc>().email        ?? UserInfo.email;
    dobController.text  = context.read<AuthBloc>().dob          ?? UserInfo.dob;
    addController.text  = context.read<AuthBloc>().address      ?? UserInfo.address;
    cController.text    = context.read<AuthBloc>().countryName  ?? UserInfo.getCountryName;
    BlocProvider.of<UpdateProfileBloc>(context).add( GetConfigValueCallApiEvent() );
    super.initState();
  }

  @override
  void dispose() {
    fnController.dispose();
    lnController.dispose();
    eController.dispose();
    dobController.dispose();
    addController.dispose();
    cController.dispose();
    mnController.dispose();
    passController.dispose();
    confPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isUpdateLoading,
      child: SabanzuriScaffold(
        title: context.l10n.updateProfile,
        showDrawer: false,
        child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
            listener: (context, state) {
              final bool isDarkThemeOn = context.read<SwitchCubit>().state.isDarkThemeOn;
              if (state is UpdatingProfile) {
                setState(() {
                  isUpdateLoading = true;
                });
              }
              else if (state is UpdatedProfile) {
                setState(() {
                  isUpdateLoading = false;
                });
                if (UserInfo.profileType == "ANONYMOUS") {
                  UserInfo.logout();
                  Navigator.pushNamedAndRemoveUntil(context, Screen.home_screen, ModalRoute.withName(Screen.home_screen));
                } else {
                  Navigator.pop(context);
                  ShowToast.showToast(context.l10n.updateSuccessText, context, type: ToastType.SUCCESS);

                }
                /*Navigator.pop(context);
                Alert.show(
                  type: AlertType.success,
                  title: context.l10n.updateProfile.toUpperCase(),
                  subtitle: state.successMsg,
                  buttonText: context.l10n.ok.toUpperCase(),
                  context: context,
                  isCloseButton: false,
                  isDarkThemeOn: isDarkThemeOn,
                  buttonClick: () {
                    Navigator.pop(context);
                  },
                );*/
              }
              else if (state is UpdateProfileError) {
                setState(() {
                  isUpdateLoading = false;
                });
                //Navigator.pop(context);
                Alert.show(
                  title: context.l10n.updateProfile,
                  subtitle: state.errorMsg,
                  buttonText: context.l10n.ok.toUpperCase(),
                  context: context,
                  isDarkThemeOn: isDarkThemeOn,
                );
              }
              else if (state is GetOtpSuccess){
                print("otp---------------->${state.msg}");
                setState(() {
                  ShowToast.showToast(state.msg, context,type: ToastType.SUCCESS);
                  isUpdateLoading = false;
                  if (!state.isResendOtp) {
                    showOtpDialog();
                  }
                });
              }
              else if (state is GetConfigValueSuccess) {
                setState((){
                  requiredFieldList = state.requiredFieldList;

                });
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: autoValidate,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HeightBox(10.0),
                      Visibility(
                        child: Column(
                          children: [
                            UpdatePhoneNo(
                              mnController: mnController,
                              emptyText: context.l10n.enterMobileNumber
                            ),
                            PasswordField(
                              passController: passController,
                              emptyText: context.l10n.enter_password,
                            ),
                            ConfirmPasswordField(
                                confPassController: confPassController,
                                passController: passController

                            )
                          ],
                        ),
                        visible: UserInfo.profileType == "ANONYMOUS",
                      ),
                      UpdateFirstName(
                          fnController: fnController,
                          emptyText: 'Plz enter first name',
                          isRequiredField: requiredFieldList.contains("firstName"),
                      ),
                      UpdateLastName(
                          lnController: lnController,
                          emptyText: 'Plz enter last name',
                          isRequiredField: requiredFieldList.contains("lastName"),
                      ),
                      UpdateEmail(
                          eController: eController,
                          emptyText: 'Plz enter email address',
                          contentType: 'email',
                          isRequiredField: requiredFieldList.contains("emailId"),
                      ),
                      UpdateDob(
                          dobController: dobController,
                          emptyText: 'Plz submit DOB',
                        isRequiredField: requiredFieldList.contains("dob"),
                      ),
                      const UpdateGender(),
                      UpdateAddress(
                          addController: addController,
                          emptyText: 'Plz enter address',
                        isRequiredField: requiredFieldList.contains("address"),
                      ),
                      isUpdateLoading
                          ? SizedBox(
                        width: 50,
                        height: 50,
                        child: Lottie.asset('assets/lottie/gradient_loading.json'),
                      ).py(16)
                          :
                      UpdateButton(
                        btnText: (UserInfo.profileType == "ANONYMOUS") ? context.l10n.get_otp : context.l10n.updateProfile,
                        onPressed: () {
                          (UserInfo.profileType == "ANONYMOUS") ? callGetOtpApi() : updatePressed(null);
                        },
                      )
                    ]).p8(),

              ),
            )
        )
      ),
    );
  }

  void callGetOtpApi() { //GetOtpApi
    isInternetConnect().then((value) {
      if(value) {
        BlocProvider.of<UpdateProfileBloc>(context).add(
          GetOtpApi(
            mobileNo: mnController.text.trim(),
            context: context,
          ),
        );
      } else {
        ApiService.showErrorSheet();
      }
    });
  }

  void updatePressed(String? otp) {
    print("============================>${_formKey.currentState!.validate()}");

    if (_formKey.currentState!.validate()) {
      String dob = '';
      if (dobController.text != '') {
        dob = formatDate(
          date: dobController.text,
          inputFormat: Format.dateFormat9,
          outputFormat: Format.apiDateFormat3,
        );
      }
      var user = User(
        firstName: fnController.text,
        lastName: lnController.text,
        email: eController.text,
        dob: dob,
        address: addController.text,
        country: cController.text,
        otp: otp,
        password: passController.text.trim(),
        mobNumber: mnController.text.trim()
      );
      var gender = context
          .read<UpdateGenderBloc>()
          .gender; //Gender.Female or Gender.Male
      user.gender = gender == Gender.Male ? "M" : "F";
      final bool isDarkThemeOn = context.read<SwitchCubit>().state.isDarkThemeOn;

      FocusScope.of(context).unfocus();
      isInternetConnect().then((value) {
        if(value) {
          BlocProvider.of<UpdateProfileBloc>(context).add(
            OnUpdateProfile(
              user: user,
              context: context,
            ),
          );
        } else {
          ApiService.showErrorSheet();
        }
      });
    } else {
      setState(() {
        autoValidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  showOtpDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => BlocProvider<UpdateProfileBloc>(
        create:(context) => UpdateProfileBloc(),
        child: WithdrawalOtpDialog(
          mobileNo: mnController.text.trim(),
          otpCallback: (String otp) {
            print("----------------->>>>>$otp");
            Navigator.of(context).pop();
            updatePressed(otp);
          }, ),
    )
    );
  }
}

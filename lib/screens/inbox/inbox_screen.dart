import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/inbox_response.dart';
import 'package:sabanzuri/screens/inbox/bloc/inbox_bloc.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/screens/inbox/inbox_widget/inbox_widget.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {

  List<PlrInboxList> inboxList        = [];
  List<PlrInboxList> inboxDummyList   = [];
  List<PlrInboxList> inboxMainList    = [];

  var inboxScrollController           = ScrollController();
  bool hasMoreInbox                   = true;
  bool isLoadingForInbox              = true;
  bool isMoreInboxAvailable           = false;
  bool hasMoreMsg                     = true;
  var offset                          = 0;
  bool isBackPressedAllowed           = true;
  bool isMoreInboxDataAvailable       = false;
  bool isSearchItem                   = false;
  late String query;

  @override
  void initState() {
    isInternetConnect().then((value) {
      if(value) {
        context.read<InboxBloc>().add(GetInbox(offset: offset));
      } else {
        ApiService.showErrorSheet();
      }
    });
    inboxScrollController.addListener(inboxPagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return SabanzuriScaffold(
        showDrawer: false,
        title: context.l10n.inbox,
        child: BlocListener<InboxBloc, InboxState>(
          listener: (context, state) {
            if (state is InboxDeleteLoaded) {
              ShowToast.showToast(context.l10n.deletedSuccessfully, context, type: ToastType.SUCCESS);
            }
            if (state is InboxError) {
                if (state.errorCode == AppConstants.sessionExpiryCode) {
                    showSnackMsg(context, state.errorMsg ?? "", Colors.red, isDarkThemeOn: isDarkThemeOn);
                } else {
                    Alert.show(
                      title: context.l10n.inbox,
                      subtitle: state.errorMsg ?? "Inbox Error",
                      buttonText: context.l10n.ok.toUpperCase(),
                      context: context,
                      isDarkThemeOn: isDarkThemeOn,
                    );
                }
            }
            if (state is InboxLoading) {
              setState(() {
                isLoadingForInbox = true;
              });
            }

            else if (state is InboxSearchLoaded) {
              inboxDummyList = [];
              setState(() {
                //searchedList.addAll(state.inboxResponseList!);
                if (state.inboxResponseList!.isNotEmpty) {
                  isSearchItem = true;
                  inboxDummyList.addAll(state.inboxResponseList!);
                } else {
                  isSearchItem = false;
                  if(query.isEmpty) {
                    inboxDummyList.addAll(inboxMainList);
                  } else {
                    inboxDummyList.clear();
                  }
                }
              });
              if (isSearchItem) {
                setState(() {
                  isMoreInboxDataAvailable = false;
                });
              } else {
                setState(() {
                  isMoreInboxDataAvailable = true;
                });
              }
            }
            else if (state is InboxLoaded) {
              setState(() { state.inboxResponseList!.length; });
              List<PlrInboxList> inboxTempList = [];

              setState(() {
                isLoadingForInbox = false;
              });
              /*var inboxList = context.watch<InboxBloc>().inboxList;
              var searchList = context.watch<InboxBloc>().searchList;*/
              inboxList = state.inboxResponseList ?? [];
              inboxTempList = inboxList;
              inboxDummyList.addAll(inboxTempList);
              inboxMainList = inboxDummyList;
              hasMoreInbox = inboxList.isEmpty ? false : true;
              setState(() {
                isLoadingForInbox = false;
              });

              /*if (searchList.isNotEmpty) {
                inboxList = searchList;
              }*/
              if (inboxTempList.isNotEmpty) {
                if(inboxTempList.length < 20) {
                  setState(() {
                    isMoreInboxDataAvailable = false;
                  });
                } else {
                  setState(() {

                    isMoreInboxDataAvailable = true;
                  });
                }

              } else {
                setState(() {
                  isMoreInboxDataAvailable = false;
                });
              }
            }
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              inboxDummyList.isNotEmpty
                ? SingleChildScrollView(
                controller: inboxScrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                          AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: inboxDummyList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 400),
                            child: SlideAnimation(
                              verticalOffset: 100,
                              child: FadeInAnimation(
                                  child: Dismissible(
                                    confirmDismiss:
                                        (DismissDirection direction) async {
                                      // var confirmDismiss =
                                      //     await _confirmDismiss(isDarkThemeOn);
                                      var confirmDismiss =
                                      await ConfirmationSheet.show(
                                          inboxList: inboxDummyList[index],
                                          isDarkThemeOn: isDarkThemeOn,
                                          context: context,
                                          onConfirm: () {
                                            isInternetConnect().then((value) {
                                              if(value) {
                                                context.read<InboxBloc>().add(InboxActivity(
                                                    context: context,
                                                    activity: "DELETE",
                                                    inboxId: inboxDummyList[index]
                                                        .inboxId
                                                        .toString()));

                                                inboxList.clear();
                                                inboxDummyList.clear();
                                                inboxMainList.clear();

                                                Navigator.of(context).pop(true);

                                              } else {
                                                ApiService.showErrorSheet();
                                              }
                                            });
                                          },
                                          onCancel: () {
                                            Navigator.of(context).pop(false);
                                          });
                                      return confirmDismiss;
                                    },
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      color: SabanzuriColors.rusty_red,
                                    ),
                                    key: Key("${inboxDummyList[index]}"),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                inboxDummyList[index].subject ?? "",
                                                //"WINNING HIGH",
                                                style: TextStyle(
                                                    color: isDarkThemeOn
                                                        ? SabanzuriColors.yellow_orange
                                                        : SabanzuriColors.warm_grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Text(
                                              _dateTimeDiff(
                                                inboxDummyList[index].mailSentDate!,
                                              ),
                                              // "Yesterday",
                                              style: const TextStyle(
                                                  color: SabanzuriColors.cool_grey,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Roboto",
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.left,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                log("Icon is pressed");
                                                ConfirmationSheet.show(
                                                    inboxList: inboxDummyList[index],
                                                    isDarkThemeOn: isDarkThemeOn,
                                                    context: context,
                                                    onConfirm: () {
                                                      isInternetConnect().then((value) {
                                                        if(value) {

                                                          context.read<InboxBloc>().add(
                                                            InboxActivity(
                                                                context: context,
                                                                activity: "DELETE",
                                                                inboxId: inboxDummyList[index]
                                                                    .inboxId
                                                                    .toString()
                                                            ),
                                                          );
                                                          inboxList.clear();
                                                          inboxDummyList.clear();
                                                          inboxMainList.clear();
                                                          Navigator.of(context).pop();

                                                        } else {
                                                          ApiService.showErrorSheet();
                                                        }
                                                      });
                                                    },
                                                    onCancel: () {
                                                      Navigator.of(context).pop();
                                                    });
                                              },
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: isDarkThemeOn
                                                    ? SabanzuriColors.white
                                                    : SabanzuriColors.warm_grey_three,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(inboxDummyList[index].contentId ?? "",
                                          style: TextStyle(color: isDarkThemeOn
                                              ? SabanzuriColors.white
                                              : SabanzuriColors.warm_grey_three,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),),
                                        Container(
                                            height: 0.5,
                                            decoration: const BoxDecoration(
                                              color: SabanzuriColors.warm_grey,
                                            )
                                        ).pOnly(top:20)
                                      ],
                                    ),
                                  ).pOnly(left: 20, right: 20)
                              ),
                            ),
                          );
                        },
                      ),
                    ).pOnly(bottom: 60),
                    isMoreInboxDataAvailable
                        ? Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: SizedBox(width: 60, height: 60, child: Lottie.asset('assets/lottie/gradient_loading.json')))
                        : Container(),
                  ],
                ),
              )
                : isLoadingForInbox
                  ? SizedBox(width: 60, height: 60, child: Lottie.asset('assets/lottie/gradient_loading.json'))
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: context.screenHeight / 4,
                    child: Lottie.asset(
                        'assets/lottie/no_data.json'),
                  ),
                  const Text(
                      "No Search found,\nPlease try with another inputs",
                      style: TextStyle(
                        color:
                        SabanzuriColors.pumpkin_orange,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center),
                ],
              ).pOnly(bottom: 120),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  color: SabanzuriColors.white,
                  child: CupertinoSearchTextField(
                    itemSize: 30,
                    onChanged: (String input) {
                      query = input.trim();
                      context.read<InboxBloc>().add(
                        InboxSearch(context: context, query: query,  inboxList: inboxDummyList),
                      );
                    },
                  ).pSymmetric(h: 15, v: 10),
                ),
              )
            ],
          )
        )
    );
  }

  String _dateTimeDiff(String mailSentDate) {
    var now = DateTime.now();

    DateFormat inputFormat = DateFormat('dd/MM/yyyy hh:mm:ss');
    DateTime input = inputFormat.parse(mailSentDate);

    var difference = now.difference(input);

    var days = difference.inDays;
    var hours = difference.inHours;
    var minutes = difference.inMinutes;
    var seconds = difference.inSeconds;
    if (days > 1) {
      if (days > 7) {
        String date = formatDate(
          date: mailSentDate,
          inputFormat: Format.apiDateFormat,
          outputFormat: Format.inboxFormat,
        );
        return date;
      }
      return "$days days ago";
    } else if (days == 1) {
      return context.l10n.yesterday;
    } else if (hours > 0) {
      return "$hours hours ago";
    } else if (minutes > 0) {
      return "$minutes minutes ago";
    } else {
      return "$seconds seconds ago";
    }
  }

  Future<bool?> _confirmDismiss(bool isDarkThemeOn) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            backgroundColor:
                isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              context.l10n.confirmation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                color: isDarkThemeOn
                    ? SabanzuriColors.yellow_orange
                    : SabanzuriColors.navy,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Text(
              context.l10n.deleteConfirmationText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkThemeOn
                    ? SabanzuriColors.white
                    : SabanzuriColors.grey_blue,
                fontSize: 16.0,
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(context.l10n.ok.toUpperCase())),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(context.l10n.cancel.toUpperCase())),
            ],
          );
        });
  }

  void inboxPagination() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (inboxScrollController.position.pixels == inboxScrollController.position.maxScrollExtent) {
      if (hasMoreInbox) {
        setState(() {
          offset += int.parse(AppConstants.inboxLimit);
        });
        isInternetConnect().then((value) {
          if(value) {
            context.read<InboxBloc>().add(GetInbox(offset: offset));
          } else {
            ApiService.showErrorSheet();
          }
        });

      } else {
        setState(() {
          isMoreInboxDataAvailable = false;
        });
      }
    }
  }
}

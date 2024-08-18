import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/transaction_response.dart';
import 'package:sabanzuri/model/response/update_profile_response.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/screens/ticket/ticket_widget/ticket_widget.dart';
import 'package:sabanzuri/screens/transaction/bloc/transaction_bloc.dart';
import 'package:sabanzuri/screens/wallet/wallet_widget/wallet_widget.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/loading_indicator.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';
import 'package:velocity_x/velocity_x.dart';

part 'transaction_tab_bar.dart';

part 'all_transaction.dart';

part 'wager_transaction.dart';

part 'deposit_transaction.dart';

part 'withdrawal_transaction.dart';

part 'transaction_card.dart';

part 'winning_transaction.dart';

part 'cash_in_transaction.dart';

part 'cash_out_transaction.dart';

part 'transaction_date.dart';

part 'txn_image.dart';

part 'txn_type.dart';

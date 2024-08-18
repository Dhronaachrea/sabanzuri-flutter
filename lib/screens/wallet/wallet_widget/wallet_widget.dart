import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/WithdrawalInitiatePaymentOptionResponse.dart';
import 'package:sabanzuri/model/wallet/deposit_model.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/screens/wallet/bloc/wallet_bloc.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/loading_indicator.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_bottom_sheet.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../model/response/payment_option_response.dart';

part 'wallet_tab_bar.dart';

part 'deposit_screen.dart';

part 'withdrawal_screen.dart';

part 'payment_option.dart';

part 'select_account.dart';

part 'currency_amount.dart';

part 'amount_selection.dart';

part 'horizontal_border.dart';

part 'deposit_amount_confirmation.dart';

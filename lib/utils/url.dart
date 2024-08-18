class Url {

  /* QA URLS */

  // static const String _RAM_URL                  = "https://beta-ram-backend.lottoweaver.com";
  // static const String _PAM_URL                  = "https://beta-pam-backend.lottoweaver.com";
  static const String _PAM_URL                  = "https://pam-backend-wls.infinitilotto.com";
  static const String _WEAVER_URL               = "https://beta-api.lottoweaver.com";
  // static const String PRIVATE_WEAVER_URL_INFINITI = "http://10.160.10.15:808f0";
  // static const String PRIVATE_WEAVER_URL_INFINITI = "https://beta-weaver.lottoweaver.com";
  static const String PRIVATE_WEAVER_URL_INFINITI        = "https://api-wls.infinitilotto.com";
  // static const String _CASHIER_URL              = "https://beta-cashier-backend.lottoweaver.com";
  static const String _CASHIER_URL              = "https://cashier-backend-wls.infinitilotto.com";
  static const String _BASE_URL                 = "https://kenya.lottoweaver.com";
  static const String _TICKET_RESULT_URL        = "https://kenya-games.lottoweaver.com";
  static const String AVATAR_BASE_URL           = "https://beta.lottoweaver.com/WeaverDoc/commonContent/www.sabanzuri.com";
  static const String DRAWER_URL                = "https://kenya.lottoweaver.com";
  static const String GAME_BASE_URL             = "https://games-wls.infinitilotto.com";
  static const String SPORT_GAME_BASE_URL       = "https://spe-node-be-wls.infinitilotto.com";

  /*GAME URLS*/
  static const String INITIAL_GAME              = "$GAME_BASE_URL/api/player/initial";
  static const String FETCH_DGE_GAME            = "$GAME_BASE_URL/api/draw/fetchgamedata";
  static const String FETCH_IGE_GAME            = "$GAME_BASE_URL/api/ige/fetchmatchlist";
  // static const String FETCH_SPORT_LOTTERY_GAME  = "$PUBLIC_BASE_DMS_URL_INFINITI/api/v1/player/getGamesWithDraw";
  static const String FETCH_SPORT_LOTTERY_GAME  = "$PUBLIC_BASE_DMS_URL_INFINITI/sle/api/v1/player/getGamesWithDraw";

  /*BASE URLS*/
  static const String FETCH_DGE_GAME_URL        = "$_BASE_URL/index.php/component/weaver/?task=api.getGamesInfo";
  /*Ticket URLS*/
  static const String FETCH_IGE_GAME_URL        = "$_TICKET_RESULT_URL/api/ige/fetchmatchlist";
  /* WEAVER URLS */
  static const String VERSION_API_URL           = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/versionControl";
  static const String FETCH_HEADER_URL          = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/fetchHeaderInfo";
  static const String GET_BALANCE               = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/getBalance";
  static const String UPLOAD_AVATAR_URL         = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/uploadAvatar";
  static const String TICKET_DETAILS_URL        = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/ticketDetails";
  static const String TRANSACTION_REQUEST_URL   = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/transactionDetails";
  static const String INBOX_URL                 = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/playerInbox";
  static const String INBOX_ACTIVITY_URL        = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/inboxActivity";
  static const String CHANGE_PASSWORD_URL       = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/changePassword";
  static const String FORGOT_PASSWORD_URL       = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/forgotPassword";
  static const String RESET_PASSWORD_URL        = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/resetPassword";

  /*CASHIER URLS*/
  static const String PAYMENT_OPTION            = "$_CASHIER_URL/player/payment/options";
  static const String DEPOSIT_REQUEST_URL       = "$_CASHIER_URL/player/payment/depositRequest";
  static const String WITHDRAWAL_REQUEST_URL    = "$_CASHIER_URL/player/payment/withdrawalRequest";
  static const String FETCH_PENDING_WITHDRAWAL  = "$_CASHIER_URL/player/fetchPendingScanNPlayWithdrawal";

  /* RAM URLS */
  static const String COUNTRY_LIST_URL          = "$_RAM_URL_INFINITI_LOTTO/preLogin/getCountryList";
  static const String GET_OTP_URL               = "$_RAM_URL_INFINITI_LOTTO/preLogin/sendRegOtp";
  static const String REGISTRATION_URl          = "$_RAM_URL_INFINITI_LOTTO/preLogin/registerPlayerWithOtp";
  static const String LOGIN_URl                 = "$_RAM_URL_INFINITI_LOTTO/preLogin/playerLogin";
  static const String UPDATE_PLAYER_PROFILE     = "$_RAM_URL_INFINITI_LOTTO/postLogin/overallUpdatePlayerProfile";
  static const String LOGIN_BY_QRCODE           = "$_RAM_URL_INFINITI_LOTTO/preLogin/playerLoginByQRCode";
  static const String FORCE_PASSWORD_CHANGE     = "$_RAM_URL_INFINITI_LOTTO/postLogin/changePassword";

  /* DRAWER URLS */
  static const String HOW_PLAY_SABANZURI_URL    = "$DRAWER_URL/mobile-pages/how-to-play-sabanzuri-lotto";
  static const String HOW_PLAY_LUCKY_TWELVE_URL = "$DRAWER_URL/mobile-pages/how-to-play-lucky-twelve";
  static const String HOW_PLAY_TREASURE_URL     = "$DRAWER_URL/mobile-pages/treasure-hunt";
  static const String HOW_PLAY_TIC_TAC_TOE_URL  = "$DRAWER_URL/mobile-pages/tic-tac-toe";
  static const String HOW_PLAY_MONEY_BEE_URL    = "$DRAWER_URL/mobile-pages/money-bee";
  static const String HOW_PLAY_BIG_FIVE_URL     = "$DRAWER_URL/mobile-pages/big-5";
  static const String HOW_PLAY_FUN_TIME_URL     = "$DRAWER_URL/mobile-pages/fun-time";
  static const String FAQ_URL                   = "$WEB_VIEWS_INFO_BASE_URL_INFINITI/en/mobile-pages/mobile-faq";// make changes
  static const String RESPONSIBLE_GAMING_URL    = "$WEB_VIEWS_INFO_BASE_URL_INFINITI/en/mobile-pages/mobile-responsible-gaming";
  static const String TNC_URL                   = "$WEB_VIEWS_INFO_BASE_URL_INFINITI/en/mobile-pages/mobile-terms-conditions";
  static const String PRIVACY_POLICY_URL        = "$WEB_VIEWS_INFO_BASE_URL_INFINITI/en/mobile-pages/mobile-privacy-policy";
  static const String CONTACT_US_URL            = "$WEB_VIEWS_INFO_BASE_URL_INFINITI/en/mobile-pages/mobile-contact-us";

  /* PAM */

  static const String GET_CONFIG_VALUE          = "${_PAM_URL}/getConfigValues";

 //============================================== INFINITI LOTTO ================================================================

  static const String BASE_URL_INFINITI                   = "https://api-wls.infinitilotto.com";
  static const String WEB_VIEWS_INFO_BASE_URL_INFINITI    = "https://www-wls.infinitilotto.com";
  static const String _RAM_URL_INFINITI_LOTTO             = "https://ram-backend-wls.infinitilotto.com";
  static const String PRIVATE_BASE_DMS_URL_INFINITI       = "http://172.31.64.17:8081";
  static const String PUBLIC_BASE_DMS_URL_INFINITI        = "https://dms-wls.infinitilotto.com";
  static const String SPORT_LOTTY_WEB_BASE_URL            = "https://dm-node1-wls.infinitilotto.com";
  static const String BONUS_URL_INFINITI                  = "https://bonus-backend-wls.infinitilotto.com";
  static const String LOGIN_URl_INFINITI                  = "$_RAM_URL_INFINITI_LOTTO/preLogin/playerLogin"; // RAM ( Main Login Url )
  //static const String LOGIN_URl_INFINITI                  = "$BASE_URL_INFINITI/Weaver/service/rest/playerLogin"; // Weaver Login Url
  static const String TICKET_DETAILS_URL_INFINITI         = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/ticketDetails";
  static const String TRANSACTION_REQUEST_URL_INFINITI    = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/transactionDetails";
  static const String CHANGE_PASSWORD_URL_INFINITI        = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/changePassword";
  static const String CHECK_AVAILABILITY_URL              = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/checkAvailability";
  static const String INBOX_URL_INFINITI                  = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/playerInbox";
  static const String INBOX_ACTIVITY_URL_INFINITI         = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/inboxActivity";
  static const String FETCH_GAMEDATA_INFINIT              = "$PUBLIC_BASE_DMS_URL_INFINITI/DMS/dataMgmt/fetchGameData";
  static const String GET_BALANCE_INFINIT                 = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/getBalance";
  static const String INVITE_FRIEND                       = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/inviteFriend";
  static const String TRACK_STATUS                        = "$PRIVATE_WEAVER_URL_INFINITI/Weaver/service/rest/plrTrackReferBonus";
  static const String CHECK_BONUS_STATUS_INFINITI         = "$BONUS_URL_INFINITI/player/checkBonusStatusPlayer";

  // static const String WITHDRAWAL_INITIATE_REQUEST_URL    = "https://cashier-backend-wls.infinitilotto.com/player/payment/withdrawalRequest";
  static const String WITHDRAWAL_INITIATE_REQUEST_URL    = "${_CASHIER_URL}/player/payment/withdrawalRequest";
  static const String RESEND_WITHDRAWAL_OTP_URL          = "${_CASHIER_URL}/player/payment/resendWithdrawalOtp";


  static const String PRIVATE_BASE                        = "http://10.160.10.116:8084";

  static const String UPDATE_PROFILE_TYPE_OTP             = "$_RAM_URL_INFINITI_LOTTO/postLogin/sendOtp";
}

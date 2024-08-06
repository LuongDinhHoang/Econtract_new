// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mật khẩu`
  String get label_password {
    return Intl.message(
      'Mật khẩu',
      name: 'label_password',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập`
  String get label_user_name {
    return Intl.message(
      'Tên đăng nhập',
      name: 'label_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập `
  String get error_input_empty {
    return Intl.message(
      'Vui lòng nhập ',
      name: 'error_input_empty',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật khẩu!`
  String get error_empty_password {
    return Intl.message(
      'Vui lòng nhập mật khẩu!',
      name: 'error_empty_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên đăng nhập!`
  String get error_empty_userName {
    return Intl.message(
      'Vui lòng nhập tên đăng nhập!',
      name: 'error_empty_userName',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập hoặc mật khẩu không đúng.`
  String get error_login {
    return Intl.message(
      'Tên đăng nhập hoặc mật khẩu không đúng.',
      name: 'error_login',
      desc: '',
      args: [],
    );
  }

  /// `Duy trì đăng nhập`
  String get keep_login {
    return Intl.message(
      'Duy trì đăng nhập',
      name: 'keep_login',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu?`
  String get forgot_password {
    return Intl.message(
      'Quên mật khẩu?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get button_login {
    return Intl.message(
      'Đăng nhập',
      name: 'button_login',
      desc: '',
      args: [],
    );
  }

  /// `Hồ sơ đi`
  String get contract_from {
    return Intl.message(
      'Hồ sơ đi',
      name: 'contract_from',
      desc: '',
      args: [],
    );
  }

  /// `Hồ sơ đến`
  String get contract_to {
    return Intl.message(
      'Hồ sơ đến',
      name: 'contract_to',
      desc: '',
      args: [],
    );
  }

  /// `Nhập Tên hồ sơ, Hồ sơ mẫu`
  String get hint_text_search {
    return Intl.message(
      'Nhập Tên hồ sơ, Hồ sơ mẫu',
      name: 'hint_text_search',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết Hồ sơ`
  String get contract_detail {
    return Intl.message(
      'Chi tiết Hồ sơ',
      name: 'contract_detail',
      desc: '',
      args: [],
    );
  }

  /// `Mã hồ sơ:`
  String get contract_code {
    return Intl.message(
      'Mã hồ sơ:',
      name: 'contract_code',
      desc: '',
      args: [],
    );
  }

  /// `Người tạo:`
  String get creator {
    return Intl.message(
      'Người tạo:',
      name: 'creator',
      desc: '',
      args: [],
    );
  }

  /// `Nguồn hồ sơ:`
  String get source_contract {
    return Intl.message(
      'Nguồn hồ sơ:',
      name: 'source_contract',
      desc: '',
      args: [],
    );
  }

  /// `Ngày tạo:`
  String get create_date {
    return Intl.message(
      'Ngày tạo:',
      name: 'create_date',
      desc: '',
      args: [],
    );
  }

  /// `Hạn ký:`
  String get date_sign {
    return Intl.message(
      'Hạn ký:',
      name: 'date_sign',
      desc: '',
      args: [],
    );
  }

  /// `Trạng thái:`
  String get status {
    return Intl.message(
      'Trạng thái:',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách Văn bản`
  String get list_text {
    return Intl.message(
      'Danh sách Văn bản',
      name: 'list_text',
      desc: '',
      args: [],
    );
  }

  /// `Đối tượng ký`
  String get signer {
    return Intl.message(
      'Đối tượng ký',
      name: 'signer',
      desc: '',
      args: [],
    );
  }

  /// `còn`
  String get left {
    return Intl.message(
      'còn',
      name: 'left',
      desc: '',
      args: [],
    );
  }

  /// `ngày`
  String get day {
    return Intl.message(
      'ngày',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Hoàn thành`
  String get complete {
    return Intl.message(
      'Hoàn thành',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Chờ ký`
  String get waiting_sign {
    return Intl.message(
      'Chờ ký',
      name: 'waiting_sign',
      desc: '',
      args: [],
    );
  }

  /// `Mới tạo`
  String get newly_created {
    return Intl.message(
      'Mới tạo',
      name: 'newly_created',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối ký`
  String get refusing_sign {
    return Intl.message(
      'Từ chối ký',
      name: 'refusing_sign',
      desc: '',
      args: [],
    );
  }

  /// `Đã huỷ`
  String get cancelled {
    return Intl.message(
      'Đã huỷ',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Đã xem`
  String get seen {
    return Intl.message(
      'Đã xem',
      name: 'seen',
      desc: '',
      args: [],
    );
  }

  /// `Đã ký`
  String get signed {
    return Intl.message(
      'Đã ký',
      name: 'signed',
      desc: '',
      args: [],
    );
  }

  /// `Chưa ký`
  String get not_signed {
    return Intl.message(
      'Chưa ký',
      name: 'not_signed',
      desc: '',
      args: [],
    );
  }

  /// `Nội Dung Văn Bản`
  String get title_content_document {
    return Intl.message(
      'Nội Dung Văn Bản',
      name: 'title_content_document',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản`
  String get me {
    return Intl.message(
      'Tài khoản',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notice {
    return Intl.message(
      'Thông báo',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối ký`
  String get no_agree_sign {
    return Intl.message(
      'Từ chối ký',
      name: 'no_agree_sign',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý ký`
  String get agree_sign {
    return Intl.message(
      'Đồng ý ký',
      name: 'agree_sign',
      desc: '',
      args: [],
    );
  }

  /// `Ký Hồ sơ`
  String get sign_contract {
    return Intl.message(
      'Ký Hồ sơ',
      name: 'sign_contract',
      desc: '',
      args: [],
    );
  }

  /// `Ngày giờ xử lý:`
  String get title_date_active {
    return Intl.message(
      'Ngày giờ xử lý:',
      name: 'title_date_active',
      desc: '',
      args: [],
    );
  }

  /// `TK thao tác:`
  String get title_account_active {
    return Intl.message(
      'TK thao tác:',
      name: 'title_account_active',
      desc: '',
      args: [],
    );
  }

  /// `Nhật ký xử lý:`
  String get title_log_active {
    return Intl.message(
      'Nhật ký xử lý:',
      name: 'title_log_active',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử Hồ sơ`
  String get title_history {
    return Intl.message(
      'Lịch sử Hồ sơ',
      name: 'title_history',
      desc: '',
      args: [],
    );
  }

  /// `Sao chép địa chỉ trang Ký Hồ sơ`
  String get title_copy_address {
    return Intl.message(
      'Sao chép địa chỉ trang Ký Hồ sơ',
      name: 'title_copy_address',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ:`
  String get address {
    return Intl.message(
      'Địa chỉ:',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Sao chép`
  String get copy {
    return Intl.message(
      'Sao chép',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Thời hạn: `
  String get duration {
    return Intl.message(
      'Thời hạn: ',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lý do từ chối từ ký`
  String get reasons_not_agreeing_sign {
    return Intl.message(
      'Nhập lý do từ chối từ ký',
      name: 'reasons_not_agreeing_sign',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lý do`
  String get hint_text_reasons {
    return Intl.message(
      'Nhập lý do',
      name: 'hint_text_reasons',
      desc: '',
      args: [],
    );
  }

  /// `Ghi lại`
  String get record {
    return Intl.message(
      'Ghi lại',
      name: 'record',
      desc: '',
      args: [],
    );
  }

  /// `Ngày cập nhật`
  String get date_update {
    return Intl.message(
      'Ngày cập nhật',
      name: 'date_update',
      desc: '',
      args: [],
    );
  }

  /// `Ngày từ chối ký`
  String get date_refusing_sign {
    return Intl.message(
      'Ngày từ chối ký',
      name: 'date_refusing_sign',
      desc: '',
      args: [],
    );
  }

  /// `Ngày huỷ`
  String get date_cancel {
    return Intl.message(
      'Ngày huỷ',
      name: 'date_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ngày hoàn thành`
  String get date_complete {
    return Intl.message(
      'Ngày hoàn thành',
      name: 'date_complete',
      desc: '',
      args: [],
    );
  }

  /// `Đã sao chép địa chỉ thành công`
  String get notify_copy {
    return Intl.message(
      'Đã sao chép địa chỉ thành công',
      name: 'notify_copy',
      desc: '',
      args: [],
    );
  }

  /// `Vô thời hạn`
  String get unlimited {
    return Intl.message(
      'Vô thời hạn',
      name: 'unlimited',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt`
  String get setting {
    return Intl.message(
      'Cài đặt',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng khuôn mặt`
  String get face_login {
    return Intl.message(
      'Đăng nhập bằng khuôn mặt',
      name: 'face_login',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào !`
  String get hi {
    return Intl.message(
      'Xin chào !',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Vân tay`
  String get fingerprint_login {
    return Intl.message(
      'Đăng nhập bằng Vân tay',
      name: 'fingerprint_login',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt đăng nhập`
  String get login_settings {
    return Intl.message(
      'Cài đặt đăng nhập',
      name: 'login_settings',
      desc: '',
      args: [],
    );
  }

  /// `Đổi mật khẩu`
  String get change_password {
    return Intl.message(
      'Đổi mật khẩu',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt cỡ chữ`
  String get font_size_setting {
    return Intl.message(
      'Cài đặt cỡ chữ',
      name: 'font_size_setting',
      desc: '',
      args: [],
    );
  }

  /// `Cỡ nhỏ`
  String get small_size {
    return Intl.message(
      'Cỡ nhỏ',
      name: 'small_size',
      desc: '',
      args: [],
    );
  }

  /// `Cỡ thường`
  String get regular_size {
    return Intl.message(
      'Cỡ thường',
      name: 'regular_size',
      desc: '',
      args: [],
    );
  }

  /// `Cỡ lớn`
  String get big_size {
    return Intl.message(
      'Cỡ lớn',
      name: 'big_size',
      desc: '',
      args: [],
    );
  }

  /// `Phiên bản`
  String get version {
    return Intl.message(
      'Phiên bản',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `© Bản quyền thuộc về Công ty cổ phần Bkav`
  String get copy_right {
    return Intl.message(
      '© Bản quyền thuộc về Công ty cổ phần Bkav',
      name: 'copy_right',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm theo Tên hồ sơ, Tên hồ sơ mẫu, Tên văn bản`
  String get label_search {
    return Intl.message(
      'Tìm kiếm theo Tên hồ sơ, Tên hồ sơ mẫu, Tên văn bản',
      name: 'label_search',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý`
  String get agree {
    return Intl.message(
      'Đồng ý',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Huỷ`
  String get cancel {
    return Intl.message(
      'Huỷ',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị chưa cài đặt Face ID`
  String get title_dialog_face_Id {
    return Intl.message(
      'Thiết bị chưa cài đặt Face ID',
      name: 'title_dialog_face_Id',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị chưa cài đặt Vân tay`
  String get title_dialog_fingerprint {
    return Intl.message(
      'Thiết bị chưa cài đặt Vân tay',
      name: 'title_dialog_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Để bật tính năng này, bạn vui lòng bấm vào nút Cài đặt và thiết lập Vân tay.`
  String get text_dialog_fingerprint {
    return Intl.message(
      'Để bật tính năng này, bạn vui lòng bấm vào nút Cài đặt và thiết lập Vân tay.',
      name: 'text_dialog_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Để bật tính năng này, bạn vui lòng bấm vào nút Cài đặt và thiết lập Face ID.`
  String get text_dialog_face_Id {
    return Intl.message(
      'Để bật tính năng này, bạn vui lòng bấm vào nút Cài đặt và thiết lập Face ID.',
      name: 'text_dialog_face_Id',
      desc: '',
      args: [],
    );
  }

  /// `Bạn muốn chuyển sang hình thức đăng nhập bằng Vân tay ?`
  String get title_dialog_fingerprint_transfer {
    return Intl.message(
      'Bạn muốn chuyển sang hình thức đăng nhập bằng Vân tay ?',
      name: 'title_dialog_fingerprint_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Bạn muốn chuyển sang hình thức đăng nhập bằng Face ID ?`
  String get title_dialog_face_Id_transfer {
    return Intl.message(
      'Bạn muốn chuyển sang hình thức đăng nhập bằng Face ID ?',
      name: 'title_dialog_face_Id_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Sử dụng tính năng đăng nhập vân tay giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.`
  String get text_dialog_fingerprint_transfer {
    return Intl.message(
      'Sử dụng tính năng đăng nhập vân tay giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.',
      name: 'text_dialog_fingerprint_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Sử dụng tính năng đăng nhập Face ID giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.`
  String get text_dialog_face_Id_transfer {
    return Intl.message(
      'Sử dụng tính năng đăng nhập Face ID giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.',
      name: 'text_dialog_face_Id_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Trống`
  String get empty {
    return Intl.message(
      'Trống',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get title_notification {
    return Intl.message(
      'Thông báo',
      name: 'title_notification',
      desc: '',
      args: [],
    );
  }

  /// `Tên hồ sơ`
  String get name_contract {
    return Intl.message(
      'Tên hồ sơ',
      name: 'name_contract',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian`
  String get time_sign {
    return Intl.message(
      'Thời gian',
      name: 'time_sign',
      desc: '',
      args: [],
    );
  }

  /// `Không có kết nối internet`
  String get title_no_internet {
    return Intl.message(
      'Không có kết nối internet',
      name: 'title_no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng kiểm tra lại`
  String get content_dialog_no_internet {
    return Intl.message(
      'Bạn vui lòng kiểm tra lại',
      name: 'content_dialog_no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Xảy ra sự cố khi tải nội dung`
  String get title_dialog_loss_internet {
    return Intl.message(
      'Xảy ra sự cố khi tải nội dung',
      name: 'title_dialog_loss_internet',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng kiểm tra kết nối internet.`
  String get content_dialog_loss_internet {
    return Intl.message(
      'Bạn vui lòng kiểm tra kết nối internet.',
      name: 'content_dialog_loss_internet',
      desc: '',
      args: [],
    );
  }

  /// `Đóng`
  String get close_dialog {
    return Intl.message(
      'Đóng',
      name: 'close_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get action_dialog_internet {
    return Intl.message(
      'Thử lại',
      name: 'action_dialog_internet',
      desc: '',
      args: [],
    );
  }

  /// `Xác thực OTP`
  String get title_sign_otp {
    return Intl.message(
      'Xác thực OTP',
      name: 'title_sign_otp',
      desc: '',
      args: [],
    );
  }

  /// `Quý khách vui lòng nhập mã OTP được gửi về số điện thoại sđt để xác nhận đồng ý với`
  String get content_input_otp {
    return Intl.message(
      'Quý khách vui lòng nhập mã OTP được gửi về số điện thoại sđt để xác nhận đồng ý với',
      name: 'content_input_otp',
      desc: '',
      args: [],
    );
  }

  /// `Gửi lại OTP`
  String get resend_otp {
    return Intl.message(
      'Gửi lại OTP',
      name: 'resend_otp',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt đăng nhập vân tay thành công !`
  String get complete_dialog {
    return Intl.message(
      'Cài đặt đăng nhập vân tay thành công !',
      name: 'complete_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã ký thành công Hồ sơ`
  String get sign_success {
    return Intl.message(
      'Bạn đã ký thành công Hồ sơ',
      name: 'sign_success',
      desc: '',
      args: [],
    );
  }

  /// `Đối tượng ký`
  String get sign_party {
    return Intl.message(
      'Đối tượng ký',
      name: 'sign_party',
      desc: '',
      args: [],
    );
  }

  /// `Mã OTP đã nhập otp không đúng. Bạn vui lòng kiểm tra lại tin nhắn mới nhất từ eContract và nhập lại đúng 6 chữ số của Mã OTP trong tin nhắn này`
  String get notifi_error_otp {
    return Intl.message(
      'Mã OTP đã nhập otp không đúng. Bạn vui lòng kiểm tra lại tin nhắn mới nhất từ eContract và nhập lại đúng 6 chữ số của Mã OTP trong tin nhắn này',
      name: 'notifi_error_otp',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian trên Điện thoại không đúng với thời gian thực tế`
  String get title_different_time {
    return Intl.message(
      'Thời gian trên Điện thoại không đúng với thời gian thực tế',
      name: 'title_different_time',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng kiểm tra lại.`
  String get content_different_time {
    return Intl.message(
      'Bạn vui lòng kiểm tra lại.',
      name: 'content_different_time',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống không hỗ trợ ký bằng USB Token trên điện thoại. Bạn vui lòng ký Hồ sơ trên máy tính.`
  String get content_no_support_usb_token_sign {
    return Intl.message(
      'Hệ thống không hỗ trợ ký bằng USB Token trên điện thoại. Bạn vui lòng ký Hồ sơ trên máy tính.',
      name: 'content_no_support_usb_token_sign',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có một yêu cầu ký Hồ sơ từ`
  String get have_a_request_to_sign {
    return Intl.message(
      'Bạn có một yêu cầu ký Hồ sơ từ',
      name: 'have_a_request_to_sign',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa thực hiện ký Hồ sơ với`
  String get you_have_not_signed {
    return Intl.message(
      'Bạn chưa thực hiện ký Hồ sơ với',
      name: 'you_have_not_signed',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã ký thành công Hồ sơ với`
  String get successfully_signed {
    return Intl.message(
      'Bạn đã ký thành công Hồ sơ với',
      name: 'successfully_signed',
      desc: '',
      args: [],
    );
  }

  /// `Vân tay không trùng khớp`
  String get error_dialog_fingerprint {
    return Intl.message(
      'Vân tay không trùng khớp',
      name: 'error_dialog_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã đăng nhập Vân tay sai quá số lần quy định. Vui lòng nhập bằng Tên đăng nhập và Mật khẩu !`
  String get error_title_fingerprint {
    return Intl.message(
      'Bạn đã đăng nhập Vân tay sai quá số lần quy định. Vui lòng nhập bằng Tên đăng nhập và Mật khẩu !',
      name: 'error_title_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã đăng nhập Face ID sai quá số lần quy định. Vui lòng nhập bằng Tên đăng nhập và Mật khẩu !`
  String get error_title_face_id {
    return Intl.message(
      'Bạn đã đăng nhập Face ID sai quá số lần quy định. Vui lòng nhập bằng Tên đăng nhập và Mật khẩu !',
      name: 'error_title_face_id',
      desc: '',
      args: [],
    );
  }

  /// `Đang tải tệp xuống...`
  String get downloading {
    return Intl.message(
      'Đang tải tệp xuống...',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Tính năng nhận thông báo từ ứng dụng eContract đang tắt`
  String get title_request_permisson_notification {
    return Intl.message(
      'Tính năng nhận thông báo từ ứng dụng eContract đang tắt',
      name: 'title_request_permisson_notification',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng bật tính năng để nhận được các thông báo từ eContract.`
  String get content_request_permission_notification {
    return Intl.message(
      'Bạn vui lòng bật tính năng để nhận được các thông báo từ eContract.',
      name: 'content_request_permission_notification',
      desc: '',
      args: [],
    );
  }

  /// `Bật thông báo`
  String get button_enable_permisson_notificaiton {
    return Intl.message(
      'Bật thông báo',
      name: 'button_enable_permisson_notificaiton',
      desc: '',
      args: [],
    );
  }

  /// `Hủy bỏ`
  String get cancel_download {
    return Intl.message(
      'Hủy bỏ',
      name: 'cancel_download',
      desc: '',
      args: [],
    );
  }

  /// `Tải xuống hoàn tất`
  String get download_complete {
    return Intl.message(
      'Tải xuống hoàn tất',
      name: 'download_complete',
      desc: '',
      args: [],
    );
  }

  /// `Tải file không thành công.`
  String get download_error {
    return Intl.message(
      'Tải file không thành công.',
      name: 'download_error',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng xác nhận mật khẩu để đăng nhập ứng dụng ( lưu ý: quý khách có thể sử dụng vân tay/ khuôn mặt/ hình vẽ/ mật mã đã đăng ký thành công trên thiết bị) `
  String get title_dialog_touch_id {
    return Intl.message(
      'Vui lòng xác nhận mật khẩu để đăng nhập ứng dụng ( lưu ý: quý khách có thể sử dụng vân tay/ khuôn mặt/ hình vẽ/ mật mã đã đăng ký thành công trên thiết bị) ',
      name: 'title_dialog_touch_id',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu hiện tại`
  String get pass_current {
    return Intl.message(
      'Mật khẩu hiện tại',
      name: 'pass_current',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới`
  String get pass_new {
    return Intl.message(
      'Mật khẩu mới',
      name: 'pass_new',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lại mật khẩu mới`
  String get confirm_pass_new {
    return Intl.message(
      'Nhập lại mật khẩu mới',
      name: 'confirm_pass_new',
      desc: '',
      args: [],
    );
  }

  /// `Lưu ý: Mật khẩu phải thỏa mãn đủ 3 điều kiện sau:<br>  - Phải có độ dài từ <b>8 ký tự trở lên</b><br> - <b>Không chứa khoảng trắng, không chứa Tên đăng nhập</b><br> - <b>Chứa 3 trong 4 kiểu ký tự </b>(a – z, A – Z, 0 – 9, !@#$%^&*)<br>   &nbsp;&nbsp;Ví dụ: Bkav0722, eCon@tract`
  String get note_change_password {
    return Intl.message(
      'Lưu ý: Mật khẩu phải thỏa mãn đủ 3 điều kiện sau:<br>  - Phải có độ dài từ <b>8 ký tự trở lên</b><br> - <b>Không chứa khoảng trắng, không chứa Tên đăng nhập</b><br> - <b>Chứa 3 trong 4 kiểu ký tự </b>(a – z, A – Z, 0 – 9, !@#\$%^&*)<br>   &nbsp;&nbsp;Ví dụ: Bkav0722, eCon@tract',
      name: 'note_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không được để trống.`
  String get pass_empty {
    return Intl.message(
      'Mật khẩu không được để trống.',
      name: 'pass_empty',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không đúng.`
  String get pass_wrong {
    return Intl.message(
      'Mật khẩu không đúng.',
      name: 'pass_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới không được trùng với mật khẩu hiện tại.`
  String get pass_duplicate {
    return Intl.message(
      'Mật khẩu mới không được trùng với mật khẩu hiện tại.',
      name: 'pass_duplicate',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không đúng định dạng.`
  String get pass_format_wrong {
    return Intl.message(
      'Mật khẩu không đúng định dạng.',
      name: 'pass_format_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không khớp với mật khẩu mới.`
  String get pass_not_same_new_pass {
    return Intl.message(
      'Mật khẩu không khớp với mật khẩu mới.',
      name: 'pass_not_same_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận mật khẩu thiết bị`
  String get fingerprint_authentication {
    return Intl.message(
      'Xác nhận mật khẩu thiết bị',
      name: 'fingerprint_authentication',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng đăng nhập lại ứng dụng`
  String get change_pass_success {
    return Intl.message(
      'Bạn vui lòng đăng nhập lại ứng dụng',
      name: 'change_pass_success',
      desc: '',
      args: [],
    );
  }

  /// `Vân tay không còn hiệu lực. Vui lòng nhập Tên đăng nhập và Mật khẩu `
  String get fingerprint_error {
    return Intl.message(
      'Vân tay không còn hiệu lực. Vui lòng nhập Tên đăng nhập và Mật khẩu ',
      name: 'fingerprint_error',
      desc: '',
      args: [],
    );
  }

  /// `FaceId không còn hiệu lực. Vui lòng nhập Tên đăng nhập và Mật khẩu `
  String get face_id_error {
    return Intl.message(
      'FaceId không còn hiệu lực. Vui lòng nhập Tên đăng nhập và Mật khẩu ',
      name: 'face_id_error',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải có độ dài từ 8 ký tự trở lên`
  String get error_pass_length {
    return Intl.message(
      'Mật khẩu phải có độ dài từ 8 ký tự trở lên',
      name: 'error_pass_length',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không chứa khoảng trắng, không chứa Tên đăng nhập`
  String get error_pass_contain_space_info {
    return Intl.message(
      'Mật khẩu không chứa khoảng trắng, không chứa Tên đăng nhập',
      name: 'error_pass_contain_space_info',
      desc: '',
      args: [],
    );
  }

  /// `Hỗ trợ`
  String get support {
    return Intl.message(
      'Hỗ trợ',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Gửi nhật ký ứng dụng`
  String get title_log_app_page {
    return Intl.message(
      'Gửi nhật ký ứng dụng',
      name: 'title_log_app_page',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có thể gửi nhật ký ứng dụng lên máy chủ để quản trị kiểm tra và xử lý sự cố`
  String get text_log_app {
    return Intl.message(
      'Bạn có thể gửi nhật ký ứng dụng lên máy chủ để quản trị kiểm tra và xử lý sự cố',
      name: 'text_log_app',
      desc: '',
      args: [],
    );
  }

  /// `Gửi nhật ký`
  String get send_log {
    return Intl.message(
      'Gửi nhật ký',
      name: 'send_log',
      desc: '',
      args: [],
    );
  }

  /// `View log`
  String get view_log {
    return Intl.message(
      'View log',
      name: 'view_log',
      desc: '',
      args: [],
    );
  }

  /// `Log Lỗi`
  String get log_bug {
    return Intl.message(
      'Log Lỗi',
      name: 'log_bug',
      desc: '',
      args: [],
    );
  }

  /// `Log Activity`
  String get log_activity {
    return Intl.message(
      'Log Activity',
      name: 'log_activity',
      desc: '',
      args: [],
    );
  }

  /// `Khác`
  String get log_other {
    return Intl.message(
      'Khác',
      name: 'log_other',
      desc: '',
      args: [],
    );
  }

  /// `Chia sẻ địa chỉ trang ký Hồ sơ`
  String get share_link_sign_contract {
    return Intl.message(
      'Chia sẻ địa chỉ trang ký Hồ sơ',
      name: 'share_link_sign_contract',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất thành công !`
  String get logout_message {
    return Intl.message(
      'Đăng xuất thành công !',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống tạm thời bị gián đoạn. Xin vui lòng trở lại sau hoặc thông báo với ban quản trị để được hỗ trợ`
  String get error_500_message {
    return Intl.message(
      'Hệ thống tạm thời bị gián đoạn. Xin vui lòng trở lại sau hoặc thông báo với ban quản trị để được hỗ trợ',
      name: 'error_500_message',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống xảy ra lỗi. Xin vui lòng trở lại sau hoặc thông báo với ban quản trị`
  String get error_200_message {
    return Intl.message(
      'Hệ thống xảy ra lỗi. Xin vui lòng trở lại sau hoặc thông báo với ban quản trị',
      name: 'error_200_message',
      desc: '',
      args: [],
    );
  }

  /// `Hết hạn phiên đăng nhập.`
  String get exp_session_message {
    return Intl.message(
      'Hết hạn phiên đăng nhập.',
      name: 'exp_session_message',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập lại`
  String get re_login {
    return Intl.message(
      'Đăng nhập lại',
      name: 're_login',
      desc: '',
      args: [],
    );
  }

  /// `Gửi nhật ký ứng dụng`
  String get send_log_setting {
    return Intl.message(
      'Gửi nhật ký ứng dụng',
      name: 'send_log_setting',
      desc: '',
      args: [],
    );
  }

  /// `Đã gửi thành công nhật ký lên máy chủ`
  String get content_send_log_complete {
    return Intl.message(
      'Đã gửi thành công nhật ký lên máy chủ',
      name: 'content_send_log_complete',
      desc: '',
      args: [],
    );
  }

  /// `Gửi Email hỗ trợ: `
  String get send_support_email {
    return Intl.message(
      'Gửi Email hỗ trợ: ',
      name: 'send_support_email',
      desc: '',
      args: [],
    );
  }

  /// `Gọi tư vấn dịch vụ: `
  String get call_service_consultation {
    return Intl.message(
      'Gọi tư vấn dịch vụ: ',
      name: 'call_service_consultation',
      desc: '',
      args: [],
    );
  }

  /// `Gọi hỗ trợ kỹ thuật: `
  String get call_technical_support {
    return Intl.message(
      'Gọi hỗ trợ kỹ thuật: ',
      name: 'call_technical_support',
      desc: '',
      args: [],
    );
  }

  /// `Chat với nhân viên hỗ trợ qua Zalo`
  String get support_zalo {
    return Intl.message(
      'Chat với nhân viên hỗ trợ qua Zalo',
      name: 'support_zalo',
      desc: '',
      args: [],
    );
  }

  /// `Chat với nhân viên hỗ trợ qua Messenger`
  String get support_messenger {
    return Intl.message(
      'Chat với nhân viên hỗ trợ qua Messenger',
      name: 'support_messenger',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị đã thay đổi cài đặt Face ID !`
  String get change_face {
    return Intl.message(
      'Thiết bị đã thay đổi cài đặt Face ID !',
      name: 'change_face',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị đã thay đổi cài đặt Vân tay !`
  String get change_touch {
    return Intl.message(
      'Thiết bị đã thay đổi cài đặt Vân tay !',
      name: 'change_touch',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng đăng nhập ứng dụng bằng Mật khẩu và sử dụng chức năng <b>Cài đặt Face ID</b> để kích hoạt tính năng này.`
  String get change_face_title {
    return Intl.message(
      'Bạn vui lòng đăng nhập ứng dụng bằng Mật khẩu và sử dụng chức năng <b>Cài đặt Face ID</b> để kích hoạt tính năng này.',
      name: 'change_face_title',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng đăng nhập ứng dụng bằng <b>Mật khẩu</b> và sử dụng chức năng <b>Cài đặt Vân tay</b> để kích hoạt tính năng này.`
  String get change_touch_title {
    return Intl.message(
      'Bạn vui lòng đăng nhập ứng dụng bằng <b>Mật khẩu</b> và sử dụng chức năng <b>Cài đặt Vân tay</b> để kích hoạt tính năng này.',
      name: 'change_touch_title',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký CKS`
  String get register_cks {
    return Intl.message(
      'Đăng ký CKS',
      name: 'register_cks',
      desc: '',
      args: [],
    );
  }

  /// `Gia hạn CKS`
  String get extend_cks {
    return Intl.message(
      'Gia hạn CKS',
      name: 'extend_cks',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng chọn Đơn vị để đăng nhập hệ thống`
  String get login_unit {
    return Intl.message(
      'Bạn vui lòng chọn Đơn vị để đăng nhập hệ thống',
      name: 'login_unit',
      desc: '',
      args: [],
    );
  }

  /// `Chọn Đơn vị`
  String get list_unit {
    return Intl.message(
      'Chọn Đơn vị',
      name: 'list_unit',
      desc: '',
      args: [],
    );
  }

  /// `Sử dụng tài khoản khác`
  String get add_user {
    return Intl.message(
      'Sử dụng tài khoản khác',
      name: 'add_user',
      desc: '',
      args: [],
    );
  }

  /// `Đặt mua`
  String get buy {
    return Intl.message(
      'Đặt mua',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có tài khoản?`
  String get no_user {
    return Intl.message(
      'Bạn chưa có tài khoản?',
      name: 'no_user',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vị`
  String get unit {
    return Intl.message(
      'Đơn vị',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Hình thức ký`
  String get sign_form {
    return Intl.message(
      'Hình thức ký',
      name: 'sign_form',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng chọn Hình thức ký Hồ sơ dưới đây:`
  String get sign_form_select {
    return Intl.message(
      'Bạn vui lòng chọn Hình thức ký Hồ sơ dưới đây:',
      name: 'sign_form_select',
      desc: '',
      args: [],
    );
  }

  /// `Chưa thực hiện ký số trên ứng dụng Bkav Remote Signing !`
  String get remote_sign_cancel {
    return Intl.message(
      'Chưa thực hiện ký số trên ứng dụng Bkav Remote Signing !',
      name: 'remote_sign_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Hết hạn phiên ký trên ứng dụng Bkav Remote Signing !`
  String get remote_sign_exp {
    return Intl.message(
      'Hết hạn phiên ký trên ứng dụng Bkav Remote Signing !',
      name: 'remote_sign_exp',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng bấm <b>Ký lại</b> để thực hiện ký Hồ sơ`
  String get remote_sign_content {
    return Intl.message(
      'Bạn vui lòng bấm <b>Ký lại</b> để thực hiện ký Hồ sơ',
      name: 'remote_sign_content',
      desc: '',
      args: [],
    );
  }

  /// `Ký lại`
  String get resign {
    return Intl.message(
      'Ký lại',
      name: 'resign',
      desc: '',
      args: [],
    );
  }

  /// `Hướng dẫn ký số trên ứng dụng\nBkav Remote Signing`
  String get remote_guide {
    return Intl.message(
      'Hướng dẫn ký số trên ứng dụng\nBkav Remote Signing',
      name: 'remote_guide',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu ký số đã được gửi đến thiết bị di động của bạn.<br>Vui lòng mở ứng dụng <b>Bkav Remote Signing</b>, chọn mục <b>Xác thực giao dịch</b> và bấm <b>Đồng ý</b> để ký số.<br><br>Thời gian ký số còn lại:`
  String get remote_guide_content {
    return Intl.message(
      'Yêu cầu ký số đã được gửi đến thiết bị di động của bạn.<br>Vui lòng mở ứng dụng <b>Bkav Remote Signing</b>, chọn mục <b>Xác thực giao dịch</b> và bấm <b>Đồng ý</b> để ký số.<br><br>Thời gian ký số còn lại:',
      name: 'remote_guide_content',
      desc: '',
      args: [],
    );
  }

  /// `Huỷ yêu cầu ký số`
  String get cancel_sign_remote_signing {
    return Intl.message(
      'Huỷ yêu cầu ký số',
      name: 'cancel_sign_remote_signing',
      desc: '',
      args: [],
    );
  }

  /// `giây`
  String get second {
    return Intl.message(
      'giây',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `phút`
  String get minute {
    return Intl.message(
      'phút',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục`
  String get continue_sign {
    return Intl.message(
      'Tiếp tục',
      name: 'continue_sign',
      desc: '',
      args: [],
    );
  }

  /// `------------------------Log Error -------------------\n`
  String get log_error_string {
    return Intl.message(
      '------------------------Log Error -------------------\n',
      name: 'log_error_string',
      desc: '',
      args: [],
    );
  }

  /// `------------------------Log Other -------------------\n`
  String get log_other_string {
    return Intl.message(
      '------------------------Log Other -------------------\n',
      name: 'log_other_string',
      desc: '',
      args: [],
    );
  }

  /// `Bạn không thể ký Hồ sơ này do đã hết hạn từ `
  String get status_expired {
    return Intl.message(
      'Bạn không thể ký Hồ sơ này do đã hết hạn từ ',
      name: 'status_expired',
      desc: '',
      args: [],
    );
  }

  /// `Đổi mật khẩu thành công`
  String get change_pass_success_title {
    return Intl.message(
      'Đổi mật khẩu thành công',
      name: 'change_pass_success_title',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối ký thành công !`
  String get not_agree_sign {
    return Intl.message(
      'Từ chối ký thành công !',
      name: 'not_agree_sign',
      desc: '',
      args: [],
    );
  }

  /// `Lý do từ chối không được để trống`
  String get not_agree_null {
    return Intl.message(
      'Lý do từ chối không được để trống',
      name: 'not_agree_null',
      desc: '',
      args: [],
    );
  }

  /// `Số ký tự nhập tối thiểu là 5`
  String get not_agree_length_5 {
    return Intl.message(
      'Số ký tự nhập tối thiểu là 5',
      name: 'not_agree_length_5',
      desc: '',
      args: [],
    );
  }

  /// `Số ký tự nhập tối đa là 500`
  String get not_agree_length_500 {
    return Intl.message(
      'Số ký tự nhập tối đa là 500',
      name: 'not_agree_length_500',
      desc: '',
      args: [],
    );
  }

  /// `Lý do từ chối không hợp lệ`
  String get not_agree_illegal {
    return Intl.message(
      'Lý do từ chối không hợp lệ',
      name: 'not_agree_illegal',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật mã để đăng nhập ứng dụng`
  String get title_dialog_face_id {
    return Intl.message(
      'Vui lòng nhập mật mã để đăng nhập ứng dụng',
      name: 'title_dialog_face_id',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

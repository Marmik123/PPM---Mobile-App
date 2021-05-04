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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in to`
  String get signIn {
    return Intl.message(
      'Sign in to',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `PPM`
  String get home {
    return Intl.message(
      'PPM',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Code`
  String get otp {
    return Intl.message(
      'Enter Your Code',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// `Enter a Phone No.`
  String get hint {
    return Intl.message(
      'Enter a Phone No.',
      name: 'hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid mobile number`
  String get valid {
    return Intl.message(
      'Please enter a valid mobile number',
      name: 'valid',
      desc: '',
      args: [],
    );
  }

  /// `please enter Otp`
  String get otpError {
    return Intl.message(
      'please enter Otp',
      name: 'otpError',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid Otp`
  String get otpValid {
    return Intl.message(
      'Enter valid Otp',
      name: 'otpValid',
      desc: '',
      args: [],
    );
  }

  /// `FeedBack`
  String get feedback {
    return Intl.message(
      'FeedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get Subject {
    return Intl.message(
      'Subject',
      name: 'Subject',
      desc: '',
      args: [],
    );
  }

  /// `Enter Feedback`
  String get hintF {
    return Intl.message(
      'Enter Feedback',
      name: 'hintF',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Enter the name`
  String get enterN {
    return Intl.message(
      'Enter the name',
      name: 'enterN',
      desc: '',
      args: [],
    );
  }

  /// `Pincode`
  String get pincode {
    return Intl.message(
      'Pincode',
      name: 'pincode',
      desc: '',
      args: [],
    );
  }

  /// `Surat`
  String get surat {
    return Intl.message(
      'Surat',
      name: 'surat',
      desc: '',
      args: [],
    );
  }

  /// `Gujarat`
  String get Gujarat {
    return Intl.message(
      'Gujarat',
      name: 'Gujarat',
      desc: '',
      args: [],
    );
  }

  /// ` Client Name :`
  String get clientN {
    return Intl.message(
      ' Client Name :',
      name: 'clientN',
      desc: '',
      args: [],
    );
  }

  /// `Client Shop Name :`
  String get clientShopN {
    return Intl.message(
      'Client Shop Name :',
      name: 'clientShopN',
      desc: '',
      args: [],
    );
  }

  /// `Client Number : `
  String get clientNo {
    return Intl.message(
      'Client Number : ',
      name: 'clientNo',
      desc: '',
      args: [],
    );
  }

  /// `Clients Registered`
  String get clientReg {
    return Intl.message(
      'Clients Registered',
      name: 'clientReg',
      desc: '',
      args: [],
    );
  }

  /// `Ad Description :`
  String get adDescrip {
    return Intl.message(
      'Ad Description :',
      name: 'adDescrip',
      desc: '',
      args: [],
    );
  }

  /// `Ad Name :`
  String get adN {
    return Intl.message(
      'Ad Name :',
      name: 'adN',
      desc: '',
      args: [],
    );
  }

  /// `GST Number`
  String get gstNo {
    return Intl.message(
      'GST Number',
      name: 'gstNo',
      desc: '',
      args: [],
    );
  }

  /// `Regular GST`
  String get regGst {
    return Intl.message(
      'Regular GST',
      name: 'regGst',
      desc: '',
      args: [],
    );
  }

  /// `Without GST`
  String get woGst {
    return Intl.message(
      'Without GST',
      name: 'woGst',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change {
    return Intl.message(
      'Change Language',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Change Name`
  String get changeN {
    return Intl.message(
      'Change Name',
      name: 'changeN',
      desc: '',
      args: [],
    );
  }

  /// `Change Mobile Number`
  String get changeMob {
    return Intl.message(
      'Change Mobile Number',
      name: 'changeMob',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get Support {
    return Intl.message(
      'Support',
      name: 'Support',
      desc: '',
      args: [],
    );
  }

  /// `Composition GST`
  String get compGst {
    return Intl.message(
      'Composition GST',
      name: 'compGst',
      desc: '',
      args: [],
    );
  }

  /// `Enter Type of GST`
  String get gstType {
    return Intl.message(
      'Enter Type of GST',
      name: 'gstType',
      desc: '',
      args: [],
    );
  }

  /// `Payment Received`
  String get paymentR {
    return Intl.message(
      'Payment Received',
      name: 'paymentR',
      desc: '',
      args: [],
    );
  }

  /// `Enter Ad Photo`
  String get adPhoto {
    return Intl.message(
      'Enter Ad Photo',
      name: 'adPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Enter Ad Description`
  String get adDesc {
    return Intl.message(
      'Enter Ad Description',
      name: 'adDesc',
      desc: '',
      args: [],
    );
  }

  /// `Support Details`
  String get SupporD {
    return Intl.message(
      'Support Details',
      name: 'SupporD',
      desc: '',
      args: [],
    );
  }

  /// `Register Advertisement`
  String get registerAd {
    return Intl.message(
      'Register Advertisement',
      name: 'registerAd',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Gujarati`
  String get Gujarati {
    return Intl.message(
      'Gujarati',
      name: 'Gujarati',
      desc: '',
      args: [],
    );
  }

  /// `Hindi`
  String get Hindi {
    return Intl.message(
      'Hindi',
      name: 'Hindi',
      desc: '',
      args: [],
    );
  }

  /// `Home Screen`
  String get HomeScreen {
    return Intl.message(
      'Home Screen',
      name: 'HomeScreen',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get warning {
    return Intl.message(
      'Something went wrong',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Great, All Done!`
  String get complete {
    return Intl.message(
      'Great, All Done!',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `No more orders are there for Delivery`
  String get info {
    return Intl.message(
      'No more orders are there for Delivery',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Clients Registered`
  String get register {
    return Intl.message(
      'Clients Registered',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get Add {
    return Intl.message(
      'Add',
      name: 'Add',
      desc: '',
      args: [],
    );
  }

  /// `Register Client`
  String get client {
    return Intl.message(
      'Register Client',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Shop Name`
  String get sName {
    return Intl.message(
      'Shop Name',
      name: 'sName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get errorName {
    return Intl.message(
      'Enter Name',
      name: 'errorName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Number`
  String get errorNum {
    return Intl.message(
      'Enter Number',
      name: 'errorNum',
      desc: '',
      args: [],
    );
  }

  /// `Enter Shop Name`
  String get errorS {
    return Intl.message(
      'Enter Shop Name',
      name: 'errorS',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get Number {
    return Intl.message(
      'Number',
      name: 'Number',
      desc: '',
      args: [],
    );
  }

  /// `Enter Type of Store`
  String get type {
    return Intl.message(
      'Enter Type of Store',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Stationary`
  String get stat {
    return Intl.message(
      'Stationary',
      name: 'stat',
      desc: '',
      args: [],
    );
  }

  /// `Medical`
  String get Medical {
    return Intl.message(
      'Medical',
      name: 'Medical',
      desc: '',
      args: [],
    );
  }

  /// `Provision`
  String get Provision {
    return Intl.message(
      'Provision',
      name: 'Provision',
      desc: '',
      args: [],
    );
  }

  /// `Vegetable`
  String get Vegetable {
    return Intl.message(
      'Vegetable',
      name: 'Vegetable',
      desc: '',
      args: [],
    );
  }

  /// `Dairy`
  String get Dairy {
    return Intl.message(
      'Dairy',
      name: 'Dairy',
      desc: '',
      args: [],
    );
  }

  /// `Kirana`
  String get Kirana {
    return Intl.message(
      'Kirana',
      name: 'Kirana',
      desc: '',
      args: [],
    );
  }

  /// `Shop photo`
  String get photo {
    return Intl.message(
      'Shop photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 1`
  String get AddressL {
    return Intl.message(
      'Address Line 1',
      name: 'AddressL',
      desc: '',
      args: [],
    );
  }

  /// `Landmark`
  String get Landmark {
    return Intl.message(
      'Landmark',
      name: 'Landmark',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get City {
    return Intl.message(
      'City',
      name: 'City',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get State {
    return Intl.message(
      'State',
      name: 'State',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get Delivered {
    return Intl.message(
      'Delivered',
      name: 'Delivered',
      desc: '',
      args: [],
    );
  }

  /// `Customer Contact No.`
  String get contact {
    return Intl.message(
      'Customer Contact No.',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Customer Address`
  String get customerAdd {
    return Intl.message(
      'Customer Address',
      name: 'customerAdd',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name`
  String get customerN {
    return Intl.message(
      'Customer Name',
      name: 'customerN',
      desc: '',
      args: [],
    );
  }

  /// `Payment option`
  String get payment {
    return Intl.message(
      'Payment option',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get price {
    return Intl.message(
      'Total Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `DeliveryId`
  String get delId {
    return Intl.message(
      'DeliveryId',
      name: 'delId',
      desc: '',
      args: [],
    );
  }

  /// `Size :`
  String get Size {
    return Intl.message(
      'Size :',
      name: 'Size',
      desc: '',
      args: [],
    );
  }

  /// `Order Total`
  String get orderTotal {
    return Intl.message(
      'Order Total',
      name: 'orderTotal',
      desc: '',
      args: [],
    );
  }

  /// `Cash on Delivery`
  String get cod {
    return Intl.message(
      'Cash on Delivery',
      name: 'cod',
      desc: '',
      args: [],
    );
  }

  /// `Online Payment`
  String get onlineP {
    return Intl.message(
      'Online Payment',
      name: 'onlineP',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card`
  String get cardC {
    return Intl.message(
      'Credit Card',
      name: 'cardC',
      desc: '',
      args: [],
    );
  }

  /// `Debit Card`
  String get cardD {
    return Intl.message(
      'Debit Card',
      name: 'cardD',
      desc: '',
      args: [],
    );
  }

  /// `Price :`
  String get priceT {
    return Intl.message(
      'Price :',
      name: 'priceT',
      desc: '',
      args: [],
    );
  }

  /// `Total Order`
  String get TotalOrder {
    return Intl.message(
      'Total Order',
      name: 'TotalOrder',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing`
  String get Ongoing {
    return Intl.message(
      'Ongoing',
      name: 'Ongoing',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get History {
    return Intl.message(
      'History',
      name: 'History',
      desc: '',
      args: [],
    );
  }

  /// `Total : `
  String get Total {
    return Intl.message(
      'Total : ',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `Order Id:`
  String get OrderId {
    return Intl.message(
      'Order Id:',
      name: 'OrderId',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get error {
    return Intl.message(
      'Something went wrong',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `No Order Delivered Till Now`
  String get message {
    return Intl.message(
      'No Order Delivered Till Now',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Order Delivered`
  String get del {
    return Intl.message(
      'Order Delivered',
      name: 'del',
      desc: '',
      args: [],
    );
  }

  /// `Order Placed`
  String get placed {
    return Intl.message(
      'Order Placed',
      name: 'placed',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get hist {
    return Intl.message(
      'Order History',
      name: 'hist',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get Yes {
    return Intl.message(
      'Yes',
      name: 'Yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `Enter Mobile`
  String get entermob {
    return Intl.message(
      'Enter Mobile',
      name: 'entermob',
      desc: '',
      args: [],
    );
  }

  /// `Kg`
  String get kg {
    return Intl.message(
      'Kg',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid Mobile number`
  String get validmob {
    return Intl.message(
      'Enter valid Mobile number',
      name: 'validmob',
      desc: '',
      args: [],
    );
  }

  /// `Pieces`
  String get piece {
    return Intl.message(
      'Pieces',
      name: 'piece',
      desc: '',
      args: [],
    );
  }

  /// `Change Unit`
  String get unit {
    return Intl.message(
      'Change Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Select Size`
  String get size {
    return Intl.message(
      'Select Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Message`
  String get ReceiptMessage {
    return Intl.message(
      'Receipt Message',
      name: 'ReceiptMessage',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Receipt`
  String get PurchaseReceipt {
    return Intl.message(
      'Purchase Receipt',
      name: 'PurchaseReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Receipt`
  String get Receipt {
    return Intl.message(
      'Receipt',
      name: 'Receipt',
      desc: '',
      args: [],
    );
  }

  /// `New User ?`
  String get newUser {
    return Intl.message(
      'New User ?',
      name: 'newUser',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get Products {
    return Intl.message(
      'Products',
      name: 'Products',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get desc {
    return Intl.message(
      'Description:',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Large (L)`
  String get large {
    return Intl.message(
      'Large (L)',
      name: 'large',
      desc: '',
      args: [],
    );
  }

  /// `Medium (M)`
  String get medium {
    return Intl.message(
      'Medium (M)',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Small (S)`
  String get small {
    return Intl.message(
      'Small (S)',
      name: 'small',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get cartAdd {
    return Intl.message(
      'Add to Cart',
      name: 'cartAdd',
      desc: '',
      args: [],
    );
  }

  /// `Product Detail`
  String get detail {
    return Intl.message(
      'Product Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Choose Type of Product`
  String get typeP {
    return Intl.message(
      'Choose Type of Product',
      name: 'typeP',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get Verify {
    return Intl.message(
      'Verify',
      name: 'Verify',
      desc: '',
      args: [],
    );
  }

  /// `Send Otp`
  String get send {
    return Intl.message(
      'Send Otp',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `OrderTotal: `
  String get orderT {
    return Intl.message(
      'OrderTotal: ',
      name: 'orderT',
      desc: '',
      args: [],
    );
  }

  /// `UPI`
  String get UPI {
    return Intl.message(
      'UPI',
      name: 'UPI',
      desc: '',
      args: [],
    );
  }

  /// `Please add items`
  String get addI {
    return Intl.message(
      'Please add items',
      name: 'addI',
      desc: '',
      args: [],
    );
  }

  /// `Cart Is Empty`
  String get empty {
    return Intl.message(
      'Cart Is Empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeO {
    return Intl.message(
      'Place Order',
      name: 'placeO',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fees`
  String get fees {
    return Intl.message(
      'Delivery Fees',
      name: 'fees',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subT {
    return Intl.message(
      'Sub Total',
      name: 'subT',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get summary {
    return Intl.message(
      'Order Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get Change {
    return Intl.message(
      'Change',
      name: 'Change',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get my {
    return Intl.message(
      'My Cart',
      name: 'my',
      desc: '',
      args: [],
    );
  }

  /// `Deliver to `
  String get delTo {
    return Intl.message(
      'Deliver to ',
      name: 'delTo',
      desc: '',
      args: [],
    );
  }

  /// `Order Received`
  String get oRec {
    return Intl.message(
      'Order Received',
      name: 'oRec',
      desc: '',
      args: [],
    );
  }

  /// `Clear Cart`
  String get cart {
    return Intl.message(
      'Clear Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear cart ?`
  String get cartM {
    return Intl.message(
      'Are you sure you want to clear cart ?',
      name: 'cartM',
      desc: '',
      args: [],
    );
  }

  /// `Add a Customer Signature Here`
  String get signatureNote {
    return Intl.message(
      'Add a Customer Signature Here',
      name: 'signatureNote',
      desc: '',
      args: [],
    );
  }

  /// `Advertisements Registered`
  String get adsRegistered {
    return Intl.message(
      'Advertisements Registered',
      name: 'adsRegistered',
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
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
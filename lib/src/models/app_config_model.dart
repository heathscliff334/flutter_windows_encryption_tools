import 'dart:convert';

class AppConfig {
  String? appMinimumVersion;
  List<String>? captchaImages;
  String? cicoRadius;
  List<String>? debugNipAccess;
  List<String>? developerAccessId;
  List<String>? enableCaptchaUser;
  bool? isEnableCaptchaAllUser;
  bool? isNeedUpdate;
  AssetCacheConfig? assetCacheConfig;
  String? klamobileAutoLogin;
  String? isNewVersionAvailable;

  AppConfig(
      {this.appMinimumVersion,
      this.captchaImages,
      this.cicoRadius,
      this.debugNipAccess,
      this.developerAccessId,
      this.enableCaptchaUser,
      this.isEnableCaptchaAllUser,
      this.isNeedUpdate,
      this.assetCacheConfig,
      this.klamobileAutoLogin,
      this.isNewVersionAvailable});

  AppConfig.fromJson(Map<String, dynamic> json) {
    appMinimumVersion = json['appMinimumVersion'];
    captchaImages = json['captchaImages'].cast<String>();
    cicoRadius = json['cicoRadius'];
    debugNipAccess = json['debugNipAccess'].cast<String>();
    developerAccessId = json['developerAccessId'].cast<String>();
    enableCaptchaUser = json['enableCaptchaUser'].cast<String>();
    isEnableCaptchaAllUser = json['isEnableCaptchaAllUser'];
    isNeedUpdate = json['isNeedUpdate'];
    assetCacheConfig = json['assetCacheConfig'] != null
        ? AssetCacheConfig.fromJson(json['assetCacheConfig'])
        : null;
    klamobileAutoLogin = json['klamobileAutoLogin'];
    isNewVersionAvailable = json['isNewVersionAvailable'];
  }

  factory AppConfig.fromJsonString(String str) =>
      AppConfig.fromJson(jsonDecode(str));

  String toJsonString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appMinimumVersion'] = appMinimumVersion;
    data['captchaImages'] = captchaImages;
    data['cicoRadius'] = cicoRadius;
    data['debugNipAccess'] = debugNipAccess;
    data['developerAccessId'] = developerAccessId;
    data['enableCaptchaUser'] = enableCaptchaUser;
    data['isEnableCaptchaAllUser'] = isEnableCaptchaAllUser;
    data['isNeedUpdate'] = isNeedUpdate;
    if (assetCacheConfig != null) {
      data['assetCacheConfig'] = assetCacheConfig!.toJson();
    }
    data['klamobileAutoLogin'] = klamobileAutoLogin;
    data['isNewVersionAvailable'] = isNewVersionAvailable;
    return data;
  }
}

class AssetCacheConfig {
  int? captchaAssetLength;
  String? captchaFileName;
  String? captchaFileExtention;
  int? durationMinutes;
  int? durationHours;
  int? durationDays;
  int? configVersion;

  AssetCacheConfig(
      {this.captchaAssetLength,
      this.captchaFileName,
      this.captchaFileExtention,
      this.durationMinutes,
      this.durationHours,
      this.durationDays,
      this.configVersion});

  AssetCacheConfig.fromJson(Map<String, dynamic> json) {
    captchaAssetLength = json['captchaAssetLength'];
    captchaFileName = json['captchaFileName'];
    captchaFileExtention = json['captchaFileExtention'];
    durationMinutes = json['durationMinutes'];
    durationHours = json['durationHours'];
    durationDays = json['durationDays'];
    configVersion = json['configVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['captchaAssetLength'] = captchaAssetLength;
    data['captchaFileName'] = captchaFileName;
    data['captchaFileExtention'] = captchaFileExtention;
    data['durationMinutes'] = durationMinutes;
    data['durationHours'] = durationHours;
    data['durationDays'] = durationDays;
    data['configVersion'] = configVersion;
    return data;
  }
}

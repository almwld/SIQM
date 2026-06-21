import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconMapper {
  static Widget getIcon(String appName, {double size = 28}) {
    final iconPath = _getIconPath(appName);
    if (iconPath != null) {
      return SvgPicture.asset(
        iconPath,
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      );
    }
    return Icon(_getFallbackIcon(appName), size: size, color: const Color(0xFF00BCD4));
  }

  static String? _getIconPath(String appName) {
    // خريطة ربط الأسماء بالملفات
    final Map<String, String> iconMap = {
      // الأدوات الأساسية
      "TERMINAL": "zion_terminal.svg",
      "FILE MANAGER": "zion_filemgr.svg",
      "BROWSER": "zion_browser.svg",
      "SETTINGS": "zion_pattern.svg",
      "CALCULATOR": "zion_calc.svg",
      "NOTES": "zion_notes.svg",
      "WEATHER": "zion_weather.svg",
      "MAPS": "zion_maps.svg",
      "RADIO": "zion_radio.svg",
      "EMAIL": "zion_email.svg",
      "GALLERY": "zion_gallery.svg",
      "VIDEO": "zion_video.svg",
      "CLOCK": "zion_clock.svg",
      "CALENDAR": "zion_calendar.svg",
      "QR CODE": "zion_qr.svg",
      "DOCUMENTS": "zion_pdf.svg",
      "BACKUP": "zion_backup.svg",
      "CLEANER": "zion_cleaner.svg",
      "APP LOCK": "zion_applock.svg",
      "NOTIFY": "zion_pattern.svg",
      
      // الهجوم (Attack)
      "WIFI": "zion_wifi.svg",
      "EXPLOIT": "zion_exploitdb.svg",
      "CRACKER": "zion_cracker.svg",
      "DDOS": "zion_ddos.svg",
      "DATABASE": "zion_sqli.svg",
      "CLOUD": "zion_pattern.svg",
      
      // الدفاع (Defense)
      "STEALTH": "zion_stealth.svg",
      "CRYPTO": "zion_encryptor.svg",
      "BATTERY": "zion_battery.svg",
      
      // التحليل (Analysis)
      "NETWORK": "zion_netscan.svg",
      "FORENSICS": "zion_sysmon.svg",
      "TEXT ANALYZER": "zion_ai_analyzer.svg",
      
      // المحولات والحاسبات
      "UNIT CONV": "zion_pattern.svg",
      "PERCENT": "zion_pattern.svg",
      "DATE CALC": "zion_pattern.svg",
      "CURRENCY": "zion_currency.svg",
      "TRANSLATOR": "zion_translator.svg",
      
      // المراكز (Hubs)
      "SECURITY HUB": "zion_firewall.svg",
      "TOOLS HUB": "zion_pattern.svg",
      "PERF HUB": "zion_performance.svg",
      "DATA HUB": "zion_disk.svg",
      "NET HUB": "zion_netmon.svg",
      "PRIV HUB": "zion_privacy.svg",
      "AUTO HUB": "zion_pattern.svg",
    };

    final fileName = iconMap[appName];
    if (fileName != null) {
      return "assets/icons/svg_colors/$fileName";
    }
    return null;
  }

  static IconData _getFallbackIcon(String appName) {
    switch (appName) {
      case "TERMINAL": return Icons.terminal;
      case "FILE MANAGER": return Icons.folder;
      case "BROWSER": return Icons.public;
      case "SETTINGS": return Icons.settings;
      case "CALCULATOR": return Icons.calculate;
      case "NOTES": return Icons.note;
      case "WEATHER": return Icons.wb_sunny;
      case "MAPS": return Icons.map;
      case "RADIO": return Icons.radio;
      case "EMAIL": return Icons.email;
      case "GALLERY": return Icons.photo_library;
      case "VIDEO": return Icons.play_circle_filled;
      case "CLOCK": return Icons.access_time;
      case "CALENDAR": return Icons.calendar_today;
      case "QR CODE": return Icons.qr_code_scanner;
      case "DOCUMENTS": return Icons.description;
      case "BACKUP": return Icons.backup;
      case "CLEANER": return Icons.cleaning_services;
      case "APP LOCK": return Icons.lock;
      case "WIFI": return Icons.wifi;
      case "EXPLOIT": return Icons.bug_report;
      case "CRACKER": return Icons.vpn_key;
      case "DDOS": return Icons.speed;
      case "DATABASE": return Icons.storage;
      case "CLOUD": return Icons.cloud;
      case "STEALTH": return Icons.visibility_off;
      case "CRYPTO": return Icons.lock;
      case "BATTERY": return Icons.battery_charging_full;
      case "NETWORK": return Icons.network_wifi;
      case "FORENSICS": return Icons.search;
      case "TEXT ANALYZER": return Icons.analytics;
      case "UNIT CONV": return Icons.science;
      case "PERCENT": return Icons.percent;
      case "DATE CALC": return Icons.calculate;
      case "CURRENCY": return Icons.attach_money;
      case "TRANSLATOR": return Icons.translate;
      case "SECURITY HUB": return Icons.security;
      case "TOOLS HUB": return Icons.build;
      case "PERF HUB": return Icons.speed;
      case "DATA HUB": return Icons.storage;
      case "NET HUB": return Icons.network_check;
      case "PRIV HUB": return Icons.privacy_tip;
      case "AUTO HUB": return Icons.settings;
      default: return Icons.apps;
    }
  }
}

/// Stores the definition of a UTC timezone
class _UtcDef {
  final String value;
  final String abbr;
  final String text;
  final List<String> utc;
  final double offset;
  final bool isDst;

  const _UtcDef(
      this.value, this.abbr, this.text, this.utc, this.offset, this.isDst);
}

class Utc {

  static List<_UtcDef> find({String? value, String? abbr, String? text, String? hasUtc, double? offset, bool? istDst}) {
    List<_UtcDef> out = [];
    for (_UtcDef def in timezones) {

      if (
        (value == null || def.value == value) &&
        (abbr == null || def.abbr == abbr) &&
        (text == null || def.text == text) &&
        (hasUtc == null || def.utc.contains(hasUtc)) &&
        (offset == null || def.offset == offset) &&
        (istDst == null || def.isDst == istDst)
      ) {
        out.add(def);
      }
    }

    return out;
  }

  static const List<_UtcDef> timezones = [
    _UtcDef(
        "Dateline Standard Time",
        "DST",
        "(UTC-12:00) International Date Line West",
        ["Etc/GMT+12"],
        -12.0,
        false),
    _UtcDef(
        "UTC-11",
        "U",
        "(UTC-11:00) Coordinated Universal Time-11",
        ["Etc/GMT+11", "Pacific/Midway", "Pacific/Niue", "Pacific/Pago_Pago"],
        -11.0,
        false),
    _UtcDef(
        "Hawaiian Standard Time",
        "HST",
        "(UTC-10:00) Hawaii",
        [
          "Etc/GMT+10",
          "Pacific/Honolulu",
          "Pacific/Johnston",
          "Pacific/Rarotonga",
          "Pacific/Tahiti"
        ],
        -10.0,
        false),
    _UtcDef(
        "Alaskan Standard Time",
        "AKDT",
        "(UTC-09:00) Alaska",
        [
          "America/Anchorage",
          "America/Juneau",
          "America/Nome",
          "America/Sitka",
          "America/Yakutat"
        ],
        -8.0,
        true),
    _UtcDef("Pacific Standard Time (Mexico)", "PDT",
        "(UTC-08:00) Baja California", ["America/Santa_Isabel"], -7.0, true),
    _UtcDef(
        "Pacific Daylight Time",
        "PDT",
        "(UTC-07:00) Pacific Daylight Time (US & Canada)",
        ["America/Los_Angeles", "America/Tijuana", "America/Vancouver"],
        -7.0,
        true),
    _UtcDef(
        "Pacific Standard Time",
        "PST",
        "(UTC-08:00) Pacific Standard Time (US & Canada)",
        [
          "America/Los_Angeles",
          "America/Tijuana",
          "America/Vancouver",
          "PST8PDT"
        ],
        -8.0,
        false),
    _UtcDef(
        "US Mountain Standard Time",
        "UMST",
        "(UTC-07:00) Arizona",
        [
          "America/Creston",
          "America/Dawson",
          "America/Dawson_Creek",
          "America/Hermosillo",
          "America/Phoenix",
          "America/Whitehorse",
          "Etc/GMT+7"
        ],
        -7.0,
        false),
    _UtcDef(
        "Mountain Standard Time (Mexico)",
        "MDT",
        "(UTC-07:00) Chihuahua, La Paz, Mazatlan",
        ["America/Chihuahua", "America/Mazatlan"],
        -6.0,
        true),
    _UtcDef(
        "Mountain Standard Time",
        "MDT",
        "(UTC-07:00) Mountain Time (US & Canada)",
        [
          "America/Boise",
          "America/Cambridge_Bay",
          "America/Denver",
          "America/Edmonton",
          "America/Inuvik",
          "America/Ojinaga",
          "America/Yellowknife",
          "MST7MDT"
        ],
        -6.0,
        true),
    _UtcDef(
        "Central America Standard Time",
        "CAST",
        "(UTC-06:00) Central America",
        [
          "America/Belize",
          "America/Costa_Rica",
          "America/El_Salvador",
          "America/Guatemala",
          "America/Managua",
          "America/Tegucigalpa",
          "Etc/GMT+6",
          "Pacific/Galapagos"
        ],
        -6.0,
        false),
    _UtcDef(
        "Central Standard Time",
        "CDT",
        "(UTC-06:00) Central Time (US & Canada)",
        [
          "America/Chicago",
          "America/Indiana/Knox",
          "America/Indiana/Tell_City",
          "America/Matamoros",
          "America/Menominee",
          "America/North_Dakota/Beulah",
          "America/North_Dakota/Center",
          "America/North_Dakota/New_Salem",
          "America/Rainy_River",
          "America/Rankin_Inlet",
          "America/Resolute",
          "America/Winnipeg",
          "CST6CDT"
        ],
        -5.0,
        true),
    _UtcDef(
        "Central Standard Time (Mexico)",
        "CDT",
        "(UTC-06:00) Guadalajara, Mexico City, Monterrey",
        [
          "America/Bahia_Banderas",
          "America/Cancun",
          "America/Merida",
          "America/Mexico_City",
          "America/Monterrey"
        ],
        -5.0,
        true),
    _UtcDef("Canada Central Standard Time", "CCST", "(UTC-06:00) Saskatchewan",
        ["America/Regina", "America/Swift_Current"], -6.0, false),
    _UtcDef(
        "SA Pacific Standard Time",
        "SPST",
        "(UTC-05:00) Bogota, Lima, Quito",
        [
          "America/Bogota",
          "America/Cayman",
          "America/Coral_Harbour",
          "America/Eirunepe",
          "America/Guayaquil",
          "America/Jamaica",
          "America/Lima",
          "America/Panama",
          "America/Rio_Branco",
          "Etc/GMT+5"
        ],
        -5.0,
        false),
    _UtcDef(
        "Eastern Standard Time",
        "EST",
        "(UTC-05:00) Eastern Time (US & Canada)",
        [
          "America/Detroit",
          "America/Havana",
          "America/Indiana/Petersburg",
          "America/Indiana/Vincennes",
          "America/Indiana/Winamac",
          "America/Iqaluit",
          "America/Kentucky/Monticello",
          "America/Louisville",
          "America/Montreal",
          "America/Nassau",
          "America/New_York",
          "America/Nipigon",
          "America/Pangnirtung",
          "America/Port-au-Prince",
          "America/Thunder_Bay",
          "America/Toronto"
        ],
        -5.0,
        false),
    _UtcDef(
        "Eastern Daylight Time",
        "EDT",
        "(UTC-04:00) Eastern Daylight Time (US & Canada)",
        [
          "America/Detroit",
          "America/Havana",
          "America/Indiana/Petersburg",
          "America/Indiana/Vincennes",
          "America/Indiana/Winamac",
          "America/Iqaluit",
          "America/Kentucky/Monticello",
          "America/Louisville",
          "America/Montreal",
          "America/Nassau",
          "America/New_York",
          "America/Nipigon",
          "America/Pangnirtung",
          "America/Port-au-Prince",
          "America/Thunder_Bay",
          "America/Toronto"
        ],
        -4.0,
        true),
    _UtcDef(
        "US Eastern Standard Time",
        "UEDT",
        "(UTC-05:00) Indiana (East)",
        [
          "America/Indiana/Marengo",
          "America/Indiana/Vevay",
          "America/Indianapolis"
        ],
        -5.0,
        false),
    _UtcDef("Venezuela Standard Time", "VST", "(UTC-04:30) Caracas",
        ["America/Caracas"], -4.5, false),
    _UtcDef("Paraguay Standard Time", "PYT", "(UTC-04:00) Asuncion",
        ["America/Asuncion"], -4.0, false),
    _UtcDef(
        "Atlantic Standard Time",
        "ADT",
        "(UTC-04:00) Atlantic Time (Canada)",
        [
          "America/Glace_Bay",
          "America/Goose_Bay",
          "America/Halifax",
          "America/Moncton",
          "America/Thule",
          "Atlantic/Bermuda"
        ],
        -3.0,
        true),
    _UtcDef("Central Brazilian Standard Time", "CBST", "(UTC-04:00) Cuiaba",
        ["America/Campo_Grande", "America/Cuiaba"], -4.0, false),
    _UtcDef(
        "SA Western Standard Time",
        "SWST",
        "(UTC-04:00) Georgetown, La Paz, Manaus, San Juan",
        [
          "America/Anguilla",
          "America/Antigua",
          "America/Aruba",
          "America/Barbados",
          "America/Blanc-Sablon",
          "America/Boa_Vista",
          "America/Curacao",
          "America/Dominica",
          "America/Grand_Turk",
          "America/Grenada",
          "America/Guadeloupe",
          "America/Guyana",
          "America/Kralendijk",
          "America/La_Paz",
          "America/Lower_Princes",
          "America/Manaus",
          "America/Marigot",
          "America/Martinique",
          "America/Montserrat",
          "America/Port_of_Spain",
          "America/Porto_Velho",
          "America/Puerto_Rico",
          "America/Santo_Domingo",
          "America/St_Barthelemy",
          "America/St_Kitts",
          "America/St_Lucia",
          "America/St_Thomas",
          "America/St_Vincent",
          "America/Tortola",
          "Etc/GMT+4"
        ],
        -4.0,
        false),
    _UtcDef("Pacific SA Standard Time", "PSST", "(UTC-04:00) Santiago",
        ["America/Santiago", "Antarctica/Palmer"], -4.0, false),
    _UtcDef("Newfoundland Standard Time", "NDT", "(UTC-03:30) Newfoundland",
        ["America/St_Johns"], -2.5, true),
    _UtcDef("E. South America Standard Time", "ESAST", "(UTC-03:00) Brasilia",
        ["America/Sao_Paulo"], -3.0, false),
    _UtcDef(
        "Argentina Standard Time",
        "AST",
        "(UTC-03:00) Buenos Aires",
        [
          "America/Argentina/La_Rioja",
          "America/Argentina/Rio_Gallegos",
          "America/Argentina/Salta",
          "America/Argentina/San_Juan",
          "America/Argentina/San_Luis",
          "America/Argentina/Tucuman",
          "America/Argentina/Ushuaia",
          "America/Buenos_Aires",
          "America/Catamarca",
          "America/Cordoba",
          "America/Jujuy",
          "America/Mendoza"
        ],
        -3.0,
        false),
    _UtcDef(
        "SA Eastern Standard Time",
        "SEST",
        "(UTC-03:00) Cayenne, Fortaleza",
        [
          "America/Araguaina",
          "America/Belem",
          "America/Cayenne",
          "America/Fortaleza",
          "America/Maceio",
          "America/Paramaribo",
          "America/Recife",
          "America/Santarem",
          "Antarctica/Rothera",
          "Atlantic/Stanley",
          "Etc/GMT+3"
        ],
        -3.0,
        false),
    _UtcDef("Greenland Standard Time", "GDT", "(UTC-03:00) Greenland",
        ["America/Godthab"], -3.0, true),
    _UtcDef("Montevideo Standard Time", "MST", "(UTC-03:00) Montevideo",
        ["America/Montevideo"], -3.0, false),
    _UtcDef("Bahia Standard Time", "BST", "(UTC-03:00) Salvador",
        ["America/Bahia"], -3.0, false),
    _UtcDef(
        "UTC-02",
        "U",
        "(UTC-02:00) Coordinated Universal Time-02",
        ["America/Noronha", "Atlantic/South_Georgia", "Etc/GMT+2"],
        -2.0,
        false),
    _UtcDef("Mid-Atlantic Standard Time", "MDT",
        "(UTC-02:00) Mid-Atlantic - Old", [], -1.0, true),
    _UtcDef("Azores Standard Time", "ADT", "(UTC-01:00) Azores",
        ["America/Scoresbysund", "Atlantic/Azores"], 0.0, true),
    _UtcDef("Cape Verde Standard Time", "CVST", "(UTC-01:00) Cape Verde Is.",
        ["Atlantic/Cape_Verde", "Etc/GMT+1"], -1.0, false),
    _UtcDef("Morocco Standard Time", "MDT", "(UTC) Casablanca",
        ["Africa/Casablanca", "Africa/El_Aaiun"], 1.0, true),
    _UtcDef("UTC", "UTC", "(UTC) Coordinated Universal Time",
        ["America/Danmarkshavn", "Etc/GMT"], 0.0, false),
    _UtcDef(
        "GMT Standard Time",
        "GMT",
        "(UTC) Edinburgh, London",
        [
          "Europe/Isle_of_Man",
          "Europe/Guernsey",
          "Europe/Jersey",
          "Europe/London"
        ],
        0.0,
        false),
    _UtcDef(
        "British Summer Time",
        "BST",
        "(UTC+01:00) Edinburgh, London",
        [
          "Europe/Isle_of_Man",
          "Europe/Guernsey",
          "Europe/Jersey",
          "Europe/London"
        ],
        1.0,
        true),
    _UtcDef(
        "GMT Standard Time",
        "GDT",
        "(UTC) Dublin, Lisbon",
        [
          "Atlantic/Canary",
          "Atlantic/Faeroe",
          "Atlantic/Madeira",
          "Europe/Dublin",
          "Europe/Lisbon"
        ],
        1.0,
        true),
    _UtcDef(
        "Greenwich Standard Time",
        "GST",
        "(UTC) Monrovia, Reykjavik",
        [
          "Africa/Abidjan",
          "Africa/Accra",
          "Africa/Bamako",
          "Africa/Banjul",
          "Africa/Bissau",
          "Africa/Conakry",
          "Africa/Dakar",
          "Africa/Freetown",
          "Africa/Lome",
          "Africa/Monrovia",
          "Africa/Nouakchott",
          "Africa/Ouagadougou",
          "Africa/Sao_Tome",
          "Atlantic/Reykjavik",
          "Atlantic/St_Helena"
        ],
        0.0,
        false),
    _UtcDef(
        "W. Europe Standard Time",
        "WEDT",
        "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna",
        [
          "Arctic/Longyearbyen",
          "Europe/Amsterdam",
          "Europe/Andorra",
          "Europe/Berlin",
          "Europe/Busingen",
          "Europe/Gibraltar",
          "Europe/Luxembourg",
          "Europe/Malta",
          "Europe/Monaco",
          "Europe/Oslo",
          "Europe/Rome",
          "Europe/San_Marino",
          "Europe/Stockholm",
          "Europe/Vaduz",
          "Europe/Vatican",
          "Europe/Vienna",
          "Europe/Zurich"
        ],
        2.0,
        true),
    _UtcDef(
        "Central Europe Standard Time",
        "CEDT",
        "(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague",
        [
          "Europe/Belgrade",
          "Europe/Bratislava",
          "Europe/Budapest",
          "Europe/Ljubljana",
          "Europe/Podgorica",
          "Europe/Prague",
          "Europe/Tirane"
        ],
        2.0,
        true),
    _UtcDef(
        "Romance Standard Time",
        "RDT",
        "(UTC+01:00) Brussels, Copenhagen, Madrid, Paris",
        [
          "Africa/Ceuta",
          "Europe/Brussels",
          "Europe/Copenhagen",
          "Europe/Madrid",
          "Europe/Paris"
        ],
        2.0,
        true),
    _UtcDef(
        "Central European Standard Time",
        "CEDT",
        "(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb",
        ["Europe/Sarajevo", "Europe/Skopje", "Europe/Warsaw", "Europe/Zagreb"],
        2.0,
        true),
    _UtcDef(
        "W. Central Africa Standard Time",
        "WCAST",
        "(UTC+01:00) West Central Africa",
        [
          "Africa/Algiers",
          "Africa/Bangui",
          "Africa/Brazzaville",
          "Africa/Douala",
          "Africa/Kinshasa",
          "Africa/Lagos",
          "Africa/Libreville",
          "Africa/Luanda",
          "Africa/Malabo",
          "Africa/Ndjamena",
          "Africa/Niamey",
          "Africa/Porto-Novo",
          "Africa/Tunis",
          "Etc/GMT-1"
        ],
        1.0,
        false),
    _UtcDef("Namibia Standard Time", "NST", "(UTC+01:00) Windhoek",
        ["Africa/Windhoek"], 1.0, false),
    _UtcDef(
        "GTB Standard Time",
        "GDT",
        "(UTC+02:00) Athens, Bucharest",
        [
          "Asia/Nicosia",
          "Europe/Athens",
          "Europe/Bucharest",
          "Europe/Chisinau"
        ],
        3.0,
        true),
    _UtcDef("Middle East Standard Time", "MEDT", "(UTC+02:00) Beirut",
        ["Asia/Beirut"], 3.0, true),
    _UtcDef("Egypt Standard Time", "EST", "(UTC+02:00) Cairo", ["Africa/Cairo"],
        2.0, false),
    _UtcDef("Syria Standard Time", "SDT", "(UTC+02:00) Damascus",
        ["Asia/Damascus"], 3.0, true),
    _UtcDef(
        "E. Europe Standard Time",
        "EEDT",
        "(UTC+02:00) E. Europe",
        [
          "Asia/Nicosia",
          "Europe/Athens",
          "Europe/Bucharest",
          "Europe/Chisinau",
          "Europe/Helsinki",
          "Europe/Kiev",
          "Europe/Mariehamn",
          "Europe/Nicosia",
          "Europe/Riga",
          "Europe/Sofia",
          "Europe/Tallinn",
          "Europe/Uzhgorod",
          "Europe/Vilnius",
          "Europe/Zaporozhye"
        ],
        3.0,
        true),
    _UtcDef(
        "South Africa Standard Time",
        "SAST",
        "(UTC+02:00) Harare, Pretoria",
        [
          "Africa/Blantyre",
          "Africa/Bujumbura",
          "Africa/Gaborone",
          "Africa/Harare",
          "Africa/Johannesburg",
          "Africa/Kigali",
          "Africa/Lubumbashi",
          "Africa/Lusaka",
          "Africa/Maputo",
          "Africa/Maseru",
          "Africa/Mbabane",
          "Etc/GMT-2"
        ],
        2.0,
        false),
    _UtcDef(
        "FLE Standard Time",
        "FDT",
        "(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius",
        [
          "Europe/Helsinki",
          "Europe/Kiev",
          "Europe/Mariehamn",
          "Europe/Riga",
          "Europe/Sofia",
          "Europe/Tallinn",
          "Europe/Uzhgorod",
          "Europe/Vilnius",
          "Europe/Zaporozhye"
        ],
        3.0,
        true),
    _UtcDef("Turkey Standard Time", "TDT", "(UTC+03:00) Istanbul",
        ["Europe/Istanbul"], 3.0, false),
    _UtcDef("Israel Standard Time", "JDT", "(UTC+02:00) Jerusalem",
        ["Asia/Jerusalem"], 3.0, true),
    _UtcDef("Libya Standard Time", "LST", "(UTC+02:00) Tripoli",
        ["Africa/Tripoli"], 2.0, false),
    _UtcDef("Jordan Standard Time", "JST", "(UTC+03:00) Amman", ["Asia/Amman"],
        3.0, false),
    _UtcDef("Arabic Standard Time", "AST", "(UTC+03:00) Baghdad",
        ["Asia/Baghdad"], 3.0, false),
    _UtcDef("Kaliningrad Standard Time", "KST", "(UTC+02:00) Kaliningrad",
        ["Europe/Kaliningrad"], 3.0, false),
    _UtcDef(
        "Arab Standard Time",
        "AST",
        "(UTC+03:00) Kuwait, Riyadh",
        [
          "Asia/Aden",
          "Asia/Bahrain",
          "Asia/Kuwait",
          "Asia/Qatar",
          "Asia/Riyadh"
        ],
        3.0,
        false),
    _UtcDef(
        "E. Africa Standard Time",
        "EAST",
        "(UTC+03:00) Nairobi",
        [
          "Africa/Addis_Ababa",
          "Africa/Asmera",
          "Africa/Dar_es_Salaam",
          "Africa/Djibouti",
          "Africa/Juba",
          "Africa/Kampala",
          "Africa/Khartoum",
          "Africa/Mogadishu",
          "Africa/Nairobi",
          "Antarctica/Syowa",
          "Etc/GMT-3",
          "Indian/Antananarivo",
          "Indian/Comoro",
          "Indian/Mayotte"
        ],
        3.0,
        false),
    _UtcDef(
        "Moscow Standard Time",
        "MSK",
        "(UTC+03:00) Moscow, St. Petersburg, Volgograd, Minsk",
        [
          "Europe/Kirov",
          "Europe/Moscow",
          "Europe/Simferopol",
          "Europe/Volgograd",
          "Europe/Minsk"
        ],
        3.0,
        false),
    _UtcDef("Samara Time", "SAMT", "(UTC+04:00) Samara, Ulyanovsk, Saratov",
        ["Europe/Astrakhan", "Europe/Samara", "Europe/Ulyanovsk"], 4.0, false),
    _UtcDef("Iran Standard Time", "IDT", "(UTC+03:30) Tehran", ["Asia/Tehran"],
        4.5, true),
    _UtcDef("Arabian Standard Time", "AST", "(UTC+04:00) Abu Dhabi, Muscat",
        ["Asia/Dubai", "Asia/Muscat", "Etc/GMT-4"], 4.0, false),
    _UtcDef("Azerbaijan Standard Time", "ADT", "(UTC+04:00) Baku",
        ["Asia/Baku"], 5.0, true),
    _UtcDef("Mauritius Standard Time", "MST", "(UTC+04:00) Port Louis",
        ["Indian/Mahe", "Indian/Mauritius", "Indian/Reunion"], 4.0, false),
    _UtcDef("Georgian Standard Time", "GET", "(UTC+04:00) Tbilisi",
        ["Asia/Tbilisi"], 4.0, false),
    _UtcDef("Caucasus Standard Time", "CST", "(UTC+04:00) Yerevan",
        ["Asia/Yerevan"], 4.0, false),
    _UtcDef("Afghanistan Standard Time", "AST", "(UTC+04:30) Kabul",
        ["Asia/Kabul"], 4.5, false),
    _UtcDef(
        "West Asia Standard Time",
        "WAST",
        "(UTC+05:00) Ashgabat, Tashkent",
        [
          "Antarctica/Mawson",
          "Asia/Aqtau",
          "Asia/Aqtobe",
          "Asia/Ashgabat",
          "Asia/Dushanbe",
          "Asia/Oral",
          "Asia/Samarkand",
          "Asia/Tashkent",
          "Etc/GMT-5",
          "Indian/Kerguelen",
          "Indian/Maldives"
        ],
        5.0,
        false),
    _UtcDef("Yekaterinburg Time", "YEKT", "(UTC+05:00) Yekaterinburg",
        ["Asia/Yekaterinburg"], 5.0, false),
    _UtcDef("Pakistan Standard Time", "PKT", "(UTC+05:00) Islamabad, Karachi",
        ["Asia/Karachi"], 5.0, false),
    _UtcDef(
        "India Standard Time",
        "IST",
        "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi",
        ["Asia/Kolkata", "Asia/Calcutta"],
        5.5,
        false),
    _UtcDef("Sri Lanka Standard Time", "SLST",
        "(UTC+05:30) Sri Jayawardenepura", ["Asia/Colombo"], 5.5, false),
    _UtcDef("Nepal Standard Time", "NST", "(UTC+05:45) Kathmandu",
        ["Asia/Kathmandu"], 5.75, false),
    _UtcDef(
        "Central Asia Standard Time",
        "CAST",
        "(UTC+06:00) Nur-Sultan (Astana)",
        [
          "Antarctica/Vostok",
          "Asia/Almaty",
          "Asia/Bishkek",
          "Asia/Qyzylorda",
          "Asia/Urumqi",
          "Etc/GMT-6",
          "Indian/Chagos"
        ],
        6.0,
        false),
    _UtcDef("Bangladesh Standard Time", "BST", "(UTC+06:00) Dhaka",
        ["Asia/Dhaka", "Asia/Thimphu"], 6.0, false),
    _UtcDef("Myanmar Standard Time", "MST", "(UTC+06:30) Yangon (Rangoon)",
        ["Asia/Rangoon", "Indian/Cocos"], 6.5, false),
    _UtcDef(
        "SE Asia Standard Time",
        "SAST",
        "(UTC+07:00) Bangkok, Hanoi, Jakarta",
        [
          "Antarctica/Davis",
          "Asia/Bangkok",
          "Asia/Hovd",
          "Asia/Jakarta",
          "Asia/Phnom_Penh",
          "Asia/Pontianak",
          "Asia/Saigon",
          "Asia/Vientiane",
          "Etc/GMT-7",
          "Indian/Christmas"
        ],
        7.0,
        false),
    _UtcDef("N. Central Asia Standard Time", "NCAST", "(UTC+07:00) Novosibirsk",
        ["Asia/Novokuznetsk", "Asia/Novosibirsk", "Asia/Omsk"], 7.0, false),
    _UtcDef(
        "China Standard Time",
        "CST",
        "(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi",
        ["Asia/Hong_Kong", "Asia/Macau", "Asia/Shanghai"],
        8.0,
        false),
    _UtcDef("North Asia Standard Time", "NAST", "(UTC+08:00) Krasnoyarsk",
        ["Asia/Krasnoyarsk"], 8.0, false),
    _UtcDef(
        "Singapore Standard Time",
        "MPST",
        "(UTC+08:00) Kuala Lumpur, Singapore",
        [
          "Asia/Brunei",
          "Asia/Kuala_Lumpur",
          "Asia/Kuching",
          "Asia/Makassar",
          "Asia/Manila",
          "Asia/Singapore",
          "Etc/GMT-8"
        ],
        8.0,
        false),
    _UtcDef("W. Australia Standard Time", "WAST", "(UTC+08:00) Perth",
        ["Antarctica/Casey", "Australia/Perth"], 8.0, false),
    _UtcDef("Taipei Standard Time", "TST", "(UTC+08:00) Taipei",
        ["Asia/Taipei"], 8.0, false),
    _UtcDef("Ulaanbaatar Standard Time", "UST", "(UTC+08:00) Ulaanbaatar",
        ["Asia/Choibalsan", "Asia/Ulaanbaatar"], 8.0, false),
    _UtcDef("North Asia East Standard Time", "NAEST", "(UTC+08:00) Irkutsk",
        ["Asia/Irkutsk"], 8.0, false),
    _UtcDef(
        "Japan Standard Time",
        "JST",
        "(UTC+09:00) Osaka, Sapporo, Tokyo",
        [
          "Asia/Dili",
          "Asia/Jayapura",
          "Asia/Tokyo",
          "Etc/GMT-9",
          "Pacific/Palau"
        ],
        9.0,
        false),
    _UtcDef("Korea Standard Time", "KST", "(UTC+09:00) Seoul",
        ["Asia/Pyongyang", "Asia/Seoul"], 9.0, false),
    _UtcDef("Cen. Australia Standard Time", "CAST", "(UTC+09:30) Adelaide",
        ["Australia/Adelaide", "Australia/Broken_Hill"], 9.5, false),
    _UtcDef("AUS Central Standard Time", "ACST", "(UTC+09:30) Darwin",
        ["Australia/Darwin"], 9.5, false),
    _UtcDef("E. Australia Standard Time", "EAST", "(UTC+10:00) Brisbane",
        ["Australia/Brisbane", "Australia/Lindeman"], 10.0, false),
    _UtcDef(
        "AUS Eastern Standard Time",
        "AEST",
        "(UTC+10:00) Canberra, Melbourne, Sydney",
        ["Australia/Melbourne", "Australia/Sydney"],
        10.0,
        false),
    _UtcDef(
        "West Pacific Standard Time",
        "WPST",
        "(UTC+10:00) Guam, Port Moresby",
        [
          "Antarctica/DumontDUrville",
          "Etc/GMT-10",
          "Pacific/Guam",
          "Pacific/Port_Moresby",
          "Pacific/Saipan",
          "Pacific/Truk"
        ],
        10.0,
        false),
    _UtcDef("Tasmania Standard Time", "TST", "(UTC+10:00) Hobart",
        ["Australia/Currie", "Australia/Hobart"], 10.0, false),
    _UtcDef("Yakutsk Standard Time", "YST", "(UTC+09:00) Yakutsk",
        ["Asia/Chita", "Asia/Khandyga", "Asia/Yakutsk"], 9.0, false),
    _UtcDef(
        "Central Pacific Standard Time",
        "CPST",
        "(UTC+11:00) Solomon Is., New Caledonia",
        [
          "Antarctica/Macquarie",
          "Etc/GMT-11",
          "Pacific/Efate",
          "Pacific/Guadalcanal",
          "Pacific/Kosrae",
          "Pacific/Noumea",
          "Pacific/Ponape"
        ],
        11.0,
        false),
    _UtcDef("Vladivostok Standard Time", "VST", "(UTC+11:00) Vladivostok",
        ["Asia/Sakhalin", "Asia/Ust-Nera", "Asia/Vladivostok"], 11.0, false),
    _UtcDef(
        "New Zealand Standard Time",
        "NZST",
        "(UTC+12:00) Auckland, Wellington",
        ["Antarctica/McMurdo", "Pacific/Auckland"],
        12.0,
        false),
    _UtcDef(
        "UTC+12",
        "U",
        "(UTC+12:00) Coordinated Universal Time+12",
        [
          "Etc/GMT-12",
          "Pacific/Funafuti",
          "Pacific/Kwajalein",
          "Pacific/Majuro",
          "Pacific/Nauru",
          "Pacific/Tarawa",
          "Pacific/Wake",
          "Pacific/Wallis"
        ],
        12.0,
        false),
    _UtcDef("Fiji Standard Time", "FST", "(UTC+12:00) Fiji", ["Pacific/Fiji"],
        12.0, false),
    _UtcDef(
        "Magadan Standard Time",
        "MST",
        "(UTC+12:00) Magadan",
        ["Asia/Anadyr", "Asia/Kamchatka", "Asia/Magadan", "Asia/Srednekolymsk"],
        12.0,
        false),
    _UtcDef(
        "Kamchatka Standard Time",
        "KDT",
        "(UTC+12:00) Petropavlovsk-Kamchatsky - Old",
        ["Asia/Kamchatka"],
        13.0,
        true),
    _UtcDef(
        "Tonga Standard Time",
        "TST",
        "(UTC+13:00) Nuku'alofa",
        [
          "Etc/GMT-13",
          "Pacific/Enderbury",
          "Pacific/Fakaofo",
          "Pacific/Tongatapu"
        ],
        13.0,
        false),
    _UtcDef("Samoa Standard Time", "SST", "(UTC+13:00) Samoa", ["Pacific/Apia"],
        13.0, false),
  ];
}

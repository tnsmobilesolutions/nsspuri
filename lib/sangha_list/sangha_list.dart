class SanghaList {
  static final List<String> sangha = [
    'Anugul',
    'Bikrampur',
    'Jagannathpur',
    'Talcher Town',
    'Nalco',
    'Rankasingha',
    'Samal Byarej',
    'NTPC',
    'Athamalik',
    'Asureswar',
    'Jobra',
    'Kamarpada',
    'Narasingpur',
    'Kendupatana',
    'Kurunti',
    'Bailaish Mouja',
    'Choudwar',
    'Tangi',
    'Badamba',
    'Barapada',
    'Sukarapada',
    'Niali',
    'Gopalpur',
    'Athagada',
    'Banki',
    'Khalarda',
    'Bachhasailo',
    'Endulapur',
    'Oupada',
    'Kaetha',
    'Katana',
    'Chandiagadhi',
    'Kurunti',
    'Gopei',
    'Gouda gaa',
    'Chhachina',
    'Jarimula',
    'Junapangara',
    'Tikhiri',
    'TULASHIKHETRA',
    'DEULAPADA',
    'NADIA BAREI',
    'NAUKANA',
    'RAJNAGAR',
    'NARAHARIPUR',
    'ADHANGA',
    'BIJAY NAGAR',
    'NUAGAA',
    'MATIA',
    'BASUDEIPUR',
    'MAHARA SAI',
    'BILIKANA',
    'MAHAKALAPADA',
    'MANDAPADA',
    'RAHAMA',
    'RAJKANIKA',
    'RAJPUR',
    'RAMNAGAR',
    'NIALA',
    'SINGHAPAHAR',
    'JAYPORE',
    'DAMANJODI',
    'SIMILIGUDA',
    'BALIMELA',
    'KENDRA SEBAK SANGHA',
    'RAJDHANI TOWN',
    'ATRI',
    'EKAMRA',
    'BANAMALIPUR',
    'BEGUNIA',
    'KHORDA',
    'BOLAGADA',
    'SANAPADAR',
    'LANJIA',
    'BADAKHETA',
    'TANARADA',
    'SIDHARTHA NAGAR  ',
    'BADAMUNDILO  ',
    'JAGATSINGHPUR  ',
    'RAHAMA  ',
    'DARADA PATANA  ',
    'NAUGAA  ',
    'NAUBAZAR, PARADIP  ',
    'ERASAMA  ',
    'HALADIPANI  ',
    'PARALAKHEMUNDI  ',
    'JHARSUGUDA TOWN  ',
    'RASOLA  ',
    'KAMAKSHYA NAGAR  ',
    'DHENKANAL  ',
    'BALIKIARI  ',
    'KANDAR SINGHA  ',
    'INDRABATI  ',
    'NAYAGARH  ',
    'THUABARI  ',
    'RANIMUNDA  ',
    'KHADIALA  ',
    'DUAJHAR  ',
    'BALIGUDA  ',
    'PHULBANI  ',
    'BARAGADA  ',
    'NIMAPADA  ',
    'PURI TOWN  ',
    'BALANGIR  ',
    'SILANDA  ',
    'RAIBANIA  ',
    'KUAGADIA  ',
    'KUPARI  ',
    'GARASANGA  ',
    'NILAGIRI  ',
    'ANTARA  ',
    'CHITOLA  ',
    'DANTIA  ',
    'GOOD  ',
    'BALABHADRAPUR  ',
    'MAHATIPUR  ',
    'SORO  ',
    'BARAPADA  ',
    'MUKTESWARPUR  ',
    'FATEPUR  ',
    'GOPINATHPUR  ',
    'DANDI  ',
    'BAINANDA  ',
    'BALASORE  ',
    'MATIGADA  ',
    'DHUSHULI  ',
    'JALAHARI  ',
    'DHUSHURI  ',
    'ARADI  ',
    'KHADIMAHARA  ',
    'BETADA  ',
    'BASUDEBPUR  ',
    'PALIABINDHA  ',
    'GOBINDPUR  ',
    'PALIABINDHA  ',
    'BHADRAK  ',
    'BANIDIA  ',
    'BACHHADA  ',
    'PANDUPANI  ',
    'BARIPADA  ',
    'KUNDAPATANA  ',
    'DHARMASHALA  ',
    'SOBRA  ',
    'KALAKALA  ',
    'KANTIGADIA  ',
    'BYASANAGAR  ',
    'JAJPUR TOWN  ',
    'KABATABANDHA  ',
    'DEKUDI, PALLI  ',
    'KUAKHIA  ',
    'SAMBALPUR  ',
    'FASHIMALA  ',
    'BURLA  ',
    'BARAGADA  ',
    'RAJGANGPUR  ',
    'ROURKELA TOWN  ',
    'SHAKTI NAGAR,ROURKELA  ',
    'BALIJODI  ',
    'DENGIBHADI  ',
    'KENDUJHAR  ',
    'JODA  ',
    'ANANDAPUR  ',
    'ATASAHI  ',
    'SALABANI  ',
    'CHENNAPADI  ',
    'BOUDHA  ',
    'America Saraswata ',
    'Mumbai Saraswata ',
    'Karnataka Saraswata ',
    'Pune Saraswata ',
    'Delhi Saraswata ',
    'Chennai  ',
    'Kolkata Saraswata ',
    'Surat',
    'Hyderabad Saraswata ',
    'Jamshedpur',
    'Rishikesh Ashram',
    'Raipur  sangha',
    'Ranchi Pathachakra',
    'Allahabad Pathachakra',
    'Ahmedabad Pathachakra',
    'Faridabad Pathachakra',
    'Ghaziabad Pathachakra',
    'Guwahati Pathachakra',
    'Europe Pathachakra',
    'Nigeria Pathachakra',
  ];

  static List<String> getSuggestions(String query, List<String>? allSangha) {
    List<String> matches = [];
    matches.addAll(allSangha ?? []);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

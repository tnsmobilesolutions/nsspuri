class StateService {
  static final List<String> states = [
    'Angul Sakha Sangha',
    'Bikrampur Sakha Sangha',
    'Jagannathpur Sakha Sangha',
    'Talcher Town Sakha Sangha',
    'Nalconagar Sakha Sangha',
    'Rankasingha Sakha Sangha',
    'Shree Shree Nigamananda Asan Mandir, Samal',
    'NTPC Sakha Sangha',
    'Athamallik Sakha Sangha',
    'Narsinghpur Sakha Sangha',
    'Gopalpur Sakha Sangha',
    'Athagarh Sakha Sangha',
    'Sukarpada Sakha Sangha',
    'Ashureswar Sakha Sangha',
    'Cuttack Saraswata Sangha, Jobra',
    'Kamarapada Sakha Sangha',
    'Kendupatana Sakha Sangha',
    'Khuntuni Sakha Sangha',
    'Bayalish Mouja Sakha Sangha',
    'Choudwar Sakha Sangha',
    'Tangi Sakha Sangha',
    'Barapada Sakha Sangha',
    'Niali Sakha Sakha Sangha',
    'Banki Sakha Sangha',
    'Badamba Sakha Sangha',
    'Khalarda Sakha Sangha',
    'Rahama Sakha Sangha',
    'Endulapur Sakha Sangha',
    'Oupada Sakha Sangha',
    'Kayatha Sakha Sangha',
    'Mandapara Sakha Sangha',
    'Chhachina Sakha Sangha',
    'Jarimula Sakha Sangha',
    'Junapangara Sakha Sangha',
    'Tulasikshetra Sakha Sangha',
    'Deulapara Sakha Sangha',
    'Nadiabarai Sakha Sangha',
    'Naukana Sakha Sangha',
    'Rajnagar Sakha Sangha',
    'Nuagaan Sakha Sangha',
    'Matia Sakha Sangha',
    'Basudeipur Sakha Sangha',
    'Maharasahi Sakha Sangha',
    'Adhanga Sakha Sangha',
    'Bijayanagar Sakha Sangha',
    'Katana Sakha Sangha',
    'Chandiagari Sakha Sangha',
    'Kurunti Sakha Sangha',
    'Gopei Sakha Sangha',
    'Tikhiri Sakha Sangha',
    'Bilikana Sakha Sangha',
    'Mahakalapada Sakha Sangha',
    'Rajakanika Sakha Sangha',
    'Rajpur Sakha Sangha',
    'Ramnagar Sakha Sangha',
    'Niala Sakha Sangha',
    'Singhpahar Sakha Sangha',
    'Naraharipur Sakha Sangha',
    'Parlakhemundai Sakha Sangha',
    'Nigam Saraswata Sangha,Badamundilo',
    'Jagatsinghapur Sangha',
    'Daradapatana Sakha Sangha',
    'Naunga Sakha Sangha',
    'Paradeep Sakha Sangha',
    'Rahama Sangha',
    'Bachhasailo Sakha Sangha',
    'Erasama Sakha Sangha',
    'Jharasuguda Sakha Sangha',
    'Kamakshyanagar Sakha Sangha',
    'Dhenkanal Sakha Sangha',
    'Balikiari Sakha Sangha',
    'Rasol Sakha Sangha',
    'Kandarsingha Sakha Sangha',
    'Indrabati Sakha Sangha',
    'Nayagarh Sakha Sangha',
    'Duajhar Sakha Sangha',
    'Ranimunda Sakha Sangha',
    'Phulbani Sakha Sangha',
    'Baliguda Sakha Sangha',
    'Baragarh Sakha Sangha',
    'Nimapara Sakha Sangha',
    'Puri Town Sangha',
    'Balangir Sangha',
    'Silanda Sakha Sangha',
    'Raibania Sakha Sangha',
    'Kuagadia Sakha Sangha',
    'Kupari Nigamananda Asan Mandir',
    'Garasanga Sakha Sangha',
    'Nilagiri Sakha Sangha',
    'Antara Sakha Sangha',
    'Chittola Sakha Sangha',
    'Dantia Sakha Sangha',
    'Gud Sakha Sangha',
    'Balabhadrapur Sakha Sangha',
    'Nigam Saraswata Sangha Mahatipur',
    'Soro Sakha Sangha',
    'Gopinathpur Sakha Sangha',
    'Mahatipur Sakha Sangha',
    'Mukteswarpur Sakha Sangha',
    'Fatepur Sakha Sangha',
    'Barapada Sakha Sangha',
    'Dandi Saraswata Sangha',
    'Bainanda Sakha Sangha',
    'Balasore Sakha Sangha',
    'Matigada Sakha Sangha',
    'Bachhada Sakha Sangha',
    'Dhusuli Sakha Sangha',
    'Jalahari Sakha Sangha',
    'Dhusuri Sakha Sangha',
    'Aradi Sakha sangha',
    'Paliabindha Sakha Sangha',
    'Khadimahara Sakha Sangha',
    'Bhadrak Sakha Sangha',
    'Basudebpur Sakha Sangha',
    'Betada Sakha Sangha',
    'Govindapur Sakha Sangha',
    'Banitia Sakha Sangha',
    'Pandupani Sakha Sangha',
    'Baripada Sakha Sangha',
    'Kundapatana Sakha Sangha',
    'Dharmasala Sakha Sangha',
    'Jajpur Town Sangha',
    'Kabatbandha Sakha Sangha',
    'Kantigadia Sakha Sangha',
    'Byasanagar Kanheipur Sakha Sangha',
    'Dekudi Sakha Sangha',
    'Sobara Sakha Sangha',
    'Kalakala Sakha Sangha',
    'Kuakhia Sakha Sangha',
    'Sambalpur Sakha Sangha',
    'Facimal Sakha Sangha',
    'Burla Sakha Sangha',
    'Rourkela Shaktinagar Sakha Sangha',
    'Badagaon Sakha Sangha',
    'Rajgangapur Sakha Sangha',
    'Rourkela Town Sangha',
    'Sundargarh Sakha Sangha',
    'Balijodi Sakha Sangha',
    'Kendujhar Sakha Sangha',
    'Joda Sakha Sangha',
    'Atasahi Sakha Sangha',
    'Anandapur Sakha Sangha',
    'Salabani Sakha Sangha',
    'Chenapadi Sakha Sangha',
    'Joypur Sakha Sangha',
    'Damanjodi Sakha Sangha',
    'Semiliguda Sakha Sangha',
    'Semiliguda Sakha Sangha',
    'Boudha Sakha Sangha',
    'Kendra Sevak Sangha',
    'Rajadhani Saraswata Sangha',
    'Atri Sakha Sangha',
    'Ekamra Saraswata Sangha',
    'Banamalipur Sakha Sangha',
    'Begunia Sakha Sangha',
    'Khurda Sakha Sangha',
    'Bolagarh Sakha Sangha',
    'Sanapadar Sakha Sangha',
    'Nayagarha Sakha Sangha',
    'Lanjia Sakha Sangha',
    'Badakheta Sakha Sangha',
    'Tanarada Sakha Sangha',
    'Berhmpur Sakha Sangha',
    'AMERICA SARASWATA SANGHA',
    'Karnataka Saraswata Sangha',
    'Pune Saraswata Sangha',
    'DELHI SARASWATA SANGHA',
    'Chennai Sakha Sangha',
    'Kolkata Saraswata Sangha',
    'Surat Shakha Sangha',
    'HYDERABAD SARASWATA SANGHA',
    'Jamshedpur Sakha Sangha',
    'Rishikesh Ashram',
    'Raipur Sakha sangha',
    'Ranchi Pathachakra',
    'Allahabad Pathachakra',
    'Ahmedabad Pathachakra',
    'Faridabad Pathachakra',
    'Ghaziabad Pathachakra',
    'Guwahati Pathachakra',
    'Europe Pathachakra',
    'Nigeria Pathachakra',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

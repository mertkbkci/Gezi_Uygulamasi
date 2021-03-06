import 'package:city_guide_app/items_screen.dart';
import 'package:city_guide_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String myJsonData =
      "{\n  \"Parks\": [\n    {\n      \"name\": \"Aşık Veysel Rekreasyon Alanı\",\n      \"information\": \"Aşık Veysel Rekreasyon Alanı, Türkiye'nin İzmir ilinin Bornova ilçesinde bulunan bir parktır. Türk halk ozanı Âşık Veysel'in adını taşıyan park, toplam 231.000 m2 alana sahiptir. İçerisinde 12.000 m2'lik Buz Sporları Salonu, 5.000 kişilik kapasitesiyle İzmir'in en büyük amfitiyatrosu, 1.500 m2'lik yapay bir gölet, üç basketbol sahası, iki tenis sahası, bir mini futbol sahası, bir kafeterya, üç çocuk oyun alanı, yürüyüş yolları, 1,5 kilometre uzunluğunda bisiklet yolu, dinlenme terasları ve otopark bulunmaktadır.\\t\",\n      \"imageUrl\": \"parkImages/asikVeysel.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Buca Gölet\",\n      \"information\": \"Buca Gölet, Ege bölgesinin ve İzmir'in en gözde dinlence ve eğlence merkezlerindendir. 167 Bin m2 alan üzerinde kurulmuştur. Buca Belediyesi tarafından 1998 Nisan ayında yapımına başlanan Buca Gölet Regreasyon Alanı yaklaşık bir sene sonra, 1999 yılı Mart ayında halkın hizmetine sunulmuştur. İçerisinde 300 kişilik Göl Restoran,600 kişilik Göl Salonu Seyir Cafe, Mangal alanı,Şarküteri, Amfitiyatro, Piknik Alanı, Ada Cafe&Pub, Seyir Terasları, Çocuk Oyun Parkları, Market, Bebek Bakım Odası, Mescid ve Otopark yer almaktadır.\",\n      \"imageUrl\": \"parkImages/bucaGolet.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İzmir Kültürpark\",\n      \"information\": \"Kültürpark, Türkiye'nin İzmir şehrinde bulunan bir parktır. Konak ilçesinde, Mimar Sinan Mahallesi'nde yer alır ve kuzeyde Dr. Mustafa Enver Bey Caddesi, doğuda 1395. ve 1396. sokaklar ile Bozkurt Caddesi, güneyde Mürsel Paşa Bulvarı, batıda Dr. Refik Saydam ve Şair Eşref bulvarları ile çevrilidir. 1922 İzmir Yangını'nda harabeye dönen 360.000 m2'lik alan üzerinde 1936'da kuruldu. Üç yıl sonra genişletilerek 420.000 m2 büyüklüğe ulaştı. Kurulduğu günden beri İzmir Enternasyonal Fuarı'na ev sahipliği yapmaktadır.\",\n      \"imageUrl\": \"parkImages/kulturpark.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İnciraltı Kent Ormanı\",\n      \"information\": \"İnciraltı Dalyanı'nı çevresiyle birlikte düzenlenen, yaklaşık 2 milyon metrekarelik İnciraltı Kent Ormanı, İzmirlilerin günün her saati kullandıkları, deniz ve yeşilin birleştiği bir ortamda spor, yürüyüş, gezinti ve piknik yapabildiği bir alanıdır. İnciraltı Kent Ormanı'nda doğal taş, kaya ve tahtalarla oluşturulmuş dinlenme alanları, köprüler, yürüyüş ve bisiklet yolları bulunmaktadır. Kuşların barındığı ve yumurtladığı orman içindeki sulak alan, tel örgüyle koruma altına alınarak, Yenikale'den başlayan bisiklet ve yürüyüş yolu, sahilden İnciraltı Kent Ormanı'na bağlanarak, kıyı şeridi taş dizgi ile döşenmiş balıkçı barınağı korunmuştur.\",\n      \"imageUrl\": \"parkImages/kentOrmani.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İzmir Doğal Yaşam Parkı\",\n      \"information\": \"İzmir Doğal Yaşam Parkı, İzmir'in Çiğli ilçesinde yer alan kâr amacı gütmeyen bir hayvanat bahçesidir. İzmir Büyükşehir Belediyesi tarafından 30 Kasım 2008'de açılmıştır. 134 türden 2.700'ü aşkın hayvanın bulunduğu park 425.000 m²'lik alan üzerinde kuruludur. Avrupa Hayvanat Bahçeleri ve Akvaryumlar Birliği üyesidir. Yılda 1 milyon civarında kişinin ziyaret ettiği parkta kapatılan İzmir Hayvanat Bahçesi'nden ve yurt dışından getirilen hayvanlar doğal ortamlarında sergilenmektedir.\",\n      \"imageUrl\": \"parkImages/dogalYasam.png\",\n      \"openHours\": \"09:00 - 18:30\",\n      \"price\": \"10₺\",\n      \"comments\": []\n    }\n  ],\n  \"Libraries\": [\n    {\n      \"name\": \"İzmir Milli Kütüphane\",\n      \"information\": \"İzmir Milli Kütüphane, İzmir'in Konak ilçesinde, adını verdiği Milli Kütüphane Caddesi'ndeki tarihi binada hizmet veren ve Türkiye'nin Milli adını taşıyan ilk kütüphanesidir. 23 Nisan 1912 tarihinde, daha sonra İzmir Milli Kütüphane Cemiyeti adını alacak olan sivil bir örgüt çatısında toplanan bir grup aydının girişimi ile Beyler Sokağı’nda, Salepçizade Konağı'nın selamlık bölümünde hizmet vermeye başladı. Kütüphaneye gelir sağlaması için 1926 yılında Elhamra Sineması’nın açılmasından sonra bu işletmeden elde edilen gelirle bir kütüphane binası inşa ettirildi. Ülkede bir sivil toplum girişimi ile kurulan ilk kütüphane olan kurum, 29 Ekim 1933 tarihinden beri Mimar Tahsin Sermet Bey’in yaptığı neo-klasik binada hizmetini sürdürür. Halen, Türkiye’nin altı derleme kütüphanesinden birisidir. Milli Kütüphane Vakfı’nın malıdır ve onun yönetimindedir.\",\n      \"imageUrl\": \"libraryImages/milli.png\",\n      \"openHours\": \"08:00 - 17:30\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İzmir Kent Kütüphanesi\",\n      \"information\": \"Kütüphanemizde 15 bin adet Türkçe, 30 bin adet İngilizce kitap bulunmakta, üyeler 2 adet kitap 21 gün süreyle ödünç alınabilmektedir. Pandemi dönemi etüt odasına 8 kişi çalışabilmektedir.\",\n      \"imageUrl\": \"libraryImages/kent.png\",\n      \"openHours\": \"09:00 - 21:00\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Ş@to Kütüphanesi\",\n      \"information\": \"Ş@to Kütüphanesi, İzmir'e her türlü kaynağı elektronik ortamlar aracılığıyla sağlamak için kurulan ilk dijital kütüphanedir ve 7 gün 24 saat erişime açıktır. Kütüphanede akademik veritabanları, (Felsefe Veritabanı, Torrossa Akdeniz Çalışmaları Veritabanı) dergi ve  3672 e-kitap mevcuttur. Ş@to Kütüphanesinde 1200 Türkçe, 500 İngilizce kitap da bulunmakta ve üyeler 2 adet kitabı 21 gün süreyle ödünç alabilmektedir. Pandemi dönemi çalışma alanına 9 kişi alınmaktadır.\",\n      \"imageUrl\": \"libraryImages/sato.png\",\n      \"openHours\": \"09:00 - 21:00\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Havagazı Gençlik Araştırma Kütüphanesi\",\n      \"information\": \"Önlisans, lisans ve lisansüstü öğrencileri gencizmir.com üzerinden randevu alarak kütüphaneyi kullanabilir. Aynı anda 64 kişinin (Pandemi döneminde 20 kişiyle sınırlı) yararlanabilir. Araştırma Kütüphanesinde digital veritabanları, e-kitap ve e-dergilere ulaşmak için 8 bilgisayar ve 20 tablet bulunuyor. Kütüphanede araştırmacıların kullanımına açık; Felsefe Veritabanı, Torrossa Akdeniz Çalışmaları Veritabanı, dergiler ve Türkçe 3672 e-kitap bulunmaktadır.\",\n      \"imageUrl\": \"libraryImages/havagazi.png\",\n      \"openHours\": \"09:00 - 21:00\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Ahmet Piriştina Vapur Kütüphanesi\",\n      \"information\": \"Türkiye'nin ilk vapur kütüphanesidir. Vapuru kullanan vatandaşlar üyelik işlemi ile 2 kitabı 21 gün süreyle ödünç alabilir. Kitaplar kütüphanenin yanı sıra Bostanlı ve Üçkuyular iskelelerinde bulunan kitap sandıklarına bırakılabilir. Kütüphanede 550 Türkçe kitap bulunmaktadır.\",\n      \"imageUrl\": \"libraryImages/piristina.png\",\n      \"openHours\": \"09:00 - 21:00\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Gezici Kütüphane\",\n      \"information\": \"7'den 70'e herkesin kitaba erişimini kolaylaştırmak ve kitap okuma alışkanlığını geliştirmek için İzmir Büyükşehir Belediyesi'ne ait 2 adet otobüs kütüphane olarak hazırlanmıştır. Köyleri dolaşmakta olan  Gezici Kütüphanelerde tabletler ile internet erişimi, dijital kütüphanede araştırma, okuma hizmeti sunulmaktadır. Kütüphanelerde 1000'er adet kitap bulunmakta ve üyelere 2 kitap 21 gün süreyle ödünç verilmektedir.\",\n      \"imageUrl\": \"libraryImages/gezici.png\",\n      \"openHours\": \"09:00 - 21:00\",\n      \"price\": 0,\n      \"comments\": []\n    }\n  ],\n  \"Historical Places\": [\n    {\n      \"name\": \"İzmir Tarihi Asansör\",\n      \"information\": \"Tarihî Asansör, İzmir'de bulunan tarihsel bir yapıdır. Biri diğerinden 58 m yüksekte olan Mithatpaşa Caddesi ile, Şehit Nihatbey Caddesi'nin arasında işleyen iki asansörü barındıran asansör kulesidir. 1907 yılında Musevi iş adamı \\\"Nesim Levi (Bayraklıoğlu)\\\" tarafından yaptırılan asansör, birinden diğerine 155 basamakla ulaşılan iki semt arasında hızlı ve kolay ulaşım sağlama amacıyla yaptırılmıştır. Günümüzde İzmir Büyükşehir Belediyesi tarafından eğlence, kültür ve dinlenme mekanı olarak kullanılır; kentin önemli bir turistik durağıdır.\",\n      \"imageUrl\": \"historicalImages/asansor.png\",\n      \"openHours\": \"08:00 - 00:00\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İzmir Saat Kulesi\",\n      \"information\": \"Tarihî Asansör, İzmir'de bulunan tarihsel bir yapıdır. Biri diğerinden 58 m yüksekte olan Mithatpaşa Caddesi ile, Şehit Nihatbey Caddesi'nin arasında işleyen iki asansörü barındıran asansör kulesidir. 1907 yılında Musevi iş adamı \\\"Nesim Levi (Bayraklıoğlu)\\\" tarafından yaptırılan asansör, birinden diğerine 155 basamakla ulaşılan iki semt arasında hızlı ve kolay ulaşım sağlama amacıyla yaptırılmıştır. Günümüzde İzmir Büyükşehir Belediyesi tarafından eğlence, kültür ve dinlenme mekanı olarak kullanılır; kentin önemli bir turistik durağıdır.İzmir Saat Kulesi, İzmir'de Osmanlı padişahı II. Abdülhamid'in tahta çıkışının 25. yıldönümünü kutlamak için 1901'de inşa edilmiş tarihî saat kulesidir.\\r\\nKonak Meydanı'ndaki İzmir Hükûmet Konağı, Kemeraltı Çarşısı girişi, Konak Yalı Camii ve İzmir Büyükşehir Belediyesi binası arasındaki alanda yer alır. 25 metre yüksekliğinde ve dört katlı olan kule, Sultan II. Abdülhamid'in iradesi gereği Osmanlı vilayetlerinde aynı dönemde meydana getirilmiş birçok saat kulesinden birisidir. Ancak özgün mimarisi ve yapımında izlenen yöntem nedeniyle diğer saat kuleleri arasında özel bir yer edinmiştir. Osmanlı saat kuleleri içinde en estetik görünüşlü ve en zarifi olarak kabul edilir.\",\n      \"imageUrl\": \"historicalImages/saat.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İzmir Agora Örenyeri\",\n      \"information\": \"İzmir'in Konak İlçesi Kemeraltı mevkinde bulunan Agora Örenyeri, Kemeraltı ile Kadifekale arasında kurulan Symrna antik kentinin Helenistik ve Roma dönemlerinde idari, sosyal, kültürel ve dini işlevlere sahip kent merkezidir. Agora Örenyeri'ndeki kalıntıların önemli bir kısmı M.S 2. yüzyıla tarihlenir. “Agora” sözcüğü, “kent meydanı, çarşı, pazar yeri” anlamına gelir. Hippodamos şehir planına uygun olarak, merkeze yakın bir yerde üç kat halinde inşa edilmiştir. İyon agoralarının en büyük ve iyi korunmuş olanı sayılır.\",\n      \"imageUrl\": \"historicalImages/agora.png\",\n      \"openHours\": \"08:00 - 20:00\",\n      \"price\": 50,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Efes\",\n      \"information\": \"Efes, Anadolu'nun batı kıyısında, bugünkü İzmir ilinin Selçuk ilçesinin üç kilometre güneybatısındaki İyonya kıyısında ve sonraları önemli bir Roma kenti olan antik bir Yunan kentiydi. Kuruluşu Cilalı Taş Devri MÖ 6000 yıllarına dayanır. MÖ 10. yüzyılda eski Arzawa başkentinin yerine Attik ve İyonyalı Yunan kolonistleri tarafından inşa edilmiştir. Klasik Yunan döneminde İyonya'nın on iki şehrinden biriydi. Şehir, MÖ 129'da Roma Cumhuriyeti ‘nin kontrolüne geçtikten sonra gelişti. 1994'te UNESCO tarafından Dünya Mirası Geçici Listesi'ne dahil edilen[1] Efes 2015'te ise Dünya Mirası olarak tescil edildi.\",\n      \"imageUrl\": \"historicalImages/efes.png\",\n      \"openHours\": \"08:00 - 20:00\",\n      \"price\": 120,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İzmir Hisar Camii\",\n      \"information\": \"Hisar Camisi, 1592 yılında Yakup Bey tarafından yaptırılmıştır. İzmir’in en büyük ve gösterişli camisidir. Merkezî bir kubbe ve bunun etrafında yer alan küçük kubbelerle örtülü bir harim mekânı (ibadet edilen asıl mekân) ile kubbeli bir son cemaat yerinden oluşmaktadır. Yenilenen minaresi ile cami, klasik dönem Osmanlı camilerinin tipik özelliklerini taşımaktadır. Cami içindeki kalem işi süslemeleri, hat sanatının inceliklerinin sergilendiği panolar ve mihrap-minber işçiliği Türk sanat zevkinin en iyi örneklerindendir. Cami 1813, 1881, 1927 ve 1980’li yıllarda onarım görmüştür.\",\n      \"imageUrl\": \"historicalImages/hisar.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    }\n  ],\n  \"Hotels\": [\n    {\n      \"name\": \"İzmir Marriott Hotel\",\n      \"information\": \"İzmir Konak bölgesinde bir lüks otel ve tatil köyü.\",\n      \"imageUrl\": \"hotelImages/marriott.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 3250,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Swissotel Büyük Efes İzmir\",\n      \"information\": \"İzmir Alsancak bölgesinde bir lüks otel.\",\n      \"imageUrl\": \"hotelImages/swissotel.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 2720,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Hilton Garden Inn İzmir Bayraklı\",\n      \"information\": \"İzmir Bayraklı bölgesinde bir lüks otel.\",\n      \"imageUrl\": \"hotelImages/bayrakli.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 1375,\n      \"comments\": []\n    }\n  ],\n  \"Markets\": [\n    {\n      \"name\": \"Kemeraltı Çarşısı\",\n      \"information\": \"Kemeraltı, Türkiye'nin İzmir şehrinde, Konak ilçesindeki Mezarlıkbaşı semtinden başlayarak Konak Meydanı'na kadar ulaşan ve ticari faaliyetlerin yoğun şekilde yaşandığı semt ve çarşıdır. Fevzipaşa Caddesi ve Eşrefpaşa Caddesi çarşının kara sınırlarını oluşturur.\",\n      \"imageUrl\": \"marketImages/kemeralti.png\",\n      \"openHours\": \"09:00 - 22:00\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Özdilek Süpermarket\",\n      \"information\": \"Balçova bölgesinde bir süpermarket.\",\n      \"imageUrl\": \"marketImages/ozdilek.png\",\n      \"openHours\": \"09:00 - 22:00\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"MaviBahçe AVM\",\n      \"information\": \"İzmir Mavişehir bölgesinde bir alış-veriş merkezi.\",\n      \"imageUrl\": \"marketImages/mavibahce.png\",\n      \"openHours\": \"09:00 - 22:00\",\n      \"price\": 0,\n      \"comments\": []\n    }\n  ],\n  \"Places of Worship\": [\n    {\n      \"name\": \"Santa Maria Kilisesi (Bornova)\",\n      \"information\": \"Bornova ilçesi, Erzene Mahallesi, 80 Sokak no.5 adresinde bulunan Katolik Kilisesidir. 1797 yılında Fransisken Mezhebi mensupları tarafından Bizans tarzında inşa edilen yapı, 1832 yılında küçük bir restorasyon geçirmiştir.\",\n      \"imageUrl\": \"worshipImages/santamaria.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Notre Dame De St. Holy Rosary Kilisesi\",\n      \"information\": \"Alsancak semtinde, 1481 Sokak No.8 adresinde bulunan Katolik Kilisesidir.1850 tarihli ilk yapı 1904 yılında yıkılarak şu andaki haliyle yeniden inşa edilmiştir.\",\n      \"imageUrl\": \"worshipImages/notredame.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Saint John Avengelist Kilisesi\",\n      \"information\": \"Alsancak semti, Mahmut Esat Bozkurt Caddesi, No 49 adresinde bulunan Anglikan Kilisesidir. 07 Nisan 1902 tarihinde açılmıştır.\",\n      \"imageUrl\": \"worshipImages/avengelist.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"Kestanepazarı Camii\",\n      \"information\": \"Kestanepazarı Camii (Kızıl İbrâhim Camii veya Ahmed Ağa Camii), İzmir'in Konak ilçesinde bulunan (Hicri) 1078, (Miladi) 1667-68 yılında inşası tamamlanmış cami.\",\n      \"imageUrl\": \"worshipImages/kestanepazari.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    },\n    {\n      \"name\": \"İzmir Konak Camii\",\n      \"information\": \"Konak Camii, bilinen diğer adıyla Yalı Camii, Türkiye'nin İzmir şehrinde yer alan bir camidir. Konak ilçesinde, kent merkezindeki Konak Meydanı'nda konumlanır. 18. yüzyılda klasik Osmanlı mimarisi tarzında inşa edilmiş olan firüze çinilerle süslü cami, Konak Meydanı ile özdeşleşmiş bir yapıdır. Yanında İzmir Saat Kulesi, Hükûmet Konağı ve 15 Mayıs 1919'da Yunanlar tarafından öldürülen Hasan Tahsin için dikilen İlk Kurşun Anıtı bulunur\",\n      \"imageUrl\": \"worshipImages/konak.png\",\n      \"openHours\": \"7/24\",\n      \"price\": 0,\n      \"comments\": []\n    }\n  ],\n  \"Car Parks\": [\n    {\n      \"name\": \"Çankaya Katlı Otoparkı\",\n      \"information\": \"İzmir Konak bölgesinde bir çok katlı otopark.\",\n      \"imageUrl\": \"carparkImages/cankaya.png\",\n      \"openHours\": \"7/24\",\n      \"price\": \"40₺\",\n      \"comments\": []\n    },\n    {\n      \"name\": \"Alsancak Katlı Otoparkı\",\n      \"information\": \"İzmir Alsancak bölgesinde bir çok katlı otopark.\",\n      \"imageUrl\": \"carparkImages/alsancak.png\",\n      \"openHours\": \"7/24\",\n      \"price\": \"35₺\",\n      \"comments\": []\n    },\n    {\n      \"name\": \"Kahramanlar Otoparkı\",\n      \"information\": \"İzmir Kahramanlar bölgesinde bir çok katlı otopark.\",\n      \"imageUrl\": \"carparkImages/kahramanlar.png\",\n      \"openHours\": \"7/24\",\n      \"price\": \"30₺\",\n      \"comments\": []\n    }\n  ]\n}";

  @override
  void initState() {
    super.initState();
    initJsonData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initJsonData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get('myJsonData') == null) {
      sharedPreferences.setString('myJsonData', myJsonData);
    } else {
      myJsonData = sharedPreferences.getString('myJsonData') ?? myJsonData;
    }
    setState(() {});
  }

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  // enumerators can be used instead, it's a more elegant solution
  String notSoGoodSolution(int index) {
    switch (index) {
      case 0:
        return "Parks";
      case 1:
        return "Libraries";
      case 2:
        return "Historical Places";
      case 3:
        return "Hotels";
      case 4:
        return "Markets";
      case 5:
        return "Places of Worship";
      case 6:
        return "Car Parks";
      default:
        return "";
    }
  }

  String getCategoryImage(int index) {
    switch (index) {
      case 0: // Parks
        return "assets/categoryImages/parks.jpg";
      case 1: // Libraries
        return "assets/categoryImages/libraries.png";
      case 2: // Historical Places
        return "assets/categoryImages/historical.png";
      case 3: // Hotels
        return "assets/categoryImages/hotels.png";
      case 4: // Markets
        return "assets/categoryImages/markets.jpg";
      case 5: // Places of Worship
        return "assets/categoryImages/worship.jpg";
      case 6: // Car Parks
        return "assets/categoryImages/carparks.jpg";
      default:
        return "assets/categoryImages/parks.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonList = jsonDecode(myJsonData);

    return Scaffold(
        appBar: CategoriesAppBar(context),
        body: Container(
          color: Colors.teal[50],
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.width * 0.02),
          child: ListView.builder(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            itemCount: jsonList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print(notSoGoodSolution(index));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new ItemsScreen(
                              category: notSoGoodSolution(index),
                              myJsonData: myJsonData,
                              username: widget.username,
                            )),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListViewCard(context, index),
                ),
              );
            },
          ),
        ));
  }

  AppBar CategoriesAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "İzmir Tour Guide",
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => new LoginScreen()),
              );
            },
            child: Text(
              "Logout",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ))
      ],
      backgroundColor: Colors.teal,
    );
  }

  Card ListViewCard(BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(children: [
        Text(
          notSoGoodSolution(index),
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        Expanded(
          child: Image.asset(
            getCategoryImage(index),
            fit: BoxFit.cover,
            width: 1000,
          ),
        )
      ]),
      shadowColor: Colors.teal,
    );
  }
}

/*
Stack(
        children: [
          Container(
            color: Colors.amber,
            child: Image.network(
              "http://www.lakemetroparks.com/KenticoTemplate/media/LakeMetroparks/Parks/Lakeshore-Reservation-path-spring-home1-LynnAnn-Smith.jpg?quality=40",
              fit: BoxFit.cover,
              width: 1000,
            ),
          ),
          Text(
            notSoGoodSolution(index),
            style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                background: Paint()
                  ..strokeWidth = 10
                  ..color = Colors.grey
                  ..style = PaintingStyle.fill
                  ..strokeCap = StrokeCap.round
                  ..strokeJoin = StrokeJoin.round),
          ),
        ],
      )
*/
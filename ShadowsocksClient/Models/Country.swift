//
//  Country.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 14.06.2024.
//

import Foundation

enum Country: Codable, CaseIterable {
  case afghanistan
  case albania
  case algeria
  case americanSamoa
  case andorra
  case angola
  case anguilla
  case antarctica
  case antiguaAndBarbuda
  case argentina
  case armenia
  case aruba
  case australia
  case austria
  case azerbaijan
  case bahamas
  case bahrain
  case bangladesh
  case barbados
  case belarus
  case belgium
  case belize
  case benin
  case bermuda
  case bhutan
  case bolivia
  case bosniaAndHerzegovina
  case botswana
  case brazil
  case brunei
  case bulgaria
  case burkinaFaso
  case burundi
  case capeVerde
  case cambodia
  case cameroon
  case canada
  case caymanIslands
  case centralAfricanRepublic
  case chad
  case chile
  case china
  case christmasIsland
  case cocosIslands
  case colombia
  case comoros
  case congoBrazzaville
  case congoKinshasa
  case cookIslands
  case costaRica
  case croatia
  case cuba
  case curacao
  case cyprus
  case czechia
  case denmark
  case djibouti
  case dominica
  case dominicanRepublic
  case ecuador
  case egypt
  case elSalvador
  case equatorialGuinea
  case eritrea
  case estonia
  case eswatini
  case ethiopia
  case falklandIslands
  case faroeIslands
  case fiji
  case finland
  case france
  case frenchGuiana
  case frenchPolynesia
  case gabon
  case gambia
  case georgia
  case germany
  case ghana
  case gibraltar
  case greece
  case greenland
  case grenada
  case guadeloupe
  case guam
  case guatemala
  case guernsey
  case guinea
  case guineaBissau
  case guyana
  case haiti
  case honduras
  case hongKong
  case hungary
  case iceland
  case india
  case indonesia
  case iran
  case iraq
  case ireland
  case isleOfMan
  case israel
  case italy
  case ivoryCoast
  case jamaica
  case japan
  case jersey
  case jordan
  case kazakhstan
  case kenya
  case kiribati
  case kosovo
  case kuwait
  case kyrgyzstan
  case laos
  case latvia
  case lebanon
  case lesotho
  case liberia
  case libya
  case liechtenstein
  case lithuania
  case luxembourg
  case macau
  case madagascar
  case malawi
  case malaysia
  case maldives
  case mali
  case malta
  case marshallIslands
  case martinique
  case mauritania
  case mauritius
  case mayotte
  case mexico
  case micronesia
  case moldova
  case monaco
  case mongolia
  case montenegro
  case montserrat
  case morocco
  case mozambique
  case myanmar
  case namibia
  case nauru
  case nepal
  case netherlands
  case newCaledonia
  case newZealand
  case nicaragua
  case niger
  case nigeria
  case niue
  case norfolkIsland
  case northMacedonia
  case northernMarianaIslands
  case norway
  case oman
  case pakistan
  case palau
  case palestine
  case panama
  case papuaNewGuinea
  case paraguay
  case peru
  case philippines
  case poland
  case portugal
  case puertoRico
  case qatar
  case romania
  case russia
  case rwanda
  case reunion
  case samoa
  case sanMarino
  case saoTomeAndPrincipe
  case saudiArabia
  case senegal
  case serbia
  case seychelles
  case sierraLeone
  case singapore
  case slovakia
  case slovenia
  case solomonIslands
  case somalia
  case southAfrica
  case southGeorgiaAndSouthSandwichIslands
  case southKorea
  case southSudan
  case spain
  case sriLanka
  case sudan
  case suriname
  case svalbardAndJanMayen
  case sweden
  case switzerland
  case syria
  case taiwan
  case tajikistan
  case tanzania
  case thailand
  case timorLeste
  case togo
  case tokelau
  case tonga
  case trinidadAndTobago
  case tunisia
  case turkey
  case turkmenistan
  case turksAndCaicosIslands
  case tuvalu
  case uganda
  case ukraine
  case unitedArabEmirates
  case unitedKingdom
  case unitedStates
  case uruguay
  case uzbekistan
  case vanuatu
  case vaticanCity
  case venezuela
  case vietnam
  case wallisAndFutuna
  case westernSahara
  case yemen
  case zambia
  case zimbabwe
  
  var flag: String {
    switch self {
    case .afghanistan: "🇦🇫"
    case .albania: "🇦🇱"
    case .algeria: "🇩🇿"
    case .americanSamoa: "🇦🇸"
    case .andorra: "🇦🇩"
    case .angola: "🇦🇴"
    case .anguilla: "🇦🇮"
    case .antarctica: "🇦🇶"
    case .antiguaAndBarbuda: "🇦🇬"
    case .argentina: "🇦🇷"
    case .armenia: "🇦🇲"
    case .aruba: "🇦🇼"
    case .australia: "🇦🇺"
    case .austria: "🇦🇹"
    case .azerbaijan: "🇦🇿"
    case .bahamas: "🇧🇸"
    case .bahrain: "🇧🇭"
    case .bangladesh: "🇧🇩"
    case .barbados: "🇧🇧"
    case .belarus: "🇧🇾"
    case .belgium: "🇧🇪"
    case .belize: "🇧🇿"
    case .benin: "🇧🇯"
    case .bermuda: "🇧🇲"
    case .bhutan: "🇧🇹"
    case .bolivia: "🇧🇴"
    case .bosniaAndHerzegovina: "🇧🇦"
    case .botswana: "🇧🇼"
    case .brazil: "🇧🇷"
    case .brunei: "🇧🇳"
    case .bulgaria: "🇧🇬"
    case .burkinaFaso: "🇧🇫"
    case .burundi: "🇧🇮"
    case .capeVerde: "🇨🇻"
    case .cambodia: "🇰🇭"
    case .cameroon: "🇨🇲"
    case .canada: "🇨🇦"
    case .caymanIslands: "🇰🇾"
    case .centralAfricanRepublic: "🇨🇫"
    case .chad: "🇹🇩"
    case .chile: "🇨🇱"
    case .china: "🇨🇳"
    case .christmasIsland: "🇨🇽"
    case .cocosIslands: "🇨🇨"
    case .colombia: "🇨🇴"
    case .comoros: "🇰🇲"
    case .congoBrazzaville: "🇨🇬"
    case .congoKinshasa: "🇨🇩"
    case .cookIslands: "🇨🇰"
    case .costaRica: "🇨🇷"
    case .croatia: "🇭🇷"
    case .cuba: "🇨🇺"
    case .curacao: "🇨🇼"
    case .cyprus: "🇨🇾"
    case .czechia: "🇨🇿"
    case .denmark: "🇩🇰"
    case .djibouti: "🇩🇯"
    case .dominica: "🇩🇲"
    case .dominicanRepublic: "🇩🇴"
    case .ecuador: "🇪🇨"
    case .egypt: "🇪🇬"
    case .elSalvador: "🇸🇻"
    case .equatorialGuinea: "🇬🇶"
    case .eritrea: "🇪🇷"
    case .estonia: "🇪🇪"
    case .eswatini: "🇸🇿"
    case .ethiopia: "🇪🇹"
    case .falklandIslands: "🇫🇰"
    case .faroeIslands: "🇫🇴"
    case .fiji: "🇫🇯"
    case .finland: "🇫🇮"
    case .france: "🇫🇷"
    case .frenchGuiana: "🇬🇫"
    case .frenchPolynesia: "🇵🇫"
    case .gabon: "🇬🇦"
    case .gambia: "🇬🇲"
    case .georgia: "🇬🇪"
    case .germany: "🇩🇪"
    case .ghana: "🇬🇭"
    case .gibraltar: "🇬🇮"
    case .greece: "🇬🇷"
    case .greenland: "🇬🇱"
    case .grenada: "🇬🇩"
    case .guadeloupe: "🇬🇵"
    case .guam: "🇬🇺"
    case .guatemala: "🇬🇹"
    case .guernsey: "🇬🇬"
    case .guinea: "🇬🇳"
    case .guineaBissau: "🇬🇼"
    case .guyana: "🇬🇾"
    case .haiti: "🇭🇹"
    case .honduras: "🇭🇳"
    case .hongKong: "🇭🇰"
    case .hungary: "🇭🇺"
    case .iceland: "🇮🇸"
    case .india: "🇮🇳"
    case .indonesia: "🇮🇩"
    case .iran: "🇮🇷"
    case .iraq: "🇮🇶"
    case .ireland: "🇮🇪"
    case .isleOfMan: "🇮🇲"
    case .israel: "🇮🇱"
    case .italy: "🇮🇹"
    case .ivoryCoast: "🇨🇮"
    case .jamaica: "🇯🇲"
    case .japan: "🇯🇵"
    case .jersey: "🇯🇪"
    case .jordan: "🇯🇴"
    case .kazakhstan: "🇰🇿"
    case .kenya: "🇰🇪"
    case .kiribati: "🇰🇮"
    case .kosovo: "🇽🇰"
    case .kuwait: "🇰🇼"
    case .kyrgyzstan: "🇰🇬"
    case .laos: "🇱🇦"
    case .latvia: "🇱🇻"
    case .lebanon: "🇱🇧"
    case .lesotho: "🇱🇸"
    case .liberia: "🇱🇷"
    case .libya: "🇱🇾"
    case .liechtenstein: "🇱🇮"
    case .lithuania: "🇱🇹"
    case .luxembourg: "🇱🇺"
    case .macau: "🇲🇴"
    case .madagascar: "🇲🇬"
    case .malawi: "🇲🇼"
    case .malaysia: "🇲🇾"
    case .maldives: "🇲🇻"
    case .mali: "🇲🇱"
    case .malta: "🇲🇹"
    case .marshallIslands: "🇲🇭"
    case .martinique: "🇲🇶"
    case .mauritania: "🇲🇷"
    case .mauritius: "🇲🇺"
    case .mayotte: "🇾🇹"
    case .mexico: "🇲🇽"
    case .micronesia: "🇫🇲"
    case .moldova: "🇲🇩"
    case .monaco: "🇲🇨"
    case .mongolia: "🇲🇳"
    case .montenegro: "🇲🇪"
    case .montserrat: "🇲🇸"
    case .morocco: "🇲🇦"
    case .mozambique: "🇲🇿"
    case .myanmar: "🇲🇲"
    case .namibia: "🇳🇦"
    case .nauru: "🇳🇷"
    case .nepal: "🇳🇵"
    case .netherlands: "🇳🇱"
    case .newCaledonia: "🇳🇨"
    case .newZealand: "🇳🇿"
    case .nicaragua: "🇳🇮"
    case .niger: "🇳🇪"
    case .nigeria: "🇳🇬"
    case .niue: "🇳🇺"
    case .norfolkIsland: "🇳🇫"
    case .northMacedonia: "🇲🇰"
    case .northernMarianaIslands: "🇲🇵"
    case .norway: "🇳🇴"
    case .oman: "🇴🇲"
    case .pakistan: "🇵🇰"
    case .palau: "🇵🇼"
    case .palestine: "🇵🇸"
    case .panama: "🇵🇦"
    case .papuaNewGuinea: "🇵🇬"
    case .paraguay: "🇵🇾"
    case .peru: "🇵🇪"
    case .philippines: "🇵🇭"
    case .poland: "🇵🇱"
    case .portugal: "🇵🇹"
    case .puertoRico: "🇵🇷"
    case .qatar: "🇶🇦"
    case .romania: "🇷🇴"
    case .russia: "🇷🇺"
    case .rwanda: "🇷🇼"
    case .reunion: "🇷🇪"
    case .samoa: "🇼🇸"
    case .sanMarino: "🇸🇲"
    case .saoTomeAndPrincipe: "🇸🇹"
    case .saudiArabia: "🇸🇦"
    case .senegal: "🇸🇳"
    case .serbia: "🇷🇸"
    case .seychelles: "🇸🇨"
    case .sierraLeone: "🇸🇱"
    case .singapore: "🇸🇬"
    case .slovakia: "🇸🇰"
    case .slovenia: "🇸🇮"
    case .solomonIslands: "🇸🇧"
    case .somalia: "🇸🇴"
    case .southAfrica: "🇿🇦"
    case .southGeorgiaAndSouthSandwichIslands: "🇬🇸"
    case .southKorea: "🇰🇷"
    case .southSudan: "🇸🇸"
    case .spain: "🇪🇸"
    case .sriLanka: "🇱🇰"
    case .sudan: "🇸🇩"
    case .suriname: "🇸🇷"
    case .svalbardAndJanMayen: "🇸🇯"
    case .sweden: "🇸🇪"
    case .switzerland: "🇨🇭"
    case .syria: "🇸🇾"
    case .taiwan: "🇹🇼"
    case .tajikistan: "🇹🇯"
    case .tanzania: "🇹🇿"
    case .thailand: "🇹🇭"
    case .timorLeste: "🇹🇱"
    case .togo: "🇹🇬"
    case .tokelau: "🇹🇰"
    case .tonga: "🇹🇴"
    case .trinidadAndTobago: "🇹🇹"
    case .tunisia: "🇹🇳"
    case .turkey: "🇹🇷"
    case .turkmenistan: "🇹🇲"
    case .turksAndCaicosIslands: "🇹🇨"
    case .tuvalu: "🇹🇻"
    case .uganda: "🇺🇬"
    case .ukraine: "🇺🇦"
    case .unitedArabEmirates: "🇦🇪"
    case .unitedKingdom: "🇬🇧"
    case .unitedStates: "🇺🇸"
    case .uruguay: "🇺🇾"
    case .uzbekistan: "🇺🇿"
    case .vanuatu: "🇻🇺"
    case .vaticanCity: "🇻🇦"
    case .venezuela: "🇻🇪"
    case .vietnam: "🇻🇳"
    case .wallisAndFutuna: "🇼🇫"
    case .westernSahara: "🇪🇭"
    case .yemen: "🇾🇪"
    case .zambia: "🇿🇲"
    case .zimbabwe: "🇿🇼"
    }
  }
  
  var name: LocalizedStringResource {
    switch self {
    case .afghanistan: "Afghanistan"
    case .albania: "Albania"
    case .algeria: "Algeria"
    case .americanSamoa: "American Samoa"
    case .andorra: "Andorra"
    case .angola: "Angola"
    case .anguilla: "Anguilla"
    case .antarctica: "Antarctica"
    case .antiguaAndBarbuda: "Antigua and Barbuda"
    case .argentina: "Argentina"
    case .armenia: "Armenia"
    case .aruba: "Aruba"
    case .australia: "Australia"
    case .austria: "Austria"
    case .azerbaijan: "Azerbaijan"
    case .bahamas: "Bahamas"
    case .bahrain: "Bahrain"
    case .bangladesh: "Bangladesh"
    case .barbados: "Barbados"
    case .belarus: "Belarus"
    case .belgium: "Belgium"
    case .belize: "Belize"
    case .benin: "Benin"
    case .bermuda: "Bermuda"
    case .bhutan: "Bhutan"
    case .bolivia: "Bolivia"
    case .bosniaAndHerzegovina: "Bosnia and Herzegovina"
    case .botswana: "Botswana"
    case .brazil: "Brazil"
    case .brunei: "Brunei"
    case .bulgaria: "Bulgaria"
    case .burkinaFaso: "Burkina Faso"
    case .burundi: "Burundi"
    case .capeVerde: "Cape Verde"
    case .cambodia: "Cambodia"
    case .cameroon: "Cameroon"
    case .canada: "Canada"
    case .caymanIslands: "Cayman Islands"
    case .centralAfricanRepublic: "Central African Republic"
    case .chad: "Chad"
    case .chile: "Chile"
    case .china: "China"
    case .christmasIsland: "Christmas Island"
    case .cocosIslands: "Cocos (Keeling) Islands"
    case .colombia: "Colombia"
    case .comoros: "Comoros"
    case .congoBrazzaville: "Congo - Brazzaville"
    case .congoKinshasa: "Congo - Kinshasa"
    case .cookIslands: "Cook Islands"
    case .costaRica: "Costa Rica"
    case .croatia: "Croatia"
    case .cuba: "Cuba"
    case .curacao: "Curaçao"
    case .cyprus: "Cyprus"
    case .czechia: "Czechia"
    case .denmark: "Denmark"
    case .djibouti: "Djibouti"
    case .dominica: "Dominica"
    case .dominicanRepublic: "Dominican Republic"
    case .ecuador: "Ecuador"
    case .egypt: "Egypt"
    case .elSalvador: "El Salvador"
    case .equatorialGuinea: "Equatorial Guinea"
    case .eritrea: "Eritrea"
    case .estonia: "Estonia"
    case .eswatini: "Eswatini"
    case .ethiopia: "Ethiopia"
    case .falklandIslands: "Falkland Islands"
    case .faroeIslands: "Faroe Islands"
    case .fiji: "Fiji"
    case .finland: "Finland"
    case .france: "France"
    case .frenchGuiana: "French Guiana"
    case .frenchPolynesia: "French Polynesia"
    case .gabon: "Gabon"
    case .gambia: "Gambia"
    case .georgia: "Georgia"
    case .germany: "Germany"
    case .ghana: "Ghana"
    case .gibraltar: "Gibraltar"
    case .greece: "Greece"
    case .greenland: "Greenland"
    case .grenada: "Grenada"
    case .guadeloupe: "Guadeloupe"
    case .guam: "Guam"
    case .guatemala: "Guatemala"
    case .guernsey: "Guernsey"
    case .guinea: "Guinea"
    case .guineaBissau: "Guinea-Bissau"
    case .guyana: "Guyana"
    case .haiti: "Haiti"
    case .honduras: "Honduras"
    case .hongKong: "Hong Kong SAR China"
    case .hungary: "Hungary"
    case .iceland: "Iceland"
    case .india: "India"
    case .indonesia: "Indonesia"
    case .iran: "Iran"
    case .iraq: "Iraq"
    case .ireland: "Ireland"
    case .isleOfMan: "Isle of Man"
    case .israel: "Israel"
    case .italy: "Italy"
    case .ivoryCoast: "Ivory Coast"
    case .jamaica: "Jamaica"
    case .japan: "Japan"
    case .jersey: "Jersey"
    case .jordan: "Jordan"
    case .kazakhstan: "Kazakhstan"
    case .kenya: "Kenya"
    case .kiribati: "Kiribati"
    case .kosovo: "Kosovo"
    case .kuwait: "Kuwait"
    case .kyrgyzstan: "Kyrgyzstan"
    case .laos: "Laos"
    case .latvia: "Latvia"
    case .lebanon: "Lebanon"
    case .lesotho: "Lesotho"
    case .liberia: "Liberia"
    case .libya: "Libya"
    case .liechtenstein: "Liechtenstein"
    case .lithuania: "Lithuania"
    case .luxembourg: "Luxembourg"
    case .macau: "Macau SAR China"
    case .madagascar: "Madagascar"
    case .malawi: "Malawi"
    case .malaysia: "Malaysia"
    case .maldives: "Maldives"
    case .mali: "Mali"
    case .malta: "Malta"
    case .marshallIslands: "Marshall Islands"
    case .martinique: "Martinique"
    case .mauritania: "Mauritania"
    case .mauritius: "Mauritius"
    case .mayotte: "Mayotte"
    case .mexico: "Mexico"
    case .micronesia: "Micronesia"
    case .moldova: "Moldova"
    case .monaco: "Monaco"
    case .mongolia: "Mongolia"
    case .montenegro: "Montenegro"
    case .montserrat: "Montserrat"
    case .morocco: "Morocco"
    case .mozambique: "Mozambique"
    case .myanmar: "Myanmar (Burma)"
    case .namibia: "Namibia"
    case .nauru: "Nauru"
    case .nepal: "Nepal"
    case .netherlands: "Netherlands"
    case .newCaledonia: "New Caledonia"
    case .newZealand: "New Zealand"
    case .nicaragua: "Nicaragua"
    case .niger: "Niger"
    case .nigeria: "Nigeria"
    case .niue: "Niue"
    case .norfolkIsland: "Norfolk Island"
    case .northMacedonia: "North Macedonia"
    case .northernMarianaIslands: "Northern Mariana Islands"
    case .norway: "Norway"
    case .oman: "Oman"
    case .pakistan: "Pakistan"
    case .palau: "Palau"
    case .palestine: "Palestinian Territories"
    case .panama: "Panama"
    case .papuaNewGuinea: "Papua New Guinea"
    case .paraguay: "Paraguay"
    case .peru: "Peru"
    case .philippines: "Philippines"
    case .poland: "Poland"
    case .portugal: "Portugal"
    case .puertoRico: "Puerto Rico"
    case .qatar: "Qatar"
    case .romania: "Romania"
    case .russia: "Russia"
    case .rwanda: "Rwanda"
    case .reunion: "Réunion"
    case .samoa: "Samoa"
    case .sanMarino: "San Marino"
    case .saoTomeAndPrincipe: "São Tomé and Príncipe"
    case .saudiArabia: "Saudi Arabia"
    case .senegal: "Senegal"
    case .serbia: "Serbia"
    case .seychelles: "Seychelles"
    case .sierraLeone: "Sierra Leone"
    case .singapore: "Singapore"
    case .slovakia: "Slovakia"
    case .slovenia: "Slovenia"
    case .solomonIslands: "Solomon Islands"
    case .somalia: "Somalia"
    case .southAfrica: "South Africa"
    case .southGeorgiaAndSouthSandwichIslands: "South Georgia and South Sandwich Islands"
    case .southKorea: "South Korea"
    case .southSudan: "South Sudan"
    case .spain: "Spain"
    case .sriLanka: "Sri Lanka"
    case .sudan: "Sudan"
    case .suriname: "Suriname"
    case .svalbardAndJanMayen: "Svalbard and Jan Mayen"
    case .sweden: "Sweden"
    case .switzerland: "Switzerland"
    case .syria: "Syria"
    case .taiwan: "Taiwan"
    case .tajikistan: "Tajikistan"
    case .tanzania: "Tanzania"
    case .thailand: "Thailand"
    case .timorLeste: "Timor-Leste"
    case .togo: "Togo"
    case .tokelau: "Tokelau"
    case .tonga: "Tonga"
    case .trinidadAndTobago: "Trinidad and Tobago"
    case .tunisia: "Tunisia"
    case .turkey: "Turkey"
    case .turkmenistan: "Turkmenistan"
    case .turksAndCaicosIslands: "Turks and Caicos Islands"
    case .tuvalu: "Tuvalu"
    case .uganda: "Uganda"
    case .ukraine: "Ukraine"
    case .unitedArabEmirates: "United Arab Emirates"
    case .unitedKingdom: "United Kingdom"
    case .unitedStates: "United States"
    case .uruguay: "Uruguay"
    case .uzbekistan: "Uzbekistan"
    case .vanuatu: "Vanuatu"
    case .vaticanCity: "Vatican City"
    case .venezuela: "Venezuela"
    case .vietnam: "Vietnam"
    case .wallisAndFutuna: "Wallis and Futuna"
    case .westernSahara: "Western Sahara"
    case .yemen: "Yemen"
    case .zambia: "Zambia"
    case .zimbabwe: "Zimbabwe"
    }
  }
  
  var formattedString: LocalizedStringResource {
    "\(flag) \(name)"
  }
}

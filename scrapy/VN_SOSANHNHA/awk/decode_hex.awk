# Decode html 
function decode_hex(s){
	gsub(/&#x110;/,"Đ",s);
	gsub(/&#x1B0;/,"ư",s)
	gsub(/&#x1EDD;/,"ờ",s)
	gsub(/&#xFA;/,"ú",s)
	gsub(/&#xE3;/,"ã",s)
	gsub(/&#xE2;/,"â",s)
	gsub(/&#x1EC7;/,"ệ",s)
	gsub(/&#x103;/,"ă",s)
	gsub(/&#x1EC9;/,"ỉ",s)
	gsub(/&#xEA;/,"ê",s)
	gsub(/&#x1EBF;/,"ế",s)
	gsub(/&#xE1;/,"á",s)
	gsub(/&#x1ED0;/,"ố",s)
	gsub(/&#xF5;/,"õ",s)
	gsub(/&#x1EA7;/,"ầ",s)
	gsub(/&#x1EAD;/,"ậ",s)
	gsub(/&#x1EA5;/,"ấ",s)
	gsub(/&#xE0;/,"à",s)
	gsub(/&#x1ED9;/,"ộ",s)
	gsub(/&#x1A1;/,"ơ",s)
	gsub(/&#x1ED1;/,"ố",s)
	gsub(/&#xF4;/,"ô",s)
	gsub(/&#x1EEB;/,"ừ",s)
	gsub(/&#x1EE9;/,"ứ",s)
	gsub(/&#x1EAF;/,"ắ",s)
	gsub(/&#x1ECB;/,"ị",s)
	gsub(/&#x1ECD;/,"ọ",s)
	gsub(/&#x111;/,"đ",s)
	gsub(/&#x1EEF;/,"ữ",s)
	gsub(/&#x1EA1;/,"ạ",s)
	gsub(/&#x1ED7;/,"ỗ",s)
	gsub(/&#x323;/,".",s)
	gsub(/&#x303;/,"~",s)
	gsub(/&#x300;/,"`",s)
	gsub(/&#xF2;/,"ò",s)
	gsub(/&#x1ED3;/,"ồ",s)
	gsub(/&#x1EE7;/,"ủ",s)
	gsub(/&#x1EE5;/,"ụ",s)
	gsub(/&#xF9;/,"ù",s)
	gsub(/&#x1EC5;/,"ễ",s)
	gsub(/&#xEC;/,"ì",s)
	gsub(/&#xED;/,"í",s)
	gsub(/&#x1EA3;/,"ả",s)
	gsub(/&#x129;/,"ĩ",s)
	gsub(/&#x1EF1;/,"ự",s)
	gsub(/&#x1EB1;/,"ằ",s)
	gsub(/&#x1EE3;/,"ợ",s)
	gsub(/&#xFD;/,"ý",s)
	gsub(/&#xCD;/,"í",s)
	gsub(/&#x1ED5;/,"ổ",s)
	gsub(/&#x1EF9;/,"ỹ",s)
	gsub(/&#x1EDB;/,"ớ",s)
	gsub(/&#x1EC1;/,"ề",s)
	gsub(/&#x1EF3;/,"ỳ",s)
	gsub(/&#x1EDF;/,"ở",s)
	gsub(/&#x1EC3;/,"ể",s)
	gsub(/&#x1ECF;/,"ó",s)
	gsub(/&#x1EC4;/,"Ễ",s)
	gsub(/&#x102;/,"Ă",s)
	gsub(/&#x1EEA;/,"Ừ",s)
	gsub(/&#x1EAC;/,"Ậ",s)
	gsub(/&#x1EED;/,"ử",s)
	gsub(/&#x169;/,"ũ",s)
	gsub(/&#x1EA9;/,"ẩ",s)
	gsub(/&#xE9;/,"é",s)
	gsub(/&#xD4;/,"Ô",s)
	gsub(/&#x1EB7;/,"ặ",s)
	gsub(/&#xC2;/,"Â",s)
	gsub(/&#x1EF7;/,"ỷ",s)
	gsub(/&#x1EBB;/,"ẻ",s)
	gsub(/&#x1EA4;/,"Ấ",s)
	gsub(/&#x2013;/,"-",s)
	gsub(/&#xF3;/,"ó",s)
	gsub(/&#x1EBA;/,"Ẻ",s)
	gsub(/&#x1EB5;/,"ẵ",s)
	gsub(/&#x301;/," ́",s)
	gsub(/&#x309;/," ̉",s)
	
	gsub(/\\u00ea/,"ê",s)
	gsub(/\\u1ec7/,"ệ",s)
	gsub(/\\u00b/,"",s)
	gsub(/\\u00e1/,"á",s)
	gsub(/u1ef7/,"ỷ",s)
	gsub(/u0110/,"Đ",s)
	gsub(/u1ead/,"ậ",s)
	# gsub(/&#x1ECD;/,"ọ",s)
	# gsub(/&#x111;/,"đ",s)
	# gsub(/&#x1EEF;/,"ữ",s)
	# gsub(/&#x1EA1;/,"ạ",s)
	# gsub(/&#x1ED7;/,"ỗ",s)
	# gsub(/&#x323;/,".",s)
	# gsub(/&#x303;/,"~",s)
	# gsub(/&#x300;/,"`",s)
	# gsub(/&#xF2;/,"ò",s)
	# gsub(/&#x1ED3;/,"ồ",s)
	# gsub(/&#x1EE7;/,"ủ",s)
	# gsub(/&#x1EE5;/,"ụ",s)
	# gsub(/&#xF9;/,"ù",s)
	# gsub(/&#x1EC5;/,"ễ",s)
	# gsub(/&#xEC;/,"ì",s)
	# gsub(/&#xED;/,"í",s)
	# gsub(/&#x1EA3;/,"ả",s)
	# gsub(/&#x129;/,"ĩ",s)
	# gsub(/&#x1EF1;/,"ự",s)
	# gsub(/&#x1EB1;/,"ằ",s)
	# gsub(/&#x1EE3;/,"ợ",s)
	# gsub(/&#xFD;/,"ý",s)
	# gsub(/&#xCD;/,"í",s)
	# gsub(/&#x1ED5;/,"ổ",s)
	# gsub(/&#x1EF9;/,"ỹ",s)
	# gsub(/&#x1EDB;/,"ớ",s)
	# gsub(/&#x1EC1;/,"ề",s)
	# gsub(/&#x1EF3/,"ỳ",s)
	# gsub(/&#x1EDF;/,"ở",s)
	# gsub(/&#x1EC3;/,"ể",s)
	# gsub(/&#x1ECF;/,"ó",s)
	# gsub(/&#x1EC4;/,"Ễ",s)
	# gsub(/&#x102;/,"Ă",s)

	return s;
}


#Check data parsing empty
function checkParsingEmpty(arr_val){
	temp=0 # number of field not null
	for (key in arr_val){
		if (arr_val[key]!="")
			temp+=1
	}
	if (temp < 2) # at least two fields not null
		exit 
}

# Each tag stay only one line 
function newBreakLineTag(s){
	gsub(">",">\n",s);
	gsub("<","\n<",s);
	return s;
}

# Remove character new line
function removeNewLine(s){
	gsub(/\n/," ",s);
	gsub(/\r/," ",s);
	return s;
}

# Remove all tags HTML
function removeHtml(m) {
	gsub(/<[^>]+>/, " ", m);
	gsub("\""," ",m);
   	gsub("[\t ]+$", " ", m);
    	gsub("^[\t ]+", " ", m);
    	gsub("\n", " ", m);    
    	gsub(/[ ]+/, " ", m);
	return m
}

# Clean SQL 
function cleanSQL(m) {
    txt=removeHtml(decodeHTML(m)); 
    gsub("\\-\\-\\-", "", txt)
    gsub(/\\/, "", txt)
    gsub("\t", "", txt)
    return trim(txt);
}

# Trim data 
function trim(s) {
	# left trim
	gsub("^[ \t]+", "", s);
	
	# right trim
	gsub("[ \t]+$", "", s);

	return removeNewLine(s);
}

# Remplace months 
function remplaceMonths(m) {
	 m=toupper(m)
         sub("JAN.*$","01",m)
         sub("FEB.*$","02",m)
         sub("MAR.*$","03",m)
         sub("APR.*$","04",m)
         sub("MAY.*$","05",m)
         sub("JUN.*$","06",m)
         sub("JUL.*$","07",m)
         sub("AUG.*$","08",m)
         sub("SEP.*$","09",m)
         sub("OCT.*$","10",m)
         sub("NOV.*$","11",m)
         sub("DEC.*$","12",m)


 	m=tolower(m)
	gsub("jan", "01", m)
	gsub("feb", "02", m)
	gsub("mar", "03", m)
	gsub("apr", "04", m)
	gsub("maj", "05", m)
	gsub("jun", "06", m)
	gsub("jul", "07", m)
	gsub("aug", "08", m)
	gsub("sep", "09", m)
	gsub("okt", "10", m)
	gsub("nov", "11", m)
	gsub("dec", "12", m)
        return m
}

# Decode html 
function decodeHTML(s){

# Begin code ASCII, reference link : http://www.ascii.cl/htmlcodes.htm 
	gsub(/&#32;/," ",s);
	gsub(/&#33;/,"!",s);
	gsub(/&#35;/,"#",s);
	gsub(/&#36;/,"$",s);
	gsub(/&#37;/,"%",s);
	gsub(/&#39;|&#x0027;|&#x27;/,"'",s);
	gsub(/&#40;/,"(",s);
	gsub(/&#41;/,")",s);
	gsub(/&#42;/,"*",s);
	gsub(/&#43;/,"+",s);
	gsub(/&#44;/,",",s);
	gsub(/&#45;/,"-",s);
	gsub(/&#46;/,".",s);
	gsub(/&#47;/,"/",s);
	gsub(/&#48;/,"0",s);
	gsub(/&#49;/,"1",s);
	gsub(/&#50;/,"2",s);
	gsub(/&#51;/,"3",s);
	gsub(/&#52;/,"4",s);
	gsub(/&#53;/,"5",s);
	gsub(/&#54;/,"6",s);
	gsub(/&#55;/,"7",s);
	gsub(/&#56;/,"8",s);
	gsub(/&#57;/,"9",s);
	gsub(/&#58;/,":",s);
	gsub(/&#59;/,";",s);
	gsub(/&#61;/,"=",s);
	gsub(/&#63;/,"?",s);
	gsub(/&#64;/,"@",s);
	gsub(/&#65;/,"A",s);
	gsub(/&#66;/,"B",s);
	gsub(/&#67;/,"C",s);
	gsub(/&#68;/,"D",s);
	gsub(/&#69;/,"E",s);
	gsub(/&#70;/,"F",s);
	gsub(/&#71;/,"G",s);
	gsub(/&#72;/,"H",s);
	gsub(/&#73;/,"I",s);
	gsub(/&#74;/,"J",s);
	gsub(/&#75;/,"K",s);
	gsub(/&#76;/,"L",s);
	gsub(/&#77;/,"M",s);
	gsub(/&#78;/,"N",s);
	gsub(/&#79;/,"O",s);
	gsub(/&#80;/,"P",s);
	gsub(/&#81;/,"Q",s);
	gsub(/&#82;/,"R",s);
	gsub(/&#83;/,"S",s);
	gsub(/&#84;/,"T",s);
	gsub(/&#85;/,"U",s);
	gsub(/&#86;/,"V",s);
	gsub(/&#87;/,"W",s);
	gsub(/&#88;/,"X",s);
	gsub(/&#89;/,"Y",s);
	gsub(/&#90;/,"Z",s);
	gsub(/&#91;/,"[",s);
	gsub(/&#92;/,"\\",s);
	gsub(/&#93;/,"]",s);
	gsub(/&#94;/,"^",s);
	gsub(/&#95;|&#151;/,"_",s);
	gsub(/&#96;/,"`",s);
	gsub(/&#97;/,"a",s);
	gsub(/&#98;/,"b",s);
	gsub(/&#99;/,"c",s);
	gsub(/&#100;/,"d",s);
	gsub(/&#101;/,"e",s);
	gsub(/&#102;/,"f",s);
	gsub(/&#103;/,"g",s);
	gsub(/&#104;/,"h",s);
	gsub(/&#105;/,"i",s);
	gsub(/&#106;/,"j",s);
	gsub(/&#107;/,"k",s);
	gsub(/&#108;/,"l",s);
	gsub(/&#109;/,"m",s);
	gsub(/&#110;/,"n",s);
	gsub(/&#111;/,"o",s);
	gsub(/&#112;/,"p",s);
	gsub(/&#113;/,"q",s);
	gsub(/&#114;/,"r",s);
	gsub(/&#115;/,"s",s);
	gsub(/&#116;/,"t",s);
	gsub(/&#117;/,"u",s);
	gsub(/&#118;/,"v",s);
	gsub(/&#119;/,"w",s);
	gsub(/&#120;/,"x",s);
	gsub(/&#121;/,"y",s);
	gsub(/&#122;/,"z",s);
	gsub(/&#123;/,"{",s);
	gsub(/&#124;/,"|",s);
	gsub(/&#125;/,"}",s);
	gsub(/&#126;/,"~",s);
	gsub(/&#338;/,"??",s);
	gsub(/&#339;|&#156;/,"??",s);
	gsub(/&#352;/,"??",s);
	gsub(/&#353;/,"??",s);
	gsub(/&#376;/,"??",s);
	gsub(/&#160;|&nbsp;/," ",s);
	gsub(/&#161;|&iexcl;/,"??",s);
	gsub(/&#162;|&cent;/,"??",s);
	gsub(/&#163;|&pound;/,"??",s);
	gsub(/&#165;|&yen;/,"??",s);
	gsub(/&#167;|&sect;/,"??",s);	
	gsub(/&#169;|&copy;/,"??",s);
	gsub(/&#170;|&ordf;/,"??",s);
	gsub(/&#171;|&laquo;/,"??",s);
	gsub(/&#172;|&not;/,"??",s);
	gsub(/&#173;|&shy;/,"??",s);
	gsub(/&#174;|&reg;/,"??",s);
	gsub(/&#175;|&macr;/,"??",s);
	gsub(/&#176;|&deg;/,"??",s);
	gsub(/&#177;|&plusmn;/,"??",s);
	gsub(/&#178;|&sup2;/,"??",s);
	gsub(/&#179;|&sup3;/,"??",s);	
	gsub(/&#181;|&micro;/,"??",s);
	gsub(/&#182;|&para;/,"??",s);
	gsub(/&#183;|&middot;/,"??",s);
	gsub(/&#185;|&sup1;/,"??",s);
	gsub(/&#186;|&ordm;/,"??",s);
	gsub(/&#187;|&raquo;/,"??",s);	
	gsub(/&#191;|&iquest;/,"??",s);
	gsub(/&#192;|&Agrave;/,"??",s);
	gsub(/&#193;|&Aacute;/,"??",s);
	gsub(/&#194;|&Acirc;/,"??",s);
	gsub(/&#195;|&Atilde;/,"??",s);
	gsub(/&#196;|&Auml;/,"??",s);
	gsub(/&#197;|&Aring;/,"??",s);
	gsub(/&#198;|&AElig;/,"??",s);
	gsub(/&#199;|&Ccedil;/,"??",s);
	gsub(/&#200;|&Egrave;/,"??",s);
	gsub(/&#201;|&Eacute;/,"??",s);
	gsub(/&#202;|&Ecirc;/,"??",s);
	gsub(/&#203;|&Euml;/,"??",s);
	gsub(/&#204;|&Igrave;/,"??",s);
	gsub(/&#205;|&Iacute;/,"??",s);
	gsub(/&#206;|&Icirc;/,"??",s);
	gsub(/&#207;|&Iuml;/,"??",s);
	gsub(/&#208;|&ETH;/,"??",s);
	gsub(/&#209;|&Ntilde;/,"??",s);
	gsub(/&#210;|&Ograve;/,"??",s);
	gsub(/&#211;|&Oacute;/,"??",s);
	gsub(/&#212;|&Ocirc;/,"??",s);
	gsub(/&#213;|&Otilde;/,"??",s);
	gsub(/&#214;|&Ouml;/,"??",s);
	gsub(/&#215;|&times;/,"??",s);
	gsub(/&#216;|&Oslash;/,"??",s);
	gsub(/&#217;|&Ugrave;/,"??",s);
	gsub(/&#218;|&Uacute;/,"??",s);
	gsub(/&#219;|&Ucirc;/,"??",s);
	gsub(/&#220;|&Uuml;/,"??",s);
	gsub(/&#221;|&Yacute;/,"??",s);
	gsub(/&#222;|&THORN;/,"??",s);
	gsub(/&#223;|&szlig;/,"??",s);
	gsub(/&#224;|&agrave;/,"??",s);
	gsub(/&#225;|&aacute;/,"??",s);
	gsub(/&#226;|&acirc;/,"??",s);
	gsub(/&#227;|&atilde;/,"??",s);
	gsub(/&#228;|&auml;/,"??",s);
	gsub(/&#229;|&aring;/,"??",s);
	gsub(/&#230;|&aelig;/,"??",s);
	gsub(/&#231;|&ccedil;/,"??",s);
	gsub(/&#232;|&egrave;/,"??",s);
	gsub(/&#233;|&eacute;/,"??",s);
	gsub(/&#234;|&ecirc;/,"??",s);
	gsub(/&#235;|&euml;/,"??",s);
	gsub(/&#236;|&igrave;/,"??",s);
	gsub(/&#237;|&iacute;/,"??",s);
	gsub(/&#238;|&icirc;/,"??",s);
	gsub(/&#239;|&iuml;/,"??",s);
	gsub(/&#240;|&eth;/,"??",s);
	gsub(/&#241;|&ntilde;/,"??",s);
	gsub(/&#242;|&ograve;/,"??",s);
	gsub(/&#243;|&oacute;/,"??",s);
	gsub(/&#244;|&ocirc;/,"??",s);
	gsub(/&#245;|&otilde;/,"??",s);
	gsub(/&#246;|&ouml;/,"??",s);
	gsub(/&#247;|&divide;/,"??",s);
	gsub(/&#248;|&oslash;/,"??",s);
	gsub(/&#249;|&ugrave;/,"??",s);
	gsub(/&#250;|&uacute;/,"??",s);
	gsub(/&#251;|&ucirc;/,"??",s);
	gsub(/&#252;|&uuml;/,"??",s);
	gsub(/&#253;|&yacute;/,"??",s);
	gsub(/&#254;|&thorn;/,"??",s);
	gsub(/&#255;|&yuml;/,"??",s);
	gsub(/&#34;|&quot;/,"'",s); # turn " into ', avoid to erros syntax sql query
	gsub(/&#38;|&amp;/,"\\&",s); 
	gsub(/&#60;|&lt;/,"<",s);
	gsub(/&#62;|&gt;/,">",s);
	gsub(/&#8364;|&#128;|&euro;/,"???",s);
	gsub(/&#8203;|&#65279;|&#8232;/,"",s);	
# End code ASCII


# begin unicode
	gsub(/&#402;/,"??",s);
	gsub(/&#8211;|&#150;|&ndash;/,"???",s);
	gsub(/&#8212;|&mdash;/,"???",s);
	gsub(/&#8216;|&lsquo;/,"\\???",s);
	gsub(/&#8217;|&#146;|&rsquo;/,"\\???",s);
	gsub(/&#8218;|&#130;|&sbquo;/,"???",s);
	gsub(/&#8220;|&#147;|&ldquo;/,"\\???",s);
	gsub(/&#8221;|&rdquo;/,"\\???",s);
	gsub(/&#8222;|&bdquo;/,"???",s);
	gsub(/&#8224;|&dagger;/,"???",s);
	gsub(/&#8225;|&Dagger;/,"???",s);
	gsub(/&#8226;|&#149;|&bull;/,"???",s);
	gsub(/&#8230;|&#133;|&hellip;/,"\\???",s);
	gsub(/&#8240;|&#137;|&permil;/,"???",s);
	gsub(/&#8242;|&#039;|&#145;|&prime;/,"???",s);
	gsub(/&#8243;|&#148;|&Prime;/,"???",s);
	gsub(/&#8249;|&lsaquo;/,"???",s);
	gsub(/&#8250;|&rsaquo;/,"???",s);
	gsub(/&#8254;|&oline;/,"???",s);
	gsub(/&#8260;|&frasl;/,"???",s);
	gsub(/&#8482;|&#153;/,"???",s);
	gsub(/&#164;|&curren;/,"??",s);
	gsub(/&#166;|&brvbar;/,"??",s);
	gsub(/&#168;|&uml;/,"??",s);
	gsub(/&#180;|&#145;|&acute;/,"??",s);
	gsub(/&#184;|&cedil;/,"??",s);
	gsub(/&#188;|&frac14;/,"??",s);
	gsub(/&#189;|&frac12;/,"??",s);
	gsub(/&#190;|&frac34;/,"??",s);
	gsub(/&#10070;/,"???",s);
# end unicode


# Begin code UTF8, reference link : https://www.utf8-chartable.de/unicode-utf8-table.pl?unicodeinhtml=hex
	gsub(/&#x20;/," ",s);
	gsub(/&#x21;/,"!",s);
	gsub(/&#x22;/,"\"",s);
	gsub(/&#x23;/,"#",s);
	gsub(/&#x24;/,"$",s);
	gsub(/&#x25;/,"%",s);
	gsub(/&#x26;/,"&",s);
	gsub(/&#x27;/,"'",s);
	gsub(/&#x28;/,"(",s);
	gsub(/&#x29;/,")",s);
	gsub(/&#x2A;/,"*",s);
	gsub(/&#x2B;/,"+",s);
	gsub(/&#x2C;/,",",s);
	gsub(/&#x2D;/,"-",s);
	gsub(/&#x2E;/,".",s);
	gsub(/&#x2F;/,"/",s);
	gsub(/&#x30;/,"0",s);
	gsub(/&#x31;/,"1",s);
	gsub(/&#x32;/,"2",s);
	gsub(/&#x33;/,"3",s);
	gsub(/&#x34;/,"4",s);
	gsub(/&#x35;/,"5",s);
	gsub(/&#x36;/,"6",s);
	gsub(/&#x37;/,"7",s);
	gsub(/&#x38;/,"8",s);
	gsub(/&#x39;/,"9",s);
	gsub(/&#x3A;/,":",s);
	gsub(/&#x3B;/,";",s);
	gsub(/&#x3C;/,"<",s);
	gsub(/&#x3D;/,"=",s);
	gsub(/&#x3E;/,">",s);
	gsub(/&#x3F;/,"?",s);
	gsub(/&#x40;/,"@",s);
	gsub(/&#x41;/,"A",s);
	gsub(/&#x42;/,"B",s);
	gsub(/&#x43;/,"C",s);
	gsub(/&#x44;/,"D",s);
	gsub(/&#x45;/,"E",s);
	gsub(/&#x46;/,"F",s);
	gsub(/&#x47;/,"G",s);
	gsub(/&#x48;/,"H",s);
	gsub(/&#x49;/,"I",s);
	gsub(/&#x4A;/,"J",s);
	gsub(/&#x4B;/,"K",s);
	gsub(/&#x4C;/,"L",s);
	gsub(/&#x4D;/,"M",s);
	gsub(/&#x4E;/,"N",s);
	gsub(/&#x4F;/,"O",s);
	gsub(/&#x50;/,"P",s);
	gsub(/&#x51;/,"Q",s);
	gsub(/&#x52;/,"R",s);
	gsub(/&#x53;/,"S",s);
	gsub(/&#x54;/,"T",s);
	gsub(/&#x55;/,"U",s);
	gsub(/&#x56;/,"V",s);
	gsub(/&#x57;/,"W",s);
	gsub(/&#x58;/,"X",s);
	gsub(/&#x59;/,"Y",s);
	gsub(/&#x5A;/,"Z",s);
	gsub(/&#x5B;/,"[",s);
	gsub(/&#x5C;/,"\\",s);
	gsub(/&#x5D;/,"]",s);
	gsub(/&#x5E;/,"^",s);
	gsub(/&#x5F;/,"_",s);
	gsub(/&#x60;/,"`",s);
	gsub(/&#x61;/,"a",s);
	gsub(/&#x62;/,"b",s);
	gsub(/&#x63;/,"c",s);
	gsub(/&#x64;/,"d",s);
	gsub(/&#x65;/,"e",s);
	gsub(/&#x66;/,"f",s);
	gsub(/&#x67;/,"g",s);
	gsub(/&#x68;/,"h",s);
	gsub(/&#x69;/,"i",s);
	gsub(/&#x6A;/,"j",s);
	gsub(/&#x6B;/,"k",s);
	gsub(/&#x6C;/,"l",s);
	gsub(/&#x6D;/,"m",s);
	gsub(/&#x6E;/,"n",s);
	gsub(/&#x6F;/,"o",s);
	gsub(/&#x70;/,"p",s);
	gsub(/&#x71;/,"q",s);
	gsub(/&#x72;/,"r",s);
	gsub(/&#x73;/,"s",s);
	gsub(/&#x74;/,"t",s);
	gsub(/&#x75;/,"u",s);
	gsub(/&#x76;/,"v",s);
	gsub(/&#x77;/,"w",s);
	gsub(/&#x78;/,"x",s);
	gsub(/&#x79;/,"y",s);
	gsub(/&#x7A;/,"z",s);
	gsub(/&#x7B;/,"{",s);
	gsub(/&#x7C;/,"|",s);
	gsub(/&#x7D;/,"}",s);
	gsub(/&#x7E;/,"~",s);
	gsub(/&#xA0;/," ",s);
	gsub(/&#xA1;/,"??",s);
	gsub(/&#xA2;/,"??",s);
	gsub(/&#xA3;/,"??",s);
	gsub(/&#xA4;/,"??",s);
	gsub(/&#xA5;/,"??",s);
	gsub(/&#xA6;/,"??",s);
	gsub(/&#xA7;/,"??",s);
	gsub(/&#xA8;/,"??",s);
	gsub(/&#xA9;/,"??",s);
	gsub(/&#xAA;/,"??",s);
	gsub(/&#xAB;/,"??",s);
	gsub(/&#xAC;/,"??",s);
	gsub(/&#xAD;/,"??",s);
	gsub(/&#xAE;/,"??",s);
	gsub(/&#xAF;/,"??",s);
	gsub(/&#xB0;/,"??",s);
	gsub(/&#xB1;/,"??",s);
	gsub(/&#xB2;/,"??",s);
	gsub(/&#xB3;/,"??",s);
	gsub(/&#xB4;/,"??",s);
	gsub(/&#xB5;/,"??",s);
	gsub(/&#xB6;/,"??",s);
	gsub(/&#xB7;/,"??",s);
	gsub(/&#xB8;/,"??",s);
	gsub(/&#xB9;/,"??",s);
	gsub(/&#xBA;/,"??",s);
	gsub(/&#xBB;/,"??",s);
	gsub(/&#xBC;/,"??",s);
	gsub(/&#xBD;/,"??",s);
	gsub(/&#xBE;/,"??",s);
	gsub(/&#xBF;/,"??",s);
	gsub(/&#xC0;/,"??",s);
	gsub(/&#xC1;/,"??",s);
	gsub(/&#xC2;/,"??",s);
	gsub(/&#xC3;/,"??",s);
	gsub(/&#xC4;/,"??",s);
	gsub(/&#xC5;/,"??",s);
	gsub(/&#xC6;/,"??",s);
	gsub(/&#xC7;/,"??",s);
	gsub(/&#xC8;/,"??",s);
	gsub(/&#xC9;/,"??",s);
	gsub(/&#xCA;/,"",s);
	gsub(/&#xCB;/,"??",s);
	gsub(/&#xCC;/,"??",s);
	gsub(/&#xCD;/,"??",s);
	gsub(/&#xCE;/,"??",s);
	gsub(/&#xCF;/,"??",s);
	gsub(/&#xD0;/,"??",s);
	gsub(/&#xD1;/,"??",s);
	gsub(/&#xD2;/,"??",s);
	gsub(/&#xD3;/,"??",s);
	gsub(/&#xD4;/,"??",s);
	gsub(/&#xD5;/,"??",s);
	gsub(/&#xD6;/,"??",s);
	gsub(/&#xD7;/,"??",s);
	gsub(/&#xD8;/,"??",s);
	gsub(/&#xD9;/,"??",s);
	gsub(/&#xDA;/,"??",s);
	gsub(/&#xDB;/,"??",s);
	gsub(/&#xDC;/,"??",s);
	gsub(/&#xDD;/,"??",s);
	gsub(/&#xDE;/,"??",s);
	gsub(/&#xDF;/,"??",s);
	gsub(/&#xE0;/,"??",s);
	gsub(/&#xE1;/,"??",s);
	gsub(/&#xE2;/,"??",s);
	gsub(/&#xE3;/,"??",s);
	gsub(/&#xE4;/,"??",s);
	gsub(/&#xE5;/,"??",s);
	gsub(/&#xE6;/,"??",s);
	gsub(/&#xE7;/,"??",s);
	gsub(/&#xE8;/,"??",s);
	gsub(/&#xE9;/,"??",s);
	gsub(/&#xEA;/,"??",s);
	gsub(/&#xEB;/,"??",s);
	gsub(/&#xEC;/,"??",s);
	gsub(/&#xED;/,"??",s);
	gsub(/&#xEE;/,"??",s);
	gsub(/&#xEF;/,"??",s);
	gsub(/&#xF0;/,"??",s);
	gsub(/&#xF1;/,"??",s);
	gsub(/&#xF2;/,"??",s);
	gsub(/&#xF3;/,"??",s);
	gsub(/&#xF4;/,"??",s);
	gsub(/&#xF5;/,"??",s);
	gsub(/&#xF6;/,"??",s);
	gsub(/&#xF7;/,"??",s);
	gsub(/&#xF8;/,"??",s);
	gsub(/&#xF9;/,"??",s);
	gsub(/&#xFA;/,"??",s);
	gsub(/&#xFB;/,"??",s);
	gsub(/&#xFC;/,"??",s);
	gsub(/&#xFD;/,"??",s);
	gsub(/&#xFE;/,"??",s);
	gsub(/&#xFF;/,"??",s);
# end UTF8

	return s;
}

# reverse string : abc -> cba
function reverse( line  ) {
	nb=length(line);
	str="";
	for(i=nb; i>0; i--){
		str = str""substr(line, i, 1);
	}
	return str;
}

#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import glob
from time import time
from os import path
import youhomes_helper
import codecs
from lxml import etree
from io import StringIO, BytesIO
from bs4 import BeautifulSoup
from datetime import datetime, date

#   Function to check whether given key already exists in a dictionary


def check_key(dict, key):
    '''
    Returns true if key exist in dictionary, false if key has not exist

            Parameters:
                    dict (dictionary): A dictionary of json files
                    key (str): String key of dictionary

            Returns:
                    True: If key exist in dictionary
                    False: If not exist
    '''

    if key in dict.keys():
        return True
    else:
        return False


def delete_special_character(string):
    '''
    Returns the string deleted special character

        Parameters:
                string (str): The string has many character (number, char, ...)

        Returns:
                string (str): The string after being deleted special character
    '''
    string = string.replace('\n', '')
    string = string.replace('"', '')
    string = string.replace("'", "")
    string = string.replace(";", "")
    character = ''.join(chr(92))  # chr(92) character in ASCII TABLE is \
    string = string.replace(character, '')
    return string


def extract(html_file):
    '''
    Returns the fields of site
            Parameters:
                    html_file (string): File html contains ads's details

            Returns:
                    data (dict): Dictionary of ads's details with key is the fields and value is the field's value
    '''
    data = {}
    ads_details = []
    content_file = codecs.open(html_file, 'r')
    soup = BeautifulSoup(content_file, 'lxml')
    try:
        data['PRO_FLAG'] = 0 
        for li_tag in soup.select("#content > div.topicpath.bread_crumbs > ul")[
                0].find_all('li'):
            if li_tag.get_text().find("BAN") >= 0 or li_tag.get_text().find("THUE") >= 0:
                data['ID_CLIENT'] = li_tag.get_text()
        data['SITE'] = 'youhomes.vn'
        data['CREATED_DATE'] = update_date.strftime("%Y-%m-%d")
        data['DATE_ORIGINAL'] = today
        data['FOR_SALE'] = 0
        data['FOR_LEASE'] = 0
    except:
        pass
    if check_key(data,'ID_CLIENT') and data['ID_CLIENT'].find('BAN') >= 0:
        data['FOR_SALE'] = 1
    if check_key(data,'ID_CLIENT') and data['ID_CLIENT'].find('THUE') >= 0:
        data['FOR_LEASE'] = 1
    price = soup.select('.row-price-sc > div:nth-child(2)')
    if (len(price) > 0):
        price = price[0].get_text()
        data['PRICE_ORIGINAL'] = price
    else:
        price = soup.select('.left-top-price > b:nth-child(2)')
        if (len(price) > 0):
            price = price[0].get_text()
            data['PRICE_ORIGINAL'] = price
    try:
        for p_tag in soup.select('#content > div.row.overview')[
                0].find_all('p'):
            ads_details.append(
                (p_tag.contents[0], p_tag.contents[1].get_text()))
    except BaseException:
        print("Apartment Detail Ads")
    pro_utilities = ''
    try:
        for li_tag in soup.select('.list-utility-around')[0].find_all('li'):
            pro_utilities = pro_utilities + li_tag.get_text() + ','
    except BaseException:
        print("Special pro_utilities Ads")
    pro_utilities = pro_utilities[0:len(pro_utilities) - 1]
    data['PRO_UTILITIES'] = pro_utilities
    try: 
        full_address = soup.select(
            '#content > div.product-title > div > div')[0].find('span').contents[0]
        data['FULL_ADDRESS'] = full_address
      
    except BaseException:
        print("No full address")
    try:
        ads_link = soup.find(attrs={"rel": "canonical"})['href']
        data['ADS_LINK'] = ads_link
    except: 
        print("No ads link")
    try: 
        data['ADS_TITLE'] = soup.select(
            "#content > div.product-title > div > h1")[0].get_text()
    except BaseException:
        print("No ads title")
    try:
        data['DETAILED_BRIEF'] = soup.select(
            '#content > div.description > p')[0].get_text()
    except BaseException:
        print("Special detailed_brief ads")
    try:
        photos = soup.select("#content > div.item > div")[0].find_all("li")
        data['PHOTOS'] = len(photos)
    except BaseException:
        print("NO PHOTOS")
    try:
        data['DEALER_NAME'] = soup.select('.name-employees-cs')[0].get_text()
    except BaseException:
        print("NO DEADLER_NAME")
    if pro_utilities.find("Si??u th???") >= 0:
        data['SUPERMARKET'] = 1
    if pro_utilities.find("B???nh vi???n") >= 0:
        data['HOSPITAL'] = 1
    if pro_utilities.find("C??ng vi??n") >= 0:
        data['PARK'] = 1
    if pro_utilities.find("Tr?????ng h???c") >= 0:
        data["SCHOOL"] = 1
    for i in range(0, len(ads_details)):
        if ads_details[i][0].find('Lo???i c??n h???') >= 0:
            data['LAND_TYPE'] = ads_details[i][1]
        if (ads_details[i][0].find('Di???n t??ch x??y d???ng') >=
                0 or ads_details[i][0].find('Di???n t??ch') >= 0):
            data['USED_SURFACE_ORIGINAL'] = ads_details[i][1]
        if (ads_details[i][0].find('Di???n t??ch ?????t') >= 0):
            data['SURFACE_ORIGINAL'] = ads_details[i][1]
        if (ads_details[i][0].find('Chi???u d??i m???nh ?????t') >= 0):
            data['PRO_LENGTH'] = (ads_details[i][1])[
                0:ads_details[i][1].find(' ')]
        if ads_details[i][0].find('H?????ng nh??') >= 0 or ads_details[i][0].find(
                'H?????ng b??n c??ng') >= 0 or ads_details[i][0].find('H?????ng') >= 0:
            data['PRO_DIRECTION'] = ads_details[i][1]
        if (ads_details[i][0].find('Ph??p l??') >= 0):
            data['LEGAL_STATUS'] = ads_details[i][1]
            data['LEGAL_STATUS'] = data['LEGAL_STATUS'].replace('-', '')
        if (ads_details[i][0].find('S??? t???ng') >= 0):
            if (ads_details[i][1].replace('-', '') != ""):
                data['NB_FLOORS'] = ads_details[i][1].replace('-', '')
        if (ads_details[i][0].find('S??? ph??ng ng???') >=
                0 or ads_details[i][0].find('Ph??ng ng???') >= 0):
            number_bedroom = ''
            for char in ads_details[i][1]:
                if char.isnumeric() == False:
                    break
                number_bedroom = number_bedroom + char
            if (number_bedroom != ""):
                data['BEDROOM'] = number_bedroom
        if (ads_details[i][0].find("S??? ph??ng v??? sinh")
                >= 0 or ads_details[i][0].find("WC") >= 0):
            data['TOILET'] = ads_details[i][1]
        if ads_details[i][0].find("M???t ti???n") >= 0:
            if (ads_details[i][1])[0:ads_details[i][1].find(' ')].replace('-', '') != "" :
                data['FRONTAGE'] = ads_details[i][1]
            
    if check_key(data, 'LAND_TYPE') and data['LAND_TYPE'].find("C??n h???") >= 0:
        try:
            data['PROJECT_NAME'] = soup.select(
                '#content > div.topicpath.bread_crumbs > ul > li:nth-child(7) > a')[0].get_text()
        except BaseException:
            print("No project name")
    for (key, value) in data.items():
        if (str(type(value)).find('int') >= 0):
            continue
        data[key] = delete_special_character(data[key])
    return data


def store(ads):
    '''
    Returns SQL command line to insert datas into database

        Parameters:
                ads (dict): The dictionary of ads's fields

        Returns:
                result[0:len(result) - 1] + ' ;' (str): The string of SQL command line
                Example:
                INSERT IGNORE INTO YOUHOMES set ID_CLIENT="BAN23653",SITE="youhomes.vn",CREATED_DATE="20200827",FOR_SALE="1",FOR_LEASE="0",PRICE="9.9",
                PRICE_UNIT="t???",PRO_UTILITIES="Tr?????ng h???c ,B???nh vi???n ,Si??u th??? ,C??y ATM ,C??ng vi??n ",FULL_ADDRESS="NGUY???N C???NH CH??N, C???u Kho, Qu???n 1, Tp H??? Ch?? Minh ",
                STREET="NGUY???N C???NH CH??N",WARD=" C???u Kho",DISTRICT=" Qu???n 1",CITY=" Tp H??? Ch?? Minh ",
                ADS_LINK="https://youhomes.vn/ban/23653-nha-rieng-nguyen-canh-chan-quan-1-39m2-nhieu-anh-sang.html",
                ADS_TITLE=" B??n nh?? ri??ng NGUY???N C???NH CH??N Qu???n 1 - 39m2 - Nhi???u ??nh s??ng",
                DETAIL_BRIEF="- Ch??nh ch??? c???n b??n nh?? xx/27 Nguy???n C???nh Ch??n, Q1, c??ch m???t ti???n Tr???n H??ng ?????o 40m- K???t c???u: 1 tr???t, 1 l???ng, 3 l???u, 1 s??n th?????ng, s??n ph??i ?????, tr???ng rau, c??y c???nh tho???i m??i- Nh?? x??y t??? 2011, vu??ng v???c, c???c ki??n c???, - N???i th???t ti???n nghi ?????y ?????, d???n v??o ??? ngay ko c???n ch???nh s???a- H???m c???t n??n r???t y??n t??nh, h???m r???ng r??i, - N???m ngay v??? tr?? trung t??m n??n d??? d??ng di chuy???n gi???a Q5, Q1, Q8 g???n Nguy???n V??n C???, C??ng An TP, B???nh vi???n, Tr?????ng h???c, Ph??? T??y B??i Vi???n, Ch??? B???n Th??nh, Trung T??m Ph??? ??i b??? Qu???n 1.- Th??ch h???p gia ????nh d???n v??o ??? ngay, cho thu?? AirBnB, b??n h??ng online..... - Gi???y t??? ph??p l??, s??? h???ng ch??nh ch???, gi???y ho??n c??ng r?? r??ng. - G??a b??n c?? th????ng l?????ng,=> Li??n h??? t??i ch??nh ch??? (B??n nh?? ri??ng NGUY???N C???NH CH??N Qu???n 1 - 39m2 - Nhi???u ??nh s??ng - Mua nh?? ri??ng d?????i 10 t???) ",
                PHOTOS="6",DEALER_NAME="Ph???m L???i (ch??? nh??)",AGENCY_WEBSITE="youhomes.vn",AGENCY_NAME="C??ng Ty TNHH CT To??n C???u",
                AGENCY_ADDRESS="T???ng 12 to?? H??? G????m Plaza, 102 Tr???n Ph??, Ph?????ng M??? Lao, H?? ????ng, H?? N???i + VPKD H?? N???i: To?? C2, Vinhomes DCapitale, 119 Tr???n Duy H??ng, C???u Gi???y, H?? N???i + VPKD HCM: To?? Indocchina Park Tower, Nguy???n ????nh Chi???u, Qu???n 1, TP HCM",AGENCY_CITY="H?? N???i, H??? Ch?? Minh",
                AGENCY_TEL="0968654865",SUPERMARKET="1",HOSPITAL="1",PARK="1",SCHOOL="1",LAND_TYPE="Nh?? ri??ng",USED_SURFACE="195",USED_SURFACE_UNIT="m2",
                SURFACE="39",SURFACE_UNIT="m2",FRONTAGE="3",NB_FLOORS="3", LEGAL_STATUS="S??? h???ng",PRO_DIRECTION="T??y Nam",PRO_LENGTH="13",BEDROOM="5",TOILET="3" ;
    '''
    result = 'INSERT IGNORE INTO YOUHOMES set '
    for (key, value) in ads.items():
        result += str(key) + '=' + '"' + str(value) + '",'
    return result[0:len(result) - 1] + ' ;'


def update_ads(ads):
    '''
    Returns SQL command line to insert datas into database

        Parameters:
                ads (dict): The dictionary of ads's fields

        Returns:
                result[0:len(result) - 1] + ' ;' (str): The string of SQL command line
                Example:
                UPDATE YOUHOMES set ID_CLIENT="BAN23653",SITE="youhomes.vn",CREATED_DATE="20200827",FOR_SALE="1",FOR_LEASE="0",PRICE="9.9" WHERE ID_CLIENT="BAN23653" ;
    '''
    result = 'UPDATE IGNORE YOUHOMES set '
    option = '  WHERE ID_CLIENT=' + '"' + str(ads['ID_CLIENT']) + '"'
    for (key, value) in ads.items():
        result += str(key) + '=' + '"' + str(value) + '",'
    return result[0:len(result) - 1] + option + ' ;'


start = time()
update_date = date.today()
folder, today, today_folder, spider_folder, all_folder, delta_folder, list_mode, sale_folder, lease_folder, house_sale_folder, apartment_sale_folder, house_lease_folder, apartment_lease_folder = youhomes_helper.create_folder()

html_files = glob.glob(all_folder + '/*.html')  # Total html files in ALL folder

print("Total html files:", len(html_files))
f =  open(delta_folder + '/VO_ANNONCE_insert.sql', 'w+')
fw = open(delta_folder + '/VO_ANNONCE_update.sql', 'w+')
for i in range(0, len(html_files)):
    if os.path.isfile(html_files[i]) == False:
        continue
    print(i + 1, html_files[i])
    ads = extract(html_files[i])
    if len(ads['ID_CLIENT']) > 0:
        #   WRITE SQL FILE INTO VO_ANNOUNCE_INTO.SQL
        f.write(store(ads) + '\n')
        fw.write(update_ads(ads) + '\n')
f.close()
fw.close()
print('DONE PUT HTML INTO DELTA AND CREATE FILE INSERT SQL')
delta = time()
print('------%s SECONDS-------' % (delta - start))
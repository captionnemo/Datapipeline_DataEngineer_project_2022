# Crawling

## 1. Objective 

- Download and parse data from **ALONHADAT** site using bash script or scrapy & awk.

## 2. How does it work ?  
**A Script structure described as below:**
-  download_site.sh : this is main script that calls other scripts using **SCRAPY**
-  download_site_bashscript.sh: this is main script that calls other scripts using **BASHSCRIPT**
-  awk:
    - put_html_to_tab.awk: convert data from list mode pages to **extract.tab**
    - put_tab_to_db.awk: convert data from **extract.tab** to insert SQL script  
    - get_ads_details.awk: convert data from ads pages to update SQL script
-  bash:
    - parsing_insert.sh: run put_tab_to_db.awk to create **ads_insert.sql** for further import
    - parsing_update.sh: run get_ads_details.awk to create **ads_update.sql** for further import
    - parsing_update_tel.sh: run put_tab_to_db.awk to create **ads_update_tel.sql** for further import
-  python:  
    - download folder: contains scrapy scripts to perform crawling .html files
    - alonhadat_helper.py: defined utiliy functions
-  requirement.txt: contains all libraries with its version

### Step 0: Create following folders
-  ALL/: contains detail ads .html files.
    - TEL/: contains detail tel .html files.
-  DELTA/: 
    - ads_insert.sql: to insert the new ads to database
    - ads_update.sql: to update information about the new ads to database
    - tel_ads_update.sql: to update information about the telephone to database
    - extract_backup.tab: ads information getting from list pages
    - extract.tab (daily download): extract.tab after compare
    - tel_extract.tab: tel information getting from list tel pages.
    - tel_extract_update.tab (daily download): tel_extract.tab after compare
    - status_ok: contains ``ok`` content to indicate that the program runs completely
- LIST_MODE/: 
    - FOR_LEASE/: contains list for lease page .html files
    - FOR_SALE/: contains list for sale page .html files
- LOG/:
    - scrapy_site.log: scrapy log when download list pages
    - scrapy_ads.log: scrapy log when download ads files
    - scrapy_tel.log: scrapy log when download tel pages
After running the `download_site.sh`, the script will generate the **three** .txt files:
- date.txt: contains date string (created date folder by command line or setting default)
- option_file.txt: contains has two values 1 or 0. If value = 1, download 2 single category for testing; value = 0 then download full
- max_page_number.txt: contains has two values: 2 or maximum page number of the site.

###  Step 1: Download list pages and save .html files in LIST_MODE folder
-  There are some main problems when download from this site:
    - This site do not show total number of ads.
    - This site is slow response. Using bashsript takes about 17 hours for download list mode and 4 days for download detail mode.
    - Telephone's dealers in detail ads are blocked by captcha.
-  Solution: find the nubmer of page by setting a very big page number, such as 100000. Example: `https://alonhadat.com.vn/nha-dat/cho-thue/trang--100000.html`. Using scrapy, which set `CONCURRENT_REQUESTS_PER_DOMAIN = 50`, can improve the download speed, about 1 hour for list mode and 6 hours for detail mode. For dealer telephone, parsing tel page can get telephone without protected.

1/ Using bashscript
-  The `download_list_mode` in download_site_bashscript.sh will begin and save all **(html)** page files in LIST_MODE/FOR_LEASE or LIST_MODE/FOR_SALE folder.

2/ Using scrapy
-   The `scrapy crawl download_site` in download_site.sh calls **download/spider.py**. This download/spider.py (download_site) will perform downloading all categories of list pages and store **(html)** files in LIST_MODE/FOR_LEASE or LIST_MODE/FOR_SALE folder.
- These scripts **(items.py, middlewares.py, pipelines.py, settings.py, scrapy.cfg)** generated by default by Scrapy framework and used to call the object class in the spider.py. Note that THESE FILES ARE OBLIGATORY and we CAN'T DELETE THEM and DON'T NEED TO CARE THEM because the spider.py is a main script to handle all requests.

### Step 2: Download detail pages and save .html files in ALL folder
- Parsing the every file in LIST_MODE/FOR_LEASE and LIST_MODE/FOR_SALE folder to create extract.tab
- Copy extract.tab to create extract_backup.tab
- If fully download, the script will generate list_need_to_download from full extract.tab. If daily download, the script will generate list_need_to_download from extract_update.tab, which created by comparing current extract.tab with its previous extract_backup.tab in the lastest folder.

1/ Using bashscript
- The `download_detail_mode` will use list_id.txt to perform to download details pages and store **.html** files in ALL/ folder.

2/ Using scrapy
-  The `scrapy crawl download_ads` in download_site.sh calls **download/spider.py** to download details pages and store .html files in ALL/ folder. The class loads id, url from DELTA/list_id.txt to download these detail pages.

### Step 3: Download tel pages and save .html files in TEL folder
- Parsing the every file in ALL folder to create tel_extract.tab
- If fully download, the script will generate list_id_tel.txt from tel_extract.tab. If daily download, the script will generate tel_list_id.txt from tel_extract_update.tab, created by removing lastest extract.tab duplicate ads in tel_extract.tab.

1/ Using bashscript
- The `download_telephone` will use tel_extract.tab or tel_extract_update to perform to download tel pages and store **.html** files in ALL/TEL folder.

2/ Using scrapy
- The `scrapy crawl download_tel` in download_site.sh calls **download/spider.py** to download tel pages and store .html files in ALL/TEL folder. The class loads id, url from DELTA/list_id_tel.txt to download these tel pages.

### Step 4: Parsing and insert data into the database
-  Parsing:  
    - Parsing list mode: for every line in extract.tab, the script bash/parsing_insert.sh will create **ads_insert.sql**
    - Parsing detail mode: for every html file in all folder, the script bash/parsing_update.sh will create **ads_update.sql**
    - Parsing telephone: for every html file in tel folder, the script bash/parsing_update_tel.sh will create **ads_update_tel.sql**

-  Import: connect to mysql and import **ads_insert.sql**, **ads_update.sql** and **ads_update_tel.sql** to the database 

## 3. How to run
**3.1/ Prerequisites**
- Libraries:
    - urllib3==1.25.8
    - Scrapy==2.2.1
    - scrapy-fake-useragent==1.4.4               
    - scrapy-user-agents==0.1.1
    - beautifulsoup4==4.9.1
- Install all libraries in requirements.txt: ``` pip3 install -r requirements.txt ```

**3.2/ How to run the script**

  ```
  * Options: 
     -x = debug
     -y = test mode
     -i = import SQL to database
     -r = Download Ads from LIST_MODE folder (don't re-download list pages)
     -d YYYYmmdd = date of download.
     -D = daily mode
  ```
    a) Test mode:    
        ./download_site.sh -zVN_ALONHADAT -d{_date_store_} -x -y > log{_date_store_} 2>&1 &
        Example: ./download_site.sh -zVN_ALONHADAT -d20200825 -x -y > log20200825 2>&1 &  

    b) Full mode:      
        ./download_site.sh -zVN_ALONHADAT -d{_date_store_} -x > log{_date_store_} 2>&1 &   
        Example: we specific {_date_store_} is 20200825
        ./download_site.sh -zVN_ALONHADAT -d20200825 -x > log20200825 2>&1 & 

    c) Daily mode:
        ./download_site.sh -zVN_ALONHADAT -d{_date_store_} -x -D > log{_date_store_} 2>&1 &
        Example: ./download_site.sh -zVN_ALONHADAT -d20200825 -x -D > log20200825 2>&1 &  
        
**Note:**
-   Download by scrapy is set by default. If download by using bash script, change `download_site.sh` to `download_site_bashscript.sh`
-   -x option must be call first others
-   If there is no {_date_store_}, {_date_store_} = today by default. Example: If today is 25/08/2020, if `./download_site.sh -zVN_ALONHADAT -x > log20200825 2>&1 &` is run, folder will be 20200825
-   If there is no option -y, the script will run full mode by default
-   The script will parse data automatically or manually by calling `bash/ads_insert.sql {_date_store_}`  or `bash/ads_update.sql {_date_store_}` or `bash/ads_update_tel.sql {_date_store_}`
-   If you import data into database, you will use -i options.      
-   If there is a test mode, only 2 pages in each category are created
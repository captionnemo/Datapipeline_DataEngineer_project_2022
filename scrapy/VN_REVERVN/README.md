# Crawling

## 1. Objective 

- Download and parse data from **revervn** site using bash script & python.

## 2. How does it work ?  
**A Script structure described as below:**
-  python:  
    - download folder: contains scrapy scripts to perform crawling .json files (list mode) & .html files (detail mode)
    - chotot_helper.py: defined utiliy functions
    - compare_data.py: the script is used to compare the id_client of yesterday ads with today to find the latest ads posted. After that, these new ads will be saved in the **list_new_id.txt** file. In case there are no new ads, list_new_id.txt will contain the **value 0**.
    - create_listid.py: the script is used to remove duplicate ads **(id_client)** and store its to **list_id.txt** file in DELTA folder
    - get_max_page_number.py: to get maximum number of pages
    - put_json_into_delta.py: used to parse data and create insert query (**VO_ANNONCE_insert.sql**) to import data into the database
-  download_site.sh : this is main script that calls other scripts
-  import_db.sh : the script is used to import data into db with predefined db configuration
-  copy_sql_to_server.sh (optional): used to copy SQL files to the defined database server and insert data into the database.
-  requirement.txt: contains all libraries with its version
-  vn_revervn.sql: contains SQL query to creat the REVERVN table

### Step 0: Create following folders
-  ALL/: .html files.
-  DELTA/: 
    - insert.sql (mandatory): to insert the new ads to database
    - List_id.txt: Save all id_client and ads_link which are also known as real estate codes. Id_client in list_id.txt has been eliminated duplication.
    - List_new_id.txt: contains new id_client and ads_link of today are posted compared to yesterday.
    - Backup.txt: contains id_client duplicated
    - Status_ok.txt: contains ``ok`` content to indicate that the program runs completely.
- LIST_MODE/: contains .json files (List pages) in LIST MODE
- LOG/: 3 log files
    - annonce_site.log: download list pages
    - annonce_ads.log: ads files
    - annonce.log: contains logs from the program
After running the download_site.sh, the script will generate the **three** .txt files:
- date.txt: contains date string (created date folder by command line or setting default)
- option_file.txt: contains has two values 1 or 0. If value = 1, download 2 single category for testing; value = 0 then download full
- max_page_number.txt: contains has two values: 2 or maximum page number of the site. This txt file is generated by **get_max_page_number.py** script. 

###  Step 1: Download list pages and save .json files in LIST_MODE folder
1./ The script download_site.sh calls **download/spider.py**. This download/spider.py (download_site) will perform downloading all categories of list pages and store **(json)** files in LIST_MODE folder.
- These scripts **(items.py, middlewares.py, pipelines.py, settings.py, scrapy.cfg)** generated by default by Scrapy framework and used to call the object class in the spider.py. Note that THESE FILES ARE OBLIGATORY and we CAN'T DELETE THEM and DON'T NEED TO CARE THEM because the spider.py is a main script to handle all requests.

2./ Then, the script **python/create_listid.py** will perform to remove duplicated ads  **(id_client)** and store these id_client in  **DELTA/list_id.txt**. In addition, the script also saves all id_client including duplicated id_client to **DELTA/backup.txt**.

3./ Next, the script calls compare_data.py to compare current list of id to previous/latest list of id. And the script only downloads these new ids. Its ouput is in the file DEALTA/list_new_id.txt. The file list_new_id.txt includes ID_CLIENT and URL. In case there is no new ads, the file contains 0.

### Step 2: Download detail pages and save .html files to ALL folder
The script will call 'download_ads' to perform to download details pages and store .html files in ALL/ folder. The class loads id, url from DELTA/list_new_id.txt to download these new detail pages.

### Step 3: Parsing and insert data into the database
1./**python/put_json_into_delta.py** script will parse .json files in ALL folder. The parsing ads is selected from ads in list_new_id.txt. In case, list_new_id.txt contains **0**, will select ads in list_id.txt, then save in the **VO_ANNONCE_insert.sql** in DELTA folder. 

2./ The script import_db.sh will import **VO_ANNONCE_insert.sql** into database.

## 3. How to run
**3.1/ Prerequisites**
- Libraries:
    - urllib3==1.25.8
    - beautifulsoup4==4.9.1
    - scrapy==2.2.1 
    - python 3.8.2
- Install all libraries in requirements.txt: ``` pip3 install -r requirements.txt ```

**3.2/ How to run the script**

  ```
  * Options: 
     -x = debug
     -y = test 
     -i = import SQL to database
     -r = Download Ads from LIST_MODE folder (don't re-download list pages)
     -d YYYYmmdd = date of download.
  ```
    a) Test mode (normally testing for 2 pages):    
        ./download_site.sh -d{_date_store_} -x -y
        Example: ./download_site.sh -d20200824 -x -y or  ./download_site.sh -x -y        

    b) FULL mode:      
       ./download_site.sh -d{_date_store_} -x    
        Example 1: we specific {_date_store_} is 20200825
        ./download_site.sh -d20200825 -x

        Example 2: we don't indice {_date_store_}, {_date_store_} is today
        ./download_site.sh -d -x
        
**Note:**
-   If there is no {_date_store_}, {_date_store_} = today par default
-   If there is no option -y, the script will run full mode par default
-   The script will parse data automatically
-   If you import data into database, you will -i options.      
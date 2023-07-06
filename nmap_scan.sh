#!/bin/bash

# Run nmap command and save output to XML file
sudo nmap -sV -O --open --script vuln <network_address/mask> -p20,21,22,23,25,53,80,81,110,143,145,443,3389,161,123,67,68,389,445,548,1433,3306,5432,1812,1813,6667,8000,8080,8081,5938,6568,5900,1194,1195 -oX /home/pi/vuln_scan.xml

# Transform XML into JSON
python3 -c "import json, xmltodict; xml_content = open('nmap_output.xml').read(); json_content = json.dumps(xmltodict.parse(xml_content), indent=4, sort_keys=True); open('vuln_scan.json', 'w').write(json_content)"

# Send JSON file to API
curl -X POST -F "file=@/home/pi/vuln_scan.json" http://<api_upload_json_route>  -H "Authorization: <your_api_token>"
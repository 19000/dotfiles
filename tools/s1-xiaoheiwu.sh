curl 'http://bbs.saraba1st.com/2b/forum.php?mod=misc&action=showdarkroom&cid=20000&ajaxdata=json'|
 sed -n 's/\([0-9]\{1,\}\):{/"\1":{/pg' |
 python -c "import sys,json; data=json.loads(sys.stdin.read()); print json.dumps(data,sort_keys=True,indent=4).decode(\"unicode_escape\").encode(\"utf8\",\"replace\")"|
 grep -B5 $1

diff <(cat 4chan-test.html| xpath.py '//a[img]/@href'| cut -c 3-) <(cat 4chan-test.html| xpath.py '//a[@class="fileThumb"]/@href'| cut -c 3-)
wget `cat 4chan-test.html| xpath.py '//a[@class="fileThumb"]/@href'| cut -c 3-| tail -1`
(cd 4chan; cat /tmp/4chan-test.html| xpath.py '//a[img]/@href'| cut -c 3-| xargs wget);
(cd 4chan/mayoiga; curl http://boards.4chan.org/a/thread/142219827/mayoiga| xpath.py '//a[img]/img/@src');
cat 4chan-test.html| xpath.py '//a[@class="fileThumb imgspoiler"]/img/@src'

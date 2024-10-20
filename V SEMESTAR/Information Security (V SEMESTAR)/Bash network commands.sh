echo 'Moj link: <a href="https://www.google.com">Google</a>' > tekst.txt
echo 'Stranica: <a href="https://www.facebook.com">Facebook</a>' >> tekst.txt
echo 'Visit <a href="https://twitter.com">Twitter</a> for updates.' >> tekst.txt
echo 'Link na <a href="http://fit.ba">FIT</a>' >> tekst.txt
echo 'Klikni <a href="https://github.com">GitHub</a> da vidiš kod.' >> tekst.txt
echo 'Pogledaj <a href="http://youtube.com">YouTube</a> za video.' >> tekst.txt
echo 'Stranica sa informacijama <a href="https://wikipedia.org">Wikipedia</a>' >> tekst.txt
echo 'Katalog na <a href="http://archive.org">Archive</a>' >> tekst.txt

# grep "href=" tekst.txt | cut -d "/" -f 3 | cut -d '"' -f 1

# grep "href=" tekst.txt | grep "https" | cut -d "/" -f 3

# cat index.html | grep -o 'http://[^"]*' | cut -d "/" -f 3 | sort -u
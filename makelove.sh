#/bin/zsh

for i in /Users/slamice/Documents/development/lua/*;
do zip -r "$i".zip "$i" && rename .zip .love *.zip
done

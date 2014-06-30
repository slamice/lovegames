#/bin/zsh
for dir in *;
do
  cd "$dir" && zip -r "$dir".zip . -i *i 
done

for dir in *;
do
  mv `basename $dir .zip` "`basename $dir .zip`.love"
done

#!/bin/bash
echo Script TalkingScanner3_55R.sh created by Sergey Znamenskiy 15012024 using algorythm Talking Scanner 3.5R
echo changed the names from Vsevolod, Anna to Aleksandr, Elena
echo directory for temporary files /tmp/TalkingScanner
echo directory for results file /var/tmp/TalkingScanner
echo "Привет! Я робот Говорилка! Буду озвучивать для вас текст из сканов." |RHVoice-test -p Aleksandr
mkdir /tmp/TalkingScanner
while true
do
echo Checkpoint 1
for var in `ls /tmp/TalkingScanner |grep IMAG`
do
rm /tmp/TalkingScanner/$var
done
echo Checkpoint 2
for var in `ls /tmp/TalkingScanner |grep pages`
do
rm /tmp/TalkingScanner/$var
done
echo "Жду подключения сканера" |RHVoice-test -p Aleksandr
var14=0
while [ ! "$var13" ]
do
sleep 1
((var14=var14+1))
if [ $var14 -eq 30 ]; then
echo "Жду подключения сканера" |RHVoice-test -p Aleksandr
var14=0
fi
var13=`ls /tmp/TalkingScanner |grep scanneron.txt`
done
echo Checkpoint 4
sudo rm /tmp/TalkingScanner/$var13
echo "Забираю сканы из сканера"|RHVoice-test -p Aleksandr
mv /media/6335-3931/DCIM/100MEDIA/* /tmp/TalkingScanner
FILENUMBER=`ls /tmp/TalkingScanner |grep IMAG |wc -l`
echo "Загружено $FILENUMBER сканов из сканера"|RHVoice-test -p Aleksandr
echo Checkpoint 7
for var in `ls /media/6335-3931/ |grep results`
do
rm /media/6335-3931/$var
done
echo Checkpoint 9
cp /var/tmp/TalkingScanner/results.txt /media/6335-3931/
echo Checkpoint 10
sudo udisksctl unmount -b /dev/sda1
sudo udisksctl power-off -b /dev/sda
echo Checkpoint 11
for SCANNERON in `df |grep /dev/sda1 |wc -l`
do
echo Checkpoint 12
done
echo Checkpoint 13
var13=`ls /tmp/TalkingScanner |grep scanneron.txt`
echo "Том сканера  отключен.  Теперь отключите кабель от сканера и немного подождите пока я завершу распознавание текста"|RHVoice-test -p Aleksandr
if [ $FILENUMBER -eq 0 ]; then
continue
fi
echo Checkpoint 15
for var in `find  /tmp/TalkingScanner/IMAG*[13579].JPG`
do
exiftran -i -1 $var
echo Checkpoint 16
done
echo Checkpoint 17
for var in `ls /tmp/TalkingScanner |grep IMAG`
do
echo Checkpoint 18
tesseract /tmp/TalkingScanner/$var /tmp/TalkingScanner/out -l rus+eng
cat   /tmp/TalkingScanner/out.txt >>/tmp/TalkingScanner/pages.txt
rm /tmp/TalkingScanner/out.txt
done
echo "Проговариваю распознанные страницы"|RHVoice-test -p Aleksandr
RHVoice-test -i /tmp/TalkingScanner/pages.txt -p Elena
cat   /tmp/TalkingScanner/pages.txt >>/var/tmp/TalkingScanner/results.txt
echo "Проговаривание распознанных страниц завершено"|RHVoice-test -p Aleksandr
done



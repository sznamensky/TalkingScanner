#!/bin/bash
echo Script Clear_results1_3.sh created by Sergey Znamenskiy 15012024 scanner voice changed to Aleksandr
echo script should be used to separate the metadata when you start reading new book 
echo script renames /var/tmp/TalkingScanner/results.txt to results_old.txt
echo script creates new empty file /var/tmp/TalkingScanner/results.txt
echo script copies results_old.txt to the scanner
echo "Привет! Я робот Говорилка! Вы планируете читать новую книгу? Тогда я очищу файл результатов и сохраню в сканере предыдущий файл результатов." |RHVoice-test -p Aleksandr
echo "Чтобы продолжить  нажмите одну из латинских букв. Или, чтобы выйти из программы, нажмите пробел."|RHVoice-test -p Aleksandr
read -n 1 var1
var2=`echo $var1 |grep '[qwertyuiopasdfghjklzxcvbnm]'`
if [ "$var2" ];
then
sudo mv /var/tmp/TalkingScanner/results.txt /var/tmp/TalkingScanner/results_old.txt
echo "results.txt переименован в results_old.txt"|RHVoice-test -p Aleksandr
sudo touch /var/tmp/TalkingScanner/results.txt
echo "Создан новый results.txt"|RHVoice-test -p Aleksandr
echo "Проверяю подключен ли сканер" |RHVoice-test -p Aleksandr
var14=0
var13=`df |grep /dev/sda1`
while [ ! "$var13" ]
do
sleep 1
((var14=var14+1))
if [ $var14 -eq 5 ]; then
echo "Жду подключения сканера" |RHVoice-test -p Aleksandr
var14=0
fi
var13=`df |grep /dev/sda1`
done
cp /var/tmp/TalkingScanner/results_old.txt /media/6335-3931/
echo "Предыдущий файл результатов сохранен в сканере" |RHVoice-test -p Aleksandr
sudo udisksctl unmount -b /dev/sda1
sudo udisksctl power-off -b /dev/sda
for SCANNERON in `df |grep /dev/sda1 |wc -l`
do
sleep 1
done
echo "Том сканера  отключен.  Теперь отключите кабель от сканера"|RHVoice-test -p Aleksandr
else
echo "Выхожу без измененийt"|RHVoice-test -p Aleksandr
fi
echo "Завершено"|RHVoice-test -p Aleksandr



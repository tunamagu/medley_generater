#!/bin/bash

mkdir after_cut
count=0
cut_time=11

# 分割処理
for file in *.mp3
do
	file_new=`echo ${file} | sed -e 's/.mp3$//g'`
	imput_number=`echo ${file} | cut -c 1-2`
	start_number=$(expr $imput_number - 1)
	count=$((++count))
	ffmpeg -y -i "$file" -codec:a copy -ss $start_number -t $cut_time "./after_cut/$count.mp3"
done

cd after_cut

cut_file_list=" "
count=0

for file in *.mp3
do
	file_new=`echo 'fade'${file}'.mp3' | sed -e 's/.mp3$//g'`
	# フェード処理
	ffmpeg -i "$file" -af afade=t=in:st=0:d=1,afade=t=out:st=10:d=1,dynaudnorm "$file_new"
	rm ${file}

	cut_file_list="${cut_file_list}-i ${file_new} "
	count=$((++count))

done

# 結合処理
command="ffmpeg ${cut_file_list} -filter_complex concat=n=${count}:v=0:a=1 output.mp3"
${command}

#array=`find . -type f -name *.mp3`
#array=`ls *.mp3`
#num_array=${#array[*]}
#random_n=%(RANDOM%num_array)
#shuffle

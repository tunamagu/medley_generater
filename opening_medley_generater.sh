#!/bin/bash

mkdir after_cut
count=0
cut_time=15
fadeout_start=$(($cut_time - 1))
cut_file_list=" "

# 分割処理
for file in *.mp4
do
	file_new=`echo ${file} | sed -e 's/.mp4$//g'`
	imput_number=`echo ${file} | cut -c 1-2`
	start_number=$(expr $imput_number - 1)

	count=$((++count))

	if [ -e ./after_cut/$count.mp4 ]; then
		continue
	else
		ffmpeg -y -ss $start_number -i "$file" -t $cut_time -s 1280x720 -vf fade=in:st=0:d=1,fade=out:st="$fadeout_start":d=1 -af afade=t=in:st=0:d=1,afade=t=out:st="$fadeout_start":d=1,volume=5dB -c:a mp3 -b:a 320k "./after_cut/$count.mp4"
	fi

done

for n in `shuf -i 1-$count`
do
	cut_file_list="${cut_file_list}-i ${n}.mp4 "
done


cd after_cut

# 結合処理
command="ffmpeg ${cut_file_list} -filter_complex concat=n=${count}:v=1:a=1 -c:a mp3 -b:a 320k output.mp4"
# command="ffmpeg -f concat ${cut_file_list} -c:v copy -af volume=5dB -c:a mp3 -b:a 320k -map 0:v -map 0:a output.mp4"
${command}
command="ffmpeg after_cut/output.mp4 -af dynaudnorm -c:v copy -c:a mp3 -b:a 320k after_cut/output_v.mp4"
${command}

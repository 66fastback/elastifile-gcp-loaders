#!/bin/bash
# invokes erun.sh script for all matching instance names. Run from local terraform directory.
# ./commander.sh <ERUN VM name> <ZONE> <PROJECT> <MODE>
NAME=$1
ZONE=$2
PROJECT=$3
MODE=$4
VHEAD_NAME=elfs
clients=10
nr_files=20
max_file_size=20M
queue_size=25
readwrites=90
min_io_block=4k
max_io_block=4k
LIST=`gcloud compute instances list --filter="name:$NAME AND zone:$ZONE" | grep $NAME | cut -d " " -f 1`

if [[ $MODE == "start" ]]; then
  echo "erun settings: clients=$clients nr_files=$nr_files max_file_size=$max_file_size queue_size=$queue_size readwrites=$readwrites min_io_block=$min_io_block max_io_block=$max_io_block"
  # echo $LIST
  # echo $VHEADLIST
  n=1
  for i in $LIST; do
    vhead=`gcloud compute instances list --filter="name:$VHEAD_NAME AND zone:$ZONE" | grep $VHEAD_NAME | cut -d " " -f 24 | sed -n $n\p`
    echo "$i starting on $vhead"
    let n+=1
    # gcloud compute --project "$PROJECT" scp --zone "$ZONE" ./erun.sh "$i":/home/andrew &>/dev/null
    # gcloud compute --project "$PROJECT" ssh --zone "$ZONE" $i --command "sudo /home/andrew/erun.sh" &
     # gcloud compute --project "$PROJECT" ssh --zone "$ZONE" $i --command "sudo cat /home/andrew/erun.sh" &
     gcloud compute --project "$PROJECT" ssh --zone "$ZONE" $i --command "sudo /bin/erun -p io $vhead:DC01/root --erun-dir $i --duration 3600 --clients $clients --nr-files $nr_files --max-file-size $max_file_size --queue-size $queue_size --readwrites $readwrites --data-payload --initial-write-phase --min-io-size $min_io_block --max-io-size $max_io_block &>/dev/null &" &
  done
elif [[ $MODE == "stop" ]]; then
  for i in $LIST; do
     gcloud compute --project "$PROJECT" ssh --zone "$ZONE" $i --command "sudo pkill erun" &
   done
fi

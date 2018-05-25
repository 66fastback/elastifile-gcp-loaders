/bin/erun -p io ecfs.local:DC01/root --erun-dir `hostname` --duration 3600 --clients 1 --nr-files 6 --max-file-size 100M --queue-size 20 --readwrites 90 --data-payload --initial-write-phase --min-io-size 4K --max-io-size 4K &>/dev/null & 
#/bin/erun -p io ecfs.local:DC02/root --erun-dir `hostname` --duration 3600 --clients 1 --nr-files 6 --max-file-size 100M --queue-size 20 --readwrites 90 --data-payload --initial-write-phase --min-io-size 4K --max-io-size 4K
wait

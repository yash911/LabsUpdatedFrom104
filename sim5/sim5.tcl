
set ns [new Simulator]
set tf [open out.tr w]
$ns trace-all $tf
set nf [open out.nam w]
$ns namtrace-all $nf

set ms1 [$ns node]
set bs1 [$ns node]
set msc [$ns node]
set bs2 [$ns node]
set ms2 [$ns node]

$ns duplex-link $ms1 $bs1 1Mb 1ms DropTail
$ns duplex-link $bs1 $msc 1Mb 10ms DropTail
$ns duplex-link $msc $bs2 1Mb 10ms DropTail
$ns duplex-link $bs2 $ms2 1Mb 1ms DropTail

puts "Cell Topology"

$ns bandwidth $ms1 $bs1 9.6kb simplex
$ns bandwidth $bs1 $ms1 9.6kb simplex

$ns insert-delayer $ms1 $bs1 [new Delayer]

#set tcp1 [new Agent/TCP]
set tcp1 [$ns create-connection TCP $ms1 TCPSink $ms2 0]
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
proc stop {} {
global node opt nf ms1 bs1
set sid [$ms1 id]
set did [$bs1 id]
puts $sid
puts $did

exec /home/ns-allinone-2.35/ns-2.35/bin/getrc -s $sid -d $did -f 0 out.tr | \
/home/ns-allinone-2.35/ns-2.35/bin/raw2xg -s 0.01 -m 100 -r > plot.xgr
exec /home/ns-allinone-2.35/ns-2.35/bin/getrc -s $sid -d $did -f 0 out.tr | \
/home/ns-allinone-2.35/ns-2.35/bin/raw2xg -a -s 0.01 -m 100 >> plot.xgr
exec ./xg2gp.awk plot.xgr
exec xgraph -bb -tk -nl -m -x time -y packet plot.xgr &
exit 0
}

$ns at 0.1 "$ftp1 start"
$ns at 20 "stop"
$ns run

set ns [new Simulator]
set tf [open sim4.tr w]
$ns trace-all $tf

set nf [open sim4.nam w]
$ns namtrace-all-wireless $nf 1000 1000

set top [new Topography]
$top load_flatgrid 1000 1000

set wch [new Channel/WirelessChannel]

proc finish { } {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exit 0
}

$ns node-config\
-adhocRouting DSDV\
-llType LL\
-macType Mac/802_11\
-ifqType Queue/DropTail\
-ifqLen 25\
-phyType Phy/WirelessPhy\
-propType Propagation/TwoRayGround\
-antType Antenna/OmniAntenna\
-topoInstance $top\
-agentTrace ON\
-routerTrace ON\
-channel $wch

create-god 3

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
$n0 label "TCP"
$n1 label "TCPSink,TCP"
$n2 label "TCPSink"

$n0 set X_ 50
$n0 set Y_ 50
$n0 set Z_ 0
$n1 set X_ 150
$n1 set Y_ 150
$n1 set Z_ 0
$n2 set X_ 500
$n2 set Y_ 500
$n2 set Z_ 0

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set tcpsink0 [new Agent/TCPSink]
$ns attach-agent $n1 $tcpsink0
$ns connect $tcp0 $tcpsink0

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set tcpsink1 [new Agent/TCPSink]
$ns attach-agent $n2 $tcpsink1
$ns connect $tcp1 $tcpsink1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

$ns at 0 "$n0 setdest 50 50 100"
$ns at 0 "$n1 setdest 150 150 100"
$ns at 0 "$n2 setdest 500 500 100"

$ns at 5 "$ftp0 start"
$ns at 5 "$ftp1 start"

$ns at 10 "$n1 setdest 400 400 100"
$ns at 20 "$n1 setdest 150 150 100"
$ns at 25 "finish"

$ns run

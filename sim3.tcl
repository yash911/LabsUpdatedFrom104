set ns [new Simulator]
set tf [open sim3.tr w]
$ns trace-all $tf
set nf [open sim3.nam w]
$ns namtrace-all $nf

proc stop { } {
	global ns nf tf
	$ns flush-trace
	close $nf
    	close $tf
    	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

lappend nl $n0 $n1 $n2 $n3 $n4 $n5
$ns make-lan $nl 1Mb 10ms LL Queue/DropTail

set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1

set tcpsink1 [new Agent/TCPSink]
$ns attach-agent $n5 $tcpsink1

$ns connect $tcp1 $tcpsink1

set tcp2 [new Agent/TCP]
$ns attach-agent $n4 $tcp2

set tcpsink2 [new Agent/TCPSink]
$ns attach-agent $n0 $tcpsink2

$ns connect $tcp2 $tcpsink2

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

$tcp1 attach $tf
$tcp1 trace cwnd_

$tcp2 attach $tf
$tcp2 trace cwnd_

$ns at 0.0 "$ftp1 start"
$ns at 0.2 "$ftp2 start"

$ns at 5.0 "stop"
$ns run

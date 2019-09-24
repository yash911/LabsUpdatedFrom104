set ns [new Simulator]
set tf [open sim2.tr w]
$ns trace-all $tf
set nf [open sim2.nam w]
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

$ns duplex-link $n0 $n5 1Mb 1ms DropTail
$ns duplex-link $n1 $n5 1Mb 1ms DropTail
$ns duplex-link $n2 $n5 1Mb 1ms DropTail
$ns duplex-link $n3 $n5 1Mb 1ms DropTail
$ns duplex-link $n4 $n5 1Mb 1ms DropTail

Agent/Ping instproc recv {from rtt} {
	$self instvar node_ 
	puts "node [$node_ id] recieved ping packet from $from with round trip time of $rtt ms"
}
$ns queue-limit $n0 $n5 2
$ns queue-limit $n1 $n5 2
$ns queue-limit $n2 $n5 2
$ns queue-limit $n3 $n5 2
$ns queue-limit $n4 $n5 2

set c1 [$ns create-connection Ping $n0 Ping $n2 1]
set c2 [$ns create-connection Ping $n1 Ping $n4 0]
set c3 [$ns create-connection Ping $n0 Ping $n3 0]
set c4 [$ns create-connection Ping $n3 Ping $n2 0]
set c5 [$ns create-connection Ping $n4 Ping $n3 0]

for {set i 1} {$i<=30} {incr i} {
	$ns at [expr $i/10] "$c1 send"
	$ns at [expr $i/10] "$c2 send"
	$ns at [expr $i/10] "$c3 send"
	$ns at [expr $i/10] "$c4 send"
	$ns at [expr $i/10] "$c5 send"
}

$ns at 5.0 "stop"
$ns run      																		

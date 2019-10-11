BEGIN {
    count1=0;
    count2=0;
    pack1=0;
    pack2=0;
    time1=0;
    time2=0;
}
{
    if($1=="r" && $3=="_1_" && $4=="AGT")
    {
        count1++;
        pack1=pack1+$8;
        time1=$2;
     }
     if($1=="r" && $3=="_2_" && $4=="AGT")
    {
        count2++;
        pack2=pack2+$8;
        time2=$2;
     }
}
END {
    printf("node(0) to node(1) performance link: %6.2f Mbps\n",((pack1*8)/(time1*1000000)));
    printf("node(0) to node(1) performance link: %6.2f pps\n",(count1/time1));
     printf("node(1) to node(2) performance link: %6.2f Mbps\n",((pack2*8)/(time2*1000000)));
    printf("node(1) to node(2) performance link: %6.2f pps\n",(count2/time2));
}

    

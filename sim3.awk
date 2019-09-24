BEGIN {
}
{
	if($6=="cwnd_")
	{
		if(($2==0)&&($4==5))
			printf("%4.2f %d\n",$1,$7)>>"g1.txt";
		if(($2==4)&&($4==0))
			printf("%4.2f %d\n",$1,$7)>>"g2.txt";
	}
}
END {
	printf("Done");
}

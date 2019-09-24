BEGIN {
	drop=0;
}
{
	if($1=="d")
	{
		drop++;
	}
}
END {
	printf("total number of packets dropped due to congestion=%d\n",drop);
}

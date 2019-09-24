BEGIN {
	count=0;
}
{
	if($1=="d")
		count++;
}
END {
	printf("Number of packet dropped= %d",count);
}

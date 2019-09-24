import java.util.*;
import java.io.*;
class LBucket
{
	public static void main (String[] args) throws InterruptedException
	{
		
		int csize=0;
		Scanner in=new Scanner(System.in);
		System.out.println("\nEnter the number of packets: ");
		int n=in.nextInt();
		System.out.println("\nEnter the bucket size : ");
		int bsize=in.nextInt();
		System.out.println("Enter the output rate : ");
		int opr=in.nextInt();
		System.out.println("Enter the time interval between packets : ");
		int time=in.nextInt();
		Random r=new Random();
		for(int i=0;i<n;i++)
		{
			int psize=r.nextInt(bsize+100);
			System.out.println("New packet arrived ");
			System.out.println("Packet number : "+(i+1)+ ",Packet size=" +psize);
			if(psize>bsize)
				System.out.println("Packet is too large...Non conforming packet");
			else if((psize+csize)>bsize)
				System.out.println("Bucket overflow..Non conforming packet ");
			else
				csize+=psize;
			for(int j=0;j<time;j++)
			{
				if(csize>opr)
				{
					System.out.println(opr+" bytes transmitted");
					csize-=opr;
			
				}
				else if(csize==0)
					System.out.println("Bucket empty...No bytes to transmit ");
				else
				{
					System.out.println("Remaining "+csize+" bytes transitted");
					csize=0;
				}
				Thread.sleep(1000);
			}
			System.out.println("Timer expired ");
			if(csize!=0)
				System.out.println(csize+" bytes still remain in bucket ");
			Thread.sleep(1000);
		}
		System.out.println("No more new packets ");
		if(csize!=0)
			System.out.println("\n Transmission of "+csize+" bytes remaining in bucket is starting ");
		while(csize>0)
		{
			if(csize>opr)
			{
				System.out.println(opr+" bytes tranmitted");
				csize-=opr;
			}
			else
			{
				System.out.println("Remaining "+csize+" bytes transmitted");
				csize=0;
			}
			Thread.sleep(1000);
		}
		System.out.println("Bucket empty ... Tramission completed ");
	}
}



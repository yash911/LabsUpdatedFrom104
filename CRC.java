import java.util.*;
import java.util.Scanner;
class CRC
{
	public static void main(String[] args)
	{
		Scanner in=new Scanner(System.in);
		
		System.out.println("enter the dataword:");
		String dw=in.next();
		System.out.println("enter the G.polynomial:");
		String gp=in.next();
		int ld=dw.length();
		int lg=gp.length();
		System.out.println("appending zero to DW:");
		for(int i=0;i<lg-1;i++)
			dw=dw+'0';
		System.out.println( "modified DW:"+dw);
		String cs=CRCode(dw,gp,lg,ld);
                System.out.println("the checksum is:"+cs);
		dw=dw.substring(0,ld)+cs;
		System.out.println("the final codeword:"+dw);
		System.out.println("Sending....");
		System.out.println("Receiving...");
		System.out.println("enter the received codeword :");
		String rcd=in.next();
		rcd=CRCode(rcd,gp,lg,ld);
		System.out.println("the new checksum is:"+rcd);
		String res="";
		for(int i=0;i<rcd.length();i++)
		{
			res=res+'0';
		}
		if(rcd.equals(res))
			System.out.println("No error");
		else
			System.out.println("error detected");
		
	
	}
	public static String CRCode(String dw,String gp,int lg,int ld)
	{
		String cs=dw.substring(0,lg);
		int e=lg;
		do
		{
			if(cs.charAt(0)=='1')
				cs=xor(cs,gp,lg);
			cs=cs.substring(1,lg);
			if(e<ld+lg-1)
				cs=cs+dw.charAt(e);
			e++;
		}while(e<=ld+lg-1);
		return cs;
	}
	public static String xor(String cs,String gp,int lg)
	{
		String v="";
		for(int i=0;i<lg;i++)
		{
			if(cs.charAt(i)==gp.charAt(i))
				v=v+'0';
			else
				v=v+'1';
		}
		
		return v;
	}

}		
					
		

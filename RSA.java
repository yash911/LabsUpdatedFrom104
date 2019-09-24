import java.util.*;
import java.lang.*;
class RSA
{
	public static void main(String[] args)
	{
		Scanner in=new Scanner(System.in);
		System.out.println("enter the message");
		String smsg=in.nextLine();
		int p,q,n,phi,e,k=1,d,c,m;
		System.out.println("generating key...");
		System.out.println("enter the values of p and q");
		p=in.nextInt();
		q=in.nextInt();
		n=p*q;
		phi=(p-1)*(q-1);
		System.out.println("n="+n);
		System.out.println("phi="+phi);
		do
		{
			System.out.println("enter the value of e such that e is < and 				relatively prime to :"+phi);
			e=in.nextInt();
		}while(gcd(e,phi)!=1);
		while(((k*phi)+1)%e!=0)
		{
			k++;
		}
		d=((k*phi)+1)/e;
		System.out.println("d="+d);
		System.out.println("public key={"+e+","+n+"}");
		System.out.println("private key={"+d+","+n+"}");
		System.out.println("encrypting...");
		int l=(int)smsg.length();
		int[] a=new int[l];
		for(int i=0;i<l;i++)
		{
			int s=ssmsg.charAt(i);
			a[i]=power(s,e,n);
		}
		System.out.println("sent message is:");
		for(int i=0;i<l;i++)
		{
			System.out.print(a[i]+"\t");
		}
		System.out.println();
		System.out.println("decrypting...");
		String rmsg="";
		for(int i=0;i<l;i++)
		{
			int s=power(a[i],d,n);
			rmsg+=(char)s;
		}
		System.out.println("decrypted message is="+rmsg);
	}
	public static int power(int m,int e,int n)
	{
		int r=1;
		for(int i=0;i<e;i++)
			r=(r*m)%n;
		return r;
	}
	public static int gcd(int m,int n)
	{
		int r;
		while(n!=0)
		{
			r=m%n;
			m=n;
			n=r;
		}
		return m;
	}
}

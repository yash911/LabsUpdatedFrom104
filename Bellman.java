import java.util.*;
import java.io.*;
class Bellman
{	
	public static class node
	{
		int dist;
		char phop;
	}
	public static void main(String[] args)
	{	
		int i,j;
		char ch[]={'a','b','c','d',};
		Scanner in=new Scanner(System.in);
		System.out.println("enter the number of nodes :");
		int n=in.nextInt();
		node[][] rt=new node[n][n];
		int[][] g=new int[n][n];
		int neigh[]=new int[n];
		for(i=0;i<n;i++)
			for(j=0;j<n;j++)
				rt[i][j]=new node();
		System.out.println("enter the adjacency matrix :");
		for(i=0;i<n;i++)
		{
			for(j=0;j<n;j++)
			{
				g[i][j]=in.nextInt();
			}
		}
		System.out.println("enter the distance:");
		for(i=0;i<n;i++)
		{
			System.out.print("the distance from node "+ch[i]+ " and" );
			for(j=0;j<n;j++)
			{
				if(g[i][j]==1)
				{
					System.out.print(" node "+ch[j]+ " is: ");
					rt[i][j].dist=in.nextInt();
				}
				else
					rt[i][j].dist=999;
				rt[i][j].phop=ch[i];
			}
		}
		int nc,choice;
		do
		{
			System.out.println("1.Routing table information\n2.Routing table\n3.Exit");
			choice=in.nextInt();
			switch(choice)
			{
				case 1:System.out.println("enter the node for which routing table shld be constructed :");
				int src=in.nextInt();
				src--;nc=0;
				System.out.println("the neighbours of "+ch[src]+ "are:");
				for(i=0;i<n;i++)
				{
					if(g[src][i]==1)
					{
						neigh[nc]=i;
						nc++;
						System.out.println(ch[i]+"\t");
					}
				}
					for(i=0;i<n;i++)
					{
						if(src!=i)
						{
							int small=rt[src][i].dist;
							int chosen=src;
							for(j=0;j<nc;j++)
							{
								int total=rt[neigh[j]][i].dist+rt[src][neigh[j]].dist;
								if(total<small)
								{
									small=total;
									chosen=neigh[j];
									rt[src][i].phop=ch[chosen];
								}
								rt[src][i].dist=small;
							}
							System.out.println("the smallest distance from " +ch[src]+" to "+ch[i]+ "is: "+small);
							System.out.println("the previous hop is :"+rt[src][i].phop);
						}
						else
							rt[src][i].dist=0;
					
				}
				break;
				case 2:for(i=0;i<n;i++)
					{
						for(j=0;j<n;j++)
						{
							System.out.print(rt[i][j].dist);
							System.out.print(rt[i][j].phop+"\t");
						}
						System.out.print("\n");
					}
					break;
			}
		}while(choice!=3);
	}
}

				
					

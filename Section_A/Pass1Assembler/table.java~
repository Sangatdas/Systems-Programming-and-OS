import java.io.*;

public class table {
			
	public static void main(String [] args) throws Exception
	{
		table tg= new table();	
		tg.read_line();
		tg.create_symtab();
		tg.create_littab();
		tg.create_IC();	
	}
    
	void mnemonic_add(String op, String cls, int inf) throws Exception
	{	
		table t = new table();
		BufferedWriter writer = new BufferedWriter(new FileWriter("mnemonics.txt", true));
		PrintWriter out = new PrintWriter(writer);
            
		if(t.mnemonic_get(op)==null)
		{
			out.println(op + " " + cls + " " +inf);
		}
		
		writer.close();
        out.close();
	}
	String[] mnemonic_get(String opcode) throws Exception
	{
		String line;
		String [] data = new String[3];
		String [] output = new String[3];
		BufferedReader reader = new BufferedReader(new FileReader("mnemonics.txt"));
		while((line = reader.readLine())!= null)
		{
			data = line.split(" ");
			if (data[0].equals(opcode))
			{
				output=data;
				break;
			}
		}
		reader.close();
		if(line!=null)
		{
			return output;
		}
		else
		{
			return null;
		}
	}
	void write_to_pool(int p) throws Exception
	{
		BufferedWriter writer = new BufferedWriter(new FileWriter("pool.txt", true));
		PrintWriter out = new PrintWriter(writer);
		out.println(p);
		writer.close();
		out.close(); 
	}
	int read_from_symtab(String symb) throws Exception
	{
		String line;
		int done=0;
		String [] data = new String[2];
		BufferedReader reader = new BufferedReader(new FileReader("symb_tab.txt"));
		while((line = reader.readLine())!= null)
		{
			data = line.split(" ");
			if (data[0].equals(symb))
			{
				done = Integer.parseInt(data[1]);
				break;
			}
		}
		reader.close();
		return done;
		
	}
	
	void write_to_symbtab(String sym, int add) throws Exception
	{
		
		BufferedWriter writer = new BufferedWriter(new FileWriter("symb_tab.txt", true));
		PrintWriter out = new PrintWriter(writer);
        out.println(sym + " " + add);
        writer.close();
        out.close();
	}
	
	void write_to_input(String line)throws Exception
	{
		BufferedWriter writer = new BufferedWriter(new FileWriter("input_with_addr.txt", true));
		PrintWriter out = new PrintWriter(writer);
		out.println(line);
		
		out.close();
		writer.close();
	}
	int get_line_addr(String label) throws Exception
	{
		int addr=0;
		String line;
		String [] instruct = new String[5];
		BufferedReader reader = new BufferedReader(new FileReader("input_with_addr.txt"));
		while((line = reader.readLine())!=null)
		{
			instruct =line.split(" ");
			int n = instruct.length;
			if(instruct[0].equals(label))
			{
				addr = Integer.parseInt(instruct[n-1]);
				break;
			}
		}
		reader.close();
		return addr;
	}
	void read_line()throws Exception
	{
		int pool = 1;
		table t = new table();
		
		BufferedReader reader = new BufferedReader(new FileReader("input.txt"));
		
        
		int initaddr = 0, curraddr=0, nliterals=0, i=0;
		String line;
		String [] instruct = new String[5];
		String [] literals = new String[10];
		
		//Address giving to each line
		while((line = reader.readLine())!=null)
		{
			instruct =line.split(" ");
			int n = instruct.length;
			
			//Instructions with length=1
			if(n == 1)
			{
				if(instruct[0].equals("STOP"))
				{
					t.write_to_input(line + " " + curraddr++);
				}
				else if(instruct[0].equals("END"))
				{
					t.write_to_input(line);
					if(nliterals != 0)
						t.write_to_pool(pool);
					
					while(i<nliterals)
					{
						curraddr = curraddr+i;
						t.write_to_input(literals[i] + " " + curraddr);
						pool++;
						i++;
					}
					i=0;
					nliterals=0;
					curraddr++;
				}
				else if(instruct[0].equals("LTORG"))
				{
					t.write_to_input(line);
					if(nliterals != 0)
						t.write_to_pool(pool);

					while(i<nliterals)
					{
						curraddr = curraddr+i;
						t.write_to_input(literals[i] + " " + curraddr);
						pool++;
						i++;
					}
					i=0;
					nliterals=0;
					curraddr++;
				}
			}
			
			//Instructions with length=2
			if (n == 2)
			{
				if(instruct[0].equals("START"))
				{
					initaddr =Integer.parseInt(instruct[1]);
					curraddr = initaddr;
					t.write_to_input(line);
				}
					
				else if(!(instruct[0].equals("EQU") || instruct[0].equals("ORIGIN")))
				{
					t.write_to_input(line + " " + curraddr++);
				}
				
				else if(instruct[0].equals("EQU"))
				{
					int temp = t.get_line_addr(instruct[1]);
					if(temp!=0)
					{
						t.write_to_input(line + " " + temp);
					}
				}
				
				else if(instruct[0].equals("ORIGIN"))
				{
					if(instruct[1].contains("+"))
					{
						int temp = t.get_line_addr((instruct[1].split("\\+"))[0]);
						if(temp!=0)
						{
							curraddr = temp+ (Integer.parseInt((instruct[1].split("\\+"))[1]));
							t.write_to_input(line);
						}
					}
					
					else if(instruct[1].contains("-"))
					{
						int temp = t.get_line_addr((instruct[1].split("\\-"))[0]);
						if(temp!=0)
						{
							curraddr = temp+ (Integer.parseInt((instruct[1].split("\\-"))[1]));
							t.write_to_input(line);
						}
					}
				}
			}
			
			//Instructions with length=3
			if(n == 3)
			{
				if(!(instruct[1].equals("EQU") || instruct[1].equals("ORIGIN")))
				{
					if(instruct[0].equals("MOVER")||instruct[0].equals("MOVEM") ||instruct[0].equals("ADD") || instruct[0].equals("SUB")|| instruct[0].equals("MUL")|| instruct[0].equals("DIV"))	//MOVER AREG, A 205 | MOVEM AREG, A 201
					{
						if(instruct[2].contains("="))							//MOVER AREG, ='5' 200 (literal present)
						{
							literals[nliterals] = instruct[2];
							nliterals++;
						}
					}
					t.write_to_input(line + " " + curraddr++);
				}
				
				else if(instruct[1].equals("EQU"))
				{
					int temp = t.get_line_addr(instruct[2]);
					if(temp!=0)
					{
						t.write_to_input(line + " " + temp);
					}
				}
				
				else if(instruct[1].equals("ORIGIN"))
				{
					if(instruct[2].contains("+"))
					{
						int temp = t.get_line_addr((instruct[2].split("//+"))[0]);
						if(temp!=0)
						{
							curraddr = temp+ (Integer.parseInt((instruct[2].split("//+"))[1]));
							t.write_to_input(line);
						}
					}
					
					else if(instruct[2].contains("-"))
					{
						int temp = t.get_line_addr((instruct[2].split("-"))[0]);
						if(temp!=0)
						{
							curraddr = temp+ (Integer.parseInt((instruct[2].split("-"))[1]));
							t.write_to_input(line);
						}
					}
				}
			}
			
			
			//Instructions with length=4
			if (n == 4)
			{
				if(instruct[1].equals("MOVER")||instruct[1].equals("MOVEM") ||instruct[1].equals("ADD") || instruct[1].equals("SUB")|| instruct[1].equals("MUL")|| instruct[1].equals("DIV"))	//MOVER AREG, A 205 | MOVEM AREG, A 201
				{
					if(instruct[3].contains("="))							//LABEL MOVER AREG, ='5' 200 (literal present)
					{
						literals[nliterals] = instruct[3];
						nliterals++;
					}
				}
				
				t.write_to_input(line + " " + curraddr++);
			}
		}
		
		
		System.out.println("Initial addredss: " + initaddr);
		
		reader.close();
	}
	
	void create_symtab() throws Exception
	{
		String line;
		String [] instruct = new String[6];
		BufferedReader reader = new BufferedReader(new FileReader("input_with_addr.txt"));

		while((line = reader.readLine())!=null)
		{
			instruct = line.split(" ");
			table t = new table();
			int n = instruct.length;
			
			if(n == 3)
			{
				if(instruct[1].equals("STOP") || instruct[1].equals("END"))	//LAST STOP 214
				{
					if(t.read_from_symtab(instruct[0]) == 0)
					{
						t.write_to_symbtab(instruct[0],Integer.parseInt(instruct[2]));
					}
				}
				
				
			}
			
			else if(n == 4)
			{
				if(instruct[0].equals("MOVER")||instruct[0].equals("MOVEM") ||instruct[0].equals("ADD") || instruct[0].equals("SUB")|| instruct[0].equals("MUL")|| instruct[0].equals("DIV"))	//MOVER AREG, A 205 | MOVEM AREG, A 201
				{
					if(!(instruct[2].contains("=")))							//MOVER AREG, ='5' 200
					{
						if(t.read_from_symtab(instruct[2]) == 0)
						{
							t.write_to_symbtab(instruct[2],t.get_line_addr(instruct[2]));
						}
					}
				}
				
				else if(instruct[1].equals("EQU"))			//BACK EQU LOOP 202
				{
					if(t.read_from_symtab(instruct[0]) == 0)
					{
						t.write_to_symbtab(instruct[0],Integer.parseInt(instruct[3]));
					}
				}
				
				else if(instruct[0].equals("BC"))			//BC LT, BACK 213
				{
					if(t.read_from_symtab(instruct[2]) == 0)
					{
						t.write_to_symbtab(instruct[2],t.get_line_addr(instruct[2]));
					}
				}
				
			}
			
			else if(n == 5)
			{
				if(instruct[1].equals("MOVER")||instruct[1].equals("MOVEM") ||instruct[1].equals("ADD") || instruct[1].equals("SUB")|| instruct[1].equals("MUL")|| instruct[1].equals("DIV"))	//MOVER AREG, A 205 | MOVEM AREG, A 201
				{
					if(!(instruct[3].contains("=")))							//LABEL MOVER AREG, X 200
					{
						if(t.read_from_symtab(instruct[3]) == 0)
						{
							t.write_to_symbtab(instruct[3],t.get_line_addr(instruct[3]));		//Adding X
						}
					}
					if(t.read_from_symtab(instruct[0]) == 0)
					{
						t.write_to_symbtab(instruct[0],Integer.parseInt(instruct[4]));			//Adding LABEL
					}
				}
				
				
				else if(instruct[0].equals("BC"))			//LABEL BC LT, BACK 213
				{
					if(t.read_from_symtab(instruct[3]) == 0)
					{
						t.write_to_symbtab(instruct[3],t.get_line_addr(instruct[3]));		//Adding BACK
					}
					
					if(t.read_from_symtab(instruct[0]) == 0)
					{
						t.write_to_symbtab(instruct[0],Integer.parseInt(instruct[4]));			//Adding LABEL
					}
				}
			}
		}
		
		reader.close();
	}

	void create_littab() throws Exception
	{
		BufferedReader reader = new BufferedReader(new FileReader("input_with_addr.txt"));
		BufferedWriter writer = new BufferedWriter(new FileWriter("littab.txt", true));
		PrintWriter out = new PrintWriter(writer);
		
		String line;
		while((line = reader.readLine())!=null)
		{
			String[] lit = line.split(" ");
			
			if(lit[0].contains("="))
			{
				out.println(lit[0] + " " + lit[1]);
			}
		}
		reader.close();
		out.close();
		writer.close();
	}

	int get_sym_no(String symb)throws Exception
	{
		BufferedReader reader = new BufferedReader(new FileReader("symb_tab.txt"));
		int n=0,done=0;
		String line;
		
		while((line = reader.readLine())!=null)
		{
			String []instruct = line.split(" ");
			n++;
			if(instruct[0].equals(symb))
			{
				done=1;
				break;
			}
		}
		reader.close();
		if(done==1)
		{
			return n;
		}
		else
		{
			return -1;
		}
	}
	
	int get_lit_no(String lit)throws Exception
	{
		BufferedReader reader = new BufferedReader(new FileReader("littab.txt"));
		int n=0,done=0;
		String line;
		
		while((line = reader.readLine())!=null)
		{
			String []instruct = line.split(" ");
			n++;
			if(instruct[0].equals(lit))
			{
				done=1;
				break;
			}
		}
		reader.close();
		if(done==1)
		{
			return n;
		}
		else
		{
			return -1;
		}
	}
	void create_IC() throws Exception
	{
		BufferedReader reader = new BufferedReader(new FileReader("input_with_addr.txt"));
		BufferedWriter writer = new BufferedWriter(new FileWriter("IC.txt", true));
		PrintWriter out = new PrintWriter(writer);
		table t = new table();
		
		String line;
		while((line = reader.readLine()) != null)
		{
			String []instruct = line.split(" ");
			int n = instruct.length;
			
			if(n ==1)		//END
			{
				if(instruct[0].equals("END"))
				{
					out.println("(" +t.mnemonic_get("END")[1] + "," +t.mnemonic_get("END")[2]+ ")" );
				}
			}
			
			else if(n == 2)				
			{
				if(instruct[0].equals("START"))	//START 200
				{
					out.println("(" + t.mnemonic_get("START")[1] + "," + t.mnemonic_get("START")[2] + ") " + "(C," + instruct[1] + ")");
				}
				
				else if (instruct[0].contains("="))	//='5' 211
				{
					out.println("(DL,02) " + "(C," + (instruct[0].split("'")[1]) + ")");
				}
				
				else if(instruct[0].equals("ORIGIN"))
				{
					if(instruct[1].contains("+"))
					{
						out.println("(" + t.mnemonic_get("ORIGIN")[1] + "," +t.mnemonic_get("ORIGIN")[2] + ") (S," + (t.get_sym_no(instruct[1].split("\\+")[0])) + ") +" + instruct[1].split("\\+")[1]);
					}
					else if(instruct[1].contains("-"))
					{
						out.println("(" + t.mnemonic_get("ORIGIN")[1] + t.mnemonic_get("ORIGIN")[2] + ") (S," + (t.get_sym_no(instruct[1].split("\\-")[0])) + ") -" + instruct[1].split("\\-")[1]);
					}
					else
					{
						out.println("(" + t.mnemonic_get("ORIGIN")[1] + t.mnemonic_get("ORIGIN")[2] + ") (S," + t.get_sym_no(instruct[1]) + ") ");
					}
				}
				
				else if(instruct[0].equals("STOP"))
				{
					out.println("(" + t.mnemonic_get("STOP")[1] + "," +t.mnemonic_get("STOP")[2] + ")");
				}
			}
			
			
			else if(n == 3)	//LAST STOP 216
			{
				if(instruct[1].equals("STOP"))
				{
					out.println("(" + t.mnemonic_get("STOP")[1] + "," + t.mnemonic_get("STOP")[2] + ")");
				}
			}
			
			else if(n == 4)
			{
				if(instruct[0].equals("BC"))	//BC ANY, NEXT 210				Not Working
				{
				String []splitted = instruct[1].split(",");
				out.println("(" + t.mnemonic_get("BC")[1] + "," + t.mnemonic_get("BC")[2] +") (" +t.mnemonic_get(splitted[0])[2]+ ") (S," + t.get_sym_no(instruct[2]) + ")");
					
				}
				
				else if(instruct[1].equals("DS") || instruct[1].equals("DC"))		//A DS 1 217
				{
					out.println("(" + t.mnemonic_get(instruct[1])[1] +","+ t.mnemonic_get(instruct[1])[2] + ") (C," + instruct[2] + ")");
				}
				
				else if(instruct[1].equals("EQU"))	//BACK EQU LOOP 202
				{
					out.println("(" + t.mnemonic_get(instruct[1])[1] + "," + t.mnemonic_get(instruct[1])[2] + ") (S," + t.get_sym_no(instruct[2]) + ")");
				}
				else
				{
					if(!(instruct[2].contains("=")))		//MOVER AREG, A 205 | MULT CREG, B 204
					{
						out.println("(" + t.mnemonic_get(instruct[0])[1] + "," + t.mnemonic_get(instruct[0])[2] + ") (" + t.mnemonic_get(instruct[1].split(",")[0])[2] + ") (S," + t.get_sym_no(instruct[2])+ ")");
					}
					else								//ADD CREG, ='1' 204 | MOVER AREG, ='5' 200
					{
						out.println("(" + t.mnemonic_get(instruct[0])[1] + "," + t.mnemonic_get(instruct[0])[2] + ") (" + t.mnemonic_get(instruct[1].split(",")[0])[2] + ") (L," + t.get_lit_no(instruct[2])+ ")");
					}
				}
			}
			
			else if(n == 5)
			{
				if(!instruct[3].contains("="))		//LABEL MOVER AREG, A 205 |LABEL MULT CREG, B 204
				{
					out.println("(" + t.mnemonic_get(instruct[1])[1] + "," + t.mnemonic_get(instruct[1])[2] + ") (" + t.mnemonic_get(instruct[2].split(",")[0])[2] + ") (S," + t.get_sym_no(instruct[3])+ ")");
				}
				else								//LABEL ADD CREG, ='1' 204 |LABEL MOVER AREG, ='5' 200
				{
					out.println("(" + t.mnemonic_get(instruct[1])[1] + "," + t.mnemonic_get(instruct[1])[2] + ") (" + t.mnemonic_get(instruct[2].split(",")[0])[2] + ") (L," + t.get_lit_no(instruct[3])+ ")");
				}
			}
		}
		
		out.close();
		writer.close();
		reader.close();
	}
}

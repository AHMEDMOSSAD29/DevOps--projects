#!/bin/bash
shopt -s extglob

PS3="
Enter your option >>> "  
clear
# Function to create a new database
create_database() {
    read -p "
              Enter the name of the new database: " database_name
    
    regex="^[a-zA-Z][a-zA-Z0-9_]*$"
    
    if ! [[ $database_name =~ $regex ]]; then
	
        echo "
	       Invalid,The name should only contain alphanumeric characters and underscores.
	     "
	
        return
    elif [[ -d $database_name ]]; then

        echo "
	           Database[ $database_name ]already exists. Please choose a different name.
	     "
	
        return
    else
    
    mkdir $database_name
    clear
   
    echo "
                                Database[ $database_name ]created successfully!
	 "
    
    fi
}

# Function to list all existing databases
list_databases() {
clear
        echo " 
	                *---------------------List of Databases----------------------*
	     "
     for db in */
    do
        if [[ -d $db ]]

        then
                
                echo "
		                           Database Name=[${db%/}]
		     "
	      
	else
         	clear
                echo "
	         	                    No Databases avilable    
	             "
               
        fi
    done
}

# Function to drop a database
drop_database() {
    read -p "
    Enter the name of the database to drop (separated by spaces if more than one): " db_names
    for db_name in $db_names
    do
        if [[ ! -d $db_name ]]
        then
	clear
                echo "
	        	              Database[ $db_name ]does not exist!
		     "
                         read -p "Would you like to list all Databases? (y/n) " ans
                         if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                          list_databases
                         fi

	        
        else
            rm -rf $db_name
	    clear
	    
            echo "
	                           Database[ $db_name ]dropped successfully!
	         "
	   

        fi
    done
}
 
#function to create table 
create_table(){
	read -p "Enter the table name (str): " table_name
     if [[ ! "$table_name" =~ ^[a-zA-Z_]+$ ]]
    then
	    clear
        echo "
	          Error: The table name can only contain letters, underscores."
        return 1
    fi

    if [ -f "$table_name" ]
    then
        read -p "Table [$table_name] exists. Would you like to list all tables? (y/n): " ans1
        if [[ "$ans1" =~ ^[Yy]$ ]]
        then
            list_table
        fi
    else
        touch "$table_name"
        touch "$table_name.metadata"
        read -p "Enter number of columns (int): " column_count
	if [[ "$column_count" =~ ^[0-9]*$ ]]; then
		echo "number of columns: $column_count" >> "$table_name.metadata"
            else
                    clear
                echo "
		           Error: The number of columns must be numbers "
                return 1
            fi
	    primary_key_set=false
            primary_key=""

for ((i=1; i<=$column_count; i++))
do
    read -p "Enter the name of column $i (str): " column_name
    echo "name of column $i: $column_name" >> "$table_name.metadata"
    read -p "Enter the datatype of column $i :" column_type
    echo "type of column $i: $column_type" >> "$table_name.metadata"

    if ! $primary_key_set; then
        while true; do
            read -p "Is $column_name the primary key? [y/n]: " is_primary
            case $is_primary in
                [yY] )
                    primary_key=$column_name
                    primary_key_set=true
                    break ;;
                [nN] )
                    break ;;
                * )
                    echo "Please answer yes or no." ;;
            esac
        done
    fi
done

# Write primary key information to metadata file
echo "primary key: $primary_key" > "$table_name.metadata.tmp"
cat "$table_name.metadata" >> "$table_name.metadata.tmp"
mv "$table_name.metadata.tmp" "$table_name.metadata"


	awk -F': ' 'NR>2 && NR % 2 == 1 {print $2}' $table_name.metadata >>tmp
        awk '{printf " %s |",$0} END{printf "\n"}' tmp > $table_name

	rm -rf tmp
	clear

        echo "
	                          Table [$table_name] created successfully
	    "
    fi
}

list_table() {
	clear
 echo "
                               * -----------------List of Tables---------------- *
        "
	echo "
	       Hints :
	       i) (table_name) has a name without any exctentions.
	      ii) table metadata have name of (table_name.meatedata)
	      "
	dir=$(pwd)

    if [ "$(ls -A $dir)" ]
    then
	    echo "`ls $dir`"
    else
        echo "
	                                         No tables exist 
	     "
        read -p "Would you like to create new table? (y/n) " ans
        if [[ "$ans" =~ ^Y$|^y$ ]]
        then
            create_table
        else
            echo "
	                                         No table created
	    "
	    clear
        fi
    fi
}

drop_table() {
    read -p "
               Enter the name(s) of the table(s) to drop: " -a table_names
    for table_name in "${table_names[@]}"
    do
        if [ -f "$table_name" ]
        then
            rm -rf "$table_name"
	    rm -rf "$table_name.metadata"
	    clear
            echo "
	                             table [$table_name] dropped successfully.
	               "
		     
        else
		clear
		      read -p "
               Table[$table_name]doesnt exist,Would you like to list all Tables? (y/n): " ans
                         if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                          list_table
                         fi
 
        fi
    done
}

#function to insert into table

insert_into_table() {

declare -a column_data_array

  read -p "Enter table name : " table_name
  if  [[ ! -f $table_name ]]; then
	  read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
	   if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
				 clear
                          list_table
			  return
		  else
			  return
			  clear
                         fi
  fi
  column_count=`awk 'NR==2{split($0,a,":"); print a[2]}' $table_name.metadata`
  column_type=(`awk -F': ' 'NR>3 && NR % 2 == 0 {print $2}' $table_name.metadata`)
  column_name=(`awk -F': ' 'NR>2 && NR % 2 == 1 {print $2}' $table_name.metadata`)
  

for ((i=0; i<$column_count; i++))
do
	read -p "Enter the data for column (${column_name[$i]}) with type(${column_type[$i]}): " column_data
column_data_array+=("$column_data")

done
printf ' %s | ' "${column_data_array[@]}" >> "$table_name"; printf '\n' >> "$table_name"
clear
echo " 
                                       Data inserted successfully "

}

#function for row selection
row_selection(){
while true
do

	echo "======================================================================================="
        echo "                                  Row Selection options                                "
        echo "======================================================================================="



    select n in  "press a to select all rows  " "press s to select spasfic row"\
                  "press n to select number of rows" "press q to Quit"
    do

        case $REPLY in
            a)
			  read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
			  break
				  fi
			  fi

		cat $table_name
                
				 
			  break
	       	;;
            s)
		    read -p "
                          Enter table name : " table_name
			  if  [[ ! -f $table_name ]]; then
          read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
           if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          break
			  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
			  break
	   fi
			  fi


		    read -p "
		          Enter row number : " row_num
		awk 'NR==1{print}' $table_name
                awk -v num="$row_num" 'NR==num{print; exit}' $table_name

                
			  break
	       	;;
            n)
		    read -p "
                          Enter table name : " table_name
			  if  [[ ! -f $table_name ]]; then
          read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
           if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
			  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
			  break
	   fi
			  fi

		    read -p "
		          Enter number of rows : " row_num
			   awk -v num="$row_num" '{print} NR==num{exit}' $table_name | head -n "$row_num"
	   
			 
                break ;;
            q)
                clear
                return ;;
            *)
                    echo "
                                                     Invalid option
                         "
                ;;
        esac
    done
done


}

#function of column selection 

column_selection(){
while true
do

	echo "======================================================================================="
        echo "                                  Column Selection options                             "
        echo "======================================================================================="



    select n in  "press a to select all columns  " "press s to select spasfic column"\
                 "press n to select number of columns" "press q to Quit"
    do

        case $REPLY in
            a)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi


		cat $table_name
                break ;;
            s)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi


		    read -p "
		          Enter column number : " num
			  cut -d "|" -f $num $table_name | sed 's/^/| /; s/$/ |/'

                break ;;
            n)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi

			  read -p "
			  Enter the comma-separated column numbers to display: " col_nums
                          cut -d "|" -f $col_nums $table_name | sed 's/^/| /; s/$/ |/'



                break ;;
            q)
                clear
                return ;;
            *)
                    echo "
                                                     Invalid option
                         "
                ;;
        esac
    done
done


}

#function for row deletion
row_deletion(){
while true
do

	echo "======================================================================================="
        echo "                                  Row Deletion options                                "
        echo "======================================================================================="



    select n in  "press a to delete all rows  " "press s to delete spasfic row"\
                  "press n to delete number of rows" "press q to Quit"
    do

        case $REPLY in
            a)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi


		sed '2,$d' $table_name > $table_name.tmp
		mv $table_name.tmp $table_name
		clear 
		echo "
		                             all row deleted successfully"

                break ;;
            s)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi

			  read -p "Enter the row number to delete: " row_num
                          sed "${row_num}d" $table_name > $table_name.tmp 
			  mv $table_name.tmp $table_name
			  clear
			  echo "
			                   row[$row_num]deleted successfully"



                break ;;
            n)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi

			  read -p "Enter the comma-separated row numbers to delete: " row_nums
                          sed -i "2,$(echo $row_nums | sed 's/,/d;/g')d" $table_name
			  clear
                          echo "
                                           rows[$row_nums]deleted successfully"





                break ;;
            q)
                clear
                return ;;
            *)
                    echo "
                                                     Invalid option
                         "
                ;;
        esac
    done
done


}

#function for columns deletion
column_deletion(){
while true
do

	echo "======================================================================================="
        echo "                                  Column Deletion options                             "
        echo "======================================================================================="



    select n in  "press a to delete all columns  " "press s to delete spasfic column"\
                 "press n to delete number of columns" "press q to Quit"
    do

        case $REPLY in
            a)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi


		sed '2,$d' $table_name > $table_name.tmp
                mv $table_name.tmp $table_name
                clear
                echo "
                                             all cloumns deleted successfully"

                break ;;
            s)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi

			  read -p "
			  Enter column number to delete : " colnum
		          awk -F\| -v OFS=\| -v colnum=$colnum '{ $colnum="" }1' $table_name > $table_name.tmp

                          mv $table_name.tmp $table_name
			  clear
			  echo "
			  column[$colnum]deleted successfully 
			  "



                break ;;
            n)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi

			  read -p "Enter space-separated column numbers to delete: " cols
                          awk -v cols="$cols" -F\| -v OFS=\| '{split(cols, nums, " "); for (i in nums) $nums[i]=""; print}' $table_name > $table_name.tmp
			  mv $table_name.tmp $table_name
			  clear
			  echo "
			  columns[$cols]deleted successfully
			  "





                break ;;
            q)
                clear
                return ;;
            *)
                    echo "
                                                     Invalid option
                         "
                ;;
        esac
    done
done


}


 
 

# function to select data from a table

select_from_table() {

while true
do
	echo "======================================================================================="
        echo "                                    Selection options                                  "
        echo "======================================================================================="



    select n in  "press r for row selection " "press c for column selection" "press q to Quit"
    do
        case $REPLY in
            r)
                row_selection
                break ;;
            c)
                column_selection
                break ;;
            q)
                clear
                return ;;
            *)
                    echo "
                                                     Invalid option
                         "
                ;;
        esac
    done
done
    
}

delete_from_table() {

while true
do
	echo "======================================================================================="
        echo "                                    Deletion options                                  "
        echo "======================================================================================="



    select n in  "press r for row Deletion " "press c for column Deletion" "press q to Quit"
    do
        case $REPLY in
            r)
                row_deletion
                break ;;
            c)
                column_deletion
                break ;;
            q)
                clear
                return ;;
            *)
                    echo "
                                                     Invalid option
                         "
                ;;
        esac
    done
done

}


#function to update table 

update_table() {

while true
do
	echo "======================================================================================="
        echo "                                    Update options                                     "
        echo "======================================================================================="



    select n in  "press u for update " "press q to Quit"
    do
        case $REPLY in
            u)
		      read -p "
                          Enter table name : " table_name
                          if  [[ ! -f $table_name ]]; then
                    read -p "Table [$table_name] doesn't exist ,list all tables ? (y/n): " ans
                                  if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                                 clear
                          list_table
                          return
                  elif [[ "$ans" =~ ^N$|^n$ ]]
                  then
                          return
                  else
                          break
                                  fi
                          fi


			 echo " "
			    cat $table_name
			 echo "" 


                          read -p "Enter the field to replace and its replacement, separated by a space: " search_word replace_word
awk -v search="$search_word" -v replace="$replace_word" -F '|' -v OFS='|' '{gsub(search, replace, $0); print}' "$table_name" > $table_name.tmp
                          mv $table_name.tmp $table_name
			  
			  cat $table_name
			  echo "
			  [$search_word] replaced by [$replace_word] successfully "


        
                
                break ;;
         
            q)
                clear
                return ;;
            *)
                    echo "
                                                     Invalid option
                         "
                ;;
        esac
    done
done

}


#function to show table metadata
show_data(){

	read -p "Enter table name : " table_name
	if [ -f "$table_name" ]
        then
		clear
		echo " 
		     *-----------------Metadata of Table[$table_name]----------------*
				      "
		sed -n '1,$p' $table_name.metadata | sed G | awk '{printf("%60s\n",$0)}'

        else
                clear
                      read -p "
               Table[$table_name]doesnt exist,Would you like to list all Tables? (y/n) " ans
                         if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                          list_table
                         fi

        fi



}

# Function to connect to a database
connect_to_database() {
    read -p "
                 Enter the name of the database to connect : " database_name
    if [[ ! -d $database_name ]]
    then
	    clear
       read -p "
              Database [$database_name] doesnt exist,Would you like to list all Databases? (y/n) " ans
                         if [[ "$ans" =~ ^Y$|^y$ ]]
                         then
                          list_databases
                         fi

                          return   
    fi
    cd $database_name
    clear
   
    echo "
                            Connected to Database[$database_name].
         "
   



while true
do

        echo "======================================================================================="
        echo "           	                  Database Menu  		                     "
        echo "======================================================================================="
	    

    select n in  "press c to Create a table" "press l to List tables"\
                 "press d to drop table" "press i to insert into table"\
                 "press s to select from table" "press D to Delete from table"\
		 "press u to update table" "press w to show tables metadata"\
		 "press q to return to main menu"
    do
        case $REPLY in
            c)
                create_table 
                break ;;
                
            l)
                list_table
                break ;;
            d)
                drop_table
                break ;;
            i)
                insert_into_table
                break ;;
            D)
                delete_from_table
                break ;;
	    u)
		update_table
		break ;;
	    w)
		show_data
		break ;;

	    s) 
		select_from_table
		break ;;
	    q)
		cd ..
		clear
                
                echo "
		                                 Returned to Main Menu.
		     "
               
                break 2 ;;
            *)

		    
                    echo " 
	 	                                    Invalid option           
		         "
                    
		 ;;   
        esac
    done
done
 
}



# Main menu 

ahmed=$(cat << "EOF"
          __  __  ____   _____ _____         _____    _____  ____  
         |  \/  |/ __ \ / ____/ ____|  /\   |  __ \  |  __ \|  _ \ 
         | \  / | |  | | (___| (___   /  \  | |  | | | |  | | |_) |
         | |\/| | |  | |\___ \\___ \ / /\ \ | |  | | | |  | |  _ < 
         | |  | | |__| |____) |___) / ____ \| |__| | | |__| | |_) |
         |_|  |_|\____/|_____/_____/_/    \_\_____/  |_____/|____/ 
                                                           
                                                                                               
                                            Welcome to the database 
EOF
)

green=$(tput setaf 2)
reset=$(tput sgr0)
echo "${green}$ahmed${reset}"

while true
do

	echo "================================================================================================"
	echo "                                         Main Menu                                              "
        echo "================================================================================================"

    select n in  "press C to Create a database" "press l to List all databases"\
		  "press c to connect to a database"\
		  "press d to Drop a database" "press q to Quit"
    do
        case $REPLY in
            C)
                create_database
                break ;;
            l)
                list_databases
                break ;;
            c)
                connect_to_database
                break ;;
            d)
                drop_database
                break ;;
            q)
		clear
                exit ;;
            *)
                    echo " 
	               	                             Invalid option   
	  	         " 
		;;
        esac
    done
done








# tbl2lst -- table to list

BEGIN { FS = OFS = "\t" }
NR == 1 {
         for (i=1; i<=NF; i++) {
               number[$i] = i
               name[i] = $i
               }
         Fields = NF
         next
       }

NR == 2        { printf "\n"; next }

       { for (i=1; i<=Fields; i++)
               printf "%s\t%s\n", name[i], $i
         printf "\n"
       }

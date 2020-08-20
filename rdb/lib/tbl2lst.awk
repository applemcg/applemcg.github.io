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

#
# awklib -- library of awk functions
#
# extern nf            // number of fields in the record
# static posn[]        // associative array "name" -> index
# extern field[]       // surrogate for $, field[i] -> $i
#
function prtarr( ar) { for ( a in ar) { print ar[a], a }; }
function concat(var,str) { if(var) return(var OFS str); else return(str); }

function record() {    send("%s",i=1)  # send all fields,
       while(++i<=nf)  send("\t%s",i)  # some may have blanks
                       send("\n", "")  # and follow with newline.
       }
function send(f,i)     { printf f, field[i]; field[i]="" }

function posf(n)       { if(!posn[n]) posn[n]=++nf; return posn[n] }

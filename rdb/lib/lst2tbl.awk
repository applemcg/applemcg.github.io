# lst2tbl -- list 2 tabl

BEGIN { FS = OFS = "\t"; stderr = ".awk.err"; }
function hedrRecord() {

         if (!head) { print HEAD; print DASH; head=1 }
              record()
       }

NF < 1 { if (NR>1) { hedrRecord();  next; }; }

       { print "# DEBUG: " NR, $0 > stderr }

head != 1 && $1 != "" {
       HEAD = concat(HEAD, $1)
       DASH = concat(DASH, substr("--------------",1,length($1)))

      print "# HEAD ", HEAD > stderr
      print "# DASH ", DASH > stderr

       field[posf($1)] = $2
       next
       }

       { field[posn[$1]] = $2 }

       END    { hedrRecord(); }
#
# awklib -- library of awk functions
#
# extern nf            // number of fields in the record
# static posn[]        // associative array "name" -> index
# extern field[]       // surrogate for $, field[i] -> $i
#
function concat(var,str) { if(var) return(var OFS str); else return(str); }

function record() {    send("%s",i=1)  # send all fields,
       while(++i<=nf)  send("\t%s",i)  # some may have blanks
                       send("\n", "")  # and follow with newline.
       }
function send(f,i)     { printf f, field[i]; field[i]="" }






function posf(n)       { if(!posn[n]) posn[n]=++nf; return posn[n] }

#  rdupdate  -- Relational Data update

[ -f $1 -a -f h.$1 ] || {
       echo $1 and h.$1 must both be files
       exit 1
}
 awk -F'	' "
BEGIN  { now = \"`date '+%y%m%d%H%M%S'`\""'    # make it a string
         fmt = "%s: %12s\t%12s\t<%s>\n"
         fmr = "%s\t%s\t%s\n"
}
function errprt(msg, ma, mb) {
	 printf fmt, msg, FILENAME, ma, mb > "test.err"
}
function nf(n,  i,r) {
       for (i=n; i<NF; i++) {
                r = r $(i) "\t"
       }
       r = r $NF
       errprt( "ordinar", r , $0 )
       return r
}
FILENAME ~ /^h\./   {
#
# deleted records, since, in the history, a record with a
#   value in the deleted field, is still deleted.
#
       if($2) {
              	errprt( "deleted", $2, $0)	
       		print $0
       } else {
#
#    ELSE,
# current historical records, so, for now ignore them.
#   collect the insertion time, and set a delete time,
#   if they dont show up. if found, they are undeleted.
#
	    record = nf(3)
            insert[record] = $1
            dtime[record]  = now
            errprt( "history",  dtime[record], record )
       }
}
FILENAME !~ /^h\./ && FNR > 2 {
	 if (icount++ < 1) {
	    for (f in insert) {
	           errprt("insrecd",insert[f], f )
		   }
	   }
	    	
#
# current records, "undelete" any here
#
       delete dtime[$0]
       errprt("currecd",insert[$0], $0 )
       if(! insert[$0]) {
       	    insert[$0] = now;
        }
        errprt(  "undelet", insert[$0], $0 )
        printf fmr,  insert[$0] , "", $0
}
#
# now print deleted records
#
END    {
       for (d in dtime) {
       	  errprt("testing", dtime[d], d)
               if (dtime[d] > 0) {    
	       	       errprt( "deleted", insert[d] " " dtime[d], d)
                       printf fmr,    insert[d], dtime[d] "" , d
               }
	       else
	       {

	              errprt( "ignored", insert[d] " " dtime[d], d)
	      }
       }
}'  h.$1 $1



#  rdupdate  -- Relational Data update
# date: 2020-06-21 defend against blank spaces in the DELETED field
# user must set NOW
BEGIN  { 
         fmt = "%s: %12s\t%12s\t<%s>\n"
         fmr = "%s\t%s\t%s\n"
}
function errprt(msg, ma, mb) {
	 printf fmt, msg, FILENAME, ma, mb > ".test.err"
}
function nf(n,  i,r) {
       for (i=n; i<NF; i++) {
                r = r $(i) "\t"
       }
       r = r $NF
       errprt( "ordinar", r , $0 )
       return r
}
       { errprt("RECORD", NR, NF); }
	   
FILENAME ~ /^h\./      || \
FILENAME ~ /\.hry\//   {    
#
# deleted records, since, in the history, a record with a
# non-blank value in the deleted field, is still deleted.
#
       if($2 !~ /^ *$/) {
              	errprt( "deleted", $2, $0)	
       		print $0
       } else {
#
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

FNR > 2 &&           ( \
FILENAME !~ /^h\./  && \
FILENAME !~ /\.hry\// ) {

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
}



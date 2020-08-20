  { [README](./README.md) }{ [Changelog](./changelog.md) }

# RDB, in awk

## RDB awk implementation

This is RDB 0.1.0, the Unix(R) Relational DataBase.

No warranty is implied, and this package should not be confused with
commercial versions of the same name, though there is much similarity
in the outlook and operation.

The source for this package was  manually entered by the author from a
draft copy of Manis, Shaeffer, and Jorgenson's [UNIX Relational
Database Management][UnixRDB], given to the author by Rod Manis in 1988.  
I've used these tools in more or less in their original form since then.

## State of the Project

This is a work in progress as of  2020-04-11.

At the moment, there are two components in ./bin: first the master
rdlib, the collection of all the functions, and the direction of the
project -- a single library of bash shell functions.  And the
collection of executable shell scripts, the great majority of which
will be converted to shell functions.

The commands and the library, **rdlib**

    column		  minimum	    rdegrep	      splittable
    dbdict		  mtable	    rdfgrep	      subtotal
    indexlib	  newjoinsh	    rdjoin	      total
    intersect	  nrdjoin	    rdlib	      trdp
    justify		  nrow		    rdpr	      ucd
    maximum		  precision	    rdudate	      whennew
    mean		  rd_hlistd	    sorttable	  widest

## References

+  The book: ["Unix RDB, Manis,.."][UnixRDB]

 [UnixRDB]: http://www.amazon.com/Relational-Database-Management-Prentice-Hall-Software/dp/013938622X   


for /d %%A in (7z,arj,bz2,bzip2,cab,cpio,deb,dmg,gz,gzip,hfs,iso,lha,lzh,lzma,rar,rpm,split,swm,tar,taz,tbz,tbz2,tgz,tpz,wim,xar,z,zip) do (

 assoc .%%A=7-zip.%%A
 
 )
 
reg import "%distrib_path%\7z.reg"
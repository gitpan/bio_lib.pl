#!/perl
#______________________________________________________________________
# Title     : Bio
# Usage     : require "Bio.pl"; ##<-- This is very slow, so you'd better
#             copy the subroutines in your prog. or make a smaller lib files
#               which are classified according to functions(like, Bio_Seq.pl
#               for sequence handling, Bio_Array.pl for various array
#               subroutines..), or make your own module out of this, do whatever
#               you want....
# Function  : This has all the sub routines A Biomatic has developed.
#             You can copy any of the sub routines in this file, modify, use
#             in yours...
#             Use Bio.pm if you want to use bio_lib.pl as a module and want
#             to call its subroutines by 'use Bio' in your code.
#             PLEASE MODIFY AS FREELY AS YOU WANT !!
#
#             " I am the programmer and I will try to debug with all my
#             efforts if you have any problems with my codes."
#
#             All my subroutines are tested in small files which test
#             the subroutines. If you want to have such single example program
#             to see how they really work, pls contact me( A Biomatic )
#             For example, a file called  'handle_arguments.pl' exists to
#             test the subroutine 'handle_arguments'.
#
#             for Bioperl project(the open project anybody can participate in)
#             The newest version of Bio.pl is in:
#             ftp://ftp.mrc-cpe.cam.ac.uk/pub/jong/Bioperl
#
# Example   : require "Bio.pl";
# Warning   : CopyLEFTed, and for the enhancement of Biology and Science.
#             This is a development companion, nothing else.
# Class     : Bio
#             Class is for classification of my subroutines. If it is B, it can
#             be useful for biological sequence data handling. If it's Utility,
#             it can also be used for general purpose file handling stuff.
#             File, Array, Hash,... are my classification items.
# Keywords  : Biology, sequence handling,
# Options   : nothing (used as subroutine library)
# Package   : B (remember, this is my personal Bio, not public Bioperl module)
#             There are certain package structures;
#               1. Bio is the highest structure. This includes file handling
#                  and utility stuff, too.
#               2. Bio::Seq  is rather specific for sequence handling stuff.
#                  To be sorted and developed later.
#               3. YOU can add, modify or discuss on this structure anytime :-)
#
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   : nothing (used as subroutine library)
# Tips      :
# Argument  : nothing (used as subroutine library)
# Todo      : Objects out of this.
# Author    : A Biomatic  and many others. Send me your codes to me!
# Version   : 1.3    (17/10/1996)
# Used in   :
# Enclosed  : None
#------------------------------------------------------------------

## The following box is used as the header for any subroutines developed to
##  give information on the subroutines. It is used by Jong as a template.
#______________________________________________________________
# Title     :
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------

## Following variables in 'my' are very commonly used ones. I have
## put those to be copied into any new subroutines to be developed
## This is because, in Perl, every variable is global unless you mark them
## to be inside the subroutines. Many BUGs are coming from not localizing vars.
## This array variables are used  as a defalt insertion for the subroutine
## 'handle_arguments'. If you add this box in any sub, 'handle_arguments'
## subroutine will be called and any arguments passed to the subroutine will
## be classified to file, dir, string, hash(as reference), array(as reference),
## pure number, or option(with -) prefix. etc. For more detail look at
## handle_argument's header.

	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#________________________________________________________________________
# Title     : handle_arguments
# Usage     : Just put the whole box delimited by the two '###..' lines below
#             to inside of your subroutines. It will call 'handle_arguments'
#             subroutine and parse all the given input arguments.
#             To use, claim the arguments, just use the variable in the box.
#             For example, if you had passed 2 file names for files existing
#             in your PWD(or if the string looks like this: xxxx.ext),
#             you can claim them by $file[0], $file[1] in
#             your subroutine.
# Function  : Sorts input arguments going into subroutines and returns default
#             arrays of references for various types (file, dir, hash, array,,,,)
#
# Example   : 'handle_arguments(\@array, $string, \%hash, 8, 'any_string')
# Warning   :
# Class     : Perl::Utility::Arg_handling
# Keywords  : handling arguments, parsing arguments,
# Options   :
# Package   :
# Reference :
# Returns   : Following GLOBAL variables
#
#             $num_opt,    @num_opt     @file          @dir
#             $char_opt,   @char_opt    %vars          @array,
#             @hash        @string,     @raw_string    @range,
#
#             $num_opt has 10,20
#             @num_opt has (10, 20)
#             @file has  xxxx.ext
#             @dir has  dir  or /my/dir
#             $char_opt has 'A,B'
#             @char_opt has (A, B)
#             @array has  (\@ar1, \@ar2)
#             @hash has (\%hash1, \%hash2)
#             @string  ('sdfasf', 'dfsf')
#             @raw_string (file.ext, dir_name, 'strings',,)
#             @range has values like  10-20
#
# Tips      : takes 0.02 u time with INDY
# Argument  : any type, any amount
# Todo      :
# Author    : A Biomatic
# Version   : 4.0
#             set_debug_option  is added.
# Used in   : everywhere
# Enclosed  :
#--------------------------------------------------------------------
sub handle_arguments{
	my($c, $d, $e, $f, $i, $j, $k, $l, $s, $t, $x, $y, $z, $char_opt, $dir, @hash,
		$file, $in_dir, $num_opt, @char_opt, @dir, @file, @string, @file_dir, @k,
		@num_opt, @string, @array, %vars, @range, @temp, $temp);

  &set_debug_option;
  if(@_<1){ print chr(7),"\n This is handle_arguments. No args Passed, Error?\n"}
  elsif( (@_ ==1)&& (ref($_[0]) eq 'ARRAY') ){ # when there is only 1 argument
	  push(@array, $_[0]);
	  push(@k, $_[0]);
  }elsif( (@_==1)&&( !ref($_[0]) ) ){
	  if(-f $_[0]){ push(@file, $_[0]);   push(@string, $_[0]) }
	  elsif(-d $_[0]){ push(@dir, $_[0]); push(@string, $_[0]) }
	  elsif($_[0]=~/^\d+$/){ push(@num_opt, $_[0]); $num_opt.=$_[0] }
	  elsif($_[0]=~/^\w+$/){ push(@string, $_[0]); }
  }elsif(@_ >=1){ @k = @_ }

  #####______Start of  general argument handling______######
  for($k=0; $k < @k ;$k++){
	  if( !ref($k[$k]) ){
		  if($k[$k]=~ /^[\-]*([a-zA-Z]\d*)$/){  push(@char_opt, $1); $char_opt .= "$1\,";
		  }elsif($k[$k]=~ /^\-([a-zA-Z]+)$/){          ## When multiple option is given,
			  my(@char_options) = split(/\,|/, $1);  push(@char_opt, @char_options);
			  $char_opt .= join("\,", @char_options); ## '-' should be used. eg. '-HEGI'
		  }elsif($k[$k]=~ /^(\w+)\=(\S*)$/){  $vars{$1}=$2;  $vars .= "$1\,";
		  }elsif($k[$k]=~ /^(\-?\d+)$/){ push(@num_opt, $1);  $num_opt .= "$1\,";
		}elsif($k[$k]=~ /^\d+\.?\d*\-\d+\.?\d*$/){   push(@range,  $k[$k] );
		  }elsif(-f $k[$k]){                           push(@file,   $k[$k] );
		  }elsif(-d $k[$k]){                           push(@dir,    $k[$k] );
		  }elsif($k[$k]=~ /\/[\w\d\.\-]+[\/].+[\/]/){  push(@dir,    $k[$k] );
		  }elsif($k[$k]=~ /^\/[\w\d\.\-]+[\/]*$/){     push(@dir,    $k[$k] );
		  }elsif($k[$k]=~ /^[\/\w\d\-\.]+\.\w+$/){     push(@file,   $k[$k] );
		  }elsif($k[$k]=~/^\w+[\w\d\.\-]+$/){          push(@string, $k[$k] );      }
	  }elsif( ref($k[$k]) ){
		  if( ref($k[$k]) eq "SCALAR"){
			 if(${$k[$k]} =~ /^[\-]*([a-zA-Z]\d*)$/){ push(@char_opt, $1); $char_opt  .= "$1\,";
				}elsif(${$k[$k]}=~ /^\-([a-zA-Z]+)$/){ push(@char_opt, @char_options);
					$char_opt  .= join("\,", @char_options);  ## as an option string.
				}elsif(${$k[$k]}=~ /^(\w+)\=(\S*)$/){  $vars{$1}=$2;  $vars .= "$1\,";
				}elsif(${$k[$k]}=~ /^(\-*\d+)$/){ $num_opt .= "$1\,";  push(@num_opt, $1);
			}elsif(${$k[$k]}=~ /^\d+\.?\d*\-\d+\.?\d*$/){    push(@range,  $k[$k] );
				}elsif(-f ${$k[$k]}){                            push(@file,   ${$k[$k]} );
				}elsif(-d ${$k[$k]}){                            push(@dir,    ${$k[$k]} );
				}elsif(${$k[$k]}=~ /\/[\/\w\d\.\-]+[\/].+[\/]/){ push(@dir,    ${$k[$k]} );
				}elsif(${$k[$k]}=~/^\/[\/\w\d\.\-]+[\/]*$/){     push(@dir,    ${$k[$k]} );
				}elsif(${$k[$k]}=~ /^[\/\w\d\-\.]+\.\w+$/){      push(@file,   ${$k[$k]} );
				}elsif(${$k[$k]}=~/^\w+[\w\d\.\-]+$/){           push(@string, ${$k[$k]} );
				}else{                                           push(@raw_string, ${$k[$k]}); }
		  }elsif(ref($k[$k]) eq "ARRAY"){     my @temp_arr = @{$k[$k]};
				for ($i=0; $i<@temp_arr; $i++){
			   if(-f $temp_arr[$i]){                            push(@file, $temp_arr[$i]);
			   }elsif($temp_arr[$i]=~/^\d+\.?\d*\-\d+\.?\d*$/){ push(@range,$temp_arr[$i] );
					}elsif(-d $temp_arr[$i]){                        push(@dir , $temp_arr[$i]);
					}elsif($temp_arr[$i]=~/\/[\/\w\d\.\-]+[\/].+[\/]/){ push(@dir, $temp_arr[$i] );
					}elsif($temp_arr[$i]=~/^\/[\/\w\d\.\-]+[\/]*$/){ push(@dir, $temp_arr[$i] );
					}elsif($temp_arr[$i]=~/^[\/\w\d\-\.]+\.\w+$/){   push(@file,$temp_arr[$i] );
					}elsif($temp_arr[$i]=~/^\w+[\w\d\.\-]+$/){       push(@string,$temp_arr[$i]);
					}else{                                           push(@raw_string, $temp_arr[$i]);}
				}
		  }elsif(ref($k[$k]) eq "HASH"){                             push(@hash,   $k[$k] ); }
	  }
  }
  @raw_string=(@raw_string, @string);
  @file = @{&remove_dup_in_arrayH(\@file)};
  #-----------------------------------------------------
	 sub remove_dup_in_arrayH{  my($i, @out_ref, %duplicate, @orig, @out_ref);
		for($i=0; $i<@_; $i++){  undef(%duplicate);
	 if(ref($_[$i]) eq 'ARRAY'){    @orig = @{$_[$i]};    }
	 @nondup = grep { ! $duplicate{$_}++ } @orig; push(@out_ref, \@nondup);  }
		if(@out_ref ==1){ return($out_ref[0]);}
		elsif(@out_ref >1){  return(@out_ref);}
	 }
  #-----------------------------------------------------
  return(\@hash, \@array, \@string, \@dir, \@file, \@num_opt,
			\@char_opt, \$num_opt, \$char_opt, \@raw_string, \%vars, \@range );
}

#______________________________________________________________
# Title     : make_swiss_index
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub make_swiss_index{
   my $swiss, %index;
   if(-e "$ENV{'SWDIR'}seq.dat" ){
	  $swiss="$ENV{'SWDIR'}seq.dat";
   }elsif( -f "$ENV{'SWISS'}seq.dat" ){
	  $swiss="$ENV{'SWISS'}seq.dat";
   }elsif( -e 'seq.dat'){
	  $swiss="seq.dat";
   }elsif( -f "$ENV{'swiss'}seq.dat"){
	  $swiss="$ENV{'swiss'}seq.dat";
   }else{
	 ASK: print "\n Where is your swissprot seq.dat file?\n";
	  $swiss=<>;
	  chomp($swiss);
	  if(-e "$swiss"){
		 goto OPEN;
	  }else{
		 goto ASK;
	  }
   }
   OPEN: open(DB, "$swiss");
   while(<DB>){

	 if(/^ID[\t ]+(\w+) +/){
		$index{$1}=tell(DB);
		print "\n$1 $index{$1}";
	 }
   }
}



#______________________________________________________________
# Title     : fetch_swiss_seq
# Usage     :
# Function  : fetches swissprot entry or fasta format seq with
#             given seq name(like  SAA_HORSE, SA*HORSE, SAA,..)
#             you can give multi files(SAA*, SAU*) at the same
#             time. This uses ENV setting of 'SWDIR'
# Example   : &fetch_swiss_seq(@ARGV);
# Warning   :
# Class     : Bio
# Keywords  : fetch_swissprot_sequence, fetch_sequence,
#             find_swiss_sequence, find_sequence, fetch
# Options   : _  for debugging.
#             #  for debugging.
#             -f for fasta format file output
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  : swissprot seqname
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub fetch_swiss_seq{
   my @in=@_; my $i, $index_file, $target, $matched, $seq;
   if(@_ < 1){
	 print "\n Usage: $0 [-f] <any swissprot name entry>\n";
	 print "   -f is for fasta output format only\n";
	 print "\n You have to set ENV var, SWDIR to seq.dat path\n";
	 print chr(7);
   }
   for($i=0; $i<@in; $i++){
	  if($in[$i]=~/\-f$/i){
		 $fasta=1;
		 splice(@in, $i, 1);
		 next;
	  }
   }

   if(-e "$ENV{'SWDIR'}seq.dat" ){
	  open(DB, "$ENV{'SWDIR'}seq.dat");
   }elsif( -f "$ENV{'SWISS'}seq.dat" ){
	  open(DB, "$ENV{'SWISS'}seq.dat");
   }elsif( -e 'seq.dat'){
	  open(DB, "seq.dat");
   }elsif( -f "$ENV{'swiss'}seq.dat"){
	  open(DB, "$ENV{'swiss'}seq.dat");
   }

   if(-e "$ENV{'SWDIR'}seq.idx" ){
	  $index_file="$ENV{'SWDIR'}seq.idx";
   }elsif( -f "$ENV{'SWISS'}seq.idx" ){
	  $index_file="$ENV{'SWISS'}seq.idx";
   }elsif( -e 'seq.idx'){
	  $index_file="seq.idx";
   }elsif( -f "$ENV{'swiss'}seq.idx"){
	  $index_file= "$ENV{'swiss'}seq.idx";
   }
   for($i=0; $i<@in; $i++){
	  my @possible;
	  my $target=$in[$i];
	  $target=~s/\*/\\\w\{0,4\}/; # to handle glob input
	  open(INDEX, "$index_file");
	  while(<INDEX>){
		if( /(\w*$target\w*)/ ){
		   push(@possible, $1);
		}
	  }
	  close INDEX;
	  open(INDEX,  "$index_file");
	  if(@possible >1){
		 print "\n@possible", "\n";
		 print chr(7);
		 print "\n There are more than a few seqs for $in[$i], \n be more specific!\n\n";
	  }else{
		 print "\n";
		 A:while(<INDEX>){
		   if(/(\w*$target\w*)[\t ]+(\d+)/){
			 $matched=$1;
			 seek(DB, ($2-51), 0);
			 while(<DB>){
			   if((/^\/\/$/)&&($fasta==1)){
				  $seq=~s/ //g;
				  print "\>$matched\n$seq\n";
				  $seq='';
				  next A;
			   }elsif((/^\/\/$/) && ($fasta !=1)){
				  print "\n";
				  next A;
			   }elsif(($fasta==1)&&(/^[\t ]+\w+/)){
				  $seq.=$_;
				  next ;
			   }elsif($fasta !=1){
				  print ;
			   }
			 }
		   }
		 }
		 print "========= Search for $ARGV[$i] was a success\n" if @in > 1;
	  }
   }
}




#______________________________________________________________
# Title     : get_sequence_number
# Usage     :
# Function  : reads database and tells how many sequences are there
#             fasta format db is only accepted for now.
# Example   :
# Warning   :
# Class     :
# Keywords  : count_number_of_sequence, get_number_of_sequence
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_sequence_number{
   	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my $seq_number_in_db;
	for($i=0; $i< @file; $i++){
	   open(DB, "$file[$i]");
	   while(<DB>){
		  if(/^\> {0,5}\w+/){
			 $seq_number_in_db++;
		  }
	   }
	   close DB;
	}
	return(\$seq_number_in_db);
}




#______________________________________________________________________
# Title    : write_msf
# Function : writes multiple seqs. in msf format (takes one or more than one seq.!!)
# Usage    : two argments:  $seq_hash_reference  and $output_file_name
# Usage    : takes a hash which has got names keys and sequences values.
# Usage    : uses Perl5 pointers(references).
# Example  : &write_msf(\%hash, \$out_file_name);
#    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    PileUp
#
#
#
#       MSF: 1205  Type: P    Check:  9937   ..
#
#     Name: PYC1_YEAST      oo  Len: 1205  Check:  7954  Weight:  1.00
#     Name: PYC2_YEAST      oo  Len: 1205  Check:  5807  Weight:  1.00
#     Name: PYC_MOUSE       oo  Len: 1205  Check:  6176  Weight:  1.00
#
#    //
#
#
#
#    PYC1_YEAST      MSQ.RKFAGL RDNFNLLGEK N......... .......... .KILVANRGE
#    PYC2_YEAST      MSSSKKLAGL RDNFSLLGEK N......... .......... .KILVANRGE
#    PYC_MOUSE       ...MLKFQTV RGGLRLLGVR RSSSAPVASP NVRRLEYKPI KKVMVANRGE
#
#
#    PYC1_YEAST      IPIRIFRTAH ELSMQTVAIY SHEDRLSTHK QKADEAYVIG EVGQYTPVGA
#    PYC2_YEAST      IPIRIFRSAH ELSMRTIAIY SHEDRLSMHR LKADEAYVIG EEGQYTPVGA
#    PYC_MOUSE       IAIRVFRACT ELGIRTVAVY SEQDTGQMHR QKADEAYLIG R..GLAPVQA
#
#
#    PYC1_YEAST      YLAIDEIISI AQKHQVDFIH PGYGFLSENS EFADKVVKAG ITWIGPPAEV
#    PYC2_YEAST      YLAMDEIIEI AKKHKVDFIH PGYGFLSENS EFADKVVKAG ITWIGPPAEV
#    PYC_MOUSE       YLHIPDIIKV AKENGVDAVH PGYGFLSERA DFAQACQDAG VRFIGPSPEV
#
# Keywords : write_msf_files, save_msf_files
# Version  : 1.2
# Warning  :
#------------------------------------------------------------
sub write_msf{
   $| =1;
   my(%input)=%{$_[0]};
   my($output_file)=${$_[1]};
   my($string, $name);
   open (msf_WRITE,">$output_file");		# $string is the seq string.

   print msf_WRITE 'PileUp', "\n\n";
   print msf_WRITE '   MSF: 1205  Type: P    Check:  9937   .. '; ## This is dummy
   print msf_WRITE "\n\n";

   my(@names) = keys %input;
   my($larg)  = length($input{$names[0]});

   for $name (keys %input){
	 $len = length($input{$name});
	 printf msf_WRITE (" Name: %-15s oo  Len: %-5s Check:  9999  Weight:  1.00\n", $name, $len);
   }
   print msf_WRITE "\n";
   print msf_WRITE "\/\/\n\n\n\n";

#""""""""""""""""""""""""""""""""""""""""""""""""""
#             MSF file form
#==================================================
format msf_WRITE =
@<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$names,         $seq
.
  for ($k=0; $k < $larg; $k+=50){    # 50 residues interval
	for($i=0; $i < @names; $i++){    # number of sequences
	  $names = $names[$i];
	  $input{$names[$i]}=~ s/\n//g;
	  $seq = substr($input{$names[$i]}, $k, 50);
	  $seq = &put_gaps_every_x_position_in_string($seq, 10, ' ');
	  select (msf_WRITE); ## to print out to a FILE
	  #$~='msf_WRITE';
	  write msf_WRITE;
	}
	print "\n";                       # next block starts.
  }
  close(msf_WRITE);
  select STDOUT;  # <- this is necessary to normalize output for other sub
}

#______________________________________________________________
# Title     : get_seqblock
# Usage     :
# Function  :
# Example   : @blocks_in_hash=@{&get_seqblock(\%msf, 30)};
# Warning   :
# Class     :
# Keywords  : find_sequence_block, get_sequence_block,
#             make_seq_block, make_seqblock, find_seqblock
# Options   : _  for debugging.
#             #  for debugging.
#             <anydigit> for minimum seqlet size
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_seqblock{
  	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my @seq_frag, %digitized, %hash;
	my $min_seqlet_size;
	for($o=0; $o<@hash; $o++){
	  %hash=%{$hash[$o]};
	  %digitized=%{&convert_char_to_0_or_1_hash($hash[$o])};
	}
	if( defined($num_opt[0])){
	   $min_seqlet_size=$num_opt[0];
	}else{
	   $min_seqlet_size=30;
	}
	%added=%{&add_columns(\%digitized)}; # 11111 + 1010101 => 2121211
	%blocks=%{&get_high_score_blocks(\%added)};
	my @keys=keys %blocks;
	for($e=0; $e< @keys; $e++){
	   my $range="$keys[$e]\-$blocks{$keys[$e]}";
	   my $seq_let_leng=$blocks{$keys[$e]} - $keys[$e] + 1;
	   if($seq_let_leng < $min_seqlet_size){
		  next;
	   }
	   print "\n \$range is $range", "\n" if $debug ==1;
	   push(@RANGE, $range);
	}
	@seq_frag=&get_seq_fragments(\%hash, @RANGE, $min_seqlet_size);
	return(\@seq_frag);
}



#______________________________________________________________
# Title     : add_columns
# Usage     :
# Function  :
# Example   :
# Warning   : if the attached name is too long(over 12 char),
#             it changes to 'Added_upX' while X is a numb.
# Class     :
# Keywords  : add_seq_columns, add_sequence_columns,
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub add_columns{
	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my $gap_char=' ';
	for($i=0; $i<@hash; $i++){
	  my %hash=%{$hash[$i]};
	  my @names=keys %hash;
	  my %final_hash_out;
	  my @final_added;
	  my $out_seq_name='Add';
	  for($j=0; $j<@names; $j++){
	     $out_seq_name.= "_$names[$j]";
		 my $string =$hash{$names[$j]};
		 my @ar_string;
		 if($string=~/\d{1,5}[ \,]\d{1,5}[ \,]\d{1,5}/){
			@ar_string =split(/$gap_char|\,/, $string );
		 }elsif($string=~/^\d{5,}$/){
			@ar_string =split(//, $string );
		 }
		 for($s=0; $s < @ar_string; $s++){
			$final_added[$s]=$ar_string[$s]+$final_added[$s];
		 }
	  }
	  if(length($out_seq_name) > 12){ $out_seq_name="Added_up${i}"; }
	  $final_hash_out{$out_seq_name}=join("$gap_char", @final_added);
	  push(@OUT_HASH, \%final_hash_out);
	}
	wantarray ? return(@OUT_HASH) : return($OUT_HASH[0]);
}


#______________________________________________________________
# Title     : get_high_score_blocks
# Usage     :
# Function  : get_high_score_blocks(<ref. of hash for number string>)
# Example   : %block_start_end=%{&get_high_score_blocks(\%input_numb_block)};
# Warning   :
# Class     :
# Keywords  : get_high_scoring_blocks, find_blocks, get_blocks
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  : accepts one single ref. of hash
# Todo      :
# Author    : A Scientist
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_high_score_blocks{
  	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my $min_seqblock_leng=12;
	my $threshold=0.9;
	my %block_start_end, @possible_block;
	my $margin=$margin_ori=3;  # $margin is m in .....mmm111111111111mmm.....
	my $gap_char=' ';
	my %hash;
	for($i=0; $i<@hash; $i++){
	   my @range;
	   my %hash_ori=%{$hash[$i]};
	   my @names=keys %hash_ori;
	   if(@names>1){ # If the hash has multi entry, make one added up hash
	      %hash=%{&add_columns(\%hash_ori)};
	      @names=keys %hash;
	   }else{
	      %hash=%hash_ori;
	   }
	   for($j=0; $j< @names; $j++){
		  my $string=$hash{$names[$j]};
		  if($string=~/\d{1,5}[ \,]\d{1,5}[ \,]\d{1,5}/){
			 @ar_string =split(/$gap_char|\,/, $string );
		  }elsif($string=~/^\d{5,}$/){
			 @ar_string =split(//, $string );
		  }
		  my $largest = ${&get_largest_element(\@ar_string)};
		  my $cut_line=$largest*$threshold;

		  print "\n \$cutline in get_high_score_blocks is $cut_line \n" if $debug==1;
		  ###### Cutting the tops#######
		  for($s=0; $s< @ar_string; $s++){
			 if($ar_string[$s] > $cut_line){
				if(@possible_block == $min_seqblock_leng){
				   while( $ar_string[$s] > $cut_line){
					  $ar_string[$s]=1;
					  while($s+1+$margin > @ar_string){ $margin-- }
					  push(@possible_block, ($s+1+$margin));
					  $margin=$margin_ori;
					  $s++;
				   }
				   $ar_string[$s]=0;  #<--- Should be 0 than 1
				   $block_start_end{$possible_block[0]}=$possible_block[$#possible_block];
				   @possible_block=();
				}else{
				   $ar_string[$s]=1;
				   while(($s+1-$margin) < 0){ $margin-- };
				   push(@possible_block, ($s+1-$margin) );
				   $margin=$margin_ori;
				}
			 }elsif($ar_string[$s] <= $cut_line){
				$ar_string[$s]=0;
				@possible_block=();
			 }

		  }
		  print "\n", @ar_string,"\n" if $debug==1;
	   }
	}
	return(\%block_start_end);
}





#______________________________________________________________
# Title     : delbut
# Usage     : delbut *.zip  (delete files except xxxx.zip)
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub delbut{
  my $i;
  @save_files=@{$_[0]} || @_;
  for(@save_files){
	unless(-e $_){
	  print "\n\n \"$_\" does not exist, so nothing is deleted\n\n";
	  print chr(7);
	  exit;
	}
  }
  my @files=@{&read_file_names_only('.')};
  my @del_files=@{&subtract_array(\@files, \@save_files)};

  for($i=0; $i< @del_files; $i++){
	 system("rm -f $del_files[$i]");
  }
  print "\n\n Subdirs are never deleted \n\n";
}



#______________________________________________________________
# Title     : get_msp_range
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_msp_range{
   my $lines1=$_[0];
   my $SEQ, $num_seq, $matched_SEQ, @Ranges;
   if($lines1 =~/^ *\d+ +\d+\.\d+ +(\d+) +(\d+) +(\w+) +(\d+) +(\d+) +(\w+)/i){
	  $SEQ        =$3;
	  $matched_SEQ=$6;
	  if($SEQ eq $matched_SEQ){ ## skipping self match
		  $num_seq++;
		  print "\n $num_seq";
	  }else{
		  @Ranges=($1, $2, $4, $5);  ## <-- example. (10-20, 30-45)
	  }
   }
   return(\@Ranges, $SEQ, $matched_SEQ);
}


#______________________________________________________________
# Title     : get_linked_sequence
# Function  : opens msp file and links the sequences according
#             to the matches.
# Usage     :
# Example   : seq1 ------------------------------
#                            |||||||||||
#             seq2        --------------------------------
#             OUT  000000000011111111111000000000000000000
#
# Warning   :
# Class     :
# Keywords  : link_sequence_from_msp_file, linked_sequenced_length
#             get_clustered_sequence_length, get_annexed_sequence_length
#
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   : A ref. of an array
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_linked_sequence{
	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   my $final_leng, $start_diff,@MSP, %seq_sizes, $final_leng;
   my $max_head_overhang, $head_diff, $tail_diff, $start_diff,
		 $off_set, $max_tail_overhang, @LINKED, $LINKED;
   my $Threshold=40;
   for($i=0; $i< @file; $i++){
	  my($input_file) = ${$file[$i]} || $file[$i];
	  if($debug eq 1){ print "\n inputfile is $input_file\n" };
	  unless (-e $input_file){
		  print chr(7);
		  print "\n\n\t This is sub open_msp_files in $0  \n\n";
		  print "\t Fatal: The input file $input_file is not in the directory \n";
	  }
	  my %seq_sizes=%{&open_msp_files(\$input_file, '-s')};
	  my @NAmes=keys %seq_sizes;
	  for($s=0; $s< @NAmes; $s++){ # making '000000000000000.....';
		 my $len=$seq_sizes{$NAmes[$s]};
		 for($t=0; $t< $len; $t++){
			${"$NAmes[$s]"}[$t]=0;
		 }
	  }
	  open(FILE_1,"$input_file");
	  my @MSP=<FILE_1>;
	  close(FILE_1);
	  for($j=0; $j<@MSP; $j++){
		 if($MSP[$j]=~/^ *(\d+) +\d+\.*\d* +(\d+) +(\d+) +(\w+) +(\d+) +(\d+) +(\w+) +(.+)/i){
			if(($1 >= $Threshold)&& ($4 eq $7)){
			   push(@matched_members, $4);
			}elsif(($1 >= $Threshold)&& ($4 ne $7)){
			   $matched_segment_count++;
			   if($match_name ne $7){  push(@matched_members, $7);  }
			   $query_start=$2-1;  $query_end  =$3-1;
			   $query_seq  =$4;    $match_start=$5-1;
			   $match_end  =$6-1;  $desc       =$8;
			   $match_name =$7;
			   for($x=$query_start; $x<= $query_end; $x++){
				  ${"$query_name"}[$x]++;
			   }
			   for($y=$match_start; $y<= $match_end; $y++){
				  ${"$match_name"}[$y]++;
			   }
			}
		 }
	  }
	  for($j=0; $j<@MSP; $j++){
		 #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		 #                 $1                $2     $3    $4      $5     $6    $7     $8
		 #                 171     41.18      6      73  HI1690    9      76  HI0736 sodium...
		 #,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
		 if($MSP[$j]=~/^ *(\d+) +\d+\.*\d* +(\d+) +(\d+) +(\w+) +(\d+) +(\d+) +(\w+) +(.+)/i){
			if(($1 >= $Threshold)&& ($4 eq $7)){
			   $query_name=$4;   $query_leng=$3;
			   push(@matched_members, $4);
			}elsif(($1 >= $Threshold)&& ($4 ne $7)){
			   $matched_segment_count++;
			   if($match_name ne $7){  push(@matched_members, $7);  }
			   $query_start=$2-1;  $query_end  =$3-1;
			   $query_seq  =$4;    $match_start=$5-1;
			   $match_end  =$6-1;  $desc       =$8;
			   $match_name =$7;
			}
			@matched_seq_array= @{"$match_name"};
			$matched_seq_array=join('', @matched_seq_array);
			my $start_diff= $query_start - $match_start;
			if($start_diff >= 0){
			   my $tail_diff= $start_diff + $seq_sizes{$match_name} - $seq_sizes{$query_name};
			   if($tail_diff > 0){
				  $max_tail_overhang = $tail_diff if $tail_diff > $max_tail_overhang;
				  for($x=0; $x< $tail_diff; $x++){
					 $tail_start=$seq_sizes{$match_name}-$tail_diff + $x;
					 @matched_seq_array=split(//,$matched_seq_array);
					 $tail_array[$x] +=$matched_seq_array[$tail_start];
				  }
			   }
			}elsif($start_diff < 0){
			   $head_diff = abs($start_diff);
			   $max_head_overhang=$head_diff if $head_diff > $max_head_overhang;
			   for($z=0; $z< $head_diff; $z++){
				  $head_array[$z] += ${"$match_name"}[$z];
			   }
			}
		 }
	  }
   }
   @LINKED=( @{"$match_name"}[0..($max_head_overhang-1)], @{"$query_name"}, @tail_array);
   $LINKED=join('', @LINKED);
   if($debug eq 1){
	 print __LINE__, " In open_msp_files \%sequence is", %sequence ,"\n";
   }
   $final_offset=$extened_number_line - $query_leng;
   return(\@LINKED);
}


#______________________________________________________________
# Title     : get_average_sequence_size
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  : get_av_sequence_size, get_average_seq_size
#             get_av_seq_size, average_seq_size, av_seq_size
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_average_sequence_size{
 	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   my @OUT_AV, $size, @size, @names, %hash, $sum, $av;
   for($i=0; $i<@hash; $i++){
	 %hash=%{$hash[$i]};
	 @names=keys %hash;
	 for($j=0; $j<@names; $j++){
		$size=length($hash{$names[$j]});
		push(@size, $size);
	 }
	 for($j=0; $j<@size; $j++){
		$sum+=$size[$j];
	 }
	 $av=int($sum/@names);
	 push(@OUT_AV, $av);
   }
   wantarray ? \@OUT_AV : \$OUT_AV[0];
}


#______________________________________________________________
# Title     : get_linux_kernel_version
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  : get_kernel_version, kernel_version,
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : Tom Faucett
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_linux_kernel_version {
  my($image)  = ${$_[0]} || $_[0];
  unless(defined($image)){
	 if(-e '/vmlinuz'){
		$image='/vmlinuz';
	 }elsif(-e '/boot/vmlinuz'){
		$image='/boot/vmlinuz';
	 }
  }
  my($str)             = "phlogiston";
  my($version_start)   = 1164;
  my($version_length)  = 10;

  open(DATA, $image) or return(undef);
  seek(DATA, $version_start, 0);
  read(DATA, $str, $version_length);
  ######  Do careful matching in case we got some random string.
  my($version) = $str =~ /^(\d+\.\d+\.\d+)\s/;
  return(\$version)
}


#______________________________________________________________
# Title     : load_mount_info
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : Tom Faucett
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub load_mount_info {
  undef %mounted;
  undef %fs_type;

  open(MTAB, "</etc/mtab") or die "Can't read /etc/mtab: $!\n";
  while (<MTAB>) {
	my($dev, $mp, $type) = split;
	next if $dev eq 'none';
	$mounted{$dev} = $mp;
	$mounted{$mp}  = $dev;
	$fs_type{$dev} = $type;
  }
  close(MTAB);
}



#______________________________________________________________
# Title     : plot_horizontally
# Usage     : &plot_horizontally(\@query);
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub plot_horizontally{
  my @numbers=@{$_[0]};
  my $leng= @numbers;
  my $largest, @inversed, $m, $i;
  for($i=0; $i< @numbers; $i++){
	$largest=$numbers[$i] if $largest < $numbers[$i];
  }
  for($i=0; $i< @numbers; $i++){ # this inverse the digits
	$inversed[$i]=abs($numbers[$i]-$largest);
  }
  print "\n ", @numbers;
  print "\n 1", "\-"x($leng-4),$leng;
  print "\n\|";
  print "\n\|";

  for($m=0; $m< $largest; $m++){
	print "\n\|";
	for($i=0; $i<@inversed;$i++){
	   if($inversed[$i] > 0){
		 print " ";
		 $inversed[$i]--;
	   }else{
		 print "\*";
	   }
	}
  }
  print "\n\|", "\-"x@numbers;
  print "\n";
}

#______________________________________________________________
# Title     : plot_vertically
# Usage     : &plot_vertically(\@query);
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub plot_vertically{
  @numbers=@{$_[0]};
  print "\n    |===================================================\>\n";
  for($i=0; $i<@numbers;$i++){
	 printf ("%-4d\|", $i);
	 print "\*"x$numbers[$i], "\n";
  }
  print "    |===================================================\>\n";
}


#______________________________________________________________
# Title     : condense_number_string
# Usage     :
# Function  : condenses the numbers by making an average with
#             given factor. If the factor is 2 on number seq
#              1334284425 , result will be 23543
#              133428442  ,                23541 <-- preserved end
#             Factor 3 =>
#              133428442  , (1+3+3)/3 = 2
#                           (4+2+8)/3 = 4,,,
# Example   : @output=@{&condense_number_string(\@input, $factor)};
#             with @input=qw(1 2 4 10 10 22 2 3 44 2 3); and $factor=3
# Warning   :
# Class     :
# Keywords  : compact_number_string, compact_digits, condense
#             condense_string
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub condense_number_string{
	my @ARRAY=@{$_[0]};
	my $factor = ${$_[1]} || $_[1];
	unless(defined($factor)){ $factor=1 }
	for($i=0; $i< @ARRAY; $i+=$factor){
	  my $temp_sum;
	  for($j=$i; $j < ($factor+$i); $j++){
		$temp_sum+=$ARRAY[$j]
	  }
	  push(@out, int($temp_sum/$factor) );
	}
	return(\@out);
}



#___________________________________________________________
# Title     : get_seq_fragments
# Usage     : @seq_frag=&get_seq_fragments(\%msf, @RANGE);
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  : get_sequence_fragments,
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    :  A Biomatic
# Version   : 1.4
# Used in   :
# Enclosed  :
#-------------------------------------------------------
sub get_seq_fragments{
	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   my $min_seqlet_size;
   if(defined($num_opt[0]) ){
	  $min_seqlet_size=$num_opt[0];
   }else{
	  $min_seqlet_size=30;
   }
   for($i=0; $i< @hash; $i++){
	 my %out_frag, $range_start, $range_end, @out_hash;
	 my %seqs = %{$hash[$i]};
	 my @names = keys %seqs;
	 if(@names==1){
	    for($j=0; $j < @names; $j++){
		   my $seq_name = $names[$j];
		   my $seq = $seqs{$seq_name};
		   for($k=0; $k< @range; $k++){
			  my $range = $range[$k];
			  my $frag_name = "$seq_name\_$range";
			  #if(length($frag_name)>14 ){
			  #	 $frag_name ='x'."${j}_${range}";
		      #}
			  ($range_start, $range_end)=$range=~/(\d+\.?\d*)\-(\d+\.?\d*)/;
			  my $frag_len = $range_end-$range_start+1;
			  if($frag_len < $min_seqlet_size){
			     next;
			  }
			  my $fragment = substr($seq, $range_start-1, $frag_len);
			  $out_frag{$frag_name}=$fragment;
		   }
		}
		push(@out_hash,  \%out_frag);
	 }elsif(@names > 1){
	    for($k=0; $k< @range; $k++){
		  my %out_frag=();
	      my $range=$range[$k];
	      ($range_start, $range_end)=$range=~/(\d+\.?\d*)\-(\d+\.?\d*)/;
	      my $frag_len = $range_end-$range_start+1;
		  if($frag_len < $min_seqlet_size){
		     next;
		  }
	      for($j=0; $j < @names; $j++){
	         my $seq_name=$names[$j];
			 my $seq = $seqs{$seq_name};
			 my $frag_name = "$seq_name\_$range";
			 #if(length($frag_name)>15 ){
			 #	$frag_name ='x'."${j}_${range}";
		     #}
			 my $fragment = substr($seq, $range_start-1, $frag_len);
			 $out_frag{$frag_name}=$fragment;
		  }
		  push(@out_hash, \%out_frag);
		}
	 }
   }
   if(@out_hash > 1){ return(@out_hash)
   }elsif(@out_hash==1){ return($out_hash[0]) }
}




#________________________________________________________________________
# Title     : make_standalone_subroutines
# Usage     :
# Example   :
# Function  : Creates each subroutine derived xxx.pl file from B.pl or any
#             given library file.
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub make_standalone_subroutines{
  my($each_sub, %out_subs, %left_out, @lib, $ver, $real_sub_entry_found);

	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  $|=1;
  for($i=0; $i < @file; $i++){
		open(LIB_FILE, "<$file[$i]")|| die  "\n $file[$i]  <- $! \n";
		my @lib =<LIB_FILE>;
		FOR: for($j=0; $j < @lib; $j++){
				  my %out_subs, $each_sub;
				  my $title_found;
				  #"""" Taking the headbox """""""""""""
				  if( ($lib[$j]=~/^#+[_\-\*]{10,120} *$/)
					 &&($lib[$j+1]=~/^(# *title *: *([\w\-]+))[^\.pl]/i) ){
					  $each_sub=$2;
					  $title_found =1;
					  if( (-s "$each_sub\.pl") > 2400 ){
						  print (-s "$each_sub\.pl"), "   ";
						  print "  $each_sub", " exists \n";
						  next FOR;
					  }elsif((-s "$each_sub\.pl") < 2400){
					     my $temp;
					     open (TEMP, "<$each_sub\.pl");
					     while(<TEMP>){
					        if(/^#[_\-\*]{10,120} *$/){ $temp++ }
					        elsif(/^# *title *: *[\w\-]+[^\.pl]/i ){
					           $temp++;
					        }elsif(/^# *\w+/){
					           $temp=$temp+0.5;
					        }
					     }
					     if($temp >2){
					        next FOR;
					     }
					  }

					  $out_subs{"$each_sub"}.="$lib[$j]$1\n";
					  $j+=2;
					  until( ($lib[$j]=~/^sub *\w+ *\{/)||($lib[$j]=~/^#---+ *$/) ||
							 ($lib[$j]=~/^#_____+ *$/) || ($lib[$j]=~/^#\*\*+ *$/) ){
							 $lib[$j]=~s/( *)$//;  #<-- removing ending space
							 $out_subs{"$each_sub"}.="$lib[$j]";
							 $j++;
					  }
					  $out_subs{"$each_sub"}.="$lib[$j]";
					  $j++;    ## essential to remove #------------- line
				  }

				  #"""""""" Reading sub {  } """""""
				  if( ($title_found==1)&&($lib[$j]=~/^sub +([\w\-]+) *\{/) ){
				     $each_sub=$1;
					  $out_subs{"$each_sub"}.="$lib[$j]";
					  if($lib[$j]=~/^sub +([\w\-]+) *\{.+\}/){
						  goto WRITE;
					  }
					  $j++;
					  until($lib[$j]=~/^\}/){
					     $out_subs{"$each_sub"}.="$lib[$j]";  $j++;
					  }
					  $out_subs{"$each_sub"}.="$lib[$j]";  ## to fetch '}'
					  $j++;

					  WRITE:
				     open (EACH_FILE, ">$each_sub\.pl");
				     print EACH_FILE  "#\!\/perl\n";
				     print EACH_FILE  "# Made by $0 at: ", `date`, "\n";
				     print EACH_FILE $out_subs{$each_sub};
		           close EACH_FILE;
		           %out_subs=();
		           #chmod

				  }
			  }
	}#""""""""""""" end of for (@file)
	close LIB_FILE;
}



#___________________________________________________________
# Title     : is_html
# Usage     :
# Function  : Checks if it is an html file.
# Example   : $html=&is_html(\@test);
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    :  A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#-------------------------------------------------------
sub is_html{
	#"""""""""""""""""< handle_arguments{ head Ver 1.4 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,
	$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash has \"@hash\"
	\@raw_string has\t\"@raw_string\"\n\t\@array has \"@array\"
	\@char_opt has\t\"@char_opt\"\n\t\@file has \"@file\"\@string has \"@string\""}
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my $html=0;
  if( @string >0 ){
	 for($i=0; $i<@string; $i++){
		if($string[$i]=~/^[.\n]{0, 100}\< *HTML *\>/i){
			$html_head=1;
		}if($string[$i]=~/[.\n]+\< *\/HTML *\>[\n.]{0,100}$/i){
			$html_end=1;
		}
	 }
	 if( ($html_head eq $html_end)&&($html_end=1)){
		$html=1;
	 }
	 if($debug==1){ print "\n \@string is @string\n"; }
  }elsif(@file>0){
	 for($i=0; $i< @file; $i++){
		my $all_lines;
		open(F, "$file[$i]");
		while(<F>){
		  $all_lines.=$_;
		}
		print "\n All the lines of $file[$i] is $all_lines\n" if $debug==1;
		if($all_lines =~/\< *HTML *\>/i){
		  if($all_lines=~/\< *\/ *HTML *\>/i){
			  $html=1;
			  print "\n html matched $html\n" if $debug ==1;
		  }
		}
	 }
  }elsif( @array>0 ){
	 @arr = @{$array[$i]};
	 for($i=0; $i< @arr; $i++){
		 if($arr[$i]=~/^[.\n]{0, 100}\< *HTML *\>/i){
			$html_head=1;
		 }if($arr[$i]=~/[.\n]+\< *\/HTML *\>[\n.]{0,100}$/i){
			$html_end=1;
		 }
	 }
	 if( ($html_head eq $html_end)&&($html_end=1) ){
		$html=1;
	 }
  }elsif(@hash>0){
	 for($i=0; $i< @hash; $i++){
		@hash=%{$hash[$i]};
		for($i=0; $i< @hash; $i++){
			if($hash[$i]=~/^[.\n]{0, 100}\< *HTML *\>/i){
			  $html_head=1;
			}if($hash[$i]=~/[.\n]+\< *\/HTML *\>[\n.]{0,100}$/i){
			  $html_end=1;
			}
		}

	 }
  }
  return($html);
}

#___________________________________________________________________
# Title     : get_column
# Usage     : &get_column(\@ar, 1,2 ,3);
#             &get_column(\%ha, 1,2 ,3);
#             &get_column(@ARGV);
#             # where prompt is like: column.pl temp.txt 1 2 3 4
# Function  : Prints any specified columns, can change order of them,
#             can filter values of columns to filter (max or min value)
#
# Example   : For getting only necessary columns
#             Input: %Hash=(1, 'col1 col2 col3',
#                           2, 'col1 col2 col3',
#                           3, 'col1 col2 col3');
#             input format: &get_column(\%Hash, 3,2,1, 'k'); # k is opt
#             Ouput format: STDOUT as
#
#                1     col3 col2 col1
#                2     col3 col2 col1
#                3     col3 col2 col1
#
# Warning   : Skipps blank line.
# Class     : Perl::Utility::Arg_handling
# Keywords  : column, get_columns, take_columns,
# Options   : #  for debugging.
#             _  for debugging.
#             k  for Key print when hash input is given.
#             n  for no first line display(Handy when you have title line
#                                          and wanna remove it)
#             ?max?=xxx for filtering column numbers by maximum of xxx
#             ?min?=yyy for filtering column numbers by minimum of yyy
#                      (eg, min4=100000 means 4th column minimum is 100000)
#                      (eg, 1min4=10, 2min3=10, means get 4th column values
#                           below 10 as the first output column. Get 3rd
#                           column values below 10 as the second out column.
#
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   : Ref of
# Tips      :
# Argument  : Ref of Hash, Array or just filename, and wanted column numbers.
# Todo      :
# Author    :  A Biomatic
# Version   : 1.2
# Used in   : column.pl
# Enclosed  :
#---------------------------------------------------------------
sub get_column{
	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my $len =4;
	my @v_keys= sort keys %vars; ## To be able to exchange order of column.
	if(@v_keys > 0){
	   for($i=0; $i< @v_keys; $i++){
	      if($v_keys[$i]=~/\d*(m..)(\d+)/i){
				$M=$1.$2;
				${"$1$2"}= $vars{$&};
	         push(@columns, $2);
			}
		}
	}else{
	   @columns=@num_opt;
	}
	my $troubled_column ;
	###### File is given as input #######""""""""""""""""""""""""""""""""""""""
	if(@file>0){
	  my $file;
	  for $file(@file){
		 my $line_num, $line_read;
		 my $change=0.1;
		 open(IN, "$file");
		 while(<IN>){ # This open is only for getting column size
		   $line_read++;
		   @splited=split(/ +/, $_);
			$l=${&get_longest_str_size(\@splited)};
			if($l>$len){ $len=$l; $change++ }
			if( ($line_read/$change) > 50 ){ last }
		 }
		 if($debug==1){
		   print "\n$line_read lines read to get right column size\n";
		 }
		 close(IN);
		 my $line_counter;
		 open(IN, "$file"); # real showing is now.
		 while(<IN>){
			if(/^[\t ]*$/){ next }  # skipping blank line
		   $line_counter++;
		   if(($char_opt=~/n/i)&&($line_counter==1)){ next }
			if(/^ *(\S+) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*)/){
	        for($i=0; $i< @columns; $i++){ # columns is num_opt
				  $col =$columns[$i];  #

				  if( defined( ${"max$col"} ) &&    # when max or min is defined
						defined( ${"min$col"} ) ){
						if( ( ${"max$col"}  > ${"$col"})&&
	                   ( ${"min$col"}  < ${"$col"}) ){
							 printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							 printf "%-${len}s ";
						}
				  }elsif( defined(${"max$col"}) ){ #--- When max and min are not defined.----#
						if(  ${"max$col"} > ${"$col"} ){
							 printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							 printf "%-${len}s ";
						}
				  }elsif( defined(${"min$col"}) ){
						if(  ${"min$col"} < ${"$col"} ){
							printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							printf "%-${len}s ";
						}
				  }else{
						printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
				  }
	        }
	        print "\n";
			}
		 } #while

	  }
	}    ###### Array is given as input #######""""""""""""""""""""""""""""""""""
	elsif(@array>0){  # if input is ('x y xx y','k t yy zz',,,,)
	  for($t=0; $t<@array; $t++){
		 my @arr=@{$array[$t]};
	    print "\n Array input\n" if $debug ==1;
		 for($i=0; $i<@arr;$i++){
		   @splited=split(/ +/,$arr[$i]);
		   $l=${&get_longest_str_size(\@splited)};
  		   $len=$l if $l>$len;
	    }
	    for($i=0; $i< @arr; $i++){
			if($arr[$i]=~/^[\t ]*$/){ splice(@arr, $i, 1); $i--; next }
			if(($char_opt=~/n/i)&&($i==0)){ next } # skipping the first line
			if($arr[$i]=~/^ *(\S+) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*)/){
	        for($j=0; $j< @columns; $j++){
				  $col =$columns[$j];  #

				  if( defined( ${"max$col"} ) &&    # when max or min is defined
						defined( ${"min$col"} ) ){
						if( ( ${"max$col"}  > ${"$col"})&&
	                   ( ${"min$col"}  < ${"$col"}) ){
							 printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							 printf "%-${len}s ";
						}
				  }elsif( defined(${"max$col"}) ){ #--- When max and min are not defined.----#
						if(  ${"max$col"} > ${"$col"} ){
							 printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							 printf "%-${len}s ";
						}
				  }elsif( defined(${"min$col"}) ){
						if(  ${"min$col"} < ${"$col"} ){
							printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							printf "%-${len}s ";
						}
				  }else{
						printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
				  }

	        }
	        print "\n";
			}
	    }
	  }
	}  ##### Hash is given as input #######""""""""""""""""""""""""""""""""""
	elsif(@hash>0){
	  my @arr;
	  for($h=0; $h<@hash; $h++){
		  my @array=values %{$hash[$h]};
		  my @keys =keys %{$hash[$h]};
		  for($i=0; $i< @array; $i++){ # getting the longest str size
			 @arr=split(/ +/,$array[$i]);
			 $l=${&get_longest_str_size(\@arr)};
			 $len=$l if $l>$len;
		  }
		  for($i=0; $i< @array; $i++){
		    if($array[$i]=~/^[\t ]*$/){ splice(@array, $i, 1); $i--; next }
		    if(($char_opt=~/n/i)&&($i==0)){ next } #  skipping the first line
		    printf "%-10s", $keys[$i] if($char_opt=~/k/i); ## Option for key printing
		 	 if($array[$i]=~/^ *(\S+) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *(\S*)/){
	         for($j=0; $j< @columns; $j++){

	           $col =$columns[$j];

				  if( defined( ${"max$col"} ) &&    # when max or min is defined
						defined( ${"min$col"} ) ){
						if( ( ${"max$col"}  > ${"$col"})&&
	                   ( ${"min$col"}  < ${"$col"}) ){
							 printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							 printf "%-${len}s ";
						}
				  }elsif( defined(${"max$col"}) ){ #--- When max and min are not defined.----#
						if(  ${"max$col"} > ${"$col"} ){
							 printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							 printf "%-${len}s ";
						}
				  }elsif( defined(${"min$col"}) ){
						if(  ${"min$col"} < ${"$col"} ){
							printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
						}else{
							printf "%-${len}s ";
						}
				  }else{
						printf "%-${len}s ",${"$col"} unless(${"$col"} eq '');
				  }

	         }
	         print "\n";
			 }
		  }
	  }
	}
}



#________________________________________________________________________
# Title     : set_debug_option
# Usage     : &set_debug_option;
# Function  : If you put '#' or  '##' at the prompt of any program which uses
#             this sub you will get verbose printouts for the program if the program
#             has a lot of comments.
# Example   : set_debug_option #    <-- at prompt.
# Warning   :
# Class     : Utility
# Keywords  :
# Options   : #   for 1st level of verbose printouts
#             ##  for even more verbose printouts
# $debug  becomes 1 by '#'  or '_'
# $debug2 becomes 1 by '##'  or '__'
#
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :  $debug
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.8
#             generalized debug var is added for more verbose printouts.
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub set_debug_option{
  my($j, $i, $level);
  unless( defined($debug) ){
	 for($j=0; $j < @ARGV; $j ++){
		 if( $ARGV[$j] =~/^(_+)$|^(#+)$/){ # in bash, '#' is a special var, so use '_'
			 print __LINE__," >>>>>>> Debug option is set by $1 <<<<<<<<<\n";
			 $debug=1;
				  print chr(7);
			 print __LINE__," \$debug  is set to ", $debug, "\n";
			 splice(@ARGV,$j,1); $j-- ;
			 $level = length($1)+1;
			 for($i=0; $i < $level; $i++){
				 ${"debug$i"}=1;
				 print __LINE__," \$debug${i} is set to ", ${"debug$i"}, "\n";
			 }
		 }
	 }
  }
}


#____________________________________________________________________
# Title    : write_sdb_file
# Function : gets a hash ref. and writes the SDB file with 'sprintf'
# Usage    : @out=@{&write_sdb_file(\%seq)};
# Example  : @out=@{&write_sdb_file(\%seq, 'v')};  ## for STDOUT as well
#    ___________________________________________________________________________
#    Title      : EST_YEAST.sdb
#    Full Name  : Telomerase_yeast_699aa
#    Nicknames  :
#    EMBL       :
#    PDB        :
#    Swissprot  :
#
# Argument : \%ref_of_seq
# Returns  :
# Options  : v  for verbose representation. This will print boxes on STDOUT
#            n  for no '#' leader.
#            e  for Endline( '-----------------------------..' )
# Tips     :
# Author   : A Biomatic
# Version  : 1.0
# Package  : Bio
# Used in  :
# Class    : Utility
# Keywords : write_sdb
# Todo     :
# Reference: http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Warning  : if version no. is null, it automatically puts '1.0'
#---------------------------------------------------------------
sub write_sdb_file{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.3 >"""""""""""""""""""
	my(@A )=&handle_arguments( @_ );my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "\n   \@hash has \"@hash\"\n   \@raw_string has   \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has   \"@char_opt\"\n   \@file has \"@file\"
	\@string has \"@string\""; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my($Commont_Symbol, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $s, $t, $x,  $z,
	  $delimiter, $Enclosed_came, $end_found, $end_line, $entry,
	  $length, $line,  $name, $name_found, $name_found, $num,
	  $original_dir, $output, $out_string, $pre, $pwd, $start_line, $string, $string1,
	  $temp, $title_found, $type_DSSP, @arg_output, @Final_out, @k, @keys, @names, @out, @out_hash,
	  @out_hash_final, @output_box, @outref, @read_files, @str1, @str2,  @string1,
	  %correct_head_box_entry, %Final_out, %hash, %input, %out_hash_final
	 );
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my($Entry_length) =9 ;
  my($VL) =60; ## key length( like in  # Title )  ## value length
  $num    =80;
  if($char_opt =~ /n/i){
	  $Commont_Symbol=' '; ## Comment symbol. For help display, you can change into ' '
  }else{
	  $Commont_Symbol='';   #  Comment symbol. Default head_box display.
  }
  for($x=0; $x < @hash; $x++){
		my(%input) = %{$hash[$x]};  my(@keys)= sort (keys %input); my(@out);

		#''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		##  PUTTING an order in the printout entries. To make 'Title' come first
		#''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		for($i=0; $i < @keys; $i++){
		  if($keys[$i]=~/^Title/i){
			  $temp=$keys[0];	   $keys[0]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Enclosed?/i){
			  $temp=$keys[$#keys];	   $keys[$#keys]=$keys[$i];   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Usage$/i){
			  $temp=$keys[1];	   $keys[1]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Function/i){
			  $temp=$keys[2];	   $keys[2]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Example/i){
			  $temp=$keys[3];	   $keys[3]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Version/i){
			  $temp=$keys[$#keys-2];  $keys[$#keys-2]=$keys[$i];   $keys[$i]=$temp;
			  #### To make null version value to '1.0'
			  if($input{$keys[$#keys-2]}=~/^ *$/){ $input{$keys[$#keys-2]}='1.0'; }
		  }elsif($keys[$i]=~/^Warning/i){
			  $temp2=$keys[$#keys-1]; $keys[$#keys-1]=$keys[$i];   $keys[$i]=$temp2;
		  }
		}
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		##       Writing starting line
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		my($start_line) = "$Commont_Symbol".'_'x"$num"."\n";
		if( $char_opt =~ /v/i){
			print $start_line;      } # Prints to STDOUT,

		my($Enclosed_came);  ## <<-- This should be HERE !
		$Entry_length=${&get_longest_str_size(\@keys)};
		for( $i =0; $i < @keys; $i++){  #### @keys has been sorted before.
		  my($Len) = length($input{$keys[$i]});
		  my $delimiter = ':';
		  my($entry) = $keys[$i];
		  $entry =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e; ## capitalizing word
		  if($entry=~/^Enclosed?$/i){ $Enclosed_came = 1; }
		  my(@input) = split(/\n+/, $input{$keys[$i]});
		  if(@input > 0){
			  for($j =0; $j < @input; $j++){
				 ## If NO entry name(blank) is given    ##
				 if($j > 0){  ## If the value is a multi line.
					  $entry = '';   $delimiter=' ';    }
				 if( $char_opt =~ /v/i){
					  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
					  ###  This is to reduce the entry length of Enclosed content lines   ##
					  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
					  if( ($Enclosed_came==1)&&($entry eq '') ){
						  $Entry_length=2; $VL=80; }
					  printf("$Commont_Symbol %-${Entry_length}s $delimiter %-${VL}s\n", $entry , $input[$j]);
				 }
				 if(($Enclosed_came==1)&&($entry eq '')){ $Entry_length=2; $VL=80; }
				 $out[$k++]=sprintf("$Commont_Symbol %-${Entry_length}s $delimiter %-${VL}s\n", $entry,$input[$j]);
				 if($entry=~/^Enclosed?/){ $Enclosed_came = 1; }   }}
		  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		  ##   If the entries have null descriptions, just print entries  ######
		  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		  elsif(@input ==0){
				 if( $char_opt =~ /v/i){
					 printf("$Commont_Symbol %-${Entry_length}s $delimiter %-${VL}s\n", $entry, ' ');   }
				 $out[$k++]=sprintf("$Commont_Symbol %-${Entry_length}s $delimiter %-${VL}s\n", $entry, ' ');
		  }
		}
		############################################################
		##       Writing  Ending  line                            ##
		############################################################
		$end_line = "$Commont_Symbol".'-'x"$num"."\n";
		if( ($char_opt =~ /v/i)&&($char_opt =~ /e/i) ){  print $end_line;  }
		if( $char_opt =~ /e/i){  push(@out, $end_line)   }
		unshift(@out, $start_line);
		push(@Final_out, \@out);
  }
  if(@Final_out > 1){ @Final_out; }
  elsif( @Final_out==1){ $Final_out[0] }
} #<--- END of write_sdb_file
#________________________________________________________________________
# Title     : push_if_not_already
# Usage     : @out=@{&push_if_not_already(\@mother_array, \@adding_array )};
#             @out=@{&push_if_not_already(\@mother_array, $adding_scalar)};
# Function  : returns ref. of an array for a list of non-repetitive entry.
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : add_if_not_already, add_element_if_not_already, if_not_already
#             add_element_if_not_already, push_element_if_not_already,
#             if_no_already_push, put_element_if_not_already, add_new_element
#             add_new_items_only, push_new_items_only, push_new_elements_only
#             put_if_not_already,
# Options   :
# Package   : Bio
# Reference :
# Returns   : a ref. of an array.
# Tips      :
# Argument  : two references. The first should be an array ref. The 2nd can be either
#             scalar or array reference.
# Todo      :
# Author    : A Biomatic
# Version   : 1.3
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub push_if_not_already{
	my($already_in, $already, $i, @push_items_given);
	my(@out_array)=@{$_[0]};
	if(ref($_[0]) ne 'ARRAY'){ print "\n push_if_not_array need ref\n"; exit; }
	push(@push_items_given, ${$_[1]}) if(ref($_[1]) eq 'SCALAR');
	@push_items_given=@{$_[1]} if(ref($_[1]) eq 'ARRAY');
	for $already (@out_array){  ## This for is to remove repetitive
	  for ($i=0; $i< @push_items_given; $i++){
		 if($already eq $push_items_given[$i]){ splice(@push_items_given,$i); }
	  }
	}
	push(@out_array, @push_items_given);
	return(\@out_array);
}

#_______________________________________________________________
# Title     : compare_sec_template_with_db
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : sec structure mapping, map sec str, map_sec_structure
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub compare_sec_template_with_db{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.1 >""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]};my(@file)   =@{$A[4]};my(@dir   )  =@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  $ref_target_hash = shift @hash;
  %target = %{$ref_target_hash};
  @names = keys %target;
  $name_target = $names[0];
  if($name_target =~/\w+(\d+)/){ $ori_target_seq_len = length($1); }
  @target_frag = split(/ +/, $target{$name_target} );

  for($i =0; $i< @hash; $i ++){
	 %db=%{$hash[$i]};
	 @db_name = keys %db;
	 for($j=0; $j < @db_name; $j ++){
		$name = $db_name[$j];
		@db_frag = split( / +/, $db{$name} );
		for($k=0; $k < @target_frag; $k ++){
		  if( ($target_frag[$k]=~/H(\d+)/i)&&($db_frag[$k]=~/H(\d+)/i) ){
			 $simple_match_output{$name}++;
			 $leng_diff = abs($1 - $2)/15;
			 $simple_match_output{$name} = $simple_match_output{$name}- $leng_diff;
		  }elsif( ($target_frag[$k]=~/E(\d+)/i)&&($db_frag[$k]=~/H(\d+)/i) ){
			 $simple_match_output{$name}--;
			 #$leng_diff = abs($1 - $2)/10;
			 #$simple_match_output{$name} = $simple_match_output{$name}- $leng_diff;
		  }elsif( ($target_frag[$k]=~/H(\d+)/i)&&($db_frag[$k]=~/E(\d+)/i) ){
			 $simple_match_output{$name}--;
			 #$leng_diff = abs($1 - $2)/10;
			 #$simple_match_output{$name} = $simple_match_output{$name}- $leng_diff;
		  }elsif( ($target_frag[$k]=~/E(\d+)/i)&&($db_frag[$k]=~/E(\d+)/i) ){
			 $simple_match_output{$name}++;
			 $leng_diff = abs($1 - $2)/15;
			 $simple_match_output{$name} = $simple_match_output{$name}- $leng_diff;
		  }
		}
	 }
  }
  return(\%simple_match_output);
}



#___________________________________________________________________
# Title     : get_peptide_occurance
# Usage     :
# Function  : gets the number of occurances of peptide(with given size) for
#             any number of sequences given.
# Example   : %stat=%{&get_peptide_occurance(\%pro_sequence, $size)};
#              while %pro_sequence has one or more sequences like
#              seq1 AAAAAAAAAAAA, seq2 BBBBBBBBBBBBBB, ...
#              $size is number. For dipeptide=2, tripeptide=3, tetrapep=4...
# Warning   :
# Class     : Seq
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  : eg=> (\%ref_hash, 4)
# Todo      :
# Author    :  A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#---------------------------------------------------------------
sub get_peptide_occurance{
	 my($k, $i, $s, $peptide, $pep_entry_num, @name, %stat);
	 %all=%{$_[0]};
	 $size=$_[1];
	 @name=keys %all;
	 for($k=0; $k<@name; $k++){
		if($all{$name[$k]}=~/[BZX]/i){ next;
		}else{
			$seq_leng += length($all{$name[$k]});
	      my @seq=split(//, $all{$name[$k]});
			my $all_occur_pep;
	      for($i=0; $i< (@seq-($size-1)); $i ++){
	        my $peptide;
	        for($s=0; $s < $size; $s++){
		       $peptide .= $seq[$i+$s];
	        }
	        $stat{$peptide}++;
			  $all_occur_pep ++;
	        print "\n$peptide  $stat{$peptide}" if $debug==1;
	        $pep_entry_num=keys %stat;
			  if( ($debug==1)&&($pep_entry_num%100 == 0 ) ){
				  print "\n Present peptide entries are:  $pep_entry_num  out of $all_occur_pep residues \n";
			  }
	      }
		 }
	 }
	 \%stat;
}


#___________________________________________________________________
# Title     : open_lottery_file
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    :  A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#---------------------------------------------------------------
sub open_lottery_file{
  my ($i, @lines, @bin1, @bin2, @bin3, @bin4, @bin5, @bin6, @bonus, @allbins);
  open(F, "$_[0]");
  if($_[1] =~/\-a/i){ $single_array_return=1 };
  @lines = <F>;
  for($i=0; $i< @lines; $i++){
		if($lines[$i]=~/ {1,3}(\d\d) {1,3}(\d\d) {1,3}(\d\d) {1,3}(\d\d) {1,3}(\d\d) {1,3}(\d\d) {1,2}(\d\d)/){
	push(@bin1, $1);
	#print $1, "\n";
	push(@bin2, $2);
	push(@bin3, $3);
	push(@bin4, $4);
	push(@bin5, $5);
	push(@bin6, $6);
		  push(@bonus, $7);
		}
  }
  if($single_array_return == 1){ @allbins=( @bin1, @bin2, @bin3, @bin4, @bin5, @bin6, @bonus); }
  else{  return(\@bin1, \@bin2, \@bin3, \@bin4, \@bin5, \@bin6, \@bonus); }
}


#_________________________________________________________________
# Title     : get_probable_half
# Usage     :
# Function  : This produces a hash ref. which is supposed to be most probable
#             according to the given array. It divides array into halves
#             gets the more probable half until it gets one single number.
# Example   :
# Warning   :
# Class     :
# Keywords  : get_frequent_halves,
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : \@array
# Todo      :
# Author    :  A Biomatic , A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#-----------------------------------------------------------------
sub get_probable_half{
	my (%hash, $i, @keys, @values);
	%hash=%{$_[0]};
	@keys=  sort {$a<=$b} keys   %hash;
	@values= values %hash;
	print "\n Hash is ",%hash,"\n";
	if(@keys == 1){
		 return(\%hash); last;
	}elsif(@keys >1){
		if((@keys % 2) != 0){ # make the number even
			 $keys[@keys]=$keys[$#keys];
		}
		@first_half=@keys[0..(@keys/2-1)];
		@second_half=@keys[(@keys/2)..$#keys];
		print "@first_half", "\n";
		print "@second_half", "\n";
		my($sum1, $sum2, %hash1, %hash2);
		for($i=0; $i<(@keys/2); $i++){
			 $sum1 +=$hash{$first_half[$i]};
			 $sum2 +=$hash{$second_half[$i]};
			 $hash1{$first_half[$i]} =$hash{$first_half[$i]};
			 $hash2{$second_half[$i]}=$hash{$second_half[$i]};
		}
		if($sum1 > $sum2){ &get_probable_half(\%hash1);}
		else{  &get_probable_half(\%hash2);}
	}
}

#_______________________________________________________________
# Title     : divide_array
# Usage     : &show_array(&divide_array(\@input, 6));
# Function  : divides any array to the denominator given.
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : split_array_into_pieces, split_array, chop_array,
#             fragment_array,
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    :  A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub divide_array{
	 my @array = @{$_[0]};
	 if(ref($_[1])){ $denominator = ${$_[1]};
	 }else{ $denominator = $_[1];}

	if($denominator == 0){
	   print "\n Denominator is 0, error, setting to 1\n";
	   $denominator = 1;
	}

	 my $frag_ar_size = int(@array/$denominator);
	 if($debug eq 1){ print "\n Frag arr size is :  $frag_ar_size \n" }
	 $remaining = @array % $denominator;
	 if($debug eq 1){ print "\n Remnant elem size is : $remaining \n" }
	 for($i=0; $i < $denominator; $i++){
	 	if($remaining > 0){
	        @{"ar_frag$i"}=splice(@array, 0, ($frag_ar_size+1),);
	        push(@final_array_ref, \@{"ar_frag$i"});
			  $remaining --;
		}elsif(($remaining == 0)&&(@array>0)){
	        @{"ar_frag$i"}=splice(@array, 0, ($frag_ar_size),);
	        push(@final_array_ref, \@{"ar_frag$i"});
		}
	 }
	 \@final_array_ref;
}


#_______________________________________________________________
# Title     : divide_string
# Usage     : &show_array(&divide_string(\$input, 6));
# Function  : divides any string to the denominator given.
# Example   : &show_array( &divide_string(\$input, 3) );
#              while  $input is '12345789ABCDEFHIJKLMN'
# Warning   :
# Class     : Utility
# Keywords  : divide_string, split_string, chop_string, divide_sequence
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    :  A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub divide_string{
	my (@array, $i, $j, $denominator, @temp, @string, $frag_str_size,
	   $remaining, $frag);

	for($i=0; $i< @_; $i++){
	   if(ref($_[$i]) eq 'ARRAY'){
		  push(@array, @{$_[$i]});
	   }elsif(ref($_[$i]) eq 'SCALAR'){
		  if(${$_[$i]} =~/^(\d+)$/){
			 $denominator = $1;
		  }else{
			 push(@array, ${$_[$i]});
		  }
	   }elsif($_[$i]=~/^(\d+\.?\d*)$/){ # this can handle fraction number!!
		  $denominator = int($1);            # like  9.5
	   }else{
		  push(@array, $_[$i]);
	   }
	}
	if($denominator == 0){
	   print "\n Denominator is 0, error, setting to 1\n";
	   $denominator = 1;
	}
	for($i=0; $i< @array; $i++){
	   @temp;
	   @string = split(//, $array[$i]);
	   $frag_str_size = int(@string/$denominator);
	   if($debug eq 1){ print "\n Frag str size is :  $frag_str_size \n" }
	   $remaining = @string % $denominator;
	   for($j=0; $j < $denominator; $j++){
	 	    if($remaining > 0){
			 $frag=join('', splice(@string, 0, ($frag_str_size+1) ) );
	          push(@temp, $frag);
			    $remaining --;
		    }elsif(($remaining == 0)&&(@string>0)){
			 $frag=join('', splice(@string, 0, $frag_str_size,) );
	          push(@temp, $frag);
		    }
	   }
	   push(@final_array_ref, \@temp);
	}
	wantarray? \@final_array_ref : $final_array_ref[0];
}


#_______________________________________________________________
# Title     : write_html_headbox
# Usage     : &write_html_headbox($outfilename, \%entries);
# Function  : write html format headbox explanation with given hashes of headbox
#             content.
# Example   :
# Warning   : This does not print which has empty description
# Class     : Utility
# Keywords  : write_headbox_html, write headbox in html
# Options   : 'd' for date inclusion at the top of the page
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub write_html_headbox{

	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	$|=1;
	my(%in, $name);
	my $URL='http://sonja.acad.cai.cam.ac.uk/Perl/';
	for ($f=0; $f<@file; $f++){
		 $output_file=$file[$f];
		 open(FILE, ">$output_file");
	    if($char_opt =~/d/i){
		    print FILE "\<html\>\n";
		    print FILE `date`, "\<br\>\n";
	    }

	    for($i=0; $i< @hash; $i++){
		    my %in =  %{$hash[$i]};
		    my @keys = sort keys %in;
		    $name= $in{'Title'};
		    print FILE "\<H2\>\<A href=\"${URL}$name\.pl\"\>$name\<\/A\>\<\/H2\>\n";
		    print FILE "\<pre\>\n";
		    for($j = 0; $j < @keys; $j ++){
			    if($keys[$j]=~/(title)/i){
			    }elsif( ($keys[$j]=~/\w+/i)&&( $in{$keys[$j]}=~/\w+/) ){
				   chomp( $in{$keys[$j]} );
	            printf FILE ("\<b\>%-10s\<\/b\> %s\n", $keys[$j], $in{$keys[$j]});
			    }
		    }
		    print FILE "\<\/pre\>";
		    print FILE "\<hr\>\n\n";
	   }
	   print FILE "\<\/html\>\n";
	   close FILE;
	}
}



#________________________________________________________________________
# Title     : open_sdb_files
# Usage     : %entries = %{&open_sdb_files(\$file_to_read )};
# Function  :
# Example   : Output is something like
#             ('Title', 'read_head_box', 'Tips', 'Use to parse doc', ...)
# Warning   :
# Class     :
# Keywords  : read_sdb_files,read_sdb,
# Options   : 'b' for remove blank lines. This will remove all the entries
#             with no descriptions
# Package   : File_Util
# Reference :
# Returns   : A hash ref.
# Tips      :
# Argument  : One or None. If you give an argu. it should be a ref. of an ARRAY
#              or a filename, or ref. of a filename.
#             If no arg is given, it reads SELF, ie. the program itself.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   : default_help
# Enclosed  : Following commented lines are an additional attachment !
#--------------------------------------------------------------------
sub open_sdb_files{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.3 >"""""""""""""""""""
	my(@A )=&handle_arguments( @_ );my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "\n   \@hash has \"@hash\"\n   \@raw_string has   \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has   \"@char_opt\"\n   \@file has \"@file\"
	\@string has \"@string\""; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my($title_found, %Final_out, $variable_string, $TITLE, $title, @keys,
	  $end_found, $line, $entry, $entry_match, $End_line_num, $remove_blank,
	  $title_entry_null, $end_found, $Enclosed_entry, $Enclosed_var,
	  $blank_counter, $title_entry_exist, $entry_value, $temp_W, $Warning_part
	);

	for($r=0; $r<@file; $r++){
		open(SEQ_IN, "$file[$r]");
		my @whole_file =<SEQ_IN>;

		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		for($i=0; $i<@whole_file; $i++){
	$whole_file[$i] =~ tr/\t/ {7}/;  ## This is quite important to some parsing!!!
	#"""""""""""""""""""""""""""""""""""""""""""
	##  The first and second line of box 1 ##
	#"""""""""""""""""""""""""""""""""""""""""""
	if( ($whole_file[$i]=~/^[_\*\-\/]{55,}$/)&&    ##  '______' is discarded
	   ($whole_file[$i+1]=~/^ {0,4}([TitlNam]+e) {0,8}:? {0,20}(\S[\-\w\.:]*) *(Copyright.*)/i) ){
	   $TITLE = $1;      $title = "$2\n";   $Final_out{'Warning'}.="$3\n";
	   $entry_match=$TITLE; ## The very first $entry_match is set to 'Title' to prevent null entry
	   if($TITLE =~ /^Title|Name$/i){   #
	       if( ($title=~/^\s+$/)||( $title eq "\n") ){
		  $title_entry_null =1;  $title = '';  }    }
	   $Final_out{$TITLE}=$title;
	   $title_found ++ ;   $i++;  ## << this is essential to prevent reading the same line again.
	}

	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	## The first and second line of box 2, #__________ or #**************
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	elsif( ($end_found != 1)&&($whole_file[$i]=~/^[_\*]{20,}$/)&&
	   ($whole_file[$i+1]=~/^ *(\w{1,6}\s{0,2}\w+) {0,7}: {1,5}(.*) */i) ){
	   $title_found ++ ;        $i++;
	   $entry_match=$1;       $entry_value=$2;
	   $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;  ## Capitalize words
	   $Final_out{$entry_match}.= "$entry_value\n";
	   last if $title_found > 1;  next;   }

	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	##  With PROPER entry 2 : descriptins like. 'Ussage : ssssssxxjkk  kj'
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	elsif( ($end_found != 1)&&($title_found==1)&&
	   ($whole_file[$i]=~ /^ {0,3}(\w{1,4}\s{0,2}\w{1,7}) {0,8}[:\)] {0,9}(\S.*) */i)){
	   $entry_match = $1;
			  $entry_value = $2;
	   $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
	   $Final_out{$entry_match}.= "$entry_value\n"; }

	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	#  With proper entry 3 : descriptins like. 'Ussage :', But blank description ##
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	elsif( ($end_found != 1)&&($title_found==1)&&
	   ($whole_file[$i]=~ /^ {0,3}(\w{1,4}\s{0,2}\w{1,7}) {0,8}[:\)]( {0,})$/i)){
	   $entry_match = $1;
			  $entry_value = $2;
	   $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
	   $Final_out{$entry_match}.= " $entry_value\n"; }

	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	###  all space line matching                 ##
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	elsif( ($end_found != 1)&&  ##<----- If blank line is matched. Take the line
	   ($title_found==1)&&($whole_file[$i]=~/^ {0, 110}$/) ){
	   $blank_counter++;
	   if($blank_counter > 2){ $blank_counter--; }
	   else{ $Final_out{$entry_match}.= " \n";  }     }

	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	###  Anything after 3 space to 14 positions eg: '#           HHHHHHHHH'
	###  To match 'examples' etc. INC. ':'
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	elsif( ($end_found != 1)&&
	   ($title_found==1)&&($whole_file[$i]=~/^( {0,50})(\S.+)/) ){
	   $Final_out{$entry_match}.= "$2\n"; $blank_counter=0; }

	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	###  Anything after 1 space to 11 positions  ##
	###  To match 'examples' etc. EXC. ':'       ##
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	elsif( ($end_found != 1)&&
	   ($title_found==1)&&($whole_file[$i]=~/^ {0,16}([^:.]+)/) ){
	   $Final_out{$entry_match}.= "$1\n"; $blank_counter=0;}

	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	###-------End of the read_box reading--------##
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	elsif( ($title_found==1)&&
	   ($whole_file[$i]=~ /^[\*\-_]{15,}/)){  ## to match '#-----..' or '#*******..'(Astrid's)
	   $End_line_num = $i;       $end_found++;
	   last;      }
		} ## < End of for loop


		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		### If title is not there at all     ####
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		@keys=keys %Final_out;
		for(@keys){
	 if(/^Title$/i){    ## No Entry of Title at all??
	    $TITLE =$&;
	    $title_entry_exist = 1;
	    if($Final_out{$_}=~/^ *$/){   ## if Title => Null or just space
	       $title_entry_null = 1;    }  }  }

		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		### When title entry is not there    ####
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		if( $title_entry_exist != 1){
	  for($s=$End_line_num+1; $s < $End_line_num+20; $s++){
	     if( $whole_file[$s] =~ /^sub {1,5}([\w\.]+) {0,6}\{/){
		$Final_out{'Title'} = "$1\n";   last;       }
	     elsif( $whole_file[$s] =~/^________________________________+/){
		#######################################
		## Uses running file name as titile  ##
		#######################################
		$Final_out{'Title'} = "$0";     last;
	     }else{
		#######################################
		## Uses running file name as titile  ##
		#######################################
		$Final_out{'Title'} = "$0";
	     }
	  }
		}
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		### When title is blank              ####
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		elsif($title_entry_null ==1){  ## It looks for 'sub xxxxx{ ' line to get title
	  ### $End_line_num is the last line read.
	  for($s = $End_line_num+1; $s < $End_line_num+20; $s++){
	     if( $whole_file[$s] =~ /^sub {1,5}(\w+\.*\w*) {0,7}{/){
		$Final_out{$TITLE} = "$1\n";    last;     }
	     elsif( $whole_file[$s] =~/^#________________________+/){
		#######################################
		## Uses running file name as titile  ##
		#######################################
		$Final_out{$TITLE} = "$0";     last;
	     }else{
		#######################################
		## Uses running file name as titile  ##
		#######################################
		$Final_out{$TITLE} = "$0";
	     }
	  }
		}
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		## Error handling, if no head box is found   ####
		#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		if($title_found < 1){ print "\nFatal: No headbox found by read_head_box2 sub.\n";  }
		push(@ref_of_seq_entry, \%Final_out);
	}
	if(@ref_of_seq_entry > 1){
		@ref_of_seq_entry;
	}else{ return (\%Final_out) }
}

#_______________________________________________________________
# Title     :  open_stride_files
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub open_stride_files{
	my($file, $name, %seq);

	#""""""""""""""""""""""< handle_arguments{ head Ver 1.1 >""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]};my(@file)   =@{$A[4]};my(@dir   )  =@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if($debug==1){ print __LINE__, " INPUT file were @file \n"; }
  for($i=0; $i< @file; $i++){
	 $file = $file[$i];
	 open(IN, "$file");
	 while(<IN>){
		if(/NM (\S+)/){
			$name=$1;
		}elsif( defined($name)&&(/SS (\w+)/) ){
		  $seq{$name}=$1; undef $name;
		}
	 }
  }
  return(\%seq);
}

#_______________________________________________________________
# Title     : get_pdb_file_start_number
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : start_number_of_pdb, startnumber, start number of PDB,
#             get_start_number_of_pdb_file,
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub get_pdb_file_start_number{
  my($start_number, $pdb_file);
  if( ref($_[0]) ){
	 $pdb_file = ${$_[0]};
  }else{
	 $pdb_file = $_[0];
  }
  open (PDB_FILE, "$pdb_file");
  while(<PDB_FILE>){
	 if(/^ATOM      1 +\w+ +\w+ +[\w]* +(\d+)  +/){
		 $start_number = $1; last;
	 }
  }
  \$start_number;
}
#_______________________________________________________________
# Title     : write_modeller_top_file
# Usage     : &write_modeller_top_file(\%hash, [v]);
# Function  : Writes Modeller command file format.
# Example   :
#     $modelname = 'gfct';
#     $template = '1ovt';
#     %hash=($modelname, $template);
#     &write_modeller_top_file(\%hash);
# Warning   :
# Class     : Utility
# Keywords  :
# Options   : v  for verbose. You will get STDOUT of the result as well as file
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   : a file of xxxx.top form.
# Tips      :
# Argument  : 1 hash ref which has model name and template name -> (\%hash)
#             while %hash is (modelname, tempalatename)
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   : to make CA only pdb file to sidegroup included one.
# Enclosed  :
#-----------------------------------------------------------
sub write_modeller_top_file{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.2 >""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]};my(@file)   =@{$A[4]};my(@dir   )  =@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "   \@hash has \"@hash\"\n   \@raw_string has \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has \"@char_opt\"\n   \@file has \"@file\"\n"; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
format MODELLER_TOP_FORMAT =
INCLUDE
SET ALNFILE = @<<<<<<<<<<<<<<<<
$ali_file
SET KNOWNS = @<<<<<<<<<<<<<<<<
$pdb_file
SET SEQUENCE = @<<<<<<<<<<<<<<<<
$model
SET ATOM_FILES_DIRECTORY = './:../atom_files'
SET STARTING_MODEL = 1
SET ENDING_MODEL = 1
CALL ROUTINE = 'model'
.
format STDOUT =
INCLUDE
SET ALNFILE = @<<<<<<<<<<<<<<<<
$ali_file
SET KNOWNS = @<<<<<<<<<<<<<<<<
$pdb_file
SET SEQUENCE = @<<<<<<<<<<<<<<<<
$model
SET ATOM_FILES_DIRECTORY = './:../atom_files'
SET STARTING_MODEL = 1
SET ENDING_MODEL = 1
CALL ROUTINE = 'model'
.
	########## Program starts ####################
	for($i=0; $i<@hash;$i++){
		($model, $pdb_file) = each %{$hash[$i]};
		$out_file = "$model.top";
		$ali_file = "$model.ali";
		open (MODELLER_TOP_FORMAT, ">$out_file");
		$pdb1 = "$ENV{'PDB'}\/$pdb_file.brk";
		$pdb2 = "$ENV{'PDB'}\/$pdb_file.pdb";
		if( !(-e $pdb1 ) && !( -e $pdb2 ) ){
			print "\n Error the file $pdb1  or  $pdb2\n";
		}
		$model ="\'$model\'";
		$pdb_file ="\'$pdb_file\'";
		$ali_file ="\'$ali_file\'";
		write MODELLER_TOP_FORMAT;
		if( $char_opt=~/v/i){ write STDOUT; }
	}
}
#_______________________________________________________________
# Title     : write_modeller_ali_file
# Usage     : &write_modeller_ali_file(\%model, \%template, [\$outfilename], [v]);
# Function  : Writes Modeller alignment format.
# Example   :
#             $out = 'test.ali';
#             %model =    qw(model AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAccccccccccc);
#             %template = qw(templ CCAAAAAAAACCCCCCCCCCCCCCCCCCCCCCCCCCCCC 3 42);
#             &write_modeller_ali_file(\%model, \%template, \$out);
# Warning   :
# Class     : Utility
# Keywords  :
# Options   : You can put 2 numbers for the second set of key and element for
#             the second hash input as the starting and ending points of
#             template(i.e. pdb file seq). Unless I calculate the size of seq.
#             By default, it reads PDB file defined by ENV setting of 'PDB' and
#             gets the starting number of pdb. If starting number is defined
#             explicitly at input hash, the given starting number is used instead
#             of PDB's.
#             v  for verbose. You will get STDOUT of the result as well as file
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   : a file of xxxx.ali form.
# Tips      :
# Argument  : 2 ref. of hash for seq. and optional output.name and option(s).
#             If second input hash (for template) has 3rd and 4th element which are
#             numbers they are regarded as the starting and ending number of the
#             template(i.e. pdb file seq)
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub write_modeller_ali_file{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.2 >""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]};my(@file)   =@{$A[4]};my(@dir   )  =@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "   \@hash has \"@hash\"\n   \@raw_string has \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has \"@char_opt\"\n   \@file has \"@file\"\n"; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
format MODELLER_ALI_FORMAT =
>P1;@<<<<<<<<<<<<<<<
$name
structureX: @<<<<<<<<<<<<<<: @<<<: : @<<<<<: : @<<<<<<<<<<<<<: :
$name $start_seq $seq_leng $name
@*
$seq
*
.
format STDOUT =
>P1;@<<<<<<<<<<<<<<<
$name
structureX: @<<<<<<<<<<<<<<: @<<<: : @<<<<<: : @<<<<<<<<<<<<<: :
$name $start_seq $seq_leng $name
@*
$seq
*
.
	########## Program starts ####################
	if($file[0]){
		 open (MODELLER_ALI_FORMAT, ">$file[0]");
	}else{
		@seq  = %{$hash[0]};
		$name = $seq[0]; print "\n\$name is $name" if $debug ==1;
		open (MODELLER_ALI_FORMAT, ">$name.ali");
	}
	for($i=0; $i<@hash;$i++){
		@seq  = %{$hash[$i]};
		$name = $seq[0]; print "\n\$name is $name" if $debug ==1;
		$seq  = $seq[1]; print "\n\$seq  is $seq" if $debug ==1;
		$seq_leng = length($seq);
		## checking PDB entry of the template ##
		$pdb1 = "$ENV{'PDB'}\/$name.brk";
		$pdb2 = "$ENV{'PDB'}\/$name.pdb";
		if( (-e $pdb1 ) || ( -e $pdb2 ) ){
			$pdb_file = $pdb1;
			$start_seq = ${&get_pdb_file_start_number( $pdb_file )};
		}
		## Handling the starting and ending seq points of template
		if( defined($seq[2])&&($seq[2]=~/^\d+/) ){
		  $start_seq=$seq[2]; $seq_leng+=$start_seq; }
		elsif( defined($start_seq) ){
		  $seq_leng+=$start_seq; }
		else{ $start_seq =1; }
		if( (defined($seq[2])) &&($end_seq != $seq_leng ) ){
		  print "\n Your template seq length does not match with actual seq size
					\n I will put the calculated value \"$seq_leng\" as the template length\n\n";
		}
		print "\n\$seq_leng is $seq_leng\n" if $debug ==1;
		write MODELLER_ALI_FORMAT;
		if( $char_opt=~/v/i){ write STDOUT; }
	}
}

#_______________________________________________________________
# Title     : make_template_from_sec_str
# Usage     : %target   = %{&make_template_from_sec_str(\%seq)};
# Function  : makes template of sec. str. like: 'H5 E4 E2' out of '__HHHHH__EEEE__EE__'
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub make_template_from_sec_str{
  my(%out, @name, @fragments, %in, $name, $leng, $frag_seq, $name2);
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.1 >""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]};my(@file)   =@{$A[4]};my(@dir   )  =@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  for($j = 0; $j < @hash ; $j ++){
	 %in = %{$hash[$j]};

	 @name = keys  %in;
	 print "\@name is @name\n", if($debug eq 1);

	 for($t=0; $t < @name; $t++){
		$name = $name[$t];
			print "\$name is $name\n", if($debug eq 1);
		$leng=length($in{$name});
			print "$leng\n", if($debug eq 1);
		$name2 ="$name"."$leng"; # to attach sequence length
		@fragments = split(/_+/, $in{$name});
			print "\@fragments is @fragments\n", if($debug eq 1);
		for($i = 0; $i < @fragments; $i++){
		  if($fragments[$i] =~/(\w)\w+/){
			  $fraglength = length($fragments[$i]);
			  $frag_seq .= "$1"."$fraglength "; # space is delimiter  'H5 E3 E5 E4'
			  print "\$frag_seq is $frag_seq\n", if($debug eq 1);
		  }
		  $out{$name2}=$frag_seq;
		}
	 }
  }
  return(\%out);
}



#_______________________________________________________________
# Title     : calculate_protein_volume
# Usage     : %volumes=%{&calculate_protein_volume(\%seq)}
# Function  :
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
 sub calculate_protein_volume{
	my %final_volume;
	my %volume=("A","88.6" ,"C","108.5","D","111.1","E","138.4",
					"F","189.9","G","60.1" ,"H","153.2","I","166.7",
					"K","168.6","L","166.7","M","162.9","N","117.7",
					"P","122.7","Q","143.9","R","173.4","S","89.0",
					"T","116.1","V","140.0","W","227.8","Y","193.6",
					"a","88.6" ,"c","108.5","d","111.1","e","138.4",
					"f","189.9","g","60.1" ,"h","153.2","i","166.7",
					"k","168.6","l","166.7","m","162.9","n","117.7",
					"p","122.7","q","143.9","r","173.4","s","89.0",
					"t","116.1","v","140.0","w","227.8","y","193.6");
  #""""""""""""""""""""""< handle_arguments{ head Ver 1.1 >""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]};my(@file)   =@{$A[4]};my(@dir   )  =@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my %seq_hash =  %{$hash[0]};
  my @names = keys %seq_hash;
  #if($debug == 1){
	  print "\n ",__LINE__, " Seq names are @names\n";
  # }

  for( $i=0 ; $i < @names; $i++){
	  my @seq=split(//, $seq_hash{$names[$i]});
	  for( $j=0; $j < @seq; $j ++){
		  $final_volume{$names[$i]} += $volume{$seq[$j]};
	  }
  }
  \%final_volume;
}




#_______________________________________________________________
# Title     : extract_words
# Usage     : @words = @{&extract_words(\$string)};
# Function  :
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#-----------------------------------------------------------
sub extract_words{
  #""""""""""""""""""""""< handle_arguments{ head Ver 1.1 >"""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]}; my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if($debug==1){
	  print __LINE__, " Args to extract_words are: \"@raw_string\"\n";
  }
  for($i=0; $i < @raw_string; $i ++){
	  if(ref($raw_string[$i]) eq 'SCALAR'){
		 $line = ${$raw_string[$i]};
	  }else{
		 $line = $raw_string[$i];
	  }
	  push( @words, split(/[\W\-\_]+/, $line) );
  }
  if($debug==1){
	  $num = @words;
	  print __LINE__, " Num of words are : \"$num\"\n";
  }
  \@words;
}

#________________________________________________________________________
# Title     : replace_subroutines
# Usage     :
# Function  : replaces subroutines of given file(s) with supplied subs.
#             Doesn't care version
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub replace_subroutines{
	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my($each_sub, %out_subs, $VER, %left_out, @lib, $ver, $sub_name,
	  $real_sub_entry_found);
  my %hash=%{&merge_hash(@hash)};
  my @array= keys %hash;
  my @values= values %hash;

  for($i=0; $i < @file; $i++){
		open(LIB_FILE, "<$file[$i]")|| die  "\n $file[$i]  <- $! \n";
		@lib =<LIB_FILE>;
		for($j=0; $j < @lib; $j++){
			  for($s=0; $s < @array; $s++){
				  if($array[$s] =~/^([_a-zA-Z\-]+)(\d*\.*\d*)$/){
					  $sub_name=$1;
					  $VER =$2;
				  }
				  #"""" Taking the headbox """""""""""""
				  if( ($lib[$j]=~/^#[_\-\*]{10,130} *$/)&&($lib[$j+1]=~/^(# *title *: *$sub_name)[^\.pl]/i) ){
					  $real_sub_entry_found=0;
					  $out_subs{"$sub_name"}.="$lib[$j]$1\n";
					  $j+=2;
					  until( ($lib[$j]=~/^sub *\w+ *\{/)||($lib[$j]=~/^#[\-_\*]{10,130} *$/) ){
							 $lib[$j]=~s/( *)$//;  #<-- removing ending space
							 #"""""""""""""""""""""""""""""""""""
							 #  Taking version no.
							 #"""""""""""""""""""""""""""""""""""
							 if( ($char_opt !~ /nv/i) && ($lib[$j]=~/^# *version *: *([\d+\.\d+]*) */i) ){
								  if( $1=~/^[ ]*$/){ $ver = '1.0'; }     ##  make null to 1.0
								  elsif( $1=~/^(\d+)$/){ $ver = "$1\.0"; } ### make  2   to 2.0
								  elsif($1=~/^([\d+\.\d+]+)$/){ $ver = $1; } ##  assign version
							 }
							 $out_subs{"$sub_name"}.="$lib[$j]";
							 $j++;
					  }
					  $out_subs{"$sub_name"}.="$lib[$j]";
					  $j++;  ## essential to remove #------------- line
				  }

				  #"""""""" Reading sub {  } """""""
				  if($lib[$j]=~/^sub +$sub_name *\{/){
					  $out_subs{"$sub_name"}.="$lib[$j]";
					  $j++;
					  until($lib[$j]=~/^\}/){
						  $out_subs{"$sub_name"}.="$lib[$j]";  $j++;
					  }
					  $out_subs{"$sub_name"}.="$lib[$j]";  ## to fetch '}'

					  $j++;

					  splice(@array, $s, 1); ## removing the subnames found
					  $s--;
					  unless(defined($ver)){ $ver = '1.0' }
					  unless($char_opt=~/nv/i){ ## if No version attachment option is set
						  $out_subs{"$sub_name$ver"}=$out_subs{$sub_name};
						  delete $out_subs{$sub_name};
					  }
				  }
			  }
			  $left_out{$file[$i]}.=$lib[$j]; ## Remnant file content of the operation
			                                  ## just in case you want the left out ones.
		}
		close LIB_FILE;
		open (LEFT_FILE, ">$file[$i]");
		for($h= 0; $h < @values; $h++){### appending the new subs.
			 $left_out{$file[$i]} .= $values[$h];
		}
		print LEFT_FILE $left_out{$file[$i]};
		close LEFT_FILE;

	}#""""""""""""" end of for (@file)

	@no_of_subs_fetched = keys %out_subs;
	if(@array>0){
		print chr(7);
		print "\n# Following subs are not found in \"", "@file","\"\n  ", "@array", "\n\n";
	}
	return( \%left_out ); # this has all the sub routines and other lines.
}
#________________________________________________________________________
# Title     : read_subroutines
# Usage     :
# Function  : retunrns ALL subroutines with the keys as subroutine names
#             with version like ('show_array2.2' => 'subroutine in one string')
#             It reports the subroutines not found in searched file(s)
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   : 'nv' for no version attachment in the keys of returning hash of subroutines
#             'r'  for getting remnant file content rather than the sub routines
#             't'  for leaving the original file without the sub routines taken.
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_subroutines{
	my($each_sub, %out_subs, %left_out, @lib, $ver, $real_sub_entry_found);

	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my  %final_out_subs, %out_subs;

  for($i=0; $i < @file; $i++){

		open(LIB_FILE, "<$file[$i]")|| die  "\n $file[$i]  <- $! \n";
		@lib =<LIB_FILE>;
		for($j=0; $j < @lib; $j++){

				  #"""" Taking the headbox """""""""""""
				  if( ($lib[$j]=~/^#+[_\-\*]{10,120} *$/)
				  &&($lib[$j+1]=~/^(#+ *title *: *([\w\-]+))[^\.pl]/i) ){
					  $sub_name=$2;
					  $out_subs{"$sub_name"}.="$lib[$j]$1\n";
					  $j+=2;
					  until( ($lib[$j]=~/^#+[\-\*_]{10,140} *$/)||($lib[$j]=~/^sub *\w+ *\{/) ){
							 $lib[$j]=~s/( *)$//;  #<-- removing ending space
							 #"""""""""""""""""""""""""""""""""""
							 #  Taking version no.
							 #"""""""""""""""""""""""""""""""""""
							 if( ($char_opt !~ /nv/i) && ($lib[$j]=~/^# *version *: *([\d+\.\d+]*) */i) ){
								  if( $1=~/^[ ]*$/){ $ver = '1.0'; }     ##  make null to 1.0
								  elsif( $1=~/^(\d+)$/){ $ver = "$1\.0"; } ### make  2   to 2.0
								  elsif($1=~/^([\d+\.\d+]+)$/){ $ver = $1; } ##  assign version
							 }
							 $out_subs{"$sub_name"}.="$lib[$j]";
							 $j++;
					  }
					  $out_subs{"$sub_name"}.="$lib[$j]";
					  $j++;    ## essential to remove #------------- line
				  }
				  #"""""""" Reading sub {  } """""""
				  if($lib[$j]=~/^sub {1,9}([\w\-]+) *\{/){
					  $sub_name=$1;
					  $out_subs{"$sub_name"}.="$lib[$j]";
					  $j++;
					  until($lib[$j]=~/^\}/){
						  $out_subs{"$sub_name"}.="$lib[$j]";  $j++;
					  }
					  $out_subs{"$sub_name"}.="$lib[$j]";  ## to fetch '}'
					  $j++;
					  unless(defined($ver)){ $ver = '1.0' }
					  unless($char_opt=~/nv/i){ ## if No version attachment option is set
						  $final_out_subs{"$sub_name$ver"}=$out_subs{$sub_name};
					  }
				  }
			  }
			  if($char_opt =~/[rt]/i){
			     $left_out{$file[$i]}.=$lib[$j]; ## Remnant file content of the operation
			  }
		     close LIB_FILE;
		     if($char_opt =~/t/i){
		       open (LIB_FILE, ">$file[$i]");
		       print LIB_FILE $left_out{$file[$i]};
			    close LIB_FILE;
			  }
print $final_out_subs;

	}#""""""""""""" end of for (@file)

 #s	@no_of_subs_fetched = keys %final_out_subs;
	if($char_opt =~ /r/i){
	   return( \%left_out ); # to get the files sans the subroutines.
	}else{
	   return( \%final_out_subs );
	}
}

#________________________________________________________________________
# Title     : fetch_subroutines
# Usage     :
# Function  : retunrns subroutines with the keys as subroutine names with version
#             like in the form( 'show_array2.2' => 'subroutine in one string')
#             It reports the subroutines not found in searched file(s). This
#             requires the names of sub you want while read_subroutines will
#             read any subroutines with their headbox to a hash.
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   : 'nv' for no version attachment in the keys of returning hash of subroutines
#             'r'  for getting remnant file content rather than the sub routines
#             't'  for leaving the original file without the sub routines taken.
#             'h'  for headbox only output.
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 2.4
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fetch_subroutines{

	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my($each_sub, %hash2, %out_subs, %left_out, @lib, $ver);

  @array=@{&remove_dup_in_array(\@string)};

  for($i=0; $i < @file; $i++){

		open(LIB_FILE, "<$file[$i]")|| die  "\n $file[$i]  <- $! \n";
		@lib =<LIB_FILE>;
		for($j=0; $j < @lib; $j++){
		     my $title_found;

			  for($s=0; $s < @array; $s++){
				  $each_sub = $array[$s];
				  #"""" Taking the headbox """""""""""""
				  if( ($lib[$j]=~/^#+[_\-\*]{8,140} *$/)
				  &&($lib[$j+1]=~/^(#+ *Title[ \t]*\:[ \t]*$each_sub\b).*/i) ){

					  $out_subs{"$each_sub"}.="$lib[$j]$1\n";
					  $j+=2; $title_found=1;
					  until( ($lib[$j]=~/^#+[\-_\*]{8,150} *$/)||
					  ($lib[$j]=~/^sub *$each_sub *\{/)  ){

							 $lib[$j]=~s/ *$//;  #<-- removing ending space

							 #"""""""""""""""""""""""""""""""""""
							 #  Taking version no.
							 #"""""""""""""""""""""""""""""""""""
							 if( ($char_opt !~ /nv/i)
							 && ($lib[$j]=~/^# *Version *\: *([\d+\.\d+]*) */i) ){
								  if( $1=~/^[ ]*$/){ $ver = '1.0'; }     ##  make null to 1.0
								  elsif( $1=~/^(\d+)$/){ $ver = "$1\.0"; } ### make  2   to 2.0
								  elsif($1=~/^([\d+\.\d+]+)$/){ $ver = $1; } ##  assign version
							 }
							 $out_subs{"$each_sub"}.="$lib[$j]";
							 $j++;
					  }
					  $out_subs{"$each_sub"}.="$lib[$j]";
					  $j++;    ## essential to remove #------------- line

				  }
				  if($char_opt =~ /h/i){
					  goto SPLICE2;
				  }
				  #"""""""" Reading sub {  } """""""
				  if(($title_found==1)&&($lib[$j]=~/^sub +$each_sub\b *\{/) ){
					  $out_subs{"$each_sub"}.="$lib[$j]";
					  $j++; $title_found='';
					  until($lib[$j]=~/^\}/){
						  $out_subs{"$each_sub"}.="$lib[$j]";  $j++;
					  }
					  $out_subs{"$each_sub"}.="$lib[$j]";  ## to fetch '}'
					  $j++;

					  SPLICE2:
					  splice(@array, $s, 1); ## removing the subnames found
					  $s--;
					  unless(defined($ver)){ $ver = '1.0' }
					  unless($char_opt=~/nv/i){ ## if No version attachment option is set
						  $hash2{"$each_sub${ver}"}=$out_subs{$each_sub};
						  %out_subs=();
					  }else{
					     $hash2{"$each_sub"}=$out_subs{$each_sub};
					     %out_subs=();
					  }
				  }
			  }
			  if($char_opt =~/[rt]/i){
			     $left_out{$file[$i]}.=$lib[$j]; ## Remnant file content of the operation
			  }
		}
		close LIB_FILE;
		if($char_opt =~/t/i){
		   open (LIB_FILE, ">$file[$i]");
		   print LIB_FILE $left_out{$file[$i]};
			close LIB_FILE;
		}

	}#""""""""""""" end of for (@file)

	$no_of_subs_fetched = keys %out_subs;
	if(@array>0){
		print chr(7);
		print "\n# Following subs are not found in \"", "@file","\"\n  ", "@array", "\n\n";
	}

	if($char_opt =~ /r/i){
	   return( \%left_out ); # to get the files sans the subroutines.
	}else{
	   return( \%hash2 );
	}
}

#________________________________________________________________________
# Title     : update_subroutines
# Usage     : &update_subroutines(\@file, \%fetched);
# Function  : replaces subroutines of given file(s) with supplied subs.
#             If the given subroutine versions are not higher than the
#             ones in the program, no upgrade would happen.
# Example   : &update_subroutines($file, \%fetched);
# Warning   :
# Class     : Utility
# Keywords  : upgrade_subroutines,
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 2.3
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub update_subroutines{
	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my %hash=%{&merge_hash(@hash)};
  my @SUBS = keys %hash;            # subroutine names
  for($i=0; $i < @file; $i++){
		open(TARGET_FILE, "<$file[$i]")|| die  "\n $file[$i]  <- $! \n";
		my @lines =<TARGET_FILE>;	close TARGET_FILE;
		my %temp, %final_out, %hash2, $VER, $sub_name,$ver, $first_line, @updated, $sub_name2;
 		for($j=0; $j < @lines; $j++){
 		     my ($loop_count, $title_found);
			  my %temp, $sub_name, $sub_name, $title_found, $sub_found, $VER, $ver;
			  if( $lines[$j]=~/^(#\!\/\w+)$/){
			     $final_out{$file[$i]}.=$lines[$j]; $j++;
				  if($lines[$j]=~/^# *last *update */i){ $final_out{$file[$i]}.="# Last Update by $0: ".`date`;  $j++;
				  }elsif($lines[$j+1]=~/^# *last *update */i){ $final_out{$file[$i]}.="$lines[$j]# Last Update by $0: ".`date`;  $j=$j+2;
				  }else{ $final_out{$file[$i]}.="# Last Update by $0: ".`date`.$lines[$j]; $j++; }  }
			  if($lines[$j]=~/^__END__/){ last }

			  until( (($lines[$j]=~/^#+[_\-\*]{8,150} *$/)
			  &&($lines[$j+1]=~/^(#+ *Title *[:]* *\w+\b)[^\.pl] */i) )
			  || ($lines[$j]=~/^sub [\w\-\.]+ *\{/) ||(EOF) ){
				 $final_out{$file[$i]}.=$lines[$j]; $j++;
			  }

			  for($s=0; $s < @SUBS; $s++){
				    if($SUBS[$s] =~/^([_a-zA-Z\-]+)(\d+\.*\d*) *$/){ $sub_name=$1; $VER =$2;  }
				    if( ($lines[$j]=~/^#+[_\-\*]{8,150} *$/)
				    &&($lines[$j+1]=~/^(#+ *Title *[:]* *$sub_name\b)[^\.] */i) ){
					    $temp{"$sub_name"}.="$lines[$j]$1\n"; $j+=2; $title_found=1;
					    until( $lines[$j]=~/^#[\-_\*]{10,140} *$/ ){ $lines[$j]=~s/ *$//;
							 if($lines[$j] =~ /^# *Version *\: *([\d*\.*\d*]*) */i){
								  if( $1 =~/^[ ]*$/){ $ver = '1.0';  }     ##  make null to 1.0
								  elsif($1 =~/^(\d+)$/){ $ver = "$1\.0"; } ### make  2   to 2.0
								  elsif($1 =~/^(\d+\.\d+)$/){ $ver = $1; }  }
							 $temp{"$sub_name"}.="$lines[$j]";	 $j++;   }
					    $temp{"$sub_name"}.="$lines[$j]";   $j++;	  }
				    if($lines[$j]=~/^sub +$sub_name *\{/){
					    $sub_found =1; $temp{"$sub_name"}.="$lines[$j]"; $j++;
					    until( $lines[$j] =~/^\}/){ $temp{"$sub_name"}.="$lines[$j]"; $j++;
						   if( ($lines[$j] =~/^#[_\-\*]{8,150} *$/)
						   &&($lines[$j+1]=~/^(# *Title *[:]* *$sub_name)[^\.pl]/i) ){
								$temp{"$sub_name"}.="\n\}\n"; $j++; # fixes missing '}' in the read sub hash.
								goto SPLICE;  }
						   elsif($lines[$j+1]=~/^sub +[\w\-]+ *\{/){
								$temp{"$sub_name"}.="\n\}\n";
								goto SPLICE;  }
						   $loop_count++;
						   if($loop_count > 10000){
								$final_out{$file[$i]} .="\n\}\n";    # fixes missing '}' in the input file
								$temp{"$sub_name"}.="\n\}\n";   # fixes missing '}' in the read sub hash.
						  	   goto SPLICE;  }  }
					    if($lines[$j]=~/^\}/){ $temp{"$sub_name"}.=$lines[$j];  }
					    SPLICE:
					    push(@updated, splice(@SUBS, $s, 1) );   $s--;
					    unless(defined($ver)){ $ver = '1.0' }
					    $temp{"$sub_name$ver"}=$temp{$sub_name};
					    undef( $temp{$sub_name} );
					    last;
				    }# end of  if ($lines[$j]=~/sub xxxxxx{)

			    }## END of for(@SUBS)
				if( ($title_found==1)&&($sub_found==1)&&( $VER < $ver) ){
					  print "\nTitle Yes SUB Yes for $sub_name VER $sub_name${VER} \< ver $ver";
				      $hash2{ "$sub_name$ver" }= $temp{ "$sub_name$ver" };
					  undef($temp{"$sub_name$ver"} );
					  undef($hash{"$sub_name$VER"} );
					  undef($VER, $ver, $title_found, $sub_found);
			    }elsif( ($title_found==1) && ($sub_found==1) && ($VER >=$ver) ){
					  print "\nTitle Yes  SUB Yes for $sub_name  VER \>= ver ";
					  $hash2{ "$sub_name$VER" }= $hash{"$sub_name$VER"};
					  delete($temp{"$sub_name$ver"});
					  delete($hash{"$sub_name$VER"});
					  undef($VER, $ver,$title_found, $sub_found);
				}elsif( ($title_found != 1)&&($sub_found==1) ){
					  print "\nTitle NO SUB Yes for $sub_name";
					  $hash2{ "$sub_name$VER" }= $hash{"$sub_name$VER"};
					  delete($hash{"$sub_name$VER"});
					  delete($temp{"$sub_name$ver"});
					  undef($VER, $ver,$title_found, $sub_found);
				}elsif( ($title_found ==1)&&($sub_found !=1 ) ){
					  print "\nTitle Yes SUB No for $sub_name";
				      delete( $temp{$sub_name} );
				      undef( $VER, $ver, $title_found, $sub_found);
				      next;
				}elsif(  ($title_found !=1)&&($sub_found !=1) ){
				      $final_out{$file[$i]}.=$lines[$j];
				}
			    ## $title_found and $sub_found are relevant only to names in @SUBS !!!!!!!!!
			    #""""""""""""""" Two things to consider """""""""
			    # both title and sub found or none of them found
			    #""""""""""""""""""""""""""""""""""""""""""""""""
			    for($t=0; $t< @updated; $t++){
			        if($updated[$t] =~/^([\w\-]+)(\d+\.\d*)$/){
			  		    $sub_name2=$1;   }
					    if( ($lines[$j]=~/^#+[_\-\*]{8,150} *$/)
				  	    &&($lines[$j+1]=~/^(#+ *Title *[:]* *${sub_name2})\b/i) ){  $j++;
			  		    until($lines[$j]=~/^#[\-_\*]{10,140} *$/ ){  $j++;   }   $j++;     }
			        if($lines[$j]=~/^sub +${sub_name2}\b *\{/){
			            until($lines[$j]=~/^\}/){   $j++; }
			            $j++;
				    }
			    }
		} # for (@lines)

		@values= (values %hash2, values %hash);
		print "@values";
		open (LEFT_FILE, ">$file[$i]");
		for($h= 0; $h < @values; $h++){ ### appending the new subs.
			  $final_out{$file[$i]} .= $values[$h];		}
		print LEFT_FILE $final_out{$file[$i]};
		close LEFT_FILE;	}#""""""""""""" end of for (@file)
	return( \%final_out ); # this has all the sub routines and other lines.
}





#________________________________________________________________________
# Title     : takeout_subroutines
# Usage     :
# Function  : retunrns subroutines with the keys as subroutine names with version
#             like in the form( 'show_array2.2' => 'subroutine in one string')
#             It reports the subroutines not found in searched file(s)
#             fetch_subroutines  also has this feature.
# Example   :
# Warning   : If there is no headbox and version no. It thinks the version
#             is 1.0
# Class     : Utility
# Keywords  : take_out_subroutines, take_subroutines, cut_subroutines,
#             cutout_subroutines, remove_subroutines
# Options   : 'nv' for no version attachment in the keys of returning hash of subroutines
#             'r'  for getting remnant file content rather than the sub routines
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    :  A Biomatic
# Version   : 1.3
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub takeout_subroutines{
  my($each_sub, %out_subs, %left_out, @lib, $ver, $real_sub_entry_found);

	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  @array=@{&remove_dup_in_array($array[0])};
  for($i=0; $i < @file; $i++){
		my %left_out;
		open(LIB_FILE, "<$file[$i]")|| die  "\n $file[$i]  <- $! \n";
		@lib =<LIB_FILE>;
		for($j=0; $j < @lib; $j++){
			  for($s=0; $s < @array; $s++){
				  $each_sub = $array[$s];
				  #"""" Taking the headbox """""""""""""
				  if( ($lib[$j]=~/^#[_\-\*]{10,130} *$/)&&($lib[$j+1]=~/^(# *title *: *$each_sub)[^\.pl]/i) ){
					  $real_sub_entry_found=0;
					  $out_subs{"$each_sub"}.="$lib[$j]$1\n";
					  $j+=2;
					  until( ($lib[$j]=~/^sub *\w+ *\{/)||($lib[$j]=~/^#[\-_\*]{10,130} *$/) ){
							 $lib[$j]=~s/( *)$//;  #<-- removing ending space
							 #"""""""""""""""""""""""""""""""""""
							 #  Taking version no.
							 #"""""""""""""""""""""""""""""""""""
							 if( ($char_opt !~ /nv/i) && ($lib[$j]=~/^# *version *: *([\d+\.\d+]*) */i) ){
								  if( $1=~/^[ ]*$/){ $ver = '1.0'; }     ##  make null to 1.0
								  elsif( $1=~/^(\d+)$/){ $ver = "$1\.0"; } ### make  2   to 2.0
								  elsif($1=~/^([\d+\.\d+]+)$/){ $ver = $1; } ##  assign version
							 }
							 $out_subs{"$each_sub"}.="$lib[$j]";
							 $j++;
					  }
					  $out_subs{"$each_sub"}.="$lib[$j]";
					  $j++;  ## essential to remove #------------- line
				  }

				  #"""""""" Reading sub {  } """""""
				  if($lib[$j]=~/^sub +$each_sub *\{/){
					  $out_subs{"$each_sub"}.="$lib[$j]";
					  $j++;
					  until($lib[$j]=~/^\}/){
						  $out_subs{"$each_sub"}.="$lib[$j]";  $j++;
					  }
					  $out_subs{"$each_sub"}.="$lib[$j]";  ## to fetch '}'

					  $j++;

					  splice(@array, $s, 1); ## removing the subnames found
					  $s--;
					  unless(defined($ver)){ $ver = '1.0' }
					  unless($char_opt=~/nv/i){ ## if No version attachment option is set
						  $out_subs{"$each_sub$ver"}=$out_subs{$each_sub};
						  delete $out_subs{$each_sub};
					  }
				  }
			  }
			  $left_out{$file[$i]}.=$lib[$j]; ## Remnant file content of the operation
			                                  ## just in case you want the left out ones.
		}
		close LIB_FILE;
		open (LEFT_FILE, ">$file[$i]");
		print LEFT_FILE $left_out{$file[$i]};
		close LEFT_FILE;
	}#""""""""""""" end of for (@file)

	@no_of_subs_fetched = keys %out_subs;
	if(@array>0){
		print chr(7);
		print "\n# Following subs are not found in \"", "@file","\"\n  ", "@array", "\n\n";
	}
	if($char_opt =~ /r/i){
	   return( \%left_out ); # to get the files sans the subroutines.
	}else{
	   return( \%out_subs );
	}
}

#________________________________________________________________________
# Title     : get_subroutine_calls
# Usage     : @sub_name_array= @{&get_subroutine_calls(\@AR))};
# Function  : gets all the subroutine calls( like &show_hash ) in the given
#             file name or array of lines which is the content of a file,
#             text etc. If there is no input arg, it reads the running
#             program as default input
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : get_sub_names,get_subroutine_names, get_sub_calls,
#             get_subroutine_calls,
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.7
# Used in   : fetch_subroutines, update_subroutines,
# Enclosed  :
#--------------------------------------------------------------------
sub get_subroutine_calls{

	#"""""""""""""""""< handle_arguments{ head Ver 1.6 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,
	$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  my(@arr, @sub_names, @nondup, %duplicate );
  if(@_== 0){  open(FILE, "$0"); @arr = <FILE>;  }
  elsif( @file > 0){
	 for($i=0; $i<@file; $i++){
		open(FILE, "$file[$i]");
		push(@arr, <FILE>);
	 }
  }
  if(@array>0){
	  for($i=0; $i<@array; $i++){
		 push(@arr, @{$array[$i]} ) if ref($array[$i]) eq 'ARRAY';
	  }
  }
  if( @raw_string>0){ push(@arr, @raw_string) }

  for($i=0; $i< @arr; $i ++){
	  if($arr[$i]=~/^#+/){ next }
	  $arr[$i]=~s/^(.+)(# ..+)$/$1/;  # I have to remove all COMMENTS as comments can have &xxx

	  if($arr[$i]=~/\$\~ = *\S/){
		  next;
	  }elsif($arr[$i]=~/^format *=/){
		  until($arr[$i]=~/^\./){  $i++ }
	  }elsif($arr[$i]=~/\& *([\w\-]+) {0,3}.*\;/){         # for   =&xxxx(\$xxx, $yyy);
		  push(@sub_names, $1);
	  }elsif($arr[$i]=~/= *([a-zA-Z][\w\-]+) {0,3}\;/){       # for   =xxxx;
		  push(@sub_names, $1);
	  }elsif($arr[$i]=~/= *[\@\%\$] *\{ *([a-zA-Z_]+[\d]*).+\} *\;/){ # for   =${ xxxx };
		  push(@sub_names, $1);
	  }
  }
  @nondup = grep { ! $duplicate{$_}++ } @sub_names;  ## removing duplicates
  \@nondup;
}



#________________________________________________________________________
# Title     : set_special_options   (derived from set_debug_option)
# Usage     : &set_special_options;
# Function  : If you put special chars like '#' or  '##', '###..' at the
#             prompt of any program which uses
#             this sub you will get verbose printouts for the program if
#             the program has a lot of comments.
# Example   : &set_special_options.pl  ##    <-- at prompt.
# Warning   :
# Class     : Utility
# Keywords  :
# Options   : #   for 1st level of debugging printouts
#             ##  for even more debugging printouts
#             +   for more outputs(more calculations are shown, like statistics)
#             ++  even more outputs.(
#    $DEBUG    becomes 1 by '#'
#    $DEBUG2   becomes 1 by '##'
#    $VERBOSE  becomes 1 by '+'
#    $VERBOSE2 becomes 1 by '++'
#
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :  $debug, $verbose
# Tips      :
# Argument  : Nothing in a program.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
#             generalized debug var is added for more verbose printouts.
# Used in   : parse_arguments,
# Enclosed  :
#--------------------------------------------------------------------
sub set_special_options{
  my($j, $i, $level, $key, %special_chars);
  %special_chars=('DEBUG'=>'#', 'VERBOSE'=>'+');

  for $key (keys %special_chars){
	 for($j=0; $j < @ARGV; $j ++){
		 if( $ARGV[$j] =~/([$special_chars{$key}]+)/){
			 print __LINE__," >>>>>>> Debug option is set by $1 <<<<<<<<<\n";
			 ${"$key"}=1; print chr(7);
			 print __LINE__," \$$key  is set to ", ${"$key"}, "\n";
			 splice(@ARGV,$j,1); $j-- ;
			 $level = length($1)+1;
			 for($i=0; $i < $level; $i++){
				 ${"$key$i"}=1;
				 print __LINE__," \$${key}${i} is set to ", ${"$key$i"}, "\n";
			 }
		 }
	 }
  }
}

#________________________________________________________________________
# Title     : set_debug
# Usage     : &set_debug;
# Function  : If you put '#' or  '##' at the prompt of any program which uses
#             this sub you will get verbose printouts for the program if the program
#             has a lot of comments.
# Example   : set_debug #    <-- at prompt.
# Warning   :
# Class     : Utility
# Keywords  :
# Options   : #   for 1st level of verbose printouts
#             ##  for even more verbose printouts
# $debug  becomes 1 by '#'  or '_'
# $debug2 becomes 1 by '##'  or '__'
#
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :  $debug
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.8
#             generalized debug var is added for more verbose printouts.
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub set_debug{
  my($j, $i, $level);
  unless( defined($debug) ){
	 for($j=0; $j < @ARGV; $j ++){
		 if( $ARGV[$j] =~/^(_+)$|^(#+)$/){ # in bash, '#' is a special var, so use '_'
			 print __LINE__," >>>>>>> Debug option is set by $1 <<<<<<<<<\n";
			 $debug=1;
				  print chr(7);
			 print __LINE__," \$debug  is set to ", $debug, "\n";
			 splice(@ARGV,$j,1); $j-- ;
			 $level = length($1)+1;
			 for($i=0; $i < $level; $i++){
				 ${"debug$i"}=1;
				 print __LINE__," \$debug${i} is set to ", ${"debug$i"}, "\n";
			 }
		 }
	 }
  }
}

#________________________________________________________________________
# Title     : open_self
# Usage     : @lines =  &open_self;
# Function  :
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : read self, read_self, open self, open itself
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   : one array
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_self{
  open(SELF, "$0");
  my(@Line)=<SELF>;
  return( \@Line );
}



#________________________________________________________________________
# Title     : tell_seq_length
# Usage     : %hash_out = %{&tell_seq_length(\%hash_in)};
# Function  : tells the sequence sizes of given sequences
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub tell_seq_length{
	###########################################################################
	my($i,$j,$k,$l,$m,$n,$o,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z,
	  $dir, $file, $in_dir, $end_found, $entry, $entry_match,
	  $gap_chr, $length, $line, $name, $name_found,
	  $output, $out_string, $pre, $pwd, $string,
	  @keys, @out_hash, @out_hash_final, @string, @temp,
	  @whole_file, %correct, %Final_out, %hash, %input, %out_hash_final   );
	#=~~~~~~~~~( handle_arguments head 1.0 )~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#
	 my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	 my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	 my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	#=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#

  for($i=0; $i < @hash; $i++){
	 %hash = %{$hash[$i]};
	 @keys = keys %hash;
	 for ($j=0; $j < @keys; $j ++){
		if($hash{$keys[$j]}=~/\,\S+\,/){ @string= split(/\,/, $hash{$keys[$j]});
		}else{ @string= split(//, $hash{$keys[$j]}); }
		$h -> {$keys[$j]} = @string;  ## $h is the ref. of the anonymous hash
	 }                               ## This is equivalent to "$h{$keys[$j]}= $length;"
	 push(@out_hash , $h ) ;
  }
  if(@out_hash == 1){ $out_hash[0]; }
  elsif(@out_hash < 1){ die "\nSomething is wrong at tell_seq_length\n"; }
  elsif(@out_hash > 1){ return(@out_hash); }
}

#________________________________________________________________________
# Title     : do_window_scan
# Usage     : @out_array = @{&do_window_scan(\@input_array)};
#             Often, bioters(Bio Computer Scientists) need to scan a long sequences
#             of DNA or Protein like(ABADFAFASDFASFASDFDFA or 109384717817947) to
#             caculate something out of them. This routine is providing such scanning
#             function in perl.
# Function  : This is the core part of any window (of sequences) scanning function.
# Example   :
# Warning   :
# Class     :
# Keywords  : scan_sequence, scan_window
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub do_window_scan{
  my(@string1) = @{$_[0]};
  my($win_size) = ${$_[1]} || $_[1];
  my($w, $start, $end, $average1, @window_1, $w_abs, @out_string),

  $start = -($win_size - ($win_size%2))/2; ## If the window size is odd numbers (eg 5),
									 ## the starting average position is 0  from (-2,-1,0,1,2)
									 ## If it is even numbers (eg 4)
									 ## the starting position is 0 from (-2,-1,0,1)
  $end = @string1 - ($win_size - ($win_size%2))/2;
								 ## End point is also dependent on oddity of the numbers
								 ## for window size.
	 for ($w= $start; $w < $end ; $w ++){
		$moving_window = $w + $win_size - 1;
		@window_1= @string1[$w .. $moving_window ];
		if($w < 0){          #### This if is to prevent the circularization of the array
			$w_abs = abs($w); #### (like  6 7 1 2 3 4 5 , for  . . 1 2 3 4 5 from 1234567 )
			splice(@window_1, 0, $w_abs);  # $w_abs is the absolute value of $w
		}

		################ PUT YOUR calc HERE #####

		 $average1= ${average_of_array(\@window_1, 'int')};

		################ PUT YOUR calc HERE #####

		push(@out_string, $average1);
		print "\nWinSize:$win_size halfwin: $half_win_size str size: $string_size \(from offset: $offset to  mov_wind: $moving_window \) AV: $average1 of  win1:", @window_1, "\n";
	 }
	 \@out_string;
}

#________________________________________________________________________
# Title     : scan_window_and_calc_something
# Usage     :
# Function  : scans any given length window of sequence and computes something.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : average for getting average of given window size.
#             sum for getting sum of given window size.
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scan_window_and_calc_something{
	my($a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p,
		$q, $r, $s, $t, $u, $v, $w, $x, $y, $z,
		$average1, $char_opt, $char_opt_given, $dir, $file, $in_dir,
		$error_rate, $gap_chr, $id_compos, $jp_file, $line, $name, $name_found,
		$name_found, $type_seq, $num_opt, $num_opt_given,
		$offset, $option_string, $original_dir, $output, $out_string, $pwd,
		$string, $string1, $sum, $sum1, $type_secon, $type_sol, $type_DSSP, $type_acc,
		$win_size,
		@array, @char_options, @dir, @file, @hash, @in,
		@keys, @names, @out_hash_final, @outref, @read_files, @str1, @str2, @string, @string1,
		%array_jp, %array_msf, %DSSP, %hash, %input, %out_hash_final, %percent_accessibility,
		%dummy, %database, %out, %out_hash, %sequence, %secondary, %solvent_access
  );

	#=~~~~~~~~~( handle_arguments head 1.0 )~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#
	 my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	 my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	 my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	#=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#

  $win_size = $num_opt[0];
  print "\n $win_size\n";
  for($o = 0; $o < @char_opt; $o ++){
	  if($char_opt[$o] eq ""){
		  splice(@char_opt, $o, 1); $o --;
	  }
	  elsif($char_opt[$o] eq "a"){
		  if(@hash ==1){
			  print "\n Now I am doing  scan_window_and_calc_average with \n\t\t
							@hash, and $win_size ";
			  %out_hash_final = %{scan_window_and_calc_average(@hash, \$win_size)};

		  }elsif(@hash > 1){
			  @out_hash_final = @{scan_window_and_calc_average(@hash, \$win_size)};
		  }
	  }
	  elsif($char_opt[$o] eq "s"){
		  if(@hash ==1){
			  %out_hash_final = %{scan_window_and_calc_sum(\@hash, \$win_size)};
		  }elsif(@hash > 1){
			  @out_hash_final = @{scan_window_and_calc_sum(\@hash, \$win_size)};
		  }
	  }
  }

  #_______________________________________________
  # Options  : 1, 2
  #######################################################
  sub scan_window_and_calc_sum{
		my(@hash)=@{$_[0]};
		my($win_size)  =${$_[1]};
		my(%out_hash, $i, $j, $w, $string1, @string, @window_1, $moving_window,
			$sum, $out_string, @keys, %input, $half_win, $actual_win_size);

		for($i = 0; $i < @hash; $i++){
			%input = %{$hash[$i]};
			@keys = sort keys %input;
			for ($j=0; $j < @keys; $j ++){
				$string1 = $input{$keys[$j]};
				@string1 = split(//, $string1);

				##### This small for loop is important for AVERAGE calc. To return the original residue value
				##### as there is no point in calculating segment smaller than window size.
				if ($return_type_option eq ''){
					&main_calc_from_half_win_size_pos;
				}elsif($return_type_option == 1){
					&return_the_av_for_small_win_size;
					&main_calc_from_half_win_size_pos;
				}

				#############################################
				sub return_the_resicue_value{
					$half_win = int($win_size/2);
					for($pre = 0; $pre < $half_win; $pre ++){
						$out_string .= "$string1[$pre]\,";

						print "\nWindow size $win_size \(from 0 to  $pre \)  of  ", @window_1, "\n";
					}
				}

				###################################################################
				#### The actual Window scanning and summing part.           ####
				###################################################################
				sub main_calc_from_half_win_size_pos{
				  for ($w=0; $w < @string1; $w++){

					 my($offset) = $w - int($win_size/2);  # $offset starts from -5 when window_size is 10.
					 my($half_win_size)= int($win_size/2);
					 $offset = 0 if ($offset < 0);

					 $moving_window = $w + $half_win_size - 1;

					 $actual_win_size = $moving_window - $offset + 1;

					 @window_1= @string1[$offset..($moving_window)]; ### This is the segment.

					 $sum= ${sum_of_array(\@window_1, 'int')};
					 $out_string .="$sum\,";
					 print "\nWindow size $actual_win_size \(from $offset to  $moving_window \) $sum of  ", @window_1, "\n";

				  }
				  $out_hash{$keys[$j]} = $out_string;
				  $out_string='';
				}
				#############################################
			}
			push(@out_hash, \%out_hash);
		}
		if(@out_hash ==1){ \%out_hash; }elsif(@out_hash >1){ \@out_hash; }
  }
  ############### Sub end ########################################
  if(@hash ==1){ \%out_hash_final; }elsif(@hash >1){ \@out_hash_final; }

}

#________________________________________________________________________
# Title     : scan_window_and_calc_average
# Usage     : %out_hash_final = %{scan_window_and_calc_average(\@hash, \$win_size)};
# Function  :
# Example   :
# Warning   :
# Class     : Bio
# Keywords  :
# Options   :
# Package   : Bio
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scan_window_and_calc_average{
  my(%out_hash, $i, $j, $w, $string1, @string, @window_1, $actual_win_size, $w_abs,
	  $average1, $out_string, @keys, %input, $moving_window, $pre, $half_win,
	  $start, $end);
	#=~~~~~~~~~( handle_arguments head 1.0 )~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#
	 my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	 my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	 my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	#=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#

  my($win_size)            =$num_opt[0];

  for($i = 0; $i < @hash; $i++){
	  %input = %{$hash[$i]};
	  @keys = sort keys %input;
	  for ($j=0; $j < @keys; $j ++){
		  $string1 = $input{$keys[$j]};
		  @string1 = split(//, $string1);
		  &do_window_scan_for_average;

		  sub do_window_scan_for_average{
			 ##### Following $start and $end are critically important for correct calc.
			 $start = -($win_size - ($win_size%2))/2; ## If the window size is odd numbers (eg 5),
																	## the starting average position is 0  from (-2,-1,0,1,2)
																	## If it is even numbers (eg 4)
																	## the starting position is 0 from (-2,-1,0,1)
			 $end = @string1 - ($win_size - ($win_size%2))/2;
																	## End point is also dependent on oddity of the numbers
																	## for window size.
			 #################################################################
			 for ($w= $start; $w < $end ; $w ++){
				$moving_window = $w + $win_size - 1;
				@window_1= @string1[$w .. $moving_window ];
				if($w < 0){          #### This if is to prevent the circularization of the array
					$w_abs = abs($w); #### (like  6 7 1 2 3 4 5 , for  . . 1 2 3 4 5 from 1234567 )
					splice(@window_1, 0, $w_abs);  # $w_abs is the absolute value of $w
				}
				$average1= ${average_of_array(\@window_1, 'int')};
				$out_string .="$average1\,";
				print "WinSize:$win_size halfwin: $half_win_size str size: $string_size \(from offset: $offset to  mov_wind: $moving_window \) AV: $average1 of  win1:", @window_1, "\n";
			 }
			 $out_hash{$keys[$j]} = $out_string;
			 $out_string='';
			 print "\n";
		  }
		  #############################################
	  }
	  push(@out_hash, \%out_hash);
  }
  if(@out_hash ==1){ \%out_hash; }elsif(@out_hash >1){ \@out_hash; }
}


#________________________________________________________________________
# Title     : read_blast_hits
# Usage     : @array_of_names = @{&read_blast_hits(\$file_name, \$threshold)};
# Function  : This reads the output of blastp program(xxxx.bla or whatever file extension
#             you attatched). And produces the names of found sequences which are
#             above(smaller in probability) a certain threshold in the blast result.
#             For example, it will produce a reference of an array (@hits, in the code)
#             which contains (1mbs, 1pmb, 1ymb) from the example in this header box(down the
#             lines) with the given (you give!) threshold of, say, 0.0001.
# Example   :
# Warning   :
# Class     :
# Keywords  : bla2fasta, take_blast_hits
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#      - - - - -  EXample of blastp file  - - - - - - - - - - - - - - - - - - - - - - - - -
#      BLASTP 1.4.8 [19-Dec-94] [Build 16:06:14 Jul 26 1995]
#      Reference:  Altschul, Stephen F., Warren Gish, Webb Miller, Eugene W. Myers,
#      and David J. Lipman (1990).  Basic local alignment search tool.  J. Mol. Biol.
#      215:403-10.
#      Query=  1mbs
#      (153 letters)
#      Database:  /nfs/ind4/ccpe1/people/A Biomatic /jpo/align/all_in_fasta.fas
#      406 sequences; 77,134 total letters.
#      Searching..................................................done
#      WARNING:  -hspmax 100 was exceeded with 13 of the database sequences, with as
#      many as 173 HSPs being found at one time.
#      Smallest
#      Sum
#      High  Probability
#      Sequences producing High-scoring Segment Pairs:              Score  P(N)      N
#      1mbs                                                          804  2.0e-109  1
#      1pmb                                                          718  1.4e-97   1
#      1ymb                                                          707  4.7e-96   1
#      2xxx                                                           31  0.55      1
#--------------------------------------------------------------------
sub read_blast_hits{
  my ($threshold);
  my(@hits);
  my($file)= ${$_[0]};
  $threshold = ${$_[1]} ;

  open(BLA_FILE, "$file");
  while(<BLA_FILE>){
	  if(/^ *(\w+)[\t ]+\d+ +(\d+[\.]*[\d]+[\w\-\d]*) +\d+/){
		 $probability = $2;
		 if($probability <= $threshold){
			push(@hits, $1);
		 }elsif( $probability > 0.6 ){ ### In Blast, p value over 0.3 or 0.4 is too high.
			last;                       ### So, to reduce the file reading time.
		 }
	 }
  }
  \@hits;  ## I am returning a ref. of the array rather than array.
}          ## In fact, just @array is fine enough, but for future addition of arg.

#________________________________________________________________________
# Title     : put_gaps_every_x_position_in_string.pl  (operator function)
# Usage     :
# Function  :
# Example   : "1234567890123456789012345678901234567890"  will be
#             "1234567890 1234567890 1234567890 1234567890"
#             with
#                &put_gaps_every_x_position_in_string(\$test, 10, ' ')
# Warning   : it does not returns reference
# Class     :
# Keywords  : put_space_in_sequence, put_gaps_in_sequence, put_gaps,
#             put_space
# Options   :
# Package   : Bio::Seq
# Reference :
# Returns   :
# Tips      : If you put '0' as the second arg (for interval), it puts gaps after
#             every char.
# Argument  : 3 arg. One is the string, second is the interval number, third is
#             the gap separater
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub put_gaps_every_x_position_in_string{
	my($string);
	if(ref($_[0])){
	  $string = ${$_[0]};
	}else{ $string = $_[0]; }

	my($interval) = $_[1];     my($gap_char) = $_[2];
	$string =~ s/(.{$interval,$interval})/$1$gap_char/g;
	$string;  ### Not a reference ###
}


#________________________________________________________________________
# Title     : transform_values
# Usage     : Used in predict_secondary_structure
# Function  : transform any value to another value with given table, matrix..
#             This is used to transform Amino Acid to its various propensities
#             If you feed a sequence 'ACDEDA', this transforms it to '
#             '124741' if the table given is 'A->1, C->2, D->4, E->7'
# Example   :
#             IN =>  to transform E and H to 9 and 4
#
#             1cdg_6taa      -------EEE-----------HH--HHHH------EE---------EEE-
#             1cdg_2aaa      -------EEE-----------HH--HHHH------EE---------EEE-
#             2aaa_6taa      -------EEEEE------EE-HHHHHHHH----EEEE-------EEEEE-
#
#             OUT
#             1cdg_6taa      -------999-----------44--4444------99---------999-
#             1cdg_2aaa      -------999-----------44--4444------99---------999-
#             2aaa_6taa      -------99999------99-44444444----9999-------99999-
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : hash(es)
# Tips      : The possible matrices are:
#             Sheraga_alpha_matrix
#             Richardson_alpha_matrix  or any conversion table made in a hash.
#
# Argument  : hash(es) and Matrix or table for conversion.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub transform_values{
  my($a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r,
	  $s, $t, $u, $v, $w, $x, $y, $z, $pwd, $file, $dir, $output, $in_dir,
	  %hash, @keys, @array, @hash, $option_string, $string, @in,
	  $name, %out, $gap_chr, @str1, @str2, @hash_output, $given_matrix
  );

  ##########################################
  #####   general argument handling   ######
  ##########################################
  for($k=0; $k< @_ ;$k++){
	  if( ( !ref($_[$k]) )&&($_[$k]=~ /^(\w)$/) ){
		  $option_string  .= $1;
	  }elsif( ( !ref($_[$k]) )&&($_[$k]=~ /^(\d*\w+matrix)/) ){
		  $given_matrix  = $1;
	  }elsif( ( !ref($_[$k]) )&&($_[$k]=~ /^(\d*\w+table)/) ){
		  $given_table  =  $1;
	  }elsif((ref($_[$k]) eq "ARRAY")&&(${$_[$k]}=~ /^(\w)$/) ){
		  $option_string  .= $1;
	  }elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(\w)$/) ){
		  $option_string  .= $1;
	  }elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(\d*\w+matrix)$/) ){
		  $given_matrix  = $1;
	  }elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(\d*\w+table)$/) ){
		  $given_table  =  $1;
	  }elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(\w+)$/) ){
		  $dummy{'dummy'}=${$_[$k]};       ## When mere sequence string is given, it
		  push(@hash,  \%dummy);     # makes a dummy hash to mimick hash input
	  }elsif(ref($_[$k]) eq "HASH") { push(@hash,  $_[$k]); }
  }

  if( defined( $given_matrix ) ){   ## calling given matrix.
	  &{"$given_matrix"};
  }elsif( defined( &{"$given_table"} ) ){  ## calling given table.
	  &{"$given_table"};
  }

  for( $k=0; $k < @hash; $k ++){
	  my(%hash) = %{$hash[$k]};
	  my(@keys) = keys %hash;
	  my(@out_string);
	  for($i=0; $i < @keys; $i++){
		  @string = split(/|\,/, $hash{$keys[$i]} ); ## splitting the string(value of
																	## the hash into array.
		  for($j=0; $j < @string; $j ++){
			  $out_string[$j]= ${"$given_matrix"}{ $string[$j] };
		  }
		  $out_hash{$keys[$i]} = join(',', @out_string);
	  }
	  push(@hash_output, \%out_hash);
  }
  if(@hash_output > 1){ @hash_output }else{ $hash_output[0] }
}

#________________________________________________________________________
# Title     : Sheraga_alpha_matrix
# Usage     :
# Function  : an alpha matrix propensity table.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub Sheraga_alpha_matrix{
  %Sheraga_alpha_matrix = ( ## ref: Protein Eng. V.8, no9, pp905-913, 1995
		  'A', 	1.07,
		  'C', 	0.99,
		  'D', 	0.68,
		  'E', 	0.97,
		  'F', 	1.09,
		  'G', 	0.59,
		  'H', 	0.69,
		  'I', 	1.14,
		  'K', 	0.94,
		  'L', 	1.14,
		  'M', 	1.20,
		  'N', 	0.78,
		  'P',    0.19,
		  'Q', 	0.98,
		  'R', 	1.03,
		  'S', 	0.76,
		  'T', 	0.82,
		  'V', 	0.95,
		  'W', 	1.11,
		  'Y',    1.02
  );
  return(%Sheraga_alpha_matrix);
}
#________________________________________________________________________
# Title     : Richardson_alpha_matrix
# Usage     :
# Function  : an alpha matrix propensity table.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub Richardson_alpha_matrix{
  %Richardson_alpha_matrix = ( ## ref: Protein Eng. V.8, no9, pp905-913, 1995
		  'A', 	1.80,
		  'C', 	0.70,
		  'D', 	1.00,
		  'E', 	0.80,
		  'F', 	1.30,
		  'G', 	0.,     ## <<----
		  'H', 	0.69,
		  'I', 	1.14,
		  'K', 	0.94,
		  'L', 	1.14,
		  'M', 	1.20,
		  'N', 	0.78,
		  'P',    0.19,
		  'Q', 	0.98,
		  'R', 	1.03,
		  'S', 	0.76,
		  'T', 	0.82,
		  'V', 	0.95,
		  'W', 	1.11,
		  'Y',    1.02
  );
  return(%Richardson_alpha_matrix);
}


#________________________________________________________________________
# Title     : get_segment_shift_rate
# Usage     : &get_segment_shift_rate(\%hash_for_errors, \%hash_for_sec_str);
# Function  : calculates the secondary structure segment shift rate.
# Example   : <input example> First block is for the first hash input
#                             and Second is for the second hash input.
#
#             1cdg_6taa      00000442222222222242222222222777700000007000000000
#             1cdg_2aaa      00000442222222222242222222222777700000007000000000
#             2aaa_6taa      00000000000000000000000000000000000000000000000000
#
#             1cdg_6taa      -------EEE-----------EE--EEEE------EE---------EEE-
#             1cdg_2aaa      -------EEE-----------EE--EEEE------EE---------EEE-
#             2aaa_6taa      -------EEEEE------EE-EEEEEEEE----EEEE-------EEEEE-
#
#             <intermediate output example>
#             2aaa_6taa      -------00000---------00000000----0000-------00000-
#             1cdg_6taa      -------442---------------2222-----------------000-
#             1cdg_2aaa      -------222---------------2222-----------------000-
#
#             <Final output>
#             2aaa_6taa      0%
#             1cdg_6taa      67%
#             1cdg_2aaa      67%
#
# Warning   :
# Class     :
# Keywords  :
# Options   : 'p' or 'P' for percentage term(default)
#             'r' or 'R' for ratio term (0.0 - 1.0), where 1 means all the
#              segments were wrongly aligned.
#             's' or 'S' for Shift rate (it actually caculates the position shift
#              rate for the secondary structure segment.
#             'h' or 'H' for position Shift rate (it actually caculates the position
#              shift rate for helical segments). If this is the only option, it
#              will show the default percentage term rate for helical segments.
#              If used with 'r', it will give you ratio (0.0 - 1.0) for helical
#              segment. If used with 's' option, it will give you position shift
#              rate for only helical segments.
#             'e' or 'E' for position Shift rate (it actually caculates the position
#              shift rate for beta segments). If this is the only option, it will
#              show the default percentage term rate for beta segments. If used
#              with 'r', it will give you ratio (0.0 - 1.0) for beta. If used
#              with 's' option, it will give you position shift rate for only
#              beta segments.
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : Two references of hashes. One for error rate the other for sec.
#             assignment.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_segment_shift_rate{
  my($i, $k, $j, @hash, $option_string, %h, %superposed_hash,
	  $name, %out, $gap_chr, @str1, @str2, %temp, %hash_error, %hash_secondary);
  #"""""""""""""""""""""""""""""""""""""""""
  #       general argument handling        #
  #"""""""""""""""""""""""""""""""""""""""""
  for($k=0; $k< @_ ;$k++){
	  if( ( !ref($_[$k]) )&&($_[$k]=~ /^(\w)$/) ){
		  $option_string  .= $1;    }
	  elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(\w)$/) ){
		  $option_string  .= $1;    }
	  elsif(ref($_[$k]) eq "HASH") {
		  %temp = %{$_[$k]};
		  my(@keys)= sort keys (%temp);
		  my($temp_seq) = $temp{$keys[0]};

		  if($temp_seq=~/\d\d+/){
			  %hash_error = %temp; }
		  else{ %hash_secondary = %temp; }
	  }
  }#### OUTPUT are  : %hash_error  &  %hash_secondary
  #"""""""""""""""""""""""""""""""""""""""""
  #       general argument handling end    #
  #"""""""""""""""""""""""""""""""""""""""""
  %hash_secondary =%{&tidy_secondary_structure_segments(\%hash_secondary)};
  %superposed_hash =%{&superpose_seq_hash(\%hash_error, \%hash_secondary)};
  %h=%{&get_wrong_segment_rate(\%superposed_hash)};
  \%h;
}

#________________________________________________________________________
# Title     : get_wrong_segment_rate
# Usage     : print_seq_in_block( &get_wrong_segment_rate(\%superposed_hash) );
# Function  : Treats the segment as one single big error.
#             calculates the wrong segment number compared to the correct ones.
# Example   : <input example> hash of 3 keys and values.
#             2aaa_6taa      -------00000---------00000000----0000-------00000-
#             1cdg_6taa      -------442---------------2222-----------------000-
#             1cdg_2aaa      -------222---------------2222-----------------000-
#
#             In the above there are two segments wrong in 3 segment blocks = 2/3
#             <output example> hash of 3 percentage rates.
#
#             2aaa_6taa      0 %
#             1cdg_6taa      66.6666666666667 %
#             1cdg_2aaa      66.6666666666667 %
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   : get_segment_shift_rate
# Enclosed  :
#--------------------------------------------------------------------
sub get_wrong_segment_rate{
  my($a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r,
	  $s, $t, $u, $v, $w, $x, $y, $z, %h, $seg_min,
	  %hash, @keys, @array, @hash, $option_string, $string,
	  $name, %out, $gap_chr, @str1, @str2, $seg, $len, $wrong_seg, $correct_seg
  );
  %hash=%{$_[0]};
  $seg_min =$_[1];
  if($seg_min !~/\d+/){ $seg_min = 3; } ### Default segmin is 3
  @keys = sort keys (%hash);
  for $k (@keys){
	 my($string) = $hash{$k}; $string =~s/\,//g;
	 my(@segments) = split(/[\-\.\ ]+/, $string);
	 for $seg (@segments){
		$len=length($seg);
		if( $len >= $seg_min){
			if($seg =~/[1-9]/){
				$wrong_seg ++;  }
			else{ $correct_seg ++; }
		}
	 }
	 $h{$k}= ($wrong_seg/($wrong_seg + $correct_seg)*100).' %';
	 $wrong_seg=$correct_seg='';
  }
  \%h;
}


#________________________________________________________________________
# Title     : tidy_secondary_structure_segments
# Usage     : print_seq_in_block(&tidy_secondary_structure_segments(\%hash, 'e4', 'h4'), 's');
#
# Function  : receives any secondary structure assignment hashes and
#             tidys up them. That is removes very shoft secondary structure
#             regions like( --HH--, -E-, -EE- ) according to the given minimum
#             lengths(threshold) of segments by you.
# Example   : print_seq_in_block(&tidy_secondary_structure_segments(\%hash, 'e4', 'h4'), 's');
#             <makes following into the next block>
#
#             1cdg_2aaa      -------EEE-----------EE--EEEE------EE---------EEE-
#             1cdg_6taa      -------EEE-----------EE--EEEE------EE---------EEE-
#             2aaa_6taa      -------EEEEE------EE-EEEEEEEE----EEEE-------EEEEE-
#
#             <example output>
#
#             1cdg_6taa      -------------------------EEEE---------------------
#             1cdg_2aaa      -------------------------EEEE---------------------
#             2aaa_6taa      -------EEEEE---------EEEEEEEE----EEEE-------EEEEE-
#
# Warning   :
# Class     :
# Keywords  :
# Options   : something like 'H3' or 'E3' for minimum segment length set to 3 positions.
# Package   : Bio::Seq
# Reference :
# Returns   : array of references of hashes.
# Tips      :
# Argument  : hashes and [options]. No options result in default of 'H3', 'E3'
# Todo      :
# Author    : A Biomatic
# Version   : 1.0.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub tidy_secondary_structure_segments{
  my($i, $k,$a, $j, $helix_min, $beta_strand_min, %hash, @keys, @hash,
	  $option_string, @hash_out, $string1, $name, %out, $gap_chr, @str1, @str2,
	  @stringout, @string_segH, @string_segE, $countH, $countE
	  );

  #### Default helix and beta strand segment length setting #####
  $helix_min=3;
  $beta_strand_min=3;

  ########################################################################
  #####   general argument handling  for options of segment length  ######
  ########################################################################
  for($k=0; $k< @_ ;$k++){
	  if( ( !ref($_[$k]) )&&($_[$k]=~ /^[Hh](\d+)$/) ){
		  $helix_min  = $1;    }
	  elsif( ( !ref($_[$k]) )&&($_[$k]=~ /^[Ee](\d+)$/) ){
		  $beta_strand_min  = $1;    }
	  elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^[Hh](\d+)$/) ){
		  $helix_min  = $1;    }
	  elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^[EeBb](\d+)$/) ){
		  $beta_strand_min  = $1;    }
	  elsif(ref($_[$k]) eq "HASH") { push(@hash,  $_[$k]); }    }

  for($i=0; $i < @hash; $i++){
	  my(%hash) = %{$hash[$i]};
	  @keys = sort keys( %hash );
	  for($j=0; $j < @keys; $j++){
		  my(@string_segH, @string_segE, @stringout);
		  $string1=$hash{$keys[$j]};
		  $gap_char = $1 if ($string1=~ /(\W)/);

		  ##### actual cleaning ####
		  my(@string) = split(//, $string1);
		  for($a = 0; $a < @string; $a++){
			 if($string[$a] !~/[HE]/){ ### if the splited element doesn't match 'H' or 'E'

				 ##### If any of the HH or EE counter is over the given minimum($helix_min,,)
				 if((@string_segH >= $helix_min)||( @string_segE >=$beta_strand_min)){
					 push(@stringout, @string_segH, @string_segE, '-');
					 @string_segH=@string_segE=();     }   ## just resetting.
				 else{  ### if the accumulated 'HH' or 'EE' is smaller than the minimum
					 for(0.. (@string_segH + @string_segE) ){
						push(@stringout, '-'); ### replace the short 'EE' etc with '-'
					 }
					 @string_segH=@string_segE=();  ## just resetting.
				 }
			 }
			 elsif($string[$a] =~ /^([Hh])$/){
				 push(@string_segH, $1); }
			 elsif($string[$a] =~ /^([Ee])$/){
				 push(@string_segE, $1); }
		  }
		  $hash{$keys[$j]}=join("", @stringout);
	  }
	  push(@hash_out, \%hash);
  }
  if(@hash_out == 1){ return($hash_out[0]);
  }elsif(  @hash_out > 1 ){ return(@hash_out); }
}

#________________________________________________________________________
# Title     : define_secondary_structure_segments, synonim of tidy_secondary_structure_segments
# Usage     : print_seq_in_block(&define_secondary_structure_segments(\%hash, 'e4', 'h4'), 's');
#
# Function  : receives any secondary structure assignment hashes and
#             tidys up them. That is removes very shoft secondary structure
#             regions like( --HH--, -E-, -EE- ) according to the given minimum
#             lengths of segments.
# Example   : print_seq_in_block(&define_secondary_structure_segments(\%hash, 'e4', 'h4'), 's');
#             <makes following into the next block>
#
#             1cdg_2aaa      -------EEE-----------EE--EEEE------EE---------EEE-
#             1cdg_6taa      -------EEE-----------EE--EEEE------EE---------EEE-
#             2aaa_6taa      -------EEEEE------EE-EEEEEEEE----EEEE-------EEEEE-
#
#             <example output>
#
#             1cdg_6taa      -------------------------EEEE---------------------
#             1cdg_2aaa      -------------------------EEEE---------------------
#             2aaa_6taa      -------EEEEE---------EEEEEEEE----EEEE-------EEEEE-
#
# Warning   :
# Class     :
# Keywords  :
# Options   : something like 'H3' or 'E3' for minimum segment length set to 3 positions.
# Package   : Bio::Seq
# Reference :
# Returns   : array of references of hashes.
# Tips      :
# Argument  : hashes and [options]. No options result in default of 'H3', 'E3'
# Todo      :
# Author    : A Biomatic
# Version   : 1.0.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub define_secondary_structure_segments{
  my($i, $k,$a, $j, $helix_min, $beta_strand_min, %hash, @keys, @hash,
	  $option_string, @hash_out, $string1, $name, %out, $gap_chr, @str1, @str2,
	  @stringout, @string_segH, @string_segE, $countH, $countE
	  );

  #### Default helix and beta strand segment length setting #####
  $helix_min=3;
  $beta_strand_min=3;

  ########################################################################
  #####   general argument handling  for options of segment length  ######
  ########################################################################
  for($k=0; $k< @_ ;$k++){
	  if( ( !ref($_[$k]) )&&($_[$k]=~ /^[Hh](\d+)$/) ){
		  $helix_min  = $1;    }
	  elsif( ( !ref($_[$k]) )&&($_[$k]=~ /^[Ee](\d+)$/) ){
		  $beta_strand_min  = $1;    }
	  elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^[Hh](\d+)$/) ){
		  $helix_min  = $1;    }
	  elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^[EeBb](\d+)$/) ){
		  $beta_strand_min  = $1;    }
	  elsif(ref($_[$k]) eq "HASH") { push(@hash,  $_[$k]); }    }

  for($i=0; $i < @hash; $i++){
	  my(%hash) = %{$hash[$i]};
	  @keys = sort keys( %hash );
	  for($j=0; $j < @keys; $j++){
		  my(@string_segH, @string_segE, @stringout);
		  $string1=$hash{$keys[$j]};
		  $gap_char = $1 if ($string1=~ /(\W)/);

		  ##### actual cleaning ####
		  my(@string) = split(//, $string1);
		  for($a = 0; $a < @string; $a++){
			 if($string[$a] !~/[HE]/){ ### if the splited element doesn't match 'H' or 'E'

				 ##### If any of the HH or EE counter is over the given minimum($helix_min,,)
				 if((@string_segH >= $helix_min)||( @string_segE >=$beta_strand_min)){
					 push(@stringout, @string_segH, @string_segE, '-');
					 @string_segH=@string_segE=();     }   ## just resetting.
				 else{  ### if the accumulated 'HH' or 'EE' is smaller than the minimum
					 for(0.. (@string_segH + @string_segE) ){
						push(@stringout, '-'); ### replace the short 'EE' etc with '-'
					 }
					 @string_segH=@string_segE=();  ## just resetting.
				 }
			 }
			 elsif($string[$a] =~ /^([Hh])$/){
				 push(@string_segH, $1); }
			 elsif($string[$a] =~ /^([Ee])$/){
				 push(@string_segE, $1); }
		  }
		  $hash{$keys[$j]}=join("", @stringout);
	  }
	  push(@hash_out, \%hash);
  }
  if(@hash_out == 1){ return($hash_out[0]);
  }elsif(  @hash_out > 1 ){ return(@hash_out); }
}






#________________________________________________________________________
# Title     : overlay_seq_by_certain_chars
# Usage     : %out =%{&overlay_seq_by_certain_chars(\%hash1, \%hash2, 'HE')};
# Function  : (name1 000000112324)+(name1  ABC..AD..EFDK ) => (name1 000..00..12324)
#             (name2 000000112324)+(name2  --HHH--EEEE-- ) => (name1 ---000--1123--)
#             uses the second hash a template for the first sequences. gap_char is
#             '-' or '.' or any given char or symbol.
#             To insert gaps rather than overlap, use insert_gaps_in_seq_hash
# Example   : %out =%{&overlay_seq_by_certain_chars(\%hash1, \%hash2, 'E')};
#             output> with 'E' option >>> "name1     --HHH--1232-"
# Warning   : If gap_chr ('H',,,) is not given, it replaces all the
#             non-gap chars (normal alphabet), ie,
#             it becomes 'superpose_seq_hash'
# Class     :
# Keywords  : Overlap, superpose hash, overlay, superpose_seq_hash
# Options   : E for replacing All 'E' occurrances in ---EEEE--HHHH----, etc.
#             : H for replacing all 'H'  "     " "
# Package   : Array_Util
# Reference :
# Returns   : one hash ref.
# Tips      :
# Argument  : 2 ref for hash of identical keys and value length.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub overlay_seq_by_certain_chars{
  my($i, $k,$j, $name, @in, %out, $gap_chr, @str1, @str2);
  ######################################
  ####### Sub argument handling ########  $gap_chr here can be 'HE' etc.
  ######################################
  for($k=0; $k< @_ ;$k++){
	  if( ( !ref($_[$k]) )&&($_[$k]=~ /^(.+)$/) ){
		  $gap_chr  .= $1;
	  }elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(.)+$/) ){
		  $gap_chr  .= $1;
	  }elsif(ref($_[$k]) eq "HASH") { push(@in,  $_[$k]); }
  }

  if($#in < 1){
	  print "\n overlay_seq_by_certain_chars needs 2 hashes. Error \n"; exit; }
  my(%hash1)=%{$in[0]};
  my(%hash2)=%{$in[1]};
  my(@names1)= sort keys %hash1;
  my(@names2)= sort keys %hash2;
  (@names1 > @names2)? $bigger=@names1 : $bigger=@names2;
  for ($j=0; $j < $bigger; $j++){
	  @str1=split(//, $hash1{$names1[$j]});
	  @str2=split(//, $hash2{$names2[$j]});
	  if( ($gap_chr eq '') && ($hash2{$names2[$j]}=~/(\W)/) ){
		  $gap_chr=$1;
		  for($i=0; $i < @str2; $i++){
			  if($str2[$i] =~ /$gap_chr/){ $str1[$i]=$gap_chr;}     }
		  $out{$names1[$j]}=join(",", @str1);
	  }else{
		  for($i=0; $i < @str2; $i++){
			  if($gap_chr =~ /$str2[$i]/){ $str2[$i]=$str1[$i];}    }
		  $out{$names1[$j]}=join(",", @str2);    }
  }
  \%out;
}



#________________________________________________________________________
# Title     : rev_lines_pdb
# Usage     : &rev_lines_pdb(\$ARGV[0]);
# Function  : reorders the lines of any pdb files, but takes only C alpha positions.
# Example   :
#             The INPUT example >
#
#             ATOM    191  CA  ALA   195      -2.566   8.099  42.827  1.00 12.42      1ENG 256
#             ATOM    192  CA  ARG   196      -1.401  11.546  41.629  1.00  8.63      1ENG 257
#             ATOM    193  CA  THR   197      -4.073  13.846  43.107  1.00  9.93      1ENG 258
#
#             The OUTPUT example >             <first file, called  xxxx1.atm >
#
#             ATOM      1  CA  ALA     1      -2.566   8.099  42.827  1.00 12.42      1ENG 256
#             ATOM      2  CA  ARG     2      -1.401  11.546  41.629  1.00  8.63      1ENG 257
#             ATOM      3  CA  THR     3      -4.073  13.846  43.107  1.00  9.93      1ENG 258
#
#                                           <2nd file, called  xxxx2.atm >
#             ATOM      1  CA  THR     1      -4.073  13.846  43.107  1.00  9.93      1ENG 258
#             ATOM      2  CA  ARG     2      -1.401  11.546  41.629  1.00  8.63      1ENG 257
#             ATOM      3  CA  ALA     3      -2.566   8.099  42.827  1.00 12.42      1ENG 256
#
# Warning   : A Biomatic
# Class     :
# Keywords  :
# Options   : None
# Package   :
# Reference :
# Returns   : directly writes two output files  xxxx1.atm  xxxx2.atm
# Tips      :
# Argument  : one pdb coordinate file reference
# Todo      :
# Author    :
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rev_lines_pdb{
	 my(@lines, $i, $c, @line_rev, $ATOM, $RES );
	 my($input_file_name) = ${$_[0]};
	 open(INPUT, "$input_file_name");
	 while(<INPUT>){  push(@lines, $_); $whole++;  }
	 my($base_name) =${&get_base_name(\$input_file_name)};
	 my($file1) = "${base_name}1\.atm";
	 my($file2) = "${base_name}2\.atm";

	 ##################################################################################
	 # This section is for forward C alpha lines (it renumbers residues and atoms)
	 ##################################################################################
	 open(F1, ">$file1");
	 open(F2, ">$file2");

	 for($i=0; $i < $whole ; $i ++){
		  if($lines[$i]=~ /^(ATOM +)(\d+)(  CA  \w+ +)(\d+)( +.+)$/){
				$c++;
				if( length($2)== length($c) ){
					 unshift(@lines2, "$1$c$3$c$5\n");
					 print F1 "$1$c$3$c$5\n"; next;
				}
				if( length($2) != length($c) ){
					 if( abs( ( length($2)- length($c) )) ==1){
						  unshift(@lines2, "$1 $c$3 $c$5\n");
						  print F1 "$1 $c$3 $c$5\n"; next;
					 }
					 if( abs( (length($2)-length($c))) ==2){
						  unshift(@lines2, "$1  $c$3  $c$5\n");
						  print F1 "$1  $c$3  $c$5\n"; next;
					 }
				}
		  }
	 }
	 close F1;

	 ##################################################################################
	 # This section is for reversed C alpha lines (it renumbers residues and atoms)
	 ##################################################################################
	 $c=0;
	 for($i= 0; $i < $whole; $i ++){
		  if($lines2[$i]=~ /^(ATOM +)(\d+)(  CA  \w+ +)(\d+)( +.+)$/){
				$c++; $num = $1;
				if( length($2)== length($c) ){  # these are for column position adjustment
					 printf F2 "$1$c$3$c$5\n";
					 next;
				}
				elsif( length($2) != length($c) ){
					 if( (length($2)- length($c)) ==1){
							 print F2 "$1 $c$3 $c$5\n";
							 next;
					 }
					 elsif( (length($2)- length($c)) == -1){
							 $ATOM=$1; $RES=$3;
							 chop($ATOM); chop($RES);
							 print F2 "$ATOM$c$RES$c$5\n";
							 next;
					 }
					 elsif( (length($2)- length($c)) ==2){
							 print F2 "$1  $c$3  $c$5\n";
							 next;
					 }
					 elsif( (length($2)- length($c)) == -2){
							 $ATOM=$1; $RES=$3;
							 chop($ATOM); chop($RES); chop($ATOM); chop($RES);
							 print F2 "$ATOM$c$RES$c$5\n";
							 next;
					 }
				}
		  }
	 }
	 close F2;

	 ##################################################################################
	 #   Final result
	 ##################################################################################

	 print "\n Files   $file1, $file2  are created \n\n\n";

}


#________________________________________________________________________
# Title     : tally_2_hashes (used for get_cs_rate_for_pairs_stat.pl )
# Usage     : ($ref1, $ref2) = &tally_2_hashes(\%hash1, \%hash2, ['n', 'a', 'p', 'i']);
#              %tally_addedup=%{$ref1};    '0' position had addedup value of 1000
#              %tally_occurances=%{$ref2}; '0' position had occurred 100 times,
#                                          '0' on average had 10 in its
#                                              corresponding hash positions
# Function  : Makes hashes of tallied occurances and summed up values for disits in
#             positions.
#             calculates the occurances or occurance rates of CS rate positions.
#             The hashes should have numbers.
# Example   : you put two hash refs. (ass. array) as args (\%hash1, \%hash2)
#             The hashes are like; hash1  (name1, 0000011111, name2, 0000122222 );
#                                  hash2  (name3, 1324..1341, name4, 13424444.. );
#
#             1) The resulting 1st hash output is (0, 20,   1, 13,     2, 12)
#             which means that 0 added up to 24 in the second arg hash positions
#                              1 added up to 15 in the second arg hash positions
#                              2 added up to 18 in the second arg hash positions
#             'p' option only works with 'n' or 'a'
#             2) The resulting 2nd hash output is (0, 5,   1, 5)
#             which means that 0 occurred 5 times in the first input hash
#                              1 occurred 5 times in the first input hash
#             'p' option only works with 'n' or 'a'
# Warning   :
# Class     :
# Keywords  :  tally two hashes of numbers.
# Options   : [a n i p]
# Package   : Bio
# Reference :
# Returns   : ($ref1, $ref2), ie, two references of hash
#             averaging option causes division of 20(added up value)
#                                                by 9(occurance) in the above
#             for '0' of the first hash, so (0, 2.222,  1, 2.1666,  2, 2.4 )
#             Average is the average of numbers
#             average value in 0-9 scale (or 0-100 with 'p' option)
#             So, if there are
#                  seq1 00111110000,   The 'a' value of 0 and 1 as in the seq2
#                  seq2 33000040000    is 0-> 6/6, 1-> 4/5, while the 'n'
#                                        calc would be, 0-> 6 (60%), 1-> 4(40%)
#
# Tips      :
# Argument  : (\%hash1, \%hash2) or optionally (\%hash1, \%hash2, ['n', 'i', 'p', 'a'])
#             'n' => normalizing, 'p' => percentage out, 'i' => make int out, 'a'=> averaged
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   : get_position_shift_rate
# Enclosed  :
#--------------------------------------------------------------------
sub tally_2_hashes{
  #""""""""""""""""""""""< handle_arguments head Ver 1.0 >""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z,
	  $dir, $file, $line, $name, @keys, @names,  @temp, %hash, %input );
	my(@keys1, @keys2, %hash0, %hash1, %tally, %tally_occur,
	  %tally_all_occur, $gap_char1, $gap_char2, @string1, @string2);
	my($factor)=10;
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	%hash0 = %{$hash[0]};
	%hash1 = %{$hash[1]};
	@keys1=  keys %hash0;  ### No need to sort here as you will return hash at the end
	@keys2=  keys %hash1;

  if($char_opt =~ /p/i ){ $factor =100; }

  for($i=0; $i < @keys1; $i++ ){

	  ###################################################
	  ##  Gap char detection
	  ###################################################
	  if($hash0{$keys1[$i]} =~ /([\,\-])\S+[\,\-]/){ $gap_char1 = $1; }else{ $gap_char1=''; }
	  if($hash1{$keys2[$i]} =~ /([\,\-])\S+[\,\-]/){ $gap_char2 = $1; }else{ $gap_char2=''; }


	  ###################################################
	  ##  Split the value string by gap char
	  ###################################################
	  @string1=split(/$gap_char1/, $hash0{$keys1[$i]});
	  @string2=split(/$gap_char2/, $hash1{$keys2[$i]});
	  ### @string1 => (0,0,0,0,1,1,1,1,1) @string2 => (3,4,2,13,2,1,23,3)


	  ################################################################
	  ##  Main calc part, you get %tally_all_occur and %tally_occur
	  ################################################################
	  for($j=0; $j < @string1; $j++){
		  $tally_all_occur{$string1[$j]}++ ; ## <-- number of all the positions
		  if( ($string2[$j]=~/[\d\^]+/)&&($string1[$j]=~/[\d\^]+/) ){
			  $tally_occur{$string1[$j]}+=$string2[$j] ; # %tally_occur is for added up counts
		  }                                             # %tally_all_occur is for only the position
	  }                                                #  occurances of '0', '1' or whatever. To know
																		#  how many '0' entry were you should use this.
	  ####################################################################################
	  ##  When options were put, do more calc on %tally_all_occur and %tally_occur
	  ####################################################################################
	  if($char_opt =~ /a/i ){
		 print "\n           $char_opt ";
		 my(@cs_rates) = sort keys %tally_all_occur;
		 for($k=0; $k < @cs_rates; $k++){
			 if($tally_all_occur{$cs_rates[$k]} == 0){
				 $tally{$cs_rates[$k]} =0; next;}
			 if($char_opt =~ /i/i ){
				 $tally{$cs_rates[$k]}=int($tally_occur{$cs_rates[$k]}/$tally_all_occur{$cs_rates[$k]}); }
			 elsif($char_opt !~ /i/i ){
				 $tally{$cs_rates[$k]}= $tally_occur{$cs_rates[$k]}/$tally_all_occur{$cs_rates[$k]};
			 }
		 }
	  }
	  elsif($char_opt =~ /[np]/i){
		 my($big_sum, @cs_digits);
		 @cs_digits = sort keys %tally_occur;  # @cs_digits are (0, 1, and 2 )
		 for(@cs_digits){ $big_sum+=$tally_occur{$_}/$tally_all_occur{$_};   }
		 for($t=0; $t < @cs_digits; $t++){
			if($big_sum ==0){ $tally{$cs_digits[$t]}=0; next; }
			else{
			  if($char_opt =~ /i/i){
				 $tally{$cs_digits[$t]}= int(($tally_occur{$cs_digits[$t]}/$tally_all_occur{$cs_digits[$t]}/$big_sum*$factor)+0.4999);}
			  elsif($char_opt !~ /i/i ){
				 $tally{$cs_digits[$t]}= $tally_occur{$cs_digits[$t]}/$tally_all_occur{$cs_digits[$t]}/$big_sum*$factor;}
			}
		 }
	  }
  }
  if($char_opt =~ /[an]/i){
		 print "\n           $char_opt ";
	  return(\%tally, \%tally_all_occur);}
  else{ return(\%tally_occur, \%tally_all_occur);}
}
#________________________________________________________________________
# Title     : superpose_seq_hash   ( first to second hash) ## the oldest version.
# Usage     : %out =%{&superpose_seq_hash(\%hash1, \%hash2)};
# Function  : (name1 000000112324)+(name1  ABC..AD..EFD ) => (name1 000..01..324)
#             uses the second hash a template for the first sequences. gap_char is
#             '-' or '.'
#             To insert gaps rather than overlap, use insert_gaps_in_seq_hash
# Example   :
# Warning   : Accepts only two HASHes and many possible gap_chr. Default gap is '-'
# Class     :
# Keywords  : overlay sequence, overlay alphabet, superpose sequence,
# Options   :
# Package   :
# Reference :
# Returns   : one hash ref.
# Tips      :
# Argument  : 2 refs. for hash of identical keys and value length and gap_chr.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub superpose_seq_hash{
  if($debug eq 1){ print __LINE__, " # superpose_seq_hash : \n"; }
  my($gap_chr)='-';
  my($i, $j, %hash1, %hash2, $name, %out, @str1, @str2);

  if((ref($_[0]) eq 'HASH')&&(ref($_[1]) eq 'HASH')){
	  %hash1=%{$_[0]}; %hash2=%{$_[1]}; }
  else{ print "\n superpose_seq_hash needs hash ref\n"; print chr(007); exit; }

  my(@names1)=sort keys %hash1; my(@names2)=sort keys %hash2;
  (@names1 > @names2)? $bigger=@names1 : $bigger=@names2;

  for ($j=0; $j < $bigger; $j++){
	 if($hash2{$names2[$j]}=~/(\W)/){ $gap_chr = $1; }
		@str1=split(/|\,/, $hash1{$names1[$j]});
		@str2=split(/|\,/, $hash2{$names2[$j]});
		for($i=0; $i < @str2; $i++){
		  if($str2[$i] ne $gap_chr){ $str2[$i]=$str1[$i];  } }
		$out{$names1[$j]}=join(",", @str2);
  }
  \%out;
}


#________________________________________________________________________
# Title     : overlay_seq_hash   ( first to second hash) ## the oldest version.
# Usage     : %out =%{&overlay_seq_hash(\%hash1, \%hash2)};
# Function  : (name1 000000112324)+(name1  ABC..AD..EFD ) => (name1 000..01..324)
#             uses the second hash a template for the first sequences. gap_char is
#             '-' or '.'
#             To insert gaps rather than overlap, use insert_gaps_in_seq_hash
# Example   :
# Warning   : Accepts only two HASHes and many possible gap_chr. Default gap is '-'
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one hash ref.
# Tips      :
# Argument  : 2 refs. for hash of identical keys and value length and gap_chr.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub overlay_seq_hash{
  my($gap_chr)='-'; my($i, $j, $name, %out, @str1, @str2);

  if((ref($_[0]) eq 'HASH')&&(ref($_[1]) eq 'HASH')){
	  my(%hash1)=%{$_[0]}; my(%hash2)=%{$_[1]}; }
  else{ print "\n overlay_seq_hash needs hash ref\n"; print chr(007); exit; }

  my(@names1)=keys %hash1; my(@names2)=keys %hash2;
  (@names1 > @names2)? $bigger=@names1 : $bigger=@names2;

  for ($j=0; $j < $bigger; $j++){
	 if($hash2{$names2[$j]}=~/(\W)/){ $gap_chr = $1; }
		@str1=split(//, $hash1{$names1[$j]}); @str2=split(//, $hash2{$names2[$j]});
		for($i=0; $i < @str2; $i++){
		  if(($str2[$i] =~ /\W/)||($str2[$i] =~ //)){ $str1[$i]="$gap_chr";}}
		$out{$names1[$j]}=join(",", @str1);
  }
  \%out;
}

#________________________________________________________________________
# Title     : insert_gaps_in_seq_hash  ( first to second hash)
# Usage     : %out_extended_seq =%{&insert_gaps_in_seq_hash(\%hash1, \%hash2)};
# Function  : superpose two hashes of the same sequence or same seq. length sequences,
#             but unlike 'superpose_seq_hash', this inserts gaps and extend the
#             sequences.
#             (name1_sec  hHHHHHH EEEEEEE) +
#             (name1_seq  .CDEABC..AD..EFD..EKST) => (name1_ext  .hHHHHH..H...EEE..EEEE)
#             In the example, the undefined sec. str. position is replaced as gaps('.')
#             Uses the second hash a template for the first sequences. gap_char is
#             '-' or '.'
# Example   :
# Warning   : coded by A Biomatic
# Class     :
# Keywords  : superposing sequences with gaps
# Options   :
# Package   :
# Reference :
# Returns   : one hash ref.
# Tips      :
# Argument  : 2 ref for hash of identical keys and value length.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub insert_gaps_in_seq_hash{
  my($gap_char)='-';
  my($i, $j, $t, %hash1, %hash2, $bigger, $name, %out, @str1, @str2);
  my($join_char) =',';  ## <<-- This is for the final output joined by this var.

  if((ref($_[0]) eq 'HASH')&&(ref($_[1]) eq 'HASH')){
	  %hash1=%{$_[0]};
	  %hash2=%{$_[1]};
  }
  else{
	  print "\n superpose_seq_hash needs hash ref\n";
	  print chr(007); exit;
  }
  my(@names1)=keys %hash1;
  my(@names2)=keys %hash2;
  (@names1 > @names2)? $bigger=@names1 : $bigger=@names2;

  for ($j=0; $j < $bigger; $j++){
		if( $hash2{$names2[$j]}=~/(\W)/){
			$gap_char = $1; } ## <<-- finding the gap_char
		$hash1{$names1[$j]}=~ s/ /$gap_char/g; ## <<-- replacing space with 'gap_char';

		@str1=split(/|\,/, $hash1{$names1[$j]});
		@str2=split(/|\,/, $hash2{$names2[$j]});
		for($i=0 ; $i < @str2; $i++){
			if($str2[$i] =~ /\w/){
				$str2[$i] = shift @str1;
			}
		}
		$out{$names1[$j]}=join(",", @str2);
  }
  \%out;
}




#________________________________________________________________________
# Title     : scan_win_get_average (gets averages of windows of sequences of num)
# Usage     : %out1 = %{&scan_win_get_av(\%input, \$window_size, \%input2,,,,)};
#             The order of the arguments doesn't matter.
# Function  :
# Example   : input hash: ( seq1,  '13241234141234234',      (2 or more sequences accepted)
#                           seq2,  '1341324123413241234')
#             input winsize : 5;
#
#             output hash; (seq1, 1234123413241234);
#             output hash; (seq2, 1344234123412341);
#                  The numbers are ratios(compos/seqid) with given window size.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scan_win_get_average{
  my($window_size)=6; my($k,$r, @in_hash);
  for($k=0; $k < @_; $k++){ ######### Arg handling.
	 if(ref($_[$k]) eq 'HASH'){  push(@in_hash, $_[$k]);  }
	 elsif( ref($_[$k]) eq 'SCALAR'){ $window_size = ${$_[$k]}; }
	 elsif( !(ref($_[$k])) && ( $_[$k] =~ /\d+/)){ $window_size=$_[$k]; }
  }
  for($r=0; $r < @in_hash; $r++){ my($i,$window_1, $sepa,%out_hash,$offset, $sum, $w,@win_elem_array);
	 my(%input)=%{$in_hash[$r]};  my(@keys)= keys %input;
	 for ($i=0; $i< @keys; $i++){ my($av);
		 $input{$keys[$i]}=~ s/,//g; $input{$keys[$i]}=~ s/\./0/g;
		 $input{$keys[$i]}=~ s/\-/0/g;
		 for($w=0; $w < length($input{$keys[$i]}); $w++){
			$offset = $w - int($window_size/2);  if($offset < 0){ $offset = 0; }
			$window_1= substr($input{$keys[$i]}, $offset, $window_size);
			@win_elem_array= split(//,$window_1);
			for(@win_elem_array){    if(/^\d[\.\d]*/){   $sum+=$_;  }    }
			$av.=int($sum/@win_elem_array);         $sum=0;
		 }
		 $out_hash{$keys[$i]}=$av;
	 }
	 push(@final_out_ref, \%out_hash);
  }
  if( @final_out_ref == 1){  return($final_out_ref[0]); }
  elsif(  @final_out_ref > 1){  return(@final_out_ref); }
}
#________________________________________________________________________
# Title     : scan_win_and_get_sc_rate_pairs
# Usage     : %out1 = %{&scan_win_and_get_sc_rate_pairs(\%input, \$window_size)};
# Function  : scans input sequences(arg1) in a given(arg2) window size and gets
#             each composition and sequence identity rate(sc_rate) of the window.
#             sc rate = Sequence Id(%)/ Composition Id(%)
# Example   : input hash: ( seq1,  'ABCDEFG.HIK',      (2 or more sequences accepted)
#                         seq2,  'DFD..ASDFAFS',
#                         seq3,  'DDDDD..ASDFAFS' );
#             input winsize : 5;
#
#             output hash; (seq1seq2, 1,2,2,2,1,1,2,2); <-- joined by ',';
#             output hash; (seq1seq3, 1,2,2,2,1,1,2,2); <-- joined by ',';
#                  The numbers are ratios(compos/seqid) with given window size.
# Warning   : when $seqid is zero  the rate becomes $compos_id/10   !!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a reference of a hash.
# Tips      :
# Argument  : One ref. for hash, one ref. for a scalar.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scan_win_and_get_sc_rate_pairs{
  my($base_l)=1; my($scale)=1;
  my(%input, $i, $j, $window_size, $show_calculation, $redu_window,
	  $variable_win_size);
  for($i=0; $i < @_; $i ++){
	 if( (ref($_[$i])) eq 'HASH'  ){ %input=%{$_[$i]};}
	 elsif( (ref($_[$i]) eq 'SCALAR' )&&(${$_[$i]} =~ /^d+/)){ $window_size= ${$_[$i]}; }
	 elsif( (ref($_[$i]) eq 'SCALAR' )&&(${$_[$i]} =~ /^[vV]+/)){ $variable_win_size= 'v' }
	 elsif( (ref($_[$i]) eq 'SCALAR' )&&(${$_[$i]} =~ /[sS]+/)){ $show_calculation = 's'}
	 elsif( (ref($_[$i]) eq 'SCALAR' )&&(${$_[$i]} =~ /[rR]+/)){ $redu_window  = 'r'}
	 elsif( (ref($_[$i]) eq 'SCALAR' )&&(${$_[$i]} =~ /[fF]+/)){ $apply_factor  = 'f'}
	 elsif( (ref($_[$i]) eq 'SCALAR' )&&(${$_[$i]} =~ /[dD]+/)){ $make_gap_dot  = 'd'}
	 elsif( (ref($_[$i]) eq 'SCALAR' )&&(${$_[$i]} =~ /[mM]+/)){ $minus_whole_cs  = 'm'}
	 elsif( (!(ref($_[$i])))&&($_[$i] =~ /^\d+/) ){ $window_size= $_[$i]; }
	 elsif( (!(ref($_[$i])))&&($_[$i] =~ /^[vV]+/) ){ $variable_win_size = 'v'; }
	 elsif( (!(ref($_[$i])))&&($_[$i] =~ /^[sS]+/) ){ $show_calculation  = 's'; }
	 elsif( (!(ref($_[$i])))&&($_[$i] =~ /^[rR]+/) ){ $redu_window  = 'r'; }
	 elsif( (!(ref($_[$i])))&&($_[$i] =~ /^[fF]+/) ){ $apply_factor  = 'f'; }
	 elsif( (!(ref($_[$i])))&&($_[$i] =~ /^[dD]+/) ){ $make_gap_dot  = 'd'; }
	 elsif( (!(ref($_[$i])))&&($_[$i] =~ /^[mM]+/) ){ $minus_whole_cs  = 'm'; }
  }

  if(defined(${$_[2]})){ $base_l=${$_[2]}; }
  if(defined(${$_[3]})){ $scale =${$_[3]}; }
  my(@sequences, @out_rate, $i, $j, $title, $window_1, $window_2,
	  $ratio_compos_vs_seqid, @array_of_2_seq,%out_hash );
  my(@keys)= sort keys %input;
  for ($i=0; $i<@keys; $i++){    # putting sequences from hash to an array
	 for($j=$i+1; $j< @keys; $j++){
		push(@sequences, $input{$keys[$i]}, $input{$keys[$j]});

		######################################################################
		#################  PASSING OVER TO the next SUB routine ##############
		######################################################################
		#---> @sequences will have ('ABCDEFG.HIK', 'DFD..ASDFAFS'); ##########
		($out_rate_arr_ref,$whole_rate_ref)= &get_windows_sc_rate_array(

						\@sequences,\$window_size, $variable_win_size, \$apply_factor,
						\$redu_window, $make_gap_dot, $show_calculation, \$minus_whole_cs );

		undef(@sequences);
		@out_rate=@{$out_rate_arr_ref};
		$whole_rate=${$whole_rate_ref};
		$title = "$keys[$i]_$keys[$j]\($whole_rate\)";
		$out_hash{$title}=join(",", @out_rate);
	 }
  }
  return( \%out_hash );
}

#________________________________________________________________________
# Title     : scan_win_and_get_cs_rate_pairs
# Usage     : %out1 = %{&scan_win_and_get_cs_rate_pairs(\%input, \$window_size)};
# Function  : scans input sequences(arg1) in a given(arg2) window size and gets
#             each composition and sequence identity rate(cs_rate) of the window.
#             CS rate = Composition Id / Sequence Id
# Example   :     input hash: ( seq1,  'ABCDEFG.HIK',      (2 or more sequences accepted)
#                               seq2,  'DFD..ASDFAFS',
#                               seq3,  'DDDDD..ASDFAFS' );
#                 input winsize : 5;
#
#                 output hash; (seq1seq2, 1,2,2,2,1,1,2,2); <-- joined by ',';
#                 output hash; (seq1seq3, 1,2,2,2,1,1,2,2); <-- joined by ',';
#             The numbers are ratios(compos/seqid) with given window size.
#
# Warning   : when $seqid is zero  the rate becomes $compos_id/10   !!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a reference of a hash.
# Tips      : This is for quality checking of multiple sequence alignments.
#             It is getting the entropy of the column and calculates something after.
# Argument  : One ref. for hash, one ref. for a scalar.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scan_win_and_get_cs_rate_pairs{
  my($base_l)=1;
  my($scale)=1;   # these are default params.
  my(%input)=%{$_[0]};
  my($window_size)=${$_[1]};

  if(defined(${$_[2]})){ $base_l=${$_[2]}; } ### <---$base_c is the baseline controller for sensitivity.
  if(defined(${$_[3]})){ $scale =${$_[3]}; } ### <---$base_c is the baseline controller for sensitivity.

  my(@sequences, @out_rate, $i, $j, $title, $window_1, $window_2,
	  $ratio_compos_vs_seqid, @array_of_2_seq,  %out_hash, $whole_rate );
  my(@keys)= keys %input;

  for ($i=0; $i < @keys; $i++){    # putting sequences from hash to an array
	 for($j=$i+1; $j < @keys; $j++){
		push(@sequences, $input{$keys[$i]}, $input{$keys[$j]});
		#---> @sequences will have ('ABCDEFG.HIK', 'DFD..ASDFAFS'); ##########
		($out_rate_arr_ref,$whole_rate_ref)
			 = &get_windows_cs_rate_array(\@sequences,\$window_size,\$base_l,\$scale);
		undef(@sequences);
		@out_rate=@{$out_rate_arr_ref};
		$whole_rate=${$whole_rate_ref};
		$title="$keys[$i]_$keys[$j]\($whole_rate\)";
		$out_hash{$title}=join(",", @out_rate);
	 }
  }
  return( \%out_hash );
}
#________________________________________________________________________
# Title     : get_residue_error_rate  (used in get_posi_rates_hash_out)
# Usage     : %position_diffs =%{&get_residue_error_rate(\@seq_position1, \@seq_position2)};
# Function  : This is the final step in error rate getting.
#             gets a ref. of a hash and calculates the absolute position diffs.
# Example   :
# Warning   : split and join char is ',';
# Class     :
# Keywords  :
# Options   : 'L' for limitting the error rate to 9 to make one digit output
#  $LIMIT becomes 'L' by L, l, -l, -L
# Package   :
# Reference :
# Returns   : one ref. for an array of differences of input arrays. array context.
#             ---Example input (a hash with sequences); The values are differences after
#                                comparion with structural and sequential alignments.
#             %diffs =('seq1', '117742433441...000',   <-- input (can be speparated by '' or ','.
#                      'seq2', '12222...99999.8888',
#                      'seq3', '66222...44444.8822',
#                      'seq4', '12262...00666.772.');
#             example output;
#             seq3_seq4       '0,1,0,0,0,.,.,.,,.,0,,0,0,,0,0,,.,0,,0,0,.'
#             seq1_seq2       '0,1,0,1,1,.,.,.,,.,2,,2,2,,2,2,,.,.,,2,2,1'
#             seq1_seq3       '0,1,0,1,1,.,.,.,,.,1,,1,1,,0,.,,.,.,,1,1,1'
#             seq1_seq4       '0,1,0,,1,1,.,.,.,,.,1,,1,1,0,.,.,,.,1,,2,2'
#             seq2_seq3       '0,1,0,,0,0,,.,.,,.,0,,1,0,,0,0,,.,0,,0,0,0'
#             seq2_seq4       '0,0,0,,1,0,,.,.,,.,0,,1,0,,0,0,,.,0,,0,0,.'
# Tips      :
# Argument  : Takes a ref. for hash which have positions of residues of sequences.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   : get_position_shift_rate, previously get_each_posi_diff_hash
# Enclosed  :
#--------------------------------------------------------------------
sub get_residue_error_rate{
	my(%diffs)= %{$_[0]}; my(@names)= keys (%diffs);
	my($LIMIT)=${$_[1]} if ref($_[1]) eq 'SCALAR';
	my($LIMIT)= $_[1] unless ref($_[1]);
	my(%seqs_comp_in_pair, @temp, @temp2,$split_char, $i);
	for ($i=0; $i < @names; $i++){
		if($diffs{$names[$i]}=~/\,/){ $split_char =',';}else{ $split_char = ''; }
		(@{"string$i"}) = split(/$split_char/, $diffs{$names[$i]});   }
	for ($i=0; $i < @names; $i++){
		for ($j=$i+1; $j < @names; $j ++){
			for ($k=0; $k < @string0; $k++){
				if ((${"string$i"}[$k] =~ /[-\d+]/) && (${"string$j"}[$k] =~ /[-\d+]/)){
					my($diff) = abs(${"string$i"}[$k] - ${"string$j"}[$k]);
					if( ($LIMIT =~/L/i)&&($diff > 9) ){ push(@temp2, 9);
					}else{ push(@temp2, $diff); }
				}else{ push(@temp2, '.'); } }

			#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			#  Following if {} is for sorting output names to make  2aaa_6taa than 6taa_2aaa
			#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			if($names[$i] <= $names[$j]){
				$seqs_comp_in_pair{"$names[$i]\_$names[$j]"}=join(",", @temp2); }
			else{ $seqs_comp_in_pair{"$names[$j]\_$names[$i]"}=join(",", @temp2); }

			@temp2=();
		}
	 }
	\%seqs_comp_in_pair;  # permutated
}

#________________________________________________________________________
# Title     : get_each_posi_diff_hash , next version is  get_residue_error_rate
# Usage     : %position_diffs =%{&get_each_posi_diff_hash(\@seq_position1, \@seq_position2)};
# Function  : This is the final step in error rate getting.
#             gets a ref. of a hash and calculates the position diffs.
# Example   :
# Warning   : split and join char is ',';
# Class     :
# Keywords  :
# Options   : 'L' for limitting the error rate to 9 to make one digit output
#  $LIMIT becomes 'L' by L, l, -l, -L
#
# Package   :
# Reference :
# Returns   : one ref. for an array of differences of input arrays. array context.
#             ---Example input (a hash with sequences); The values are differences after
#                                comparion with structural and sequential alignments.
#             %diffs =('seq1', '117742433441...000',   <-- input (can be speparated by '' or ','.
#                      'seq2', '12222...99999.8888',
#                      'seq3', '66222...44444.8822',
#                      'seq4', '12262...00666.772.');
#             example output;
#             seq3_seq4       '0,1,0,0,0,.,.,.,,.,0,,0,0,,0,0,,.,0,,0,0,.'
#             seq1_seq2       '0,1,0,1,1,.,.,.,,.,2,,2,2,,2,2,,.,.,,2,2,1'
#             seq1_seq3       '0,1,0,1,1,.,.,.,,.,1,,1,1,,0,.,,.,.,,1,1,1'
#             seq1_seq4       '0,1,0,,1,1,.,.,.,,.,1,,1,1,0,.,.,,.,1,,2,2'
#             seq2_seq3       '0,1,0,,0,0,,.,.,,.,0,,1,0,,0,0,,.,0,,0,0,0'
#             seq2_seq4       '0,0,0,,1,0,,.,.,,.,0,,1,0,,0,0,,.,0,,0,0,.'
# Tips      :
# Argument  : Takes a ref. for hash which have positions of residues of sequences.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0 , old version of  get_residue_error_rate
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_each_posi_diff_hash{
	my(%diffs)= %{$_[0]}; my(@names)= keys (%diffs);
	my(%seqs_comp_in_pair, @temp, @temp2,$split_char, $i);
	my($LIMIT)=${$_[1]} if ref($_[1]) eq 'SCALAR';
	my($LIMIT)= $_[1] unless ref($_[1]);
	for ($i=0; $i < @names; $i++){
		if($diffs{$names[$i]}=~/\,/){ $split_char =',';}else{ $split_char = ''; }
		(@{"string$i"}) = split(/$split_char/, $diffs{$names[$i]});   }
	for ($i=0; $i < @names; $i++){
		for ($j=$i+1; $j < @names; $j ++){
			for ($k=0; $k < @string0; $k++){
				if ((${"string$i"}[$k] =~ /[-\d+]/) && (${"string$j"}[$k] =~ /[-\d+]/)){
					my($diff) = abs(${"string$i"}[$k] - ${"string$j"}[$k]);
					if( ($LIMIT =~/L/i)&&($diff > 9) ){ push(@temp2, 9);
					}else{ push(@temp2, $diff); }
				}else{ push(@temp2, '.'); } }

			#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			#  Following if {} is for sorting output names to make  2aaa_6taa than 6taa_2aaa
			#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			if($names[$i] <= $names[$j]){
				$seqs_comp_in_pair{"$names[$i]\_$names[$j]"}=join(",", @temp2); }
			else{ $seqs_comp_in_pair{"$names[$j]\_$names[$i]"}=join(",", @temp2); }

			@temp2=();
		}
	 }
	\%seqs_comp_in_pair;  # permutated
}

#________________________________________________________________________
# Title     : get_posi_rates_hash_out (derived from 'get_posi_shift_hash' )
# Usage     : %rate_hash = %{&get_posi_shift_hash(\%hash_msf, \%hash_jp)};
# Function  : This is to get position specific error rate for line display rather than
#             actual final error rate for the alignment.
#             Output >>
#             seq1_seq2  1110...222...2222
#             seq2_seq3  1111....10...1111
#             seq1_seq3  1111....0000.0000
#
# Example   :
# Warning   : split and join char is ','; (space)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : \%final_posi_diffs;
# Tips      :
# Argument  : %{&get_posi_rates_hash_out(\%msfo_file, \%jpo_file)};
#             Whatever the names, it takes one TRUE structral and one ALIGNED hash.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_rates_hash_out{
  my(%array1)=%{$_[0]};
  my(%array2)=%{$_[1]};
  my(@string1,@string2,@seq_position1,@seq_position2,
	  $len_of_seq,@position_diffs, @position_corrected1,
	  @names, @whole_length, %array3, $name);
  %array1 = %{&hash_common_by_keys(\%array1, \%array2)};
  %array2 = %{&hash_common_by_keys(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)};
  %array2 = %{&remov_com_column(\%array2)};
  @names=  sort keys %array2;
  for $name (@names){
	  @string1 =split(//, $array1{$name});
	  @string2 =split(//, $array2{$name});
	  @seq_position1 = @{&get_posi_sans_gaps(\$array1{$name})};
	  @seq_position2 = @{&get_posi_sans_gaps(\$array2{$name})};
	  $len_of_seq = @seq_position2;  push(@whole_length, $len_of_seq);
	  @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
	  @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
	  $array3{$name}=join(",", @position_corrected1);  }
  my(%final_posi_diffs)=%{&get_each_posi_diff_hash(\%array3)}; undef(@whole_length, $len_of_seq);
  \%final_posi_diffs;
}
#________________________________________________________________________
# Title     : get_posi_rates_hash_out_compact (derived from 'get_posi_shift_hash' )
# Usage     : %rate_hash = %{&get_posi_shift_hash(\%hash_msf, \%hash_jp)};
# Function  : This is to get position specific error rate for line display rather than
#             actual final error rate for the alignment.
#             Output >>  something like below but, without gaps, so final one is;
#             seq1_seq2  1110...222...2222     seq1_seq2  11102222222
#             seq2_seq3  1111....10...1111  -> seq2_seq3  1111101111
#             seq1_seq3  1111....0000.0000     seq1_seq3  111100000000
#
# Example   :
# Warning   : split and join char is ','; (space)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : \%final_posi_diffs_compact;  Compare with  'get_posi_rates_hash_out_jp'
# Tips      :
# Argument  : %{&get_posi_rates_hash_out(\%msfo_file, \%jpo_file)};
#             Whatever the names, it takes one TRUE structral and one ALIGNED hash.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_rates_hash_out_compact{
  my(%array1)=%{$_[0]};  my(%array2)=%{$_[1]};
  my(@string1,@string2,@seq_position1,@seq_position2,$len_of_seq,@position_diffs,
	  @position_corrected1,@names, @whole_length, %array3);
  %array1 = %{&hash_common_by_keys(\%array1, \%array2)};
  %array2 = %{&hash_common_by_keys(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)};
  %array2 = %{&remov_com_column(\%array2)};
  @names= keys %array2;
  for $name (@names){
	  @string1 =split('', $array1{$name});  @string2 =split('', $array2{$name});
	  @seq_position1 = @{&get_posi_sans_gaps(\$array1{$name})};
	  @seq_position2 = @{&get_posi_sans_gaps(\$array2{$name})};
	  $len_of_seq =(@seq_position2);  push(@whole_length, $len_of_seq);
	  @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
	  $array3{$name}=join(",", @position_diffs);  }
  my(%final_posi_diffs_compact)=%{&get_each_posi_diff_hash(\%array3)}; undef(@whole_length, $len_of_seq);
  return(\%final_posi_diffs_compact);
}
#________________________________________________________________________
# Title     : get_posi_rates_hash_out_jp (derived from 'get_posi_shift_hash' )
# Usage     : %rate_hash = %{&get_posi_shift_hash(\%hash_msf, \%hash_jp)};
# Function  : This is to get position specific error rate for line display rather than
#             actual final error rate for the alignment. get_posi_rates_hash_out_jp
#             results in jp template sequence, while get_posi_rates_hash_out_msf does
#             in msf template sequence.
#             Output >>
#             seq1_seq2  1110...222...2222   <--- the alignment template is JPO's
#             seq2_seq3  1111....10...1111        (ie structural)
#             seq1_seq3  1111....0000.0000
#
# Example   :
# Warning   : split and join char is ','; (space)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : \%final_posi_diffs;
# Tips      :
# Argument  : %{&get_posi_rates_hash_out_jp(\%msfo_file, \%jpo_file)};
#             Whatever the names, it takes one TRUE structral and one ALIGNED hash.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_rates_hash_out_jp{ my(%array1)=%{$_[0]};  my(%array2)=%{$_[1]};
  my(@string1,@string2,@seq_position1,@seq_position2,$len_of_seq,@position_diffs,
	  @position_corrected1,@names, @whole_length, %array3);
  %array1 = %{&hash_common_by_keys(\%array1, \%array2)}; %array2 = %{&hash_common_by_keys(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)};              %array2 = %{&remov_com_column(\%array2)};
  @names= keys %array2;
  for $name (@names){
	  @string1 =split('', $array1{$name});  @string2 =split('', $array2{$name});
	  @seq_position1 = @{&get_posi_sans_gaps(\$array1{$name})}; @seq_position2 = @{&get_posi_sans_gaps(\$array2{$name})};
	  $len_of_seq =(@seq_position2);  push(@whole_length, $len_of_seq);
	  @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
	  @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
	  $array3{$name}=join(",", @position_corrected1);  }
  my(%final_posi_diffs)=%{&get_each_posi_diff_hash(\%array3)}; undef(@whole_length, $len_of_seq);
  return(\%final_posi_diffs);
}



#________________________________________________________________________
# Title     : get_posi_rates_hash_out (derived from 'get_posi_shift_hash' )
# Usage     : %rate_hash = %{&get_posi_shift_hash(\%hash_msf, \%hash_jp)};
# Function  : This is to get position specific error rate for line display rather than
#             actual final error rate for the alignment.
# Example   :
# Warning   : split and join char is ','; (space)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : \%final_posi_diffs;
# Tips      :
# Argument  : %{&get_posi_rates_hash_out(\%msfo_file, \%jpo_file)};
#             Whatever the names, it takes one TRUE structral and one ALIGNED hash.
#             Output >>
#             seq1_seq2  1110...222...2222
#             seq2_seq3  1111....10...1111
#             seq1_seq3  1111....0000.0000
#
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_rates_hash_out_msf{
  my(%array1)=%{$_[0]};
  my(%array2)=%{$_[1]};
  my(@string1, @string2, @seq_position1, @seq_position2,
	  $len_of_seq,@position_diffs, @position_corrected1,
	  @names, @whole_length, %array3, $name);
  %array1 = %{&hash_common_by_keys(\%array1, \%array2)};
  %array2 = %{&hash_common_by_keys(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)};
  %array2 = %{&remov_com_column(\%array2)};
  @names= keys %array2;
  for $name (@names){
	  @string1 =split(/|\,/, $array1{$name});
	  @string2 =split(/|\,/, $array2{$name});
	  @seq_position1 = @{&get_posi_sans_gaps(\$array1{$name})};
	  @seq_position2 = @{&get_posi_sans_gaps(\$array2{$name})};
	  $len_of_seq =(@seq_position2);
	  push(@whole_length, $len_of_seq);
	  @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
	  @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
	  $array3{$name}=join(",", @position_corrected1);
  }
  my(%final_posi_diffs)=%{&get_each_posi_diff_hash(\%array3)};
  undef(@whole_length, $len_of_seq);
  # show_hash(\%final_posi_diffs);
  return(\%final_posi_diffs);
}


#________________________________________________________________________
# Title     : normalize_numbers ( from any numbers to  0 - 9 )
# Usage     : %output=%{&normalize_numbers(\%hash1)};
#             originally made to normalize the result of get_posi_rates_hash_out
#             in   'scan_compos_and_seqid.pl'
# Function  : with given numbers in hashes, it makes a scale of 0-9 and puts
#             all the elements in the scale. Also returns the average of the numbs.
# Example   : intputhash>                   Outputhash>
#             ( '1-2', '12,.,1,2,3,4',     ( '1-2',   '9,.,0,1,2,3',
#              '2-3', '12,.,1,5,3,4',       '2-3',   '9,.,0,4,2,3',
#              '4-3', '12,3,1,2,3,4',       '3-1',   '9,3,.,.,2,3',
#              '3-1', '12,4,.,.,3,4' );     '4-3',   '9,2,0,1,2,3' );
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : (\%norm_hash1, \%norm_hash2, \%norm_hash3,.... )
#
# Tips      :
# Argument  : (\%hash1, %hash2, \%hash3, ....)
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub normalize_numbers{
  my(@in)=@_;  my($split_char)=',';
  my(@out_ref_of_hash, $min, $max, $name, $u,$sum, $av, $range, @num_array,%in);
  ($min, $max, $sum, $av)=&main::hash_stat_for_all(@in);
  if(($max-$min)==0){ $range = 1} else { $range= ($max -$min) };
  for ($u=0; $u< @in ; $u++){ %in=%{$_[$u]};  my(@keys) = keys %in;
	  if($in{$keys[0]}=~/\,/){ $split_char=','; }  else { $split_char=''; };
	  for $name (@keys){  @num_array = split(/$split_char/, $in{$name});
		  for (@num_array){ $_ = int(($_ / $range)*8) if ($_ =~ /[\-]*\d+/); }
		  $in{$name}=join("$split_char", @num_array); }
	  push(@out_ref_of_hash, \%in);  }
  if( @out_ref_of_hash == 1)  {  return( $out_ref_of_hash[0]); }
  elsif( @out_ref_of_hash > 1){  return( @out_ref_of_hash   ); }
}


#________________________________________________________________________
# Title     : scan_windows_and_get_compos_seqid_rate
# Usage     : %out1 =%{&scan_windows_and_get_compos_seqid_rate(\%input, \$window_size)};
# Function  : scans input sequences(arg1) in a given(arg2) window size and gets
#             each composition and sequence identity rate of the window.
# Example   : input hash: ( seq1,  'ABCDEFG.HIK',    (2 or more sequences accepted)
#                           seq2,  'DFD..ASDFAFS',
#                           seq3,  'DDDDD..ASDFAFS' );
#             input winsize : 5;
#
#             output hash; (seq1seq2, 1,2,2,2,1,1,2,2); <-- joined by ',';
#                  The numbers are ratios(compos/seqid) with given
#                  window size.
# Warning   : when $seqid is zero  the rate becomes $compos_id/10   !!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a reference of a hash.
# Tips      :
# Argument  : One ref. for hash, one ref. for a scalar.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scan_windows_and_get_compos_seqid_rate{
  my($base_l)=1;
  my($scale)=1; # these are default params.
  my(%input)=%{$_[0]};
  my($window_size)=${$_[1]};
  if(defined(${$_[2]})){ $base_l=${$_[2]}; } ### <---$base_c is the baseline controller for sensitivity.
  if(defined(${$_[3]})){ $scale =${$_[3]}; } ### <---$base_c is the baseline controller for sensitivity.
  my(@sequences,@out_rate,$i,$title,$window_1,$window_2,$ratio_compos_vs_seqid,@array_of_2_seq,%out_hash );
  my(@keys)= keys %input;
  my($whole_rate, $whole_rate_ref ,$out_rate_arr_ref);
  for ($i=0; $i<=$#keys; $i++){
	 $sequences[$i]= $input{$keys[$i]};   }
  ($out_rate_arr_ref,$whole_rate_ref)=&get_windows_compos_and_seqid_rate_array(\@sequences,\$window_size,\$base_l,\$scale);
  @out_rate=@{$out_rate_arr_ref};  $whole_rate=${$whole_rate_ref};
  $title="CS_rate\($whole_rate\)";
  $out_hash{$title}=join(",", @out_rate);
  return( \%out_hash );
}


#________________________________________________________________________
# Title     : get_windows_cs_rate_array
# Usage     : @out_rate = @{&get_windows_cs_rate_array(\@seq, \$win_size)};
# Function  : actual working part of scan_windows_and_get_compos_seqid_rate
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : \@ratio_array, \$ratio_whole_seq
# Tips      :
# Argument  : (\@input, \$window_size);  @input => ('ABCDEFG.HIK', 'DFD..ASDFAFS', 'ASDFASDFASAS');
#             Input ar => ( 'ABCDEFG
#                'DFD..ASDFAFS'
#                'ASDFASDFASAS' )  as the name of  @sequences.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_windows_cs_rate_array{
  my(@input)=@{$_[0]};
  my($base_level)=1;
  my($scale)=1;
  my($window_size)=${$_[1]};

  if(defined(${$_[2]})){ $base_level =${$_[2]}; }   if(defined(${$_[3]})){ $scale  =${$_[3]}; }

  my(@ratio_array, @array_of_2_seq, $seq_id, $offset, $half_of_w_size, $t, $length, $w,
	  $compos_id, $seq_id, $window_2, $window_1, $compos_whole_seq, $seq_id_whole_seq,
	  $ratio_whole_seq, $win_rate_div_by_whole_rate, $normalizing_factor, $lowest_rate );

  for ($t=0; $t < @input; $t++){
	 $length=length($input[$t]) if (length($input[$t])>$length);   }

  if ($length < $window_size){  $window_size = $length;   }

	  #___________ getting ratio for the whole sequence ___________
  $compos_whole_seq=${&compos_id_percent_array(\@input)};
  $seq_id_whole_seq=${&seq_id_percent_array(\@input)};
  if ($seq_id_whole_seq == 0){  $ratio_whole_seq =$compos_whole_seq/10; }
  else{  $ratio_whole_seq =$compos_whole_seq/$seq_id_whole_seq;  }

	  #___________ getting ratio for each window sequence ___________
  for ($w=0; $w < $length; $w++){
	 $offset = $w - int($window_size/2);  # $offset starts from -5 when window_size is 10.
	 $offset=0 if ($offset < 0);
	 $window_1=substr($input[0], $offset, $window_size);  # window_1 is one segment
	 $window_2=substr($input[1], $offset, $window_size);  # of defined length(size)
	 @array_of_2_seq=($window_1, $window_2); # making an array like this = ('ABCDE', 'BDESA')
	 $compos_id=${&compos_id_percent_array(\@array_of_2_seq)};
	 $seq_id   =${&seq_id_percent_array(\@array_of_2_seq)};
  #print "\n offset = $offset Wind1 = $window_1  Wind2 = $window_2 ";
  #print " Compos1 = $compos_id  Seqid = $seq_id \n";

	 #______  Handle special case when $seqid is zero > the rate becomes $compos_id/10 ______
	 if (($seq_id == 0) && ($compos_id != 0)){ $ratio_compos_vs_seqid = $compos_id/10;   }
	 elsif(($seq_id == $compos_id)&&($seq_id == 0)){ $ratio_compos_vs_seqid = 0;}
	 elsif(($seq_id == $compos_id)&&($seq_id == 100)){ $ratio_compos_vs_seqid = 0;}
	 else{ $ratio_compos_vs_seqid=($compos_id/$seq_id); }
	 push(@ratio_array, $ratio_compos_vs_seqid);  }

  $lowest_rate = ${&min_elem_array(\@ratio_array)};

  if($lowest_rate ==0){ $normalizing_factor=1; $ratio_whole_seq=0; }else{
	 $normalizing_factor=($ratio_whole_seq/$lowest_rate);
  }

  for (@ratio_array){  # the minimum value becomes equal to the whole seq. rate.
	 $_ = int($scale*($_*$normalizing_factor - ($ratio_whole_seq*$base_level))); #<<<----
	 $_=  '^' if($_ > 9); $_=  '_' if($_ < 0);
  }

  $ratio_whole_seq=int($ratio_whole_seq);
  return( \@ratio_array, \$ratio_whole_seq);
}

#________________________________________________________________________
# Title     : read_any_seq_files  (can handle multiple input)
# Usage     : %out_seq=%{&read_any_seq_files(\$input_file_name)};
# Function  : Tries to find given input regardless it is full pathname, with or
#             without extension. If not in pwd, it searches the dirs exhaustively.
# Example   : (*out1,  *out2) =&read_any_seq_files(\$input1, \$input2);
#             : (@out_ref_array)=@{&read_any_seq_files(\$input1, \$input2)};
#             : (%one_hash_out) =%{&read_any_seq_files(\$input1)};
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : 1 ref. for a HASH of sequence ONLY if there was one hash input
#             1 array (not REF.) of references for multiple hashes.
# Tips      :
# Argument  : one of more ref. for scalar.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_any_seq_files{
  my(@out_hash_ref_list, $o, $ext );
  my(@in)=@_;
  for($o=0; $o< @in; $o++){
	 my($found, %out, @file_ext_accepted, $found_file, $sub);
	 if(ref($_[$o])){
		 @file_ext_accepted=('msf', 'fasta','jp','aln','ali','pir',
								  'slx', 'dna','fas','pdb','rms','brk', 'dssp');
		 if( !(-e ${$in[$o]} )||(-B ${$in[$o]})||(-z ${$in[$o]} ) ){
			 print "\nSUB read_any_seq_files: ${$in[$o]} no seq file exists(or not passed at all) for $0 \n\n",
			 chr(7); exit;}
		 $found_file=${&find_seq_files($in[$o])};
		 for $ext(@file_ext_accepted){ my($sub)="open\_$ext\_files";
			if($found_file =~/\.$ext$/){%out=%{&{"$sub"}(\$found_file)} if (defined &{"$sub"}); $found =1;}}
		 if($found==0){ my($sub)="open\_$ext\_files"; #<--- this is the last resort !!
			for $ext(@file_ext_accepted){%out=(%out, %{&{"$sub"}(\$found_file)}) if (defined &{"$sub"});}}}
		 elsif(!(ref($_[$o]))){ print "\nread_any_seq_files in $0 files accepts only REFERENCES\n\n"; exit;}
	  push(@out_hash_ref_list, \%out);
  }
  if(@out_hash_ref_list == 1){  ### If only single hash output is,
	  return($out_hash_ref_list[0]);
  }elsif( @out_hash_ref_list > 1){
	  return(@out_hash_ref_list);   # <-- contains (\%out_seq0, \%out_seq1, \%out_seq2, .... )
  }
}


#________________________________________________________________________
# Title     : seq_to_regexp
# Usage     :
# Function  : given an array and a start and end length,
#              return an array of regular expressions, where each element of the original
#              array has been expanded to a set of regular expressions that match the
#              original exactly num times, for num between the start and end length
#
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub seq_to_regexp{
  my($num1,$num2,@seq) = @_;
  my($begin,$char,$num,$new,@output,$seen,$seq,@splitseq,$template);

  $template = '(BEGIN)(SEQUENCE){NUMBER}(END)';
  foreach $seq (@seq) {
	 @splitseq = reverse(split('',$seq));
	 $begin = '^';
	 $seen = '';
	 foreach $char (@splitseq) {
		$begin =  $begin . '|[^' . $char . ']' . $seen;
		$seen .= $char;
	 }
	 @splitseq = split('',$seq);
	 $end = '$';
	 $seen = '';
	 foreach $char (@splitseq) {
		$end = $end . '|' . $seen . '[^' . $char . ']';
		$seen .= $char;
	 }
	 for($num = $num1; $num <= $num2 ; $num++) {
		$new = $template;
		$new =~ s/BEGIN/$begin/e;
		$new =~ s/END/$end/e;
		$new =~ s/SEQUENCE/$seq/eg;
		$new =~ s/NUMBER/$num/eg;
		push(@output,$new);
	 }
  }
  \@output;
}
#________________________________________________________________________
# Title     : strip_rotated_seq
# Usage     :
# Function  : remove all but one string of each set of rotations
#             (reverse of rotated_seq )
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub strip_rotated_seq{
  my(@input) = @_;
  my(@output,%output,@rotations,$string);
  foreach $string (@input) {
	 @rotations = @{&rotate_seq($string)};
	 if( ! grep($output{$_},@rotations) ) {
		push(@output,$string);
		$output{$string} = 1;
	 }
  }
  \@output;
}
#________________________________________________________________________
# Title     : rotate_seq
# Usage     : @out_array=@{&rotate_seq($string)};
# Function  : given a string, return all the rotations of that string
#             e.g. given 'abcd', return ('abcd','bcda','cdab','dabc')
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall   ##### RevCom
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for reverse complement
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rotate_seq{
  my($string) = @_;
  my($i, $length, @rotations);

  $length = length($string);
  push(@rotations,$string);
  for($i = 1 ; $i < $length ; $i++ ) {
	 $string =~ s/^(.)(.*)/$2$1/;
	 push(@rotations, $string);
  }
  \@rotations;
}


#________________________________________________________________________
# Title     : convert_to_anti_sense
# Usage     :
# Function  :
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall   ##### RevCom
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for reverse complement
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_to_anti_sense{
  my($seq)=@_;
  $seq =~ tr/acgtrymkswhbvdnACGTRYMKSWHBVDN/tgcayrkmswdvbhnTGCAYRKMSWDVBHN/;
  scalar reverse $seq;
  \$seq;
}
#________________________________________________________________________
# Title     : convert_rna_to_protein
# Usage     :
# Function  : translate RNA seq to protein seq.
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for protein translation
# Tips      :
# Argument  : a scalar for RNA sequence data
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_rna_to_protein{			##### RnaToProtein
  my($seq) = @_;
  my($i,$len,$output) = (0,0,'');
  my($codon);
  for($len=length($seq),$seq =~ tr/a-z/A-Z/,$i=0; $i<($len-2) ; $i+=3) {
	 $codon = substr($seq,$i,3);
	 if   ($codon =~ /^UC/)     {$output .= 'S'; }	# Serine
	 elsif($codon =~ /^UU[UC]/) {$output .= 'F'; }	# Phenylalanine
	 elsif($codon =~ /^UU[AG]/) {$output .= 'L'; }	# Leucine
	 elsif($codon =~ /^UA[UC]/) {$output .= 'Y'; }	# Tyrosine
	 elsif($codon =~ /^UA[AG]/) {$output .= '_'; }	# Stop
	 elsif($codon =~ /^UG[UC]/) {$output .= 'C'; }	# Cysteine
	 elsif($codon =~ /^UGA/)    {$output .= '_'; }	# Stop
	 elsif($codon =~ /^UGG/)    {$output .= 'W'; }	# Tryptophan
	 elsif($codon =~ /^CU/)     {$output .= 'L'; }	# Leucine
	 elsif($codon =~ /^CC/)     {$output .= 'P'; }	# Proline
	 elsif($codon =~ /^CA[UC]/) {$output .= 'H'; }	# Histidine
	 elsif($codon =~ /^CA[AG]/) {$output .= 'Q'; }	# Glutamine
	 elsif($codon =~ /^CG/)     {$output .= 'R'; }	# Arginine
	 elsif($codon =~ /^AU[UCA]/){$output .= 'I'; }	# Isoleucine
	 elsif($codon =~ /^AUG/)    {$output .= 'M'; }	# Methionine
	 elsif($codon =~ /^AC/)     {$output .= 'T'; }	# Threonine
	 elsif($codon =~ /^AA[UC]/) {$output .= 'N'; }	# Asparagine
	 elsif($codon =~ /^AA[AG]/) {$output .= 'K'; }	# Lysine
	 elsif($codon =~ /^AG[UC]/) {$output .= 'S'; }	# Serine
	 elsif($codon =~ /^AG[AG]/) {$output .= 'R'; }	# Arginine
	 elsif($codon =~ /^GU/)     {$output .= 'V'; }	# Valine
	 elsif($codon =~ /^GC/)     {$output .= 'A'; }	# Alanine
	 elsif($codon =~ /^GA[UC]/) {$output .= 'D'; }	# Aspartic Acid
	 elsif($codon =~ /^GA[AG]/) {$output .= 'E'; }	# Glutamic Acid
	 elsif($codon =~ /^GG/)     {$output .= 'G'; }	# Glycine
	 else {print " unrecognized codon $codon ";}
  }
  return \$output;
}
#________________________________________________________________________
# Title     : write_staden_file
# Usage     :
# Function  :
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for  STADEN formatted sequence record
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_staden_file {				##### PutStaden
  my($seq,$header,$id) = @_;
  my($i,$j,$len,@out);
  $i = 0;
  $len = length($seq);
  $out[$i] = ";\<------------------\>\n";
  substr($out[$i],int((20-length($ID))/2),length($ID)) = $ID;
  $i++;
  for($j=0; $j<$len ; $j+=60) {
	 $out[$i++]=sprintf("%s\n",substr($seq,$j,60));
  }
  return \@out;
}


#________________________________________________________________________
# Title     : write_primer_file
# Usage     :
# Function  :
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for PRIMER formatted sequence record
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_primer_file {	my($seq,$header,$id) = @_; my(@out,$len,$i,$j); $i = 0;
  $out[$i++] = sprintf("*seq: %8s\n", $id);
  $out[$i++] = sprintf("%s", length($header) > 8 ? "# ".$header."\n" : "");
  $out[$i++] = sprintf("%s", $id ? "# ". $id."\n" : "");
  $len = length($seq);
  for($j = 0 ; $j < $len ; ) {
		$out[$i] .= sprintf("%s",substr($seq,$j,10));  $j += 10;
		if($j < $len && $j % 50 != 0 ) {  $out[$i] .= " ";}
		elsif($j % 50 == 0 ) { $out[$i++] .= "\n"; } }
  if($j % 50 != 0 ) { $out[$i] .= "\n"; }
  return \@out;
}

#________________________________________________________________________
# Title     : write_gcg_genbank_file
# Usage     :
# Function  :
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for GCG-Genbank formatted sequence record
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_gcg_genbank_file {			##### PutGcgGenbank
  my($seq,$header,$id) = @_;
  my(@out,$len,$sum,$cnt,$i,$j);
  $len = length($seq);
  for($i=0; $i<$len ;$i++) {
	 $cnt++;
	 $sum += $cnt * ord(substr($seq,$i,1));
	 ($cnt == 57) && ($cnt=0);
  }
  $sum %= 10000;
  push(@out,"LOCUS $id\n");
  push(@out,"DEFINITION $header\n");
  push(@out,"ACCESSION $Accession\n");
  push(@out,"ORIGIN\n\n");
  push(@out," $id Length: $len (today)  Type: N Check: $sum  ..\n\n");
  $len = length($seq);
  $i = $#out + 1;
  for($j = 0 ; $j < $len ; ) {
	 if( $j % 50 == 0) {
		$out[$i] = sprintf("%8d  ",$j+1);
	 }
	 $out[$i] .= sprintf("%s",substr($seq,$j,10));
	 $j += 10;
	 if( $j < $len && $j % 50 != 0 ) {
		$out[$i] .= " ";
	 }elsif($j % 50 == 0 ) {
		$out[$i++] .= "\n";
		$out[$i++] = "\n";
	 }
  }
  if($j % 50 != 0 ) {
	 $out[$i] .= "\n";
  }
  $out[$i] .= "\n";
  return \@out;
}
#________________________________________________________________________
# Title     : write_pir_file
# Usage     :
# Function  :
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             from Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for PIR formatted sequence record
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_pir_file {				##### PutPir
  my($seq, $header) = @_;
  my(@out,$len,$i,$j,$cnt,$sum);
  $seq=~s/[\n ]//g;
  $len = length($seq);
  for($i=0; $i< $len ;$i++) {
	 $cnt++;
	 $sum += $cnt * ord(substr($seq,$i,1));
	 ($cnt==57) && ($cnt=0); }
  $sum %= 10000;  $i = 0;
  $out[$i++] = sprintf("ENTRY           %s\n",$id);
  $out[$i++] = sprintf("TITLE           %s\n",$header);
  #JDT ACCESSION out if defined
  $out[$i++] = sprintf("DATE            %s\n",'');
  $out[$i++] = sprintf("REFERENCE       %s\n",'');
  $out[$i++] = sprintf("SUMMARY         #Molecular-weight %d  #Length %d  #Checksum %d\n",0,$len,$sum);
  $out[$i++] = sprintf("SEQUENCE\n");
  $out[$i++] = sprintf("                5        10        15        20        25        30\n");
  for($j=1; $seq && $j < $len ; $j += 30) {
	 $out[$i++] = sprintf("%7d ",$j);
	 $out[$i++] = sprintf("%s\n", join(" ",split(//,substr($seq, $j - 1,length($seq) < 30 ? length($seq) : 30))) );
  }
  $out[$i++] = sprintf("///\n");
  return \@out;
}
#________________________________________________________________________
# Title     : write_genbank_file
# Usage     : @out =  @{&write_genbank_file($sequ, $header)};
# Function  : (This is DNA seq handling routine!)
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
#             stolen from Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for Genbank formatted sequence record
# Tips      :
# Argument  : two scalars.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_genbank_file{	my($seq,$header,$id) = @_; my(@out,$len,$i,$j,$cnt,$sum);
  $seq =~ tr/A-Z/a-z/;  $seq =~s/[ \n]//g;  $len = length($seq);
  for($i=0; $i<$len ;$i++) {
	 $cnt++;
	 $sum += $cnt * ord(substr($seq,$i,1));
	 ($cnt == 57) && ($cnt=0);  }
  $sum %= 10000;
  $i = 0;
  $out[$i++] = sprintf("LOCUS       %s       %d bp\n",$id,$len);
  $out[$i++] = sprintf("DEFINITION  %s , %d bases, %d sum.\n", $header, $len, $sum);
  $out[$i++] = sprintf("ACCESSION  %s\n", $Accession);
  $out[$i++] = sprintf("ORIGIN\n");
  for($j = 0 ; $j < $len ; ) {
		if( $j % 60 == 0) {
		  $out[$i] = sprintf("%8d  ",$j+1);
		}
		$out[$i] .= sprintf("%s",substr($seq,$j,10));
		$j += 10;
		if( $j < $len && $j % 60 != 0 ) {
		  $out[$i] .= " ";
		}elsif($j % 60 == 0 ) {
		  $out[$i++] .= "\n";
		}
  }
  if($j % 60 != 0 ) { $out[$i] .= "\n"; }
  $out[++$i] = sprintf("//\n");
  return \@out;
}
#________________________________________________________________________
# Title     : write_gcg_file
# Usage     :
# Function  :
# Example   :
# Warning   : Copyright (C) 1993-1994 by James Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of an array for GCG formatted sequence record
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_gcg_file {
  my($seq, $header,$id) = @_;
  my(@out,$len,$i,$j,$cnt,$sum);
  $seq=~s/[ \n]//g;
  $len = length($seq);
  for($i=0; $i<$len ;$i++) {
	 $cnt++;
	 $sum += $cnt * ord(substr($seq,$i,1));
	 ($cnt == 57)&& ($cnt=0);
  }
  $sum %= 10000;
  $i = 0;
  $out[$i++] = sprintf("%s\n",$header);
  $out[$i++] = sprintf("    %s Length: %d (today)  Check: %d  ..\n", $id, $len, $sum);
  $len = length($seq);
  for($j = 0 ; $j < $len ; ) {
		if( $j % 50 == 0) {
		  $out[$i] = sprintf("%8d  ",$j+1);
		}
		$out[$i] .= sprintf("%s",substr($seq,$j,10));
		$j += 10;
		if( $j < $len && $j % 50 != 0 ) {
		  $out[$i] .= " ";
		}elsif ($j % 50 == 0 ) {
		  $out[$i++] .= "\n";
		}
  }
  if($j % 50 != 0 ) {
	  $out[$i] .= "\n";
  }
  return (\@out);
}
#________________________________________________________________________
# Title     : write_fasta_array
# Usage     : @output = @{&put_fasta($sequence, $name)};
# Function  : take Single sequence and produce single output array of fasta
# Example   : @out = (
#             $out[0] =>     ">name",
#             $out[1] =>     "ABCDEABCDEBCDEABCDEABCDEABCDEABCDEBCDEABCDE",
#             $out[2] =>     "TTTTTTTTDEBCDEABCDEABCDEABCDEABCDEBCDEABCDE",
#             $out[3] =>     "ABCDEABCDEBCDEABCDEABCDEABCDEABCDEBCDEABCDE",
#                 );
#
# Warning   : Copyright (C) 1993-1994 by James Tisdall
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : ref. for an array of FASTA formatted sequence record
#
# Tips      :
# Argument  : \%input
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_fasta_array {
  my(%input) = %{$_[0]}; my($seq)=values(%input);
  my($key)=keys(%input); my(@out,$len, $i, $j); $seq=~s/\n//g; $i = 0;
  $out[$i++] = ">" . $key . "\n";
  for($j=0; $j< length($seq) ; $j += 60) {
	 $out[$i++]= sprintf("%.60s\n", substr($seq,$j,60));  }
  \@out; # ref. is slightly faster  2.973 vs 2.985
}

#________________________________________________________________________
# Title     : find_seq_files
# Usage     : $found_file = ${&find_seq_files(\$input_file_name)};
# Function  : (similar to find.pl) used in 'read_any_seq_file.pl'
#             seeks given test file in pwd, specified dir, default path etc.
#             If not found yet, it looks at all the subdirectories of path and pwd.
#             PATH environment dirs, then returns full path file name.
# Example   : $found_file=${&find_seq_files(\$input_file_name)};
# Warning   :
# Class     :
# Keywords  : find_anyj_seq_files, find any seq files, find seq files
# Options   :
# Package   :
# Reference :
# Returns   : return( \$final );
# Tips      :
# Argument  : (\$input_file_name) while $input_file_name can be  'xxx.xxx', or '/xxx/xxx/xxx/xxy.yyy'
#             or just directory name like 'aat' for  /nfs/ind4/ccpe1/people/A Biomatic /jpo/align/aat
#             then, it tries to find a file with stored seq file extensions like msf, jp, pir etc
#             to make aat.msf, aat.jp, aat.pir ... and searches for these files.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub find_seq_files{
  my($final, $no_ext_file, $result); my($in_file)=${$_[0]}; my($pwd)=`pwd`; chomp($pwd);
  my( $base, @ENV_dir, $ext, @probable_dir_list, $directory);
  my(@extension_db)=('sst','msf','fasta','jp','fas','aln','brk','pdb', 'rms', 'ent','slx','fa');
  my(@probable_dir_list)=('JPO','ALIGN','PATH','HOME','PIRDIR','PWD','PDBSST','PDBENT','BLASTDB','PIRDIR','SWDIR','PDB');
	if(($in_file=~/\//)&&(-e $in_file)){ $final=$in_file; }
	elsif((-e $in_file)&&(-s $in_file)&&($in_file !~/\//)){ $in_file="$pwd\/$in_file"; $final=$in_file;}
	######## if it was like  '/nfs/ind4/ccpe1/people/A Biomatic /perl.msf'
	elsif($in_file =~ /\/([\w\-\.]+)$/){ $in_file = $1;
		  if(-e $in_file){ $final = "$pwd\/$in_file"; }
		  #### if it has xxxxxx.xxxx  file form. #######
		  elsif($in_file =~ /(([\w\-]+)\.([\w\-]+))$/){ $file=$1; $base=$2; $ext=$3;
				for (@extension_db){ if($_ eq $ext){ shift(@extension_db);}}
				unshift(@extension_db, $ext);
				for (@probable_dir_list){ if($ENV{$_}=~ /\/$/){chop($ENV{$_});}
					push( @ENV_dir, split(/:/, $ENV{$_}));}
					for $dir (@ENV_dir){ $in_file="$dir\/$file";
						if ((-e $in_file) && (-s $in_file)){  $final=$in_file; last;}
						else{
							 for $ext (@extension_db){ $in_file="$dir\/$base\.$ext";
								  if ((-e $in_file) && (-s $in_file)){
									  if ($file =~  /$in_file/){ $final = $in_file; last;}}}}}
					unless(defined ($final)){
						for $dir (@ENV_dir){ $in_file= ${&search_files_in_subdir(\$dir, \$file)};
							 if(-e $in_file){ $final=$in_file; last; }}}}

			### if it has  xxxxxx   file form, ie. not extension #######
			elsif($in_file =~/\/([\w_\-]+)$/){  $base = $1;
			  for (@extension_db){
				 if($_ eq $ext){ shift(@extension_db);  }
				 unshift(@extension_db, $ext);
				 for (@probable_dir_list){
					if ($ENV{$_} =~ /\/$/){  chop($ENV{$_}); }
					push( @ENV_dir, split(/:/, $ENV{$_}) );
					for $dir (@ENV_dir){ $no_ext_file="$dir\/$base";
						 if((-e $no_ext_file) && (-s $no_ext_file)){ $final=$no_ext_file; last;}
						 else{
							for $ext (@extension_db){ $in_file ="$dir\/$base\.$ext";
								if ((-e $in_file) && (-s $in_file)){ $final = $in_file; last;}}}}}}}}

	 #### when the input was like this  'perl.msf'  in any directory.
	 elsif($in_file =~ /^(([\w\-]+)\.([\w\-]+))$/){ $file=$1; $base=$2; $ext=$3;
		  for (@extension_db){ if($_ eq $ext){ shift(@extension_db);}}
		  unshift(@extension_db, $ext);
		  for (@probable_dir_list){ if($ENV{$_}=~ /\/$/){chop($ENV{$_});}
			  push( @ENV_dir, split(/:/, $ENV{$_}));}
			  for $dir (@ENV_dir){ $in_file="$dir\/$file";
				  if ((-e $in_file) && (-s $in_file)){ $final=$in_file; last;}
				  else{
						for $ext (@extension_db){ $in_file="$dir\/$base\.$ext";
							 if ((-e $in_file) && (-s $in_file)){
								 if ($file =~  /$in_file/){ $final = $in_file; last;}}}}}
			  unless(defined ($final)){
				  for $dir (@ENV_dir){ $in_file= ${&search_files_in_subdir(\$dir, \$file)};
						if(-e $in_file){ $final=$in_file; last; }}}}
	 #### when the input was like this  'hemocyan'  in any directory.
	 elsif($in_file =~ /^([\w\-]+)$/){ $file=$1;
		  for (@probable_dir_list){ if($ENV{$_}=~ /\/$/){chop($ENV{$_});}
			  push( @ENV_dir, split(/:/, $ENV{$_}));}
			  for $dir (@ENV_dir){ $in_file="$dir\/$file";
				  if ((-e $in_file) && (-T $in_file)){  $final=$in_file; last;}
				  else{
						for $ext (@extension_db){ $in_file="$dir\/$file\.$ext";
							 if ((-e $in_file) && (-s $in_file)){
								 if ($file =~  /$in_file/){ $final = $in_file; last;}}}}}
			  unless(defined ($final)){
				  for $dir (@ENV_dir){ $in_file= ${&search_files_in_subdir(\$dir, \$file)};
						if(-e $in_file){ $final=$in_file; last; }}}}
	END_POINT:
	return( \$final );
}
#________________________________________________________________________
# Title     : search_files_in_subdir
# Usage     :
#                     $inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
# Function  : open dir and process all files in the dir if you wish,
#             and then go in any other sub
#             if any file(dir) is linked, it skips that file.
# Example   :
# Warning   : the final var $found_from_search_files_in_subdir mustn't be 'my'ed.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets a ref. of a scaler (dir name) and returns nothing(void).
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub search_files_in_subdir{ package search_files_in_subdir;
	$original_dir=${$_[0]}; my($target_file)=${$_[1]};
	my(@read_files)=@{&main::read_any_dir(\$original_dir)};
	print "\n Searching files... , wait or kill me !\n";
	for $file(@read_files){ $realfile1= "$original_dir\/$file";
	  if (-l $realfile1){ next; }
	  elsif (-d $realfile1){ &main::search_files_in_subdir(\$realfile1, \$target_file); }
	  elsif (-f $realfile1){ @split =split(/\//, $realfile1); my($f) = $split[$#split];
		  if($target_file eq $f){ $found_from_search_files_in_subdir =$realfile1;
		  print chr(007); last;}}
	  else{ next; }  }
	return(\$found_from_search_files_in_subdir);
	last;
	package main;
}

#________________________________________________________________________
# Title     : find_seq_file_old (similar to find.pl) used in 'read_any_seq_file.pl'
# Usage     : $found_file=${&find_seq_file_old(\$input_file_name)};
# Function  : seeks text file in pwd. If not found it looks at
#             PATH environment dirs
# Example   :
# Warning   : << This is READABLE old version of  find_seq_file
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. for SCALAR of a full path filename.
# Tips      :
# Argument  : one ref. for SCALAR
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub find_seq_file_old{ # This returns full path file name.
	 my($in_file)=${$_[0]};      my($pwd)=`pwd`; chomp($pwd);
	 if ((-T $in_file) && (-s $in_file) && ($in_file=~/\//))
	 { # If Text, with Size and full path filename.
		  return (\$in_file);
	 }
	 elsif((-T $in_file)&&(-s $in_file)&&($in_file !~ /\//))
	 { # if it is a Text, with size and not full path filename,
		  $in_file="$pwd\/$in_file";
		  return (\$in_file);
	 }
	 elsif(($in_file =~ /\/([\w\-\.]+)$/) && (!(-e $in_file)))
	 {  # This is to handle when wrong full path filename is given, but the filename
		 $in_file=$1;                                            # exists in pwd
		 if ((-T $in_file) && (-s $in_file)){
			 $in_file="$pwd\/$in_file";
			 return (\$in_file);
		 }
	 }
	 #------- When the search fails in pwd with either fullpath and simple filename.
	 else{   # now STDOUT
		print "\n\n Your $in_file was not found in pwd, so I am searching it\n";
		print "\n To stop press Ctrl + c \n\n";
		print "This takes time as I search PATH with different extensions of the file\n";
		# 1. Search in the ENV directories
		# 2. change the extension and check if it is in.
		my($found_seq_file, $base, $ext, @ENV_dir, @probable_dir_list, $directory);
		if ($in_file =~/([\w_\-]+)\.([\w\-]+)$/){
		  $base = $1; $ext =$2;
		}elsif($in_file =~/([\w_\-]+)$/){
		  $base = $1;
		}
		my(@extension_db)=('msf','jp','jpo','aln','sst','fa','fasta','rms',
											'slx','fas','pdb','brk','ent');
		for (@extension_db){
		  if($_ eq $ext){
		  shift(@extension_db);  last;
		}
	 }
	 unshift(@extension_db, $ext);
	 @probable_dir_list=('PATH', 'HOME', 'JPO', 'PIRDIR', 'PDB', 'PDBENT');
	 for (@probable_dir_list){
		 if ($ENV{$_} =~ /\/$/){  # if any dir ends with '/', chops if off
			chop($ENV{$_}); }
		 push( @ENV_dir, split(/:/, $ENV{$_}) );
	 }
	 for $dir (@ENV_dir){
		if ($dir=~/\//){
			for $ext (@extension_db){
			  $in_file ="$dir\/$base\.$ext";
			  print "Searching $in_file\n";
			  if ((-T $in_file) && (-s $in_file)){
				  print "\n\n I found $in_file in $dir \n\n"; print chr(7);
				  print "  If it is the file you want rerun $0 with it\n\n\n";
				  $found_seq_file = $in_file;
			  }
			}
		}#if($dir=~/\//)
	 }
	 return( \$found_seq_file);
  }#<< end of  else-------------------
}

#________________________________________________________________________
# Title     : open_sst_files_with_gap  (but reads jp file as an input, too!!!)
# Usage     : %out_sst_hash =%{&open_sst_files_with_gap(\$jp_file_dir_and_name)};
# Function  : gets the name of a file(jp file) with its absolute dir path
#             reads the sequence names in the jp file and looks up all
#             the sst files in the same directory. Puts sst sequences
#             in a hash with keys of sequence names.
#
# Example   : jp file  ==  seq1 ABDSF--DSFSDFS   <- true sequence
#                              seq2 T--kdf-GAGGGASF     (aligned)
#
#                 sst files ==> 'seq1.sst', 'seq2.sst' (in the same dir)
#
#             original sst format:  seq1 hHHHHHttEEEE  <-- No gaps!
#                                  seq2 hHHHHHHEEhh
#             After this sub ==>
#             (final out hash =   (  seq1 hHHHH--HttEEEE  <-- inserted
#                                  seq2 h--HHH-HHHEEEhh  )     gaps
#
# Warning   : $jp_file_dir_and_name should be absolute dir and file name
#             >> This gets JP file not SST file as input !!!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for a hash
# Tips      :
# Argument  : a ref. for scaler of "jp file name"
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_sst_files_with_gap{   # This automatically determines MSF or JP format
  my(%seq_file, $sst_file, %secondary_struc, @keys, $directory);
  %seq_file = %{read_any_seq_files($_[0])};
  ######  Simple reading in of SST files ------------
  ######  Simple reading in of SST files ------------
  for $seq_name (keys %seq_file){
	  $sst_file ="$seq_name\.sst";
	  print $sst_file;
	  %secondary_struc =( %secondary_struc, %{&read_any_seq_files(\$sst_file)});
  }
  print %secondary_struc;
  ### Now we have  1. %jp_file  and  2. %out_sst_seq_hash  -------
  if (!(defined(%secondary_struc))){
	  return(\%seq_file);
  }else{
	 %gap_corrected_out=%{&put_gaps_in_hash(\%seq_file, \%secondary_struc)};
	 return( \%gap_corrected_out );
  }
}

#________________________________________________________________________
# Title     : put_gaps_in_hash  (The order of input hashes DOES matter, in the end)
# Usage     : %out=%{&put_gaps_in_hash(\%hash_with_gap, \%hash_sans_gap)};
#
#             %hash1=('1ctx',  '111111111111111',      <-- hash input without gaps
#             '2ctx',  '2222222222222222',
#             '3ctx',  '3333333333');
#
#             %hash2=('1ctx',  'AAA--AAAAAAAAAAAA-',   <-- hash input with template gaps
#             '2ctx',  'BBBBBBBBBBBB-BBBB',
#             '3ctx',  'CCCCCC----CCCC');
#
#             >> resulting out hash;
#
#             %hash3=('1ctx',     '111--111111111111-',
#             '2ctx',     '222222222222-2222',
#             '3ctx',     '333333----3333 );
#
# Function  :
# Example   :
# Warning   : The keys for hashes should be the same and the two sequences
#             should be identical.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one hash reference.
# Tips      :
# Argument  : 2 hash references.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub put_gaps_in_hash{
  my($temp0)= values %{$_[0]};  # finds the hash with gaps
  my($temp1)= values %{$_[1]};  # and assigns to right input hash.
										  # above puts the first values to $temp0 & 1
  if (($temp0=~/\-/)||($temp0=~/\./)){  # compares the leng of the first
	 %hash_gap = %{$_[0]};               # values of hashes and assigns
			%hash_sans_gap=%{$_[1]};            # accordingly.
  }elsif(($temp1=~/\-/)||($temp1=~/\./)){
	 %hash_gap     =%{$_[1]};
	 %hash_sans_gap=%{$_[0]};
  }else{
	 %hash_gap     =%{$_[0]};  # If it can not determine input type, it assumes
	 %hash_sans_gap=%{$_[1]};  # that the first one was for gap, the 2nd for secondary.
  }                           # structure or whatever.
  my(@keys)=sort keys (%hash_gap);
  my($gap_char) = '-';  #  default gap_char is  '-'
  my(@string1, @string2, @gap_pos, %out_hash, $gapped_string, $res);

  if ($hash_gap{$keys[0]}=~/\-/){
	 $gap_char = '-';
  }elsif($hash_gap{$keys[0]}=~/\./){
	 $gap_char = '.';
  }
  ########## Actual exchange part ############
  for (@keys){
	 @string1 = split('', $hash_gap{$_});
	 @string2 = split('', $hash_sans_gap{$_});
	 for ($t=0; $t <=$#string1; $t++){
		  $res=$string1[$t];
		  if(($res =~ /\-/)||($res =~ /\./)||($res =~ /\s/)){
			  splice(@string2, $t, 0, $gap_char);
		  }
	 }
	 $gapped_string = join("", @string2);
	 $out_hash{$_}= $gapped_string;
  }
  \%out_hash;
}

#________________________________________________________________________
# Title     : get_gap_positions
# Usage     : @gap_pos=@{&get_gap_positions(\@string1)};
# Function  : gets gap positions of seq. and stores in an array
# Example   :
# Warning   : uses References.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : 1 ref. of array eg)=(2,3,7,8,10,100,122);
# Tips      :
# Argument  : 1 ref. of array eg)=( ABCDE--EF--GH ) while '-' is for gap.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_gap_positions{ my(@seq_array)=@{$_[0]}; my($res, @gap_posi);
  for ($i=0; $i <= $#seq_array; $i++){ $res=$seq_array[$i];
	 if (($res =~ /\-/)||($res =~ /\./)||($res =~ /\s/)){
		 push (@gap_posi, $i); }	}
  \@gap_posi;
}
#________________________________________________________________________
# Title     : make_pairs_from_hash
# Usage     : @output =@{&make_pairs_from_hash(\%input_sequence_hash);
#             Input example
#             %input =  seq1  ABCDEFAD
#              seq2  SDFSFSDF
#              seq3  SDFSFSDF
#
# Function  : returns all the possible pairs of a set of sequences in
#             an array of references;
#
# Example   : @output=($ref1, $ref2, ....$refn)
#             each $ref is the reference of a hash of a pair of sequence
#             >>  %pair1 = %{$ref1}; %pair2 = %{$ref2}; %pair3 = %{$ref3};
#
#             %pair1 is like;       %pair1 is like;       %pair3 is like;
#
#             seq1  ABCDEFAD     seq1  ABCDEFAD        seq2  SDFSFSDF
#             seq2  SDFSFSDF     seq3  SDFSFSDF        seq3  SDFSFSDF
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array for references for hashes.
# Tips      :
# Argument  : one ref. of hash
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub make_pairs_from_hash{  # making sub sequences from a mother sequence
  my(%input)=%{$_[0]};        # <-- actual sequence input
  ### make all pairs from the input sequencs  ####
  my(@keys)= keys %input;  my(@resultant_references);  my(%temp_hash);
  for ($i=0; $i <=$#keys; $i++){
	 for ($j=$i+1; $j <=$#keys ; $j++){
		${"$keys[$i]\_$keys[$j]"}{$keys[$i]} =  $input{$keys[$i]};
		${"$keys[$i]\_$keys[$j]"}{$keys[$j]} =  $input{$keys[$j]};
		%temp_hash = %{${"$keys[$i]\_$keys[$j]"}{$keys[$j]}};
		push(@resultant_references, \%temp_hash);
	 }
  }
  \@resultant_references;  # the size of the array varies according to input
}
#________________________________________________________________________
# Title     : mail_it
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub mail_it{
#  open (MAIL, "|$sendmail_path $recipient") || die $!";
  #write (MAIL);
#
}


#________________________________________________________________________
# Title     : read_fssp_files
# Usage     : %anyarray = %{&read_fssp_files(\$any_sequence_file_fssp_form)};
# Function  : read hssp file and put sequences in a hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   : read_fssp_files.pl, th_lib.pl,
# Enclosed  :
#--------------------------------------------------------------------
sub read_fssp_files{
	 my($input_file)=${$_[0]};	 # $_[0]=>input eg. $dir.$out_seq_no.hssp
	 my(%out_hash, $no_of_seq, $seq_from, $seq_to, $char,
		 @names, $flag1, $flag, $original_string, $length_string,
		 @residues_in_the_line
	 );

	 unless (-e $input_file){
		 print chr(7);		     # beep warning for error
		 print "\n\n\t This is sub read_hssp_file  in th_lib.pl \n\n";
		 print "\n\n\t Fatal: The input file $file1 is not in the directory \n";
		 print "\n\n\t  !!! Program dies abnormally, bugs !!! \n";
		 &caller_info; print "\n"; exit;  # &caller_info is in th_lib.pl
	 }

	 open(FILE_1, "$input_file"); # reading in (hssp)
	  ############## READING ######################
	  while(<FILE_1>){
		 if((/^\#\# SUMMARY/)||(/  NR. STRID1/)){
			 next;
		 }
		 if (/\d+: \w+ +([\w_\-]+) +/){    # matching the structure names
			 push(@names, $1);         # @names are the names of structural sequences;
			 next;                     # do not need to look at further.
		 }
		 if(/\#\# ALIGNMENTS\s+(\d+)\s+\-\s+(\d+)/){
			 @residues_in_the_line=();
			 $seq_from=$1-1;  # to offset $seq_from to match array counting method later
			 $seq_to  =$2-1;
			 $flag2 =1;
			 next;
		 }
		 if((/^SeqNo PDBNo/)||(/^\s\s\s\s\s\s\s\s\s\s\s\s\s\s+/)){
			 next;
		 }
		 if(/^\#\# EQUIVALENCES/){
			 last;
		 }
		 $original_string=substr($_, 42) if ($flag2==1);  # assign from chars from 43(position) to the end
		 chomp($original_string);                         # removes new line at the end.
		 $length_string = length($original_string);
		 for ($i=0; $i < $length_string; $i+=3){   # note that >>> $i+=3;
			$char=substr( $original_string, $i, 1);
			push(@residues_in_the_line, $char) unless ($char=~/[ \t]/);  # There was spaces in the last seq part.
		 }                                                              #  I am removing them.
		 for ($i=$seq_from; $i <= $seq_to; $i++){
			$out_hash{$names[$i]}.=shift(@residues_in_the_line);
		 }
	 }
	 \%out_hash;
}

#________________________________________________________________________
# Title     : get_posi_shift_rms_whole
# Usage     : just type   get_posi_shift_rms_whole.pl
# Function  :
# Example   : (0.284994272623139   0.166781214203895)
#             The first figure is for error rate with out rms consideration
#             The second is for after applying threshold.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : two refs. of scalar values (rates)
# Tips      :
# Argument  : takes 2 refs. of scalars for dir name (protein group name)
#             and threshold for rms
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_shift_rms_whole{
  my($group)    =${$_[0]};  #<---- for group name
  my($threshold)=${$_[1]};  #<---- for threshold
  my($input1) = "/nfs/ind4/ccpe1/people/A Biomatic /jpo/align/$group/$group\.msf";
  my($input2) = "/nfs/ind4/ccpe1/people/A Biomatic /jpo/align/$group/$group\.jp";
  my($input3) = "/nfs/ind4/ccpe1/people/A Biomatic /jpo/align/$group/$group\.rms";
  if($#_ < 1){ $threshold = 6; } # default is $threshold = 6
  my($average_rate2, $average_rate1, %array3);
  my(%array1)=%{&open_msf_files(\$input1)}; my(%array2)=%{&open_jp_files(\$input2)}; my(%array3);
  if (!(-e $input3)){
		  $average_rate1 = ${&get_posi_shift_hash(\%array1, \%array2)};
		  $average_rate2=$average_rate1; }
  else{ %array3=%{&open_rms_files(\$input3)};
		  ($rate_ref_1, $rate_ref_2) = &get_posi_shift_rms_hash(\%array1, \%array2, \%array3, \$threshold);
		  $average_rate1=${$rate_ref_1};  $average_rate2=${$rate_ref_2};  }
  return(\$average_rate1, \$average_rate2);
}
#________________________________________________________________________
# Title     : write_jp  (essentially the same as print_seq_in_block)
# Usage     : &write_jp(\%input_hash1,\%input_hash2, \%input_hash3.... );
# Function  : gets a ref(s) for hash and prints the content in lines of 60 char
# Example   :
# Warning   : derived from  print_in_block
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : Nothing, i.e. STDOUT
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_jp{
  my(%input)=%{$_[0]};
  my(@names)=keys(%input);
  my($larg, $offset, $diff, $gap_char);
  $gap_char='-';  # <-- setting default gap character.
  for ($i=0; $i <=$#names; $i++){
	 $larg = length($input{$names[$i]}) if length($input{$names[$i]}) > $larg;
	 if ($input{$names[$i]} =~ /\-/){
		$gap_char='-';
	 }elsif($input{$names[$i]} =~ /\./){
		$gap_char='.';
	 }
  }
  #%input=%{fill_ending_space(\%input)};
		  ######====== filling the end part gaps in shorter sequences #####
	for ($i=0; $i <=$#names; $i++){
	  if (length($input{$names[$i]}) < $larg){
		 $offset=length($input{$names[$i]});
		 $diff=$larg-$offset;
		 substr($input{$names[$i]}, $offset, $larg)= "$gap_char" x $diff;
	  }
	}
## Using format is slower than using just print ######## 0.075 vs 0.070
##   An xxx.out example -->
##            1       10        20        30        40        50
## 1cdg       CGGDWqGIinkIndgYLtgMgVtAIWISQPVeNIysiInysgvnnTAYhG

format JP_FORMAT =
@<<<<<<<<<<@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$names,    $seq
.
  for ($k=0; $k < $larg; $k+=50){     # 50 residues interval
	 for($i=0; $i < @names; $i++){    # number of sequences
		$names =$names[$i];
		$input{$names[$i]}=~ s/\n//g;
		$seq = substr($input{$names[$i]}, $k, 50);
		$~='JP_FORMAT';
		write;
	 }
	 print "\n";                       # next block starts.
  }
}

#________________________________________________________________________
# Title     : convert_num_to_0_or_1_hash (opposite of convert_num_to_0_or_1_hash)
# Usage     : with a variable for threshold ->
#
#             %out = %{&convert_num_to_0_or_1_hash(\%input_hash, \$threshold, \%input_hash2..)};
#
# Function  : changes all the numbers into 0 or 1 according to threshold given.
#             convert_num_0_or_1_hash converts threshold and bigger nums. to
#             '0' while convert_num_0_or_1_hash_opposite converts to '1'.
# Example   : A hash =>  name1  10012924729874924792742749748374297
#                        name2  10012924729874924792710012924729874
#             A threshold => 4
#             !! if numbers are smaller than 4, they become 1 (or true).
#             Outputhash  =>  name1  11111011011111011111011011110101111
#                        name2  11111011010001011001011010010101100
#
#             ($ref1, $ref2)=&convert_num_to_0_or_1_hash(\%hash, \%hash, \$threshold);
#             above is the example when with more than 2 input hashes.
# Warning   : Threshold value is set to 0 as well as all values smaller than that.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : two references, one for hash one for scaler for threshold
#
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_num_to_0_or_1_hash{
	my(@output_hash_refs, %input, $c, $i,
		@string, $name, @names, $threshold, %output_hash);
  for($c=0; $c < @_; $c++){
	 if(ref($_[$c]) eq 'SCALAR'){ $threshold =${$_[$c]};} }
  for($i=0; $i < @_; $i++){
	 if(ref($_[$i]) eq 'HASH'){ %input=%{$_[$i]};
		@names=keys (%input);
		my($split_char)=',';
		if ((@_ < 1)&&(ref($_[$a]) eq 'HASH')){  # if input argument is only one (= if no threshold given),
		  $threshold = 1; } # <---- put 1 to $threshold as a default
		for $name (@names){
		  if($input{$name}=~/\,/){  $split_char = ','; }else{ $split_char = ''; }
		  if ($input{$name} =~ /[\.\-\d]+/){ @string=split(/$split_char/, $input{$name});
			 for (@string){
				if(/\d+/){
				  if($_ >= $threshold){ $_=0; } # !! becomes 0 (or false)
				  else{  $_=1;               } # !! becomes 1 (or true)
				}
			 }
		  }
		  $output_hash{$name}=join("", @string);
		}
		push(@output_hash_refs, \%output_hash);
	 }
  }
  if(@output_hash_refs == 1){return($output_hash_refs[0]); }
  elsif(@output_hash_refs > 1){ return(@output_hash_refs) }
}
#________________________________________________________________________
# Title     : convert_num_0_or_1_hash_opposite (opposite of convert_num_to_0_or_1_hash)
# Usage     : with a variable for threshold ->
#
#               %out = %{&convert_num_0_or_1_hash_opposite(\%input_hash, \$threshold)};
#
# Function  : changes all the numbers into 0 or 1 according to threshold given.
#             convert_num_0_or_1_hash converts threshold and bigger nums. to
#             '0' while convert_num_0_or_1_hash_opposite converts to '1'.
# Example   : A hash =>  name1  10012924729874924792742749748374297
#                        name2  10012924729874924792710012924729874
#             A threshold => 4
#             !! if numbers are smaller than 4, they become 1 (or true).
#             Outputhash  =>  name1  11111011011111011111011011110101111
#                        name2  11111011010001011001011010010101100
#
#             ($ref1, $ref2)=&convert_num_to_0_or_1_hash(\%hash, \%hash, \$threshold);
#             above is the example when with more than 2 input hashes.
# Warning   : Threshold value is set to 0 as well as all values smaller than that.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : two references, one for hash one for scaler for threshold
#
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_num_0_or_1_hash_opposite{
  my(@output_hash_refs, %input,$c, $i, $split_char,
	  @string, $name, @names, $threshold,%output_hash);
  for($c=0; $c < @_; $c++){
	 if(ref($_[$c]) eq 'SCALAR'){ $threshold =${$_[$c]};}
	 elsif( $_[$c] =~/^\d+$/){ $threshold = $_[$c];}
  }
  for($i=0; $i <=$#_; $i++){
	 if(ref($_[$i]) eq 'HASH'){
		%input=%{$_[$i]};
		#show_hash(\%input);
		@names=keys (%input);
		$split_char=',';
		if ((@_ == 1)&&(ref($_[$a]) eq 'HASH')){  # if input argument is only one (= if no threshold given),
		  $threshold = 1; } # <---- put 1 to $threshold as a default
		for $name (@names){
		  if($input{$name}=~/\,/){  $split_char = ',';
		  }else{ $split_char = ','; }
		  if ($input{$name} =~ /[\.\-\d]+/){
			 @string=split(/$split_char/, $input{$name});
			 for (@string){
				if(/\d+/){
				  if($_ >= $threshold){ $_ = 1; } # !! becomes 0 (or false)
				  else{  $_=0;               } # !! becomes 1 (or true)
				}
			 }
		  }
		  $output_hash{$name}=join(",", @string);
		}
		push(@output_hash_refs, \%output_hash);
	 }
  }
  if(@output_hash_refs == 1){return($output_hash_refs[0]); }
  elsif(@output_hash_refs > 1){ return(@output_hash_refs) }
}
#________________________________________________________________________
# Title     : convert_char_to_0_or_1_hash
# Usage     : with a variable for threshold ->
#
#               %out = %{&convert_char_0_or_1_hash(\%input_hash)};
#
# Function  : changes all the chars into 1, gaps are to 0
# Example   : A hash =>  name1  ABCDSSFDSF..ASDFSD.....ADFASDF...AA
#                        name2  ASDFSD.....ADFBCDSSFDSF..ASASDF...A
#
#             Outputhash  => name1  00000000001100000011111000000011100
#                            name2  00000011111000000000000110000001110
#
# Warning   :
# Class     :
# Keywords  : convert_char, translate_char, convert_char_to_digit,
#             convert_char_to_number
# Options   :
# Package   :
# Reference :
# Returns   : A ref. of a hash
# Tips      :
# Argument  : one reference of HASH.
#
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_char_to_0_or_1_hash{
  my(%input) =%{$_[0]};
  my(@string, $name, $elem, $i, %output_hash, $split_char);
  my(@names)=keys (%input);
  for $name (@names){
	  if($input{$name}=~/^\S\,\S/){
	     $split_char=',';
	     @string=split(',', $input{$name}); }
	  else{ $split_char="";
	     @string=split("", $input{$name}); }
	  for ($i=0; $i< @string; $i++){
		 if($string[$i]=~/^[\.\-\s]$/){  $string[$i] = 0 ;
	     }elsif($string[$i]=~/\w/){  $string[$i] = 1;   }
	  }
	  $output_hash{$name}=join("$split_char", @string);
  }
  return(\%output_hash);
}



#________________________________________________________________________
# Title     : digitize_char
# Usage     : with a variable for threshold ->
#
#               %out = %{&digitize_char(\%input_hash)};
#
# Function  : changes all the chars into 1, gaps are to 0
# Example   : A hash =>  name1  ABCDSSFDSF..ASDFSD.....ADFASDF...AA
#                        name2  ASDFSD.....ADFBCDSSFDSF..ASASDF...A
#
#             Outputhash  => name1  00000000001100000011111000000011100
#                            name2  00000011111000000000000110000001110
#
# Warning   :
# Class     :
# Keywords  : convert_char, translate_char, convert_char_to_digit,
#             convert_char_to_number, digitize_sequence, digitize_char
#             digitize_hash
# Options   :
# Package   :
# Reference :
# Returns   : A ref. of a hash
# Tips      :
# Argument  : one reference of HASH.
#
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub digitize_char{
  my(%input) =%{$_[0]};
  my(@string, $name, $elem, %output_hash, $split_char);
  my(@names)=keys (%input);
  for $name (@names){
	  if($input{$name}=~/^\S\,\S/){ $split_char=','; @string=split(',', $input{$name}); }
	  else{ $split_char=""; @string=split("", $input{$name}); }
	  for (@string){  if($_ =~/[\.\-\s]/){  $_ = 0 ; } else{  $_ = 1;   } }
	  $output_hash{$name}=join("$split_char", @string);  }
  return(\%output_hash);
}


#________________________________________________________________________
# Title     : get_posi_diff_and_rms_hash
# Usage     : %position_diffs =\{&get_posi_diff_hash(\%diffs, \%rms_corrected)};
# Function  : gets two ref. of hashes and calculates the position diffs.
# Example   :
# Warning   : split and join char is ",";
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. for an array of differences of input arrays. array context.
#             ---Example input (a hash with numbers); The values are differences after comparion
#                                            with structural and sequential alignments.
#             %diffs =('seq1', '112342431111
#             'seq2', '12222...09011.1122',
#             'seq3', '13222...00011.1122',
#             'seq4', '12262...00011.112.');
#
#             %rms_corrected_0_or_1 => seq1_seq2  0111011111011101011110100101101010011
#                           seq1_seq3  01111.....111110111111111111100001011
#             example output;
#             seq3_seq4       01040...00000.000.
#             seq1_seq2       01012...1810...122
#             seq1_seq3       02012...1110...122
#             seq1_seq4       01032...1110...12.
#             seq2_seq3       01000...09000.0000
#             seq2_seq4       00040...09000.000.
#
# Tips      :
# Argument  : Takes two ref. for hash
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_diff_and_rms_hash{                 # used in 'get_posi_shift_hash'
	my(%diffs)= %{$_[0]};
	my(%rms_corrected_0_or_1)=%{$_[1]};
	my(@names)= keys (%diffs);
	my(@names_rms)= keys (%rms_corrected_0_or_1);
	my(%seqs_compared_in_pair, %seqs_compared_in_pair_rms);
	my(@temp)=();
	my(@temp_rms)=();
	my(@temp2)=();
	for ($i=0; $i <= $#names; $i ++){
	  @temp = split(',', $diffs{$names[$i]});
	  (@{"string$i"})=@temp;
	}
	##########   getting differences for permutated pairs   ##############
	for ($i=0; $i <= $#names; $i++){  # permutation part for pairs
		for ($j=$i; $j <= $#names; $j ++){
			if ($j == $i){ next; } # avoiding seq1_seq1 type match.

			  for ($k=0; $k <= $#string0; $k ++){
				  if ((${"string$i"}[$k] =~ /[-\d+]/) && (${"string$j"}[$k] =~ /[-\d+]/)){

					  my($diff) = abs(${"string$i"}[$k] - ${"string$j"}[$k]);
					  push(@temp2, $diff);
				  }else{
					  push(@temp2, '.');  # @{"diffs$i$j"}
				  }
			  }
			if ( defined $rms_corrected_0_or_1{"$names[$i]\_$names[$j]"}){
			$seqs_compared_in_pair{"$names[$i]\_$names[$j]"}=join(",", @temp2);
		 }elsif(defined $rms_corrected_0_or_1{"$names[$j]\_$names[$i]"}){
			 $seqs_compared_in_pair{"$names[$j]\_$names[$i]"}=join(",", @temp2);
		 }
		 @temp2=();
	  }
	}

	for $pair_names (keys %seqs_compared_in_pair){
		my(@temp_string1)=split(',', $seqs_compared_in_pair{$pair_names});
		my(@temp_string2)=split('' ,  $rms_corrected_0_or_1{$pair_names});  # 0 or 1 values
		my(@final_residue)=();
		for ($i=0; $i <= $#temp_string1; $i++){
			if(($temp_string1[$i] =~ /\d+/) && ($temp_string1[$i] =~ /\d+/)){ # if both are numbers!
				$temp_string1[$i] = ($temp_string1[$i]*$temp_string2[$i]);  # multiplying part
			}
			push(@final_residue, $temp_string1[$i]);
		}
		$seqs_compared_in_pair_rms{$pair_names}=join(",", @final_residue);
	}
	return(\%seqs_compared_in_pair, \%seqs_compared_in_pair_rms);  # returns two refs
}
############

#________________________________________________________________________
# Title     : get_posi_shift_rms_hash
# Usage     : ($rate1_ref,$rate2_ref) =${&get_posi_shift_rms_hash(\%msf_hash, \%jp_hash,
#                                                                 \%rms_file_hash, \$threshold)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : two refs. for scalar values of shift rate of positions for proteins.
#              frirst scalar is rate without correcting rms deviation
#              second scalar is rate with    correcting rms deviation
#             >> example of xx
#
#             1cdg            APDTSVSNKQ NFSTDVIYQI FTDRFSDGNP ANNPTGAAFD GTC.TNLRLY
#             2aaa            ......LSAA SWRTQSIYFL LTDRFGR... ....TDNSTT ATCNTGNEIY
#
#             >> example of xx
#
#             2aaa       ------lsaasWrtqSIYFLLTDRFGrtdns-------ttatCntgneiy
#             1cdg       apdtsvsnkqnFSTDVIYQIFTDRFsdgnpannptgaafdgtCtn-lrly
#
#             >> example of xx
#
#             1cdg         APDTSVSNKQ NFSTDVIYQI FTDRFSDGNP ANNPTGAAFD GTCTN-LRLY
#             2aaa         ------LSAA SWRTQSIYFL LTDRFGRTDN S-------TT ATCNTGNEIY
#             1cdg_2aaa    ------7774 2221210000 0000000148 9-------99 41114-4000
#             1cdg_6taa    ------8674 2232220000 0000011059 9-------99 52114-3000
#
# Tips      :
# Argument  : takes 4 hash REFERENCES for (one seq. and one struc. alignment(2nd arg)
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_shift_rms_hash{  # minimum sub of 'get_posi_shift_rate'
  my(%array1)  =%{$_[0]};  # sequential:  %array1 = seq1 BCC..D, seq2 DD..FD, seq3 ..LJK..KJLJ
  my(%array2)  =%{$_[1]};  # structural:  %array2 = seq1 B..CCD, seq2 DD..FD, seq3 KJ..LKKJL..J
  my(%rms_hash)=%{$_[2]};# from rms file (msarms resulting file)
  my($threshold)=${$_[3]};
  my(%array3)=();        # array3 has position differences between the same sequences
  my(@whole_length)=();  # %array2 is the structural alignments(from jp files)
  my(@string1, @string2, @seq_position1,
	  @seq_position2, $len_of_seq, @temp1, @temp2,
	  @position_diffs, @position_corrected1, @names );
  if($#_ < 3){  $threshold=6;  }
  @temp1= keys (%array1);  @temp2= keys (%array2);
  if ($#temp1 == $#temp2){   goto CALC;  };

  %array1 = %{&hash_common(\%array1, \%array2)}; # %array2 is from jp (structural)
  %array2 = %{&hash_common(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)}; # this removes wrong gaps(in '.' form, in MSF)
  %array2 = %{&remov_com_column(\%array2)};

  CALC:
  @names= keys %array2;
  for $name (@names){
	  @string1 =split('', $array1{$name});
	  @string2 =split('', $array2{$name}); # ! @string2 is the structural. ! (used)

			 @seq_position1  = @{&get_posi_sans_gaps(\$array1{$name})}; # positions after compacting.
			 @seq_position2  = @{&get_posi_sans_gaps(\$array2{$name})}; # @seq_position2 is structural

			  $len_of_seq =($#seq_position2+1);
					 push(@whole_length, $len_of_seq);

			 @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
			 @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
			 #print "@position_corrected1";
			 $array3{$name}=join(",", @position_corrected1); # array3 is for disply of seq.
  }                      # !! split and join char is ',';

  # %array3 has the form.  These numbers are position differences between the same sequences
  #                        one from str. one from seq.
  # seq1  1,1,2,3,.,2,3,.,1,.,0,0,0,1,1,1,1,1,2
  # seq2  1,1,2,1,.,1,3,.,1,.,0,0,1,0,1,1,1,3,2
  # seq3  1,1,2,3,.,2,3,.,1,.,1,1,0,0,1,1,1,3,2

  %rms_hash=%{&convert_num_to_0_or_1_hash(\%rms_hash, \$threshold)};

  ($final_posi_diffs, $final_posi_diffs_rms)=&get_posi_diff_and_rms_hash(\%array3, \%rms_hash); # get_posi_diff_hash uses
  %final_posi_diffs=%{$final_posi_diffs};
  %final_posi_diffs_rms=%{$final_posi_diffs_rms};

  my($sum_of_posi_diffs)    =${&sum_hash(\%final_posi_diffs)};
  my($sum_of_posi_diffs_rms)=${&sum_hash(\%final_posi_diffs_rms)};

  my($av_of_posi_diffs)     =$sum_of_posi_diffs/($#names+1); # dividing by seq number.
  my($av_of_posi_diffs_rms) =$sum_of_posi_diffs_rms/($#names+1); # dividing by seq number.

  my($sum_seq_length)   =${&sum_array(\@whole_length)};
  my($av_rate)          =$av_of_posi_diffs/($sum_seq_length);
  my($av_rate_rms)      =$av_of_posi_diffs_rms/($sum_seq_length);
  #&print_seq_in_block(\%final_posi_diffs); # <--- leave this
  (\$av_rate, \$av_rate_rms);  #---------> returns two ref. for rates.
}

#________________________________________________________________________
# Title     : open_rms_files
# Function  : open rms files and put sequences in a hash
#             Example of rms (aa
#             1cdg         APDTSVSNKQ NFSTDVIYQI FTDRFSDGNP ANNPTGAAFD GTCTN-LRLY
#             2aaa         ------LSAA SWRTQSIYFL LTDRFGRTDN S-------TT ATCNTGNEIY
#             6taa         ------ATPA DWRSQSIYFL LTDRFARTDG S-------TT ATCNTADQKY
#             1cdg_2aaa    ------7774 2221210000 0000000148 9-------99 41114-4000
#             1cdg_6taa    ------8674 2232220000 0000011059 9-------99 52114-3000
#             2aaa_6taa    ------1000 0000000000 0000000010 0-------00 0000000000
#
#             Example output hash;
#             1nor        LECHNQQSSQPPTTKTCS-GETNCYKKWWSDH----RGTIIERGFFC--GCPKVK-PGVNLNCCRT-DRCNN-------
#             1cdg        APDTSVSNKQNFSTDVASISGLVTSLP-QGSYNDVLGGLLNGNTLSVGSGGAASNFTLAAGGTAVWQYTAATATPTIGH
#             1cdg_2aaa   ------777002112111-----343333---431127----5433234-72354541131211111176899999999
#
# Usage     : %anyarray = {&open_rms_files(\$any_sequence_file_msf_form)};
# Example   :
# Warning   : xxx.rms files are Tim Hubbard's 'msarms' program's output.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a hash
# Tips      :
# Argument  : takes one ref. for a file.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_rms_files{
	my(@names, $n, $s, $n2, $s2, $n3, $s3, %hash);
	unless (-e ${$_[0]}){
	  print chr(7);
	  print "\n\n\t This is sub open_rms_files in th_lib.pl \n\n";
	  print "\n\n\t Fatal: The input file $file1 is not in the directory \n";
	  exit;
	}
	open(FILE_1,"${$_[0]}");  	# reading in (rms file)
	while(<FILE_1>){         	# file1 needs to be xxxx.rms for the moment, automatic later
	  if(/^(\w\w\w\w)[\t]* +([\-\w ]+)[\n]$/){ $n=$1;  $s=$2; $s =~s/ //g; $hash{$n}.= $s;
	  }elsif(/^(\w\w\w\w_\w\w\w\w+)[\t]* +([\-\d( )\-]+)[\n]$/){
		  $n2=$1; $s2=$2; $s2=~s/ //g; $hash{$n2}.= $s2;
	  }elsif(/^(\w\w\w\w\w)(\w\w\w\w+)[\t]* +([\-\d( )\-]+)[\n]$/){
		  $n3="$1_$2"; $s3=$3; $s3=~s/ //g;   $hash{$n3}.= $s3;
	  }
	}
	return( \%hash );
}
#________________________________________________________________________
# Title     : open_rms_files2
# Function  : same as open rms files but returns two hashes.
#             Example of rms (aa
#             1cdg         APDTSVSNKQ NFSTDVIYQI FTDRFSDGNP ANNPTGAAFD GTCTN-LRLY
#             2aaa         ------LSAA SWRTQSIYFL LTDRFGRTDN S-------TT ATCNTGNEIY
#             1cdg_2aaa    ------7774 2221210000 0000000148 9-------99 41114-4000
#             1cdg_6taa    ------8674 2232220000 0000011059 9-------99 52114-3000
#
#             Example output 2 hashes;
#             1nor        LECHNQQSSQPPTTKTCS-GETNCYKKWWSDH----RGTIIERGFFC--GCPKVK-PGVNLNCCRT-DRCNN-------
#             1cdg        APDTSVSNKQNFSTDVASISGLVTSLP-QGSYNDVLGGLLNGNTLSVGSGGAASNFTLAAGGTAVWQYTAATATPTIGH
#
#             1cdg_2aaa   ------777002112111-----343333---431127----5433234-72354541131211111176899999999
#             1cdg_2taa   ------777002112111-----343333---431127----5433234-72354541131211111176899999999
#
# Usage     : ($hash_for_jp, $hash_for_rms) = &open_rms_files(\$any_sequence_file_msf_form);
# Example   :
# Warning   : xxx.rms files are Tim Hubbard's 'msarms' program's output.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : return(@out); while @out is (\%hash_rms, \%hash_jp)
# Tips      :
# Argument  : takes one ref. for a file.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_rms_files2{
	my(@names, $n,$s,@out,$n2,$s2,$n3,$s3, %hash_jp,%hash_rms);
	unless (-e ${$_[0]}){   print chr(7);
	  print "\n\n\t This is sub open_rms_files in th_lib.pl \n\n";
	  print "\n\n\t Fatal: The input file $file1 is not in the directory \n"; exit; }
	open(FILE_1,"${$_[0]}");  	# reading in (rms file)
	while(<FILE_1>){         	# file1 needs to be xxxx.rms for the moment, automatic later
	  if(/^(\w\w\w\w)[\t]* +([\-\w ]+)[\n]$/){ $n=$1; $s=$2; $s =~s/ //g; $hash_jp{$n}.= $s;}
	  elsif(/^(\w\w\w\w_\w\w\w\w+)[\t]* +([\-\d( )\-]+)[\n]$/){
		  $n2=$1; $s2=$2; $s2=~s/ //g; $hash_rms{$n2}.= $s2; }
	  elsif(/^(\w\w\w\w\w)(\w\w\w\w+)[\t]* +([\-\d( )\-]+)[\n]$/){
		  $n3="$1_$2"; $s3=$3; $s3=~s/ //g;   $hash_rms{$n3}.= $s3;  } }
	push(@out, \%hash_rms, \%hash_jp); return(@out);
}



#________________________________________________________________________
# Title     : steve_permute_array  (C) Steve Brenner, copyrighted.
# Usage     : %final_out_hash=%{&steve_permute_array(\@list, \2, \4)};
#                         Above is for pairs, 3 seqs, and 4 seqs.
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a hash.
# Tips      :
# Argument  : upto 3 arg. 1st one is for the ref. of an array. 2nd for min
#             element no. 3rd for max element no. 2nd and 3rd are optional.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub steve_permute_array{
  my(@lst) =@{$_[0]};  my($from)=${$_[1]};  my($to)  =${$_[2]};
  if ($from > $to){
	 print "\n Error, you put higher \$from ($from) than \$to ($to). \$to must be equal or bigger\n
				  than \$from for right permuation\n";  }
  $from--;  # to make min and max numbers sensible.
  my($res, $com, $count, %final_out_hash, @res );
  @res = @{&CombinAll(\@lst, \$from, \$to)};
			#______________________________________________
			 sub CombinAll{
			 my (@lst) = @{$_[0]};
			 my ($from)= ${$_[1]};
			 my ($to)  = ${$_[2]};
			 my ($i, $res, @ret);
				for $i (1 .. $to){  # <<------------  change this to limit the maximum elements
				  push (@ret, @{&Combin(\@lst, $i)});
				  #_____________________________
				  sub Combin{
					 my ($lst)=$_[0];
					 my ($num)=$_[1];
					 my ($i,$elt, @newlst, $res, @ret );
					 return [[]] if $num == 0;
					 foreach $i (0 .. (@$lst-1)) {
						$elt = $lst->[$i];  # the element of interest
						@newlst = @{$lst}[$i+1 .. (@{$lst}-1)];
						$res = &Combin(\@newlst, $num-1);
						foreach $com (@{$res}) {
						splice(@$com,0,0,$elt);
						  push (@ret,$com);
						}
					 }
					 \@ret;
				  }
				  #______________________________
				}
				\@ret;
			  }
			  #_____________________________________________
  foreach $com (@res) {
	 $count++;  my($entry_key)="$count$#{$com}";   # the output will be (eg)  (1 'abc,ccd', 2, 'ccd,efg',,,)
	 $final_out_hash{$entry_key}=join(",", @{$com}) if @{$com} > $from;  }
  \%final_out_hash;
}

#________________________________________________________________________
# Title     : opendir_and_go_in_and_do_something
# Usage     : &opendir_and_go_in_and_do_something(\$input_dir);
#                     $inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
# Function  : open dir and process all files in the dir if you wish,
#             and then go in any other sub
#             if any file(dir) is linked, it skips that file.
# Example   : as in my 'indexing.pl' for perl file indexer.
# Warning   : Seems to work fine., !! Change the name of this sub to shorter one
#                                  !! for your own purpose.
# Class     :
# Keywords  : open_dir_and_go_in_and_do_something,
#             go in there do something, get into subdir and do something.
#             go_in_subdir_and_do_something, recursive execution
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets a ref. of a scaler (dir name) and returns nothing(void).
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub opendir_and_go_in_and_do_something{
  #""""""""""""""""""""""< handle_arguments head Ver 1.0 >""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z,
	  $original_dir, $dir, $file, $line, $name, @keys, @names,
	  @read_files, @temp, %hash, %input );
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	$original_dir = ${$dir[0]};  ## $dir[0] is a ref. $original_dir
	print ($original_dir);
	@read_files=@{&read_any_dir_simple($original_dir)};
	foreach $file(@read_files){
	  my($realfile1)=$original_dir.'/'.$file;

	  if (-l $realfile1){
		  print "\n\n$realfile1 is linked, skipping. \n";
		  next;
	  }elsif (-d $realfile1){  ## If it is a directory.

		 &opendir_and_go_in_and_do_something(\$realfile1);   # RECURSION occurrs here!!

	  }elsif (-f $realfile1){     #<<------ This is where things match
		 chdir($original_dir);
		 @dir=split(/\//, $realfile1);
		 $dir=$dir[($#dir-1)];  # $dir is the name of directory in where you are.
		  ###  put any program which does something here ###
		  #if(($realfile1 =~/(\.tem)$/)&&(-s $realfile1)){
		  #   print $realfile1, "\n";
		  #   @ref_of_seq = &open_tem_files(\$realfile1);
		  #   print_seq_in_block($ref_of_seq[0]);
		  #}
	  }else{  next;  }
	}
}
#________________________________________________________________________
# Title     : open_subdir_and_go_in_and_do
# Usage     : &opendir_and_go_in_and_do_something(\$input_dir);
#                     $inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
# Function  : open dir and process all files in the dir if you wish,
#             and then go in any other sub
#             if any file(dir) is linked, it skips that file.
# Example   : as in my 'indexing.pl' for perl file indexer.
# Warning   : Seems to work fine., !! Change the name of this sub to shorter one
#                                  !! for your own purpose.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets a ref. of a scaler (dir name) and returns nothing(void).
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_subdir_and_go_in_and_do{
	my($original_dir)=${$_[0]};
	my(@read_files)=@{&read_any_dir(\$original_dir)};
	my(%array_msf,%array_jp, $jp_file , $dir);
	my($id_compos)=0;
	my($error_rate)=0;
	foreach $file(@read_files){
	  my($realfile1)=$original_dir.'/'.$file;
	  if (-l $realfile1){
		  print "\n\n$realfile1 is linked, skipping. \n";
		  next;
	  }elsif (-d $realfile1){  ## If it is a directory.

		 &opendir_and_go_in_and_do_something(\$realfile1);   # RECURSION occurrs here!!

	  }elsif (-f $realfile1){     #<<------ This is where things match
		 chdir($original_dir);
		 @dir=split(/\//, $realfile1);
		 $dir=$dir[($#dir-1)];  # $dir is the name of directory in where you are.
		  ###  put any program which does something here ###
		  #if(($realfile1 =~/(\d+\-$no\.msf)$/)&&(-s $realfile1)){
		  #}
	  }else{  next;  }
	}
}
#________________________________________________________________________
# Title     : get_occurances_of_shift_type_hash
# Usage     : for single protein group
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one reference  of hash. (eg, 0=>1000, 1=>888, 2=>83, ...
#                                          0,1,2... are position shift types
#                                          1000, 888, 83... are occurances in
#                                          the comparision between str. and seq.
#                                          alignments.)
# Tips      :
# Argument  : Two references of hashes.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_occurances_of_shift_type_hash{  # minimum sub of 'get_posi_shift_rate'
  my(%array1)=%{$_[0]};   # %array1 = seq1 BCC..D, seq2 DD..FD, seq3 ..LJK..KJLJ
  my(%array2)=%{$_[1]};   # %array2 = seq1 B..CCD, seq2 DD..FD, seq3 KJ..LKKJL..J
  my(@whole_length)=();    # %array2 is the structural alignments(from jp files)
  my(%array3)=();
  my(@string1, @string2, @seq_position1,
	  @seq_position2, $len_of_seq,
	  @position_diffs, @position_corrected1, @names
  );
  %array1 = %{&hash_common(\%array1, \%array2)};
  %array2 = %{&hash_common(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)}; # this removes wrong gaps(in '.' form, in MSF)
  %array2 = %{&remov_com_column(\%array2)};

  @names= keys %array2;
  for $name (@names){
	  @string1 =split('', $array1{$name});
	  @string2 =split('', $array2{$name}); # ! @string2 is the structural. ! (used)

			 @seq_position1  = @{&get_posi_sans_gaps(\$array1{$name})};
			 @seq_position2  = @{&get_posi_sans_gaps(\$array2{$name})}; # @seq_position2 is structural

			  $len_of_seq =($#seq_position2+1);
					 push(@whole_length, $len_of_seq);

			 @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
			 @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
			 #print "@position_corrected1";
			 $array3{$name}=join(",", @position_corrected1); # array3 is for disply of seq.
  }                      # !! split and join char is ',';

  # %array3 has the form.  These numbers are position differences between the same sequences
  #                        one from str. one from seq.
  # seq1  1,1,2,3,.,2,3,.,1,.,0,0,0,1,1,1,1,1,2
  # seq2  1,1,2,1,.,1,3,.,1,.,0,0,1,0,1,1,1,3,2
  # seq3  1,1,2,3,.,2,3,.,1,.,1,1,0,0,1,1,1,3,2
  my(%final_posi_diffs) =%{&get_posi_diff_hash(\%array3)};
  my($sum_of_posi_diffs)=${&sum_hash(\%final_posi_diffs)};
  my($av_of_posi_diffs) =$sum_of_posi_diffs/($#names); # dividing by seq number.
  my($sum_seq_length)   =${&sum_array(\@whole_length)};
  my($av_rate)          =$av_of_posi_diffs/($sum_seq_length);
  &print_seq_in_block(\%final_posi_diffs); # <--- leave this
  for (values %final_posi_diffs){
	 my(@splited) = split(',', $_);
			for (@splited){
			  $out{$_}++ if ($_ =~ /\d+/);
			}
  }
  \%out;
}
#________________________________________________________________________
# Title     : get_occurances_of_shift_type_hash_all
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_occurances_of_shift_type_hash_all{  # minimum sub of 'get_posi_shift_rate'
  my(%array1)=%{$_[0]};   # %array1 = seq1 BCC..D, seq2 DD..FD, seq3 ..LJK..KJLJ
  my(%array2)=%{$_[1]};   # %array2 = seq1 B..CCD, seq2 DD..FD, seq3 KJ..LKKJL..J
  my(@whole_length)=();    # %array2 is the structural alignments(from jp files)
  my(%array3)=();
  my(@string1, @string2, @seq_position1,
	  @seq_position2, $len_of_seq,
	  @position_diffs, @position_corrected1, @names
  );
  %array1 = %{&hash_common(\%array1, \%array2)};
  %array2 = %{&hash_common(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)}; # this removes wrong gaps(in '.' form, in MSF)
  %array2 = %{&remov_com_column(\%array2)};

  @names= keys %array2;
  for $name (@names){
	  @string1 =split('', $array1{$name});
	  @string2 =split('', $array2{$name}); # ! @string2 is the structural. ! (used)

			 @seq_position1  = @{&get_posi_sans_gaps(\$array1{$name})};
			 @seq_position2  = @{&get_posi_sans_gaps(\$array2{$name})}; # @seq_position2 is structural

			  $len_of_seq =($#seq_position2+1);
					 push(@whole_length, $len_of_seq);

			 @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
			 @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
			 #print "@position_corrected1";
			 $array3{$name}=join(",", @position_corrected1); # array3 is for disply of seq.
  }                      # !! split and join char is ',';

  # %array3 has the form.  These numbers are position differences between the same sequences
  #                        one from str. one from seq.
  # seq1  1,1,2,3,.,2,3,.,1,.,0,0,0,1,1,1,1,1,2
  # seq2  1,1,2,1,.,1,3,.,1,.,0,0,1,0,1,1,1,3,2
  # seq3  1,1,2,3,.,2,3,.,1,.,1,1,0,0,1,1,1,3,2
  my(%final_posi_diffs) =%{&get_posi_diff_hash(\%array3)};
  my($sum_of_posi_diffs)=${&sum_hash(\%final_posi_diffs)};
  my($av_of_posi_diffs) =$sum_of_posi_diffs/($#names); # dividing by seq number.
  my($sum_seq_length)   =${&sum_array(\@whole_length)};
  my($av_rate)          =$av_of_posi_diffs/($sum_seq_length);
  &print_seq_in_block(\%final_posi_diffs); # <--- leave this
  for (values %final_posi_diffs){
	 my(@splited) = split(',', $_);
			for (@splited){
			  $out{$_}++ if ($_ =~ /\d+/);	 }
  }
  # the final result is %out which has accumulated entries with occurances
}
#________________________________________________________________________
# Title     : get_occurances_of_char
# Usage     : %occurances_of_shift_types=%{&get_shift_types_hash(\%final_posi_diffs)};
# Function  : gets the numbers of occurances for 1, 2, 3 ... position shifts.
# Example   :
# Warning   :
# Class     :
# Keywords  : composition of chars, composition table making,
#             make_composition, make composition table
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of hash  (a =>5, b=>6, c=>4,,,,,)
# Tips      :
# Argument  : one ref. of hash (seq1 alsdfjlsj
#                               seq2 asldfjsld
#                               seq3 owiurouou);
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub  get_occurances_of_char{
  my %input = %{$_[0]}; my %out;  my (@splited, $split );
  for (values %input){
	 @splited = split(//, $_);
	 for $split (@splited){  $out{$split}++; }
  }
  \%out;
}

#________________________________________________________________________
# Title     : make_composition_table
# Usage     : %occurances=%{&make_compos_table(\%key_and_value_for_seq)};
# Function  : gets the numbers of occurances for 1, 2, 3 ... position shifts.
# Example   :
# Warning   :
# Class     :
# Keywords  : composition of chars, composition table making, make composition table
#             make_composition_table, get_composition, get_amino_acid_composition
#             protein_composition, make_aa_composition_tablem, aa_composition
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of hash  (a =>5, b=>6, c=>4,,,,,)
# Tips      :
# Argument  : one ref. of hash (seq1 alsdfjlsj
#                               seq2 asldfjsld
#                               seq3 owiurouou);
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub  make_composition_table{
  my %input = %{$_[0]};
  my (@splited, $split, %out );
  for (values %input){
	 @splited = split(//, $_);
	 for $split (@splited){  $out{$split}++; }
  }
  \%out;
}
#________________________________________________________________________
# Title     : make_composition_ratio_table_simple
# Usage     : %occurances=%{&make_compos_ratio_table(\%final_posi_diffs)};
# Function  : gets ratio of the numbers of occurances for any chars.
# Example   :
# Warning   : This pools all the sequences, to not distinct seq composition if
#              you put more than one seq.
# Class     :
# Keywords  : composition table, composition of chars, composition table making,
#             make composition table, make_composition_table
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of hash  (a =>0.05, b=>0.06, c=>0.04,,,,,)
# Tips      :
# Argument  : one ref. of hash (seq1 alsdfjlsj
#                               seq2 asldfjsld
#                               seq3 owiurouou);
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub  make_composition_ratio_table_simple{
  my %input = %{$_[0]};
  my %out;
  my (@keys, $i, %ratio_out, $each_char_occur, @splited, $split, $all_occur );
  for (values %input){
	 @splited = split(//, $_);
	 for $split (@splited){  $out{$split}++; $all_occur ++; }
  }
  @keys = keys %out;
  for ($i=0; $i < @keys; $i ++){
	 $each_char_occur = $out{$keys[$i]};
	 $ratio_out{$keys[$i]} = $each_char_occur/$all_occur;
  }
  \%ratio_out;
}

#________________________________________________________________________
# Title     : make_composition_ratio_table
# Usage     : %seq=%{&make_compos_ratio_table(\%hash1, \%hash2, ,,,)};
# Function  : gets ratio of the numbers of occurances for any chars.
# Example   :
# Warning   : This produces each composition ration table for each seq
# Class     :
# Keywords  : composition table, composition of chars, composition table making,
#             make composition table, make_composition_table
#             aa_composition_ratio, composition_ratio, protein_composition,
#             get_composition_ratio, get_aa_composition_ratio
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of hash  ('seq_name', { a =>0.05, b=>0.06, c=>0.04,,,,, } )
# Tips      :
# Argument  : one or more ref. of hash (seq1 alsdfjlsj
#                                       seq2 asldfjsld
#                                       seq3 owiurouou);
# Todo      :
# Author    : A Biomatic
# Version   : 1.3
# Used in   : show_composition.pl
# Enclosed  :
#--------------------------------------------------------------------
sub  make_composition_ratio_table{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.3 >"""""""""""""""""""
	my(@A )=&handle_arguments( @_ );my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "\n   \@hash has \"@hash\"\n   \@raw_string has   \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has   \"@char_opt\"\n   \@file has \"@file\"
	\@string has \"@string\""; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my %final_out, %ratio_out;

  for($i=0; $i < @hash; $i ++){ ## @hash has [\%seq1, \%seq2,....]
	 my %input = %{$hash[$i]};      ## taking single hash
	 print "\n",__LINE__, " \%input has ", %input, "\n" if ($debug == 1);
	 my (%out, $all_occur);
	 my @seq_names = keys %input;     ## taking Seq names from each hash input.
	 print "\n",__LINE__, " \@seq_names has ", @seq_names, "\n" if ($debug == 1);
	 for( $j=0; $j < @seq_names; $j++){
		 %ratio_out=();
		 my $split;
		 my $name = $seq_names[$j];
		 my $seq = $input{$seq_names[$j]};
		 my @splited = split(//, $seq);
		 for $split (@splited){  $out{$split}++; $all_occur ++; }
		 my @amino_residue = keys %out;
		 print "\n",__LINE__, " \@amino_residue ", @amino_residue , "\n" if ($debug == 1);
		 for ($k=0; $k < @amino_residue; $k ++){
	      my $each_char_occur = $out{$amino_residue[$k]};
	      $ratio_out{$amino_residue[$k]} = $each_char_occur/$all_occur;
		 }
		 $final_out{$name}=\%ratio_out;
	 }
  }
  if(@hash==1){ return(\%ratio_out); }
  else{ \%final_out } #  \%final_out has ('seqname', \%hash_of_ratio_of_amino_acids )
}

#________________________________________________________________________
# Title     : get_position_shift_rate (derived from 'get_posi_shift_hash' )
# Usage     : %rate_hash = %{&get_position_shift_rate(\%hash_msf, \%hash_jp)};
# Function  : This is to get position specific error rate for line display rather than
#             actual final error rate for the alignment. Takes two file names of seq.
#             Output >>
#             seq1_seq2  1110...222...2222
#             seq2_seq3  1111....10...1111
#             seq1_seq3  1111....0000.0000
#
# Example   : my(%error_rate)=%{&get_position_shift_rate(\%input, \%input2)};
# Warning   : split and join char is ','; (space)
# Class     :
# Keywords  :
# Options   : 'ss' for secondary structure regions(Helix and Beta region only
#                 calculation for error rate). There is specialized sub called
#              get_segment_shift_rate for sec. str. only handling.
#
#    $ss_opt            becomes    ss by  ss, SS, -ss, -SS     #  for secondary structure only
#    $H                 =         'H' by   -H or -h or H       # to retrieve only H segment
#    $S                 becomes   'S' by   -S or  S            # to retrieve only S segment
#    $E                 becomes   'E' by   -E or  E            # to retrieve only E segment
#    $T                 becomes   'T' by   -T or -t or T or t  # to retrieve only T segment
#    $I                 becomes   'I' by   -I or  I            # to retrieve only I segment
#    $G                 becomes   'G' by   -G or -g or G or g  # to retrieve only G segment
#    $B                 becomes   'B' by   -B or -b or B or b  # to retrieve only B segment
#    $HELP              becomes    1  by   -help   # for showing help
#    $simplify          becomes    1  by   -p or P or -P, p
#    $simplify          becomes    1  by   -simplify or simplify, Simplify SIMPLIFY
#    $comm_col          becomes   'C' by   -C or C or common
#    $LIMIT             becomes    L  by   -L, L               # to limit the error rate to 9 .
#
# Package   :
# Reference :
# Returns   : \%final_posi_diffs;
# Tips      :
# Argument  : %{&get_position_shift_rate(\%msfo_file, \%jpo_file)};
#             Whatever the names, it takes one TRUE structral and one ALIGNED hash.
# Todo      :
# Author    : A Biomatic
# Version   : 1.5
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_position_shift_rate{
  #""""""""""""""""""""""< handle_arguments head Ver 1.1 >""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  print __LINE__," \$char_opt is  \"$char_opt\" in get_position_shift_rate\n" if $debug eq 1;
  print __LINE__," \@string is  \"@string\" in get_position_shift_rate\n" if $debug eq 1;
  print __LINE__," \$LIMIT is  \"$LIMIT\" in get_position_shift_rate\n" if $debug eq 1;

  my(%arraySEQ)=%{$hash[0]};
  my(%arraySTR)=%{$hash[1]};
  my($gap_char, %final_posi_diffs, @stringSTR,@stringSEQ,@seq_positionSEQ,
	  @seq_positionSTR,$len_of_seq, @position_diffs, @position_corrected1,
	  @names, @whole_length, %array3, @keys_common, %DSSP_common, @stringDSSP_common);

  $gap_char='.';

  %arraySTR = %{&hash_common_by_keys(\%arraySTR, \%arraySEQ)};
  %arraySEQ = %{&hash_common_by_keys(\%arraySEQ, \%arraySTR)};
  %arraySEQ = %{&remov_com_column(\%arraySEQ)};
  %arraySTR = %{&remov_com_column(\%arraySTR)};

  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if($debug eq 1){
	  print __LINE__,
	  " ## sorting sequence names. To make things constant. \n\n";  }
  @names= sort keys %arraySTR;
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #  If common column of secondary structure representation option $comm_col is set
  #  open_dssp_files sub routine will get the common seq parts of all the sequences.
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if($comm_col =~ /C/i){
	  %DSSP_common=%{&open_dssp_files( @names, $H, $S, $E, $T, $I, $G, $B, $simplify, 'C')};
	  @keys_common= keys %DSSP_common;
	  @stringDSSP_common = split(/|\,/, $DSSP_common{$keys_common[0]});
	  if($debug2 eq 1){ print __LINE__," \$comm_col is set to: $comm_col \n";
		  print __LINE__," \@stringDSSP_common is :@stringDSSP_common \n";
	  }
  }

  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  # Comparing two hashes
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  for $name (@names){
	  #"""""""""""""""" Splitting the sequence string
	  if($arraySEQ{$name}=~/\,\S+\,/){
		  @stringSEQ =split(/\,/, $arraySEQ{$name});
		  @stringSTR=split(/\,/, $arraySTR{$name});  }
	  else{
		  @stringSEQ =split(//, $arraySEQ{$name});
		  @stringSTR=split(//, $arraySTR{$name});
	  }
	  print "\n",__LINE__, " \@stringSEQ  is  @stringSEQ \n" if $debug2 eq 1;
	  print "\n",__LINE__, " \@stringSTR  is  @stringSTR \n" if $debug2 eq 1;

	  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  #   Contracting  the SEQ.
	  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  @seq_positionSEQ = @{&get_posi_sans_gaps(\$arraySEQ{$name})};
	  @seq_positionSTR = @{&get_posi_sans_gaps(\$arraySTR{$name})};

	  #"""""""""""""""" To get secondary structure only calc  """"""""""""""""""""""""""""
	  # It superposes the NON sec. region on  @seq_positionSTR to nullify positions.
	  #  get_posi_diff ignores non char positions in calc.
	  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  if( ($ss_opt =~ /ss$/i) && ($comm_col !~ /C/i) ){
		  %DSSP=%{&open_dssp_files($name, $H, $S, $E, $T, $I, $G, $B, $simplify, $comm_col)};
		  if($debug1 eq 1){
			 print "\n",__LINE__," open_dssp_files has options \$H ->$H \$S->$S \$E->$E \n";
			 print "\n",__LINE__," \$T->$T \$I->$I \$G->$B \$simplify->$simplify \$comm_col ->$comm_col\n";
			 &show_hash( \%DSSP );
		  }
		  if(ref(\%DSSP) eq 'HASH'){ # to check it %DSSP was valid, If not it skips overlaying
			  @stringDSSP = split(/|\,/, $DSSP{$name});
			  $size_of_stringDSSP = @stringDSSP;
			  $size_of_seq_positionSTR = @seq_positionSTR;
			  if($debug2 eq 1){
					print "\n",__LINE__," \@stringDSSP is \n @stringDSSP\n";
					print "\n",__LINE__," Size of \@stringDSSP      is $size_of_stringDSSP\n" ;
					print "\n",__LINE__," Size of \@seq_positionSTR is $size_of_seq_positionSTR\n";
					print "\n",__LINE__," \$gap_char is \"$gap_char\" \n" ;
			  }
			  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			  #   When the sec. str is not defined in DSSP, I delete the position of
			  #   @stringDSSP to gap(ie. make it blank to exclude error rate calc)
			  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			  for($i=0; $i < @stringDSSP; $i++){
				  if($stringDSSP[$i] =~ /\W/){ $seq_positionSTR[$i]= $gap_char;}
			  }
		  }
	  }elsif( $comm_col =~ /C/i){
			  print __LINE__, " Replacing position with \gap_char \"$gap_char\"\n" if $debug2 eq 1;
			  $ss_opt = 'ss'; # whether it was set or not, make it 'ss'
			  for($i=0; $i < @stringDSSP_common; $i++){
				  if($stringDSSP_common[$i] =~ /\W/){ $seq_positionSTR[$i]= $gap_char;}
			  }
	  }

	  if($debug2 eq 1){
		  print __LINE__,
		  print " \@seq_positionSTR is  @seq_positionSTR\n";
	  }

	  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  #   getting Position differences.
	  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  @position_diffs  = @{&get_posi_diff(\@seq_positionSEQ, \@seq_positionSTR)};

	  if($debug2 eq 1){
		  print __LINE__,
		  print " \@position_diffs is  @position_diffs\n";
	  }

	  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  #  You can have two types of output according to which alignment you compare your
	  #   error rates. (1) Compare to @stringSEQ   (2) @stringSTR
	  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  @position_corrected1 = @{&put_position_back_to_str_seq(\@stringSEQ, \@position_diffs)};
	  $array3{$name}=join(",", @position_corrected1);

  }
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  # The final Step for error rate, $LIMIT is to confine error rate in one digit (ie, less than 10)
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  %final_posi_diffs =%{&get_residue_error_rate(\%array3, $LIMIT)};

  undef(@whole_length, $len_of_seq);
  return(\%final_posi_diffs);
}

#________________________________________________________________________
# Title     : get_posi_rates_hash_out (derived from 'get_posi_shift_hash' )
# Usage     : %rate_hash = %{&get_posi_shift_hash(\%hash_msf, \%hash_jp)};
# Function  : This is to get position specific error rate for line display rather than
#             actual final error rate for the alignment.
#             Output >>
#             seq1_seq2  1110...222...2222
#             seq2_seq3  1111....10...1111
#             seq1_seq3  1111....0000.0000
#
# Example   :
# Warning   : split and join char is ','; (space)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : \%final_posi_diffs;
# Tips      :
# Argument  : %{&get_posi_rates_hash_out(\%msfo_file, \%jpo_file)};
#             Whatever the names, it takes one TRUE structral and one ALIGNED hash.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_rates_hash_out{
  my(%array1)=%{$_[0]};
  my(%array2)=%{$_[1]};
  my(@string1, @string2, @seq_position1, @seq_position2,
	  $len_of_seq,@position_diffs, @position_corrected1,
	  @names, @whole_length, %array3);
  %array1 = %{&hash_common_by_keys(\%array1, \%array2)};
  %array2 = %{&hash_common_by_keys(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)};
  %array2 = %{&remov_com_column(\%array2)};
  @names= keys %array2;
  for $name (@names){
	  @string1 =split('', $array1{$name});
	  @string2 =split('', $array2{$name});
	  @seq_position1 = @{&get_posi_sans_gaps(\$array1{$name})};
	  @seq_position2 = @{&get_posi_sans_gaps(\$array2{$name})};
	  $len_of_seq =(@seq_position2);
	  push(@whole_length, $len_of_seq);
	  @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
	  @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
	  $array3{$name}=join(",", @position_corrected1);  }
  my(%final_posi_diffs)=%{&get_each_posi_diff_hash(\%array3)};
  undef(@whole_length, $len_of_seq);
  return(\%final_posi_diffs);
}

#________________________________________________________________________
# Title     : get_posi_diff_hash
# Usage     : %position_diffs =\{&get_posi_diff_hash(\@seq_position1, \@seq_position2)};
# Function  : gets a ref. of a hash and calculates the position diffs.
# Example   :
# Warning   : split and join char is ',';    # used in 'get_posi_shift_hash'
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. for an array of differences of input arrays. array context.
#             ---Example input (a hash with sequences); The values are differences after comparion
#                                            with structural and sequential alignments.
#             %diffs =('seq1', '112342431111
#             'seq2', '12222...09011.1122',
#             'seq3', '13222...00011.1122',
#             'seq4', '12262...00011.112.');
#             example output;
#             seq3_seq4       01040...00000.000.
#             seq1_seq2       01012...1810...122
#             seq1_seq3       02012...1110...122
#             seq1_seq4       01032...1110...12.
#             seq2_seq3       01000...09000.0000
#             seq2_seq4       00040...09000.000.
# Tips      :
# Argument  : Takes a ref. for hash which have positions of residues of sequences.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_diff_hash{
	if(ref($_[0]) ne 'HASH' ){
		print "\n Arg not not hash ref in get_posi_diff_hash \n\n";print chr(7);exit;}
	else{   my(%diffs)= %{$_[0]};  my(@names)= keys (%diffs);
	  my(%seqs_compared_in_pair)=();  my(@temp, @temp2);
	  for ($i=0; $i < @names; $i ++){
		 if($diffs{$names[$i]} =~/\,/){  @temp = split(',', $diffs{$names[$i]});}
		 else{ @temp = split('', $diffs{$names[$i]}); }  (@{"string$i"})=@temp; }
		 for ($i=0; $i < @names; $i++){
			for ($j=$i+1; $j < @names; $j ++){
			for ($k=0; $k < @string0; $k ++){
			  if ((${"string$i"}[$k] =~ /[-\d+]/) && (${"string$j"}[$k] =~ /[-\d+]/)){
				  my($diff) = abs(${"string$i"}[$k] - ${"string$j"}[$k]);
				  push(@temp2, $diff); }
			  else{  push(@temp2, '.'); }    }
			$seqs_compared_in_pair{"$names[$i]\_$names[$j]"}=join(",", @temp2) if $names[$i] < $names[$j];
			$seqs_compared_in_pair{"$names[$j]\_$names[$i]"}=join(",", @temp2) if $names[$i] > $names[$j];
			@temp2=();     }    }
	 \%seqs_compared_in_pair; }
}

#________________________________________________________________________
# Title     : get_posi_shift_hash  (bug free!!)
# Usage     : $rate_final = ${&get_posi_shift_hash(\%hash_msf, \%hash_jp)};
# Function  :
# Example   :
# Warning   : split and join char is ','; (space)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : One scalar value of shift rate of position for proteins.
# Tips      :
# Argument  : takes two hash REFERENCES for (one seq. and one struc. alignment(2nd arg)
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_shift_hash{  my(%array3)=();  my(@whole_length)=();
  my(%array1)=%{$_[0]};   # %array1 = seq1 BCC..D, seq2 DD..FD, seq3 ..LJK..KJLJ
  my(%array2)=%{$_[1]};   # %array2 = seq1 B..CCD, seq2 DD..FD, seq3 KJ..LKKJL..J
  my(@string1, @string2, @seq_position1, @seq_position2, $len_of_seq, @names,
	  @position_diffs, @position_corrected1 );
  %array1 = %{&hash_common(\%array1, \%array2)}; # %array2 is from jp (structural)
  %array2 = %{&hash_common(\%array2, \%array1)};
  %array1 = %{&remov_com_column(\%array1)};
  %array2 = %{&remov_com_column(\%array2)};  @names= keys %array2;

  for $name (@names){
	  @string1 =split('', $array1{$name});
	  @string2 =split('', $array2{$name}); # ! @string2 is the structural. ! (used)

	  @seq_position1  = @{&get_posi_sans_gaps(\$array1{$name})};
	  @seq_position2  = @{&get_posi_sans_gaps(\$array2{$name})}; # @seq_position2 is structural

	  $len_of_seq = @seq_position2;
	  push(@whole_length, $len_of_seq);

	  @position_diffs = @{&get_posi_diff(\@seq_position1, \@seq_position2)};
	  @position_corrected1 = @{&put_position_back_to_str_seq(\@string2, \@position_diffs)};
	  $array3{$name}=join(",", @position_corrected1); # array3 is for disply of seq.
  }                      # !! split and join char is ',';

  # %array3 has the form.  These numbers are position differences between the same sequences
  #                        one from str. one from seq.
  # seq1  1,1,2,3,.,2,3,.,1,.,0,0,0,1,1,1,1,1,2
  # seq2  1,1,2,1,.,1,3,.,1,.,0,0,1,0,1,1,1,3,2
  # seq3  1,1,2,3,.,2,3,.,1,.,1,1,0,0,1,1,1,3,2
  my(%final_posi_diffs) =%{&get_posi_diff_hash(\%array3)};
  my($sum_of_posi_diffs)=${&sum_hash(\%final_posi_diffs)};
  my($av_of_posi_diffs) =$sum_of_posi_diffs/(@names); # dividing by seq number.
  my($sum_seq_length)   =${&sum_array(\@whole_length)};
  my($av_rate)          =$av_of_posi_diffs/($sum_seq_length);
  \$av_rate;
}



#________________________________________________________________________
# Title     : print_seq_in_block_with_print
# Usage     : &print_seq_in_block (\%input_hash1,\%input_hash2, \%input_hash3.... );
# Function  : gets a ref(s) for hash and prints the content in lines of 60 char
# Example   :
# Warning   : derived from  print_in_block
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : Nothing, STDOUT
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub print_seq_in_block_with_print{
  my(%input)=%{$_[0]};
  my(@names)=keys(%input);
  my($larg, $offset, $diff, $gap_char);
  my($seq)=0;
  $gap_char='.';  # <-- setting default gap character.
  for ($i=0; $i <=$#names; $i++){
	 $larg = length($input{$names[$i]}) if length($input{$names[$i]}) > $larg;
	 if ($input{$names[$i]} =~ /\-/){
		$gap_char='-';
	 }elsif($input{$names[$i]} =~ /\./){
		$gap_char='.';
	 }
  }

		  ######====== filling the end part gaps in shorter sequences #####
	for ($i=0; $i <=$#names; $i++){
	  if (length($input{$names[$i]}) < $larg){
				$offset=length($input{$names[$i]});
					  $diff=$larg-$offset;
					  substr($input{$names[$i]}, $offset, $larg)= "$gap_char" x $diff;
			 }
	}
		  ######====== filling the end part gaps in shorter sequences #####

  for ($k=0; $k < $larg; $k+=60){     # 60 residues interval
	 for($i=0; $i <=$#names; $i++){    # number of sequences
		print $names[$i], "  \t";       # 2 spaces and tab between the names and sequences.
		$input{$names[$i]}=~ s/\n//g;
		$seq = substr($input{$names[$i]}, $k, 60);
		print $seq;
		print "\n";                     # put a new line.
	 }
	 print "\n";                       # next block starts.
  }
}
#________________________________________________________________________
# Title     : fill_ending_space
# Usage     : (*out, *out2, *out3)=&fill_ending_space(\%input1, \%input2, \%input3);
#             &print_seq_in_block(\%out,\%out2,\%out3); <-- if you want printout.
# Function  : fills the ending gaps or space of sequences (shorter ones)
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : (\%hash1,..... )
# Tips      :
# Argument  : (\%input1, \%input2, \%input3.....);
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fill_ending_space{
  my(@out_hash_list);
  my($gap_char,$larg);
  for($a=0; $a<@_; $a++){
	 my(%hash)=%{$_[$a]};
	 my(@names)=keys(%hash); $gap_char='.';
		for ($i=0; $i < @names; $i++){
		  if (length($hash{$names[$i]}) > $larg){ $larg =length($hash{$names[$i]});}
		  if($hash{$names[$i]} =~ /\-/){  $gap_char='-'; }
		  elsif($hash{$names[$i]} =~ /\./){ $gap_char='.'; }
		  $hash{$names[$i]}=~s/\s/$gap_char/g;  }
		for ($i=0; $i < @names; $i++){
		  if (length($hash{$names[$i]}) < $larg){ $offset=length($hash{$names[$i]});
				$diff=$larg-$offset;
				if ($diff == 0){ next; }
				substr($hash{$names[$i]}, $offset, $larg)= "$gap_char" x $diff; } }
		push(@out_hash_list, \%hash);  }
  if($#_ == 0){ return(\%hash); }
  elsif($#_ > 0){ return(@out_hash_list); } # <-- contains (\%out_seq0, \%out_seq1, \%out_seq2, .... )
}

#________________________________________________________________________
# Title     : print_seq_in_block_old
# Usage     : &print_seq_in_block_old (\%input_hash1,\%input_hash2, \%input_hash3.... );
# Function  : gets a ref(s) for hash (single key and value)
#             and prints the content in lines of 60 char
# Example   :
# Warning   : This is more or less for debugging. Use  print_seq_in_block
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : Nothing, STDOUT
# Tips      :
# Argument  : one or more refs. for hash
#               if there are more than one array input it makes such outputs
#
#             Name1    THIS.IS.from.hash.one
#             Name2    This
#
#             Name1    THIS
#             Name2    This.is.from.hash.two
#
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub print_seq_in_block_old{
  for ($i=0; $i <=$#_; $i++){
	 (${"name$i"}, ${"seq$i"}) = each (%{$_[$i]});
	 ${"seq$i"}=~ s/\n//g;               # rid of new line.
			@{"seq_array$i"}= split('', ${"seq$i"});
	 $larg = $#{"seq_array$i"} if ($#{"seq_array$i"} > $larg);
  }    # results = %hash1, %hash2, %hash3, ...
  for ($k=0; $k<=$larg; $k+=60){        # 60 residues interval
	 for($i=0; $i <=$#_; $i++){          # number of sequences
		print ${"name$i"}, "  \t";        # space between the names and sequences.
		for ($j=$k; $j<=($k+59); $j++){   # 1 to 60 and 61 to 120 etc...
		  print ${"seq_array$i"}[$j];     # prints one line
		}
		print "\n";                       # put a new line.
	 }
	 print "\n";                         # next block starts.
  }
}
#________________________________________________________________________
# Title     : print_in_block   (look at print_seq_in_block !!)
# Usage     : &print_in_block (\@input_array,\@input_array2, \@input_array3.... );
# Function  : gets a ref(s) for array and prints the content in lines of 60 char
# Example   :
# Warning   : This is more or less for debugging. Use  print_seq_in_block
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : Nothing, STDOUT
# Tips      :
# Argument  : one or more refs. for array
#               if there are more than one array input it makes such outputs
#             Example out)
#               THIS.IS.from.array.one
#             This.is.from.array.two
#
#              THIS.IS.from.array.one
#               This.is.from.array.two
#
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub print_in_block{
  for ($i=0; $i <=$#_; $i++){
	 @{"arr$i"}= @{$_[$i]}; my($larg) = $#{"arr$i"} if ($#{"arr$i"}>$larg);}
  for ($k=0; $k <=$larg; $k+=60){       # 60 residues interval
	 for($i=0; $i <=$#_; $i++){  print "name$i", "  \t";
		for ($j=$k; $j <=($k+59); $j++){ print ${"arr$i"}[$j]; }
		  print "\n";  } print "\n"; }
}

#________________________________________________________________________
# Title     : get_posi_diff    # used in 'get_posi_shift_hash'
# Usage     : @position_diffs =&get_posi_diff(\@seq_position1,\@seq_position2);
# Function  :
# Example   : @compacted_posi_dif =(1 ,2, 1, 1, '.' ,2,  1,  1, '.');
#             @compacted_posi_dif2=(4 ,2, 1, 1, ,2,  1, '.' ,3,  1);
#             output ==> ( 3 0 0 0 . 1 . 2 .)   (it ignores positions which have non digits.
#             output ==> (-3 0 0 0 . 1 .-2 .) when abs is not used.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. for an @array of differences of input arrays. array context.
# Tips      :
# Argument  : Takes two ref. for arrays which have positions of residues.
# Todo      :
# Author    : A Biomatic
# Version   : 1.4
# Used in   : evalign.pl, get_position_shift_rate
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_diff{
	my(@positions1)=@{$_[0]};
	my(@positions2)=@{$_[1]};
	my(@num_diffs_between_str_and_ali, $diff, $z, $gap_char);
	if($debug eq 1){
	  print __LINE__, " # get_posi_diff : \n";
	}
	$gap_char = '.';
	for ($z=0; $z < @positions2; $z++){
	  if (($positions1[$z] =~ /\d+/) && ($positions2[$z] =~ /\d+/)){
		  $diff=($positions1[$z] - $positions2[$z]);
		  push(@num_diffs_between_str_and_ali, $diff );
	  }else{
		  push(@num_diffs_between_str_and_ali, $gap_char);
	  }
	}
	\@num_diffs_between_str_and_ali;
}

#________________________________________________________________________
# Title     : get_posi_diff_abs    # used in 'get_posi_shift_hash'
# Usage     : @position_diffs =&get_posi_diff_abs(\@seq_position1,\@seq_position2);
# Function  :
# Example   : @compacted_posi_dif =(1 ,2, 1, 1, '.' ,2,  1,  1, '.');
#             @compacted_posi_dif2=(4 ,2, 1, 1, ,2,  1, '.' ,3,  1);
#             output ==> ( 3 0 0 0 . 1 . 2 .)   (it ignores positions which have non digits.
#             output ==> (-3 0 0 0 . 1 .-2 .) when abs is not used.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. for an @array of differences of input arrays. array context.
# Tips      :
# Argument  : Takes two ref. for arrays which have positions of residues.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_diff_abs{
	 my(@positions1)=@{$_[0]};  my(@positions2)=@{$_[1]};
	 my(@num_diffs_between_str_and_ali, $diff);
	 for ($z=0; $z<=$#positions2; $z++){
	  if (($positions1[$z] =~ /\d+/) && ($positions2[$z] =~ /\d+/))
	  {  # following abs is important for the behaviour of the output.
		  #push(@num_diffs_between_str_and_ali, (($positions1[$z] - $positions2[$z])) );
		  push(@num_diffs_between_str_and_ali, (abs($positions1[$z] - $positions2[$z])) );
	  }
 }
	 \@num_diffs_between_str_and_ali;
}


#________________________________________________________________________
# Title     : put_position_back_to_str_seq ( put_posi_back_to_str_seq )
# Usage     : @result =@{&put_position_back_to_str_seq(\@string_from_struct, \@compacted_posi_dif)};
# Function  :
# Example   : @string_from_struct=('X', 'T', 'A' ,'B' , '.' ,'F',  'G', '.' , 'O' ,'P', '.');
#             @compacted_posi_dif=(1 ,2, 1, 1, ,2, 1, 1, 1);
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for an array
# Tips      :
# Argument  : takes two refs for arrays (one for char the other for digits
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub put_position_back_to_str_seq{
  my(@string_from_struct)=@{$_[0]};
  my(@compacted_posi_dif)=@{$_[1]};
  my($j)=0; my($char)=0; my($i);
  for ($i=0; $i < @string_from_struct; $i++){
	 $char = $string_from_struct[$i];
	 if ($char =~ /\w/){
		 $string_from_struct[$i] = $compacted_posi_dif[$i-$j];
	 }else{ $j++; }
  }
  \@string_from_struct;
}

#________________________________________________________________________
# Title     : get_posi_shift_hash_rms
# Usage     : $result=${&get_posi_shift_hash_rm(\%h1, \%h2, \%h3)};
# Function  : caculates the error rate of seq after filtering according to
#                rms deviation.
# Example   :
# Warning   : Not complete yet.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_shift_hash_rms{  # minimum sub of 'get_posi_shift_rate'
  my(%array1)=%{$_[0]};
  my(%array2)=%{$_[1]};
  my(%array3)=%{$_[2]};
  my($string1, $string2, $av_rate, $rate,$sum_rate,
	  $sum_of_diff, $rate2);
  my(@seq_position1, @rates, @rates2,@seq_position2, @names, @position_diffs)=();
  %array1 = %{&hash_common(\%array1, \%array2)};
  %array2 = %{&hash_common(\%array2, \%array1)};
  %array3 = %{&hash_common(\%array3, \%array1)};
  %array1 = %{&remov_com_column(\%array1)}; # this removes wrong gaps(in '.' form, in MSF)
  %array2 = %{&remov_com_column(\%array2)};
  &show_hash(\%array1);
  &show_hash(\%array2);
  @names=sort keys %array1;
  for($j=0; $j<= $#names ; $j++){  # nf1 is the number of seq.
	 my($name)=$names[$j];
	 $string1=$array1{$name};
	 $string2=$array2{$name};
	 @seq_position1 = @{&get_posi_sans_gaps(\$string1)};
	 @seq_position2 = @{&get_posi_sans_gaps(\$string2)};
	 @position_diffs =@{&get_posi_diff(\@seq_position1, \@seq_position2)};
	 $sum_of_diff = ${&sum_array(\@position_diffs)};
	 print "sum of diff  $sum_of_diff";&n;
	 print "positions  $#position_diffs"; &n;
	 $rate2=$sum_of_diff/($#position_diffs+1);
	 push(@rates2, $rate2);
  }
  $av_rate = ${&array_average(\@rates2)};
  \$av_rate;
}

#________________________________________________________________________
# Title     : open_fil_file (fil file meant to be rms file)
# Usage     : %out = %{&open_fil_file(\$input_seq_file)};
# Function  : reads xxx.fil file which shows whether I have to discard
#             regions of sequences due to too big RMS deviation.
# Example   :
# Warning   : !!! not yet complete !!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for a hash(associative array).
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_fil_file{   # opening msf files. input is a file name.
  my($nf1)=-1;
  my($input_file)=${$_[0]};							# $_[0]=>input eg. $dir.$out_seq_no.msf
  my(@names, %arr);
  unless (-e $input_file){ print chr(007);  # beep warning for error
			print "\n\n\t This is sub open_fil_files in th_lib.pl \n\n";
			print "\n\n\t Fatal: The input file $file1 is not in the directory \n";
			print "\n\n\t  !!! Program dies abnormally, bugs !!! \n";
			&caller_info; &n; exit;
  }
  open(FILE_1,"$input_file");  			# reading in (MSF)
  while(<FILE_1>){         				# file1 needs to be xxxx.msf for the moment, automatic later
			if(/^\s.+/){ next; }
			if(/\-+/)  { next; }				# to prevent lines with '-' as in hmm Sean's output
			if(/^([\w_]+)[\t]* +(\d+)$/){ 		# matching patterns (including tab space)
					 &caller_info if (($1 !=1) || ($1 !=0));
					 my($temp1)=$1;
					 my($temp2)=$2;
					 $temp2=~s/ //g;				   # removing all the spaces in $2
					 if( ! $arr{$temp1}){     		# if hash %array1 is not defined,
								$names[++$nf1]=$temp1; 	# with first set (names for seq.)
					 }
					 $arr{$temp1}.= $temp2;   		# maay and concatenate second set to first set(name)
			}
  }
  \%arr;
}

#________________________________________________________________________
# Title     : send_mail
# Usage     :
# Function  : mail a bunch of @lines to a user
# Example   :
#             send_mail ( $to, $subject, @lines );
#             #-# i -- $to      = email address
#             #-# i -- $subject = string to be put in the Subject: line
#             #-# i -- @lines   = lines to be mailed - must not have \n
#             -- DISCUSSION:
#
#             Uses /usr/lib/sendmail to mail a bunch of lines to the email address
#             specified. The @lines should not have terminating \n characters: they
#             will be supplied.
#
#             -- EXAMPLE:
#             &P10::mail ( 'schip@lmsc.lockheed.com', 'Test 34', @mylines );
#             -- END
#             : Could some one share their knowledge of how to mail a message from
#             :  within a Perl script with a novice Perl user?
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : Mail_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : 3rao29$cbg@butch.lmsc.lockheed.com
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub send_mail{
	my ( $to, $subject, @lines ) = @_;
	my $pipe;
	$pipe = '|/usr/lib/sendmail -t';
	open ( $pipe, $pipe ) || die "Cannot open: '$pipe'\n";
	print $pipe "To: $to\n";
	print $pipe "Subject: $subject\n";
	print $pipe "\n";
	print $pipe join("\n",@lines),"\n";
	close $pipe;
}

#________________________________________________________________________
# Title     : rand_word
# Usage     : $word = &rand_word(7);
#             print "sub rand_word gives $word\n";
# Function  : This sub routine should return an alphabet string of
#             length specified by  an argument.
# Example   :
# Warning   :
# Class     :
# Keywords  : randomize words, makes random words,
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : from Perl news group
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rand_word {
	 my($length) = $_[0];
	 my($word, $letter);
	 srand(((time/$$)^($>*time))/(time/(time^$$)));

	 foreach (1..$length){
		  $letter = pack("c", rand(128));
		  redo unless $letter =~ /[a-zA-Z]/;   # I just don't like \w, okay?
		  $word .= $letter;
	 }
	 return($word);
}

#________________________________________________________________________
# Title     : opendir_and_go_rand_fasta_and_clustal
# Usage     : &opendir_and_go_rand_fasta_and_clustal(\$input_dir); #$inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
# Function  : open dir and process all files if you wish, and then go in any sub
#             dir of it. Using recursion. created by A Biomatic
#             if any file is linked, it skips that file.
# Example   : $inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
#             &opendir_and_go($inputdir);
# Warning   : Seems to work fine.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub opendir_and_go_rand_fasta_and_clustal{
  my($original_dir)=${$_[0]}; my(@read_files)=@{&read_any_dir(\$original_dir)};
  foreach $file(@read_files){
			 my($realfile1)=$original_dir.'/'.$file;
			 if (-l $realfile1){
					 print "\n\n$realfile1 is linked, skipping. \n";
					 next;
			 }elsif (-d $realfile1){
					 &opendir_and_go_rand_fasta_and_clustal(\$realfile1);
			 }elsif (-f $realfile1){ #<<------ This is where things match
					 chdir($original_dir);
					 $chk_file ='1-2-rev.fas';
					 if (-e $chk_file){
						 last;
					 }elsif($file =~/(\d+\-2)\.fas$/){
						 $out_file = "$1\-rand\.fas";
						 system("rand-fasta.pl $file $out_file");
						 system("clustalw $out_file");
					 }
			 }else{
					 next;
			 }
  }
}

#________________________________________________________________________
# Title     : opendir_and_go_rand_fasta
# Usage     : &opendir_and_go_rand_fasta(\$input_dir); #$inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
# Function  : open dir and process all files if you wish, and then go in any sub
#             dir of it. Using recursion. created by A Biomatic
#             if any file is linked, it skips that file.
# Example   : $inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
#             &opendir_and_go($inputdir);
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub opendir_and_go_rand_fasta{
		  my($original_dir)=${$_[0]};
		  my(@read_files)=@{&read_any_dir(\$original_dir)};
		  foreach $file(@read_files){
					 my($realfile1)=$original_dir.'/'.$file;
					 if (-l $realfile1){
								print "\n\n$realfile1 is linked, skipping. \n";
								next;
					 }elsif (-d $realfile1){
						 &opendir_and_go_rand_fasta(\$realfile1);
					 }elsif (-f $realfile1){ #<<------ This is where things match
								chdir($original_dir);

								  $chk_file ='1-2-rev.fas';
								  if (-e $chk_file){
									 last;
								  }elsif($file =~/(\d+\-2)\.fas$/){
									 $out_file = "$1\-rand\.fas";
											system("rand-fasta.pl $file $out_file");
								  }
					 }else{
								next;
					 }
		  }
}

#________________________________________________________________________
# Title     : rev_sequence_hash
# Usage     : %out = %{&rev_sequence_hash(\%input_seq_hash, \%hash2,...)};
# Function  : gets ref. of strings, reverses the elems.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more hash references.
# Tips      :
# Argument  : hash, eg(1, 'skdfj', 2, 'kdfjkdj', 3, 'kdfjk');
#             Input example:
#             ..
#             >HI0256
#             FLSANVLPIAPIINGGRTAVDNITQSVSDKPFVKDIGTKIKEAIALSKYSTQPQYISTTN
#             >HI0094
#             DILRTFVKMETGLKFPKKFKLKANLALFMNRRNKRPDTIMTAVADAGQKISEAKLNTTAK
#             ..
#
#             Output example: (Reversed :-)
#             ..
#             >HI0256_rv   <<-- Note the added extension
#             ALDJFLKAJFJALSDJFLAJSLFJAKLSDFJLASJDFLAJSLDFJASJDFLJSDFJSDLF
#             >HI0094_rv
#             KASJDFLKAJFJALSDJFLKSDJLFAJLKDJFLASJDFLKDFJKDJFKDJFKDJFKJDID
#             ..
#
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rev_sequence_hash{ my(%rev_hash, $name_with_ext, $i);
	for($i=0; $i<=$#_; $i++){ my(%in_hash)=%{$_[$i]};
		for $name (keys %in_hash){ $name_with_ext = "$name\_rv";
			$rev_hash{$name_with_ext}=reverse($in_hash{$name}); }
		push(@rev_hash_refs, \%rev_hash); }
	if(@rev_hash_refs ==1){ return($rev_hash_refs[0]);}else{ return(@rev_hash_refs);}
}

#________________________________________________________________________
# Title     : reverse_sequence_hash  same as  rev_sequence_hash
# Usage     : %out = %{&rev_sequence_one_hash(\%input_seq_hash, \%hash2,...)};
# Function  : gets ref. of strings, reverses the elems.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more hash references.
# Tips      :
# Argument  : hash, eg(1, 'skdfj', 2, 'kdfjkdj', 3, 'kdfjk');
#             Input example:
#             ..
#             >HI0256
#             FLSANVLPIAPIINGGRTAVDNITQSVSDKPFVKDIGTKIKEAIALSKYSTQPQYISTTN
#             >HI0094
#             DILRTFVKMETGLKFPKKFKLKANLALFMNRRNKRPDTIMTAVADAGQKISEAKLNTTAK
#             ..
#
#             Output example: (Reversed :-)
#             ..
#             >HI0256_rv   <<-- note the added extension
#             ALDJFLKAJFJALSDJFLAJSLFJAKLSDFJLASJDFLAJSLDFJASJDFLJSDFJSDLJ
#             >HI0094_rv
#             LASJDFLKAJFJALSDJFLKSDJLFAJLKDJFLASJDFLKDFJKDJFKDJFKDJFKJDLJ
#             ..
#
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub reverse_sequence_hash{
	my(%rev_hash, $name, $name_with_ext, $i);
	for($i=0; $i < @_; $i++){
	   my(%in_hash)=%{$_[$i]};
		for $name (keys %in_hash){
		   $name_with_ext = "$name\_rv";
			$rev_hash{$name_with_ext}=reverse($in_hash{$name});
		}
		push(@rev_hash_refs, \%rev_hash);
	}
	if(@rev_hash_refs ==1){ return($rev_hash_refs[0]);}
	else{ return(@rev_hash_refs);}
}
#________________________________________________________________________
# Title     : rev_sequence_mul_array
# Usage     : @out = @{&rev_sequence_mul_array(\@input_mul_seq_array)};
# Function  : gets a ref. of an string, reverses the elems.
# Example   :
# Warning   : This reverses sequences!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of  mul_array, eg. ('jfkdj', 'kdfjsdj', 'jjjkk')
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rev_sequence_mul_array{
  my(@in_array)=@{$_[0]};
  my(@rev_array, $reversed);
  for ($i = 0; $i <=$#in_array ; $i++){ $reversed =reverse($in_array[$i]);
	  push(@rev_array,$reversed);  }
  return(\@rev_array);
}


#________________________________________________________________________
# Title     : scramble_seq_hash (randomise the sequence positions)
# Usage     : %out = %{&scramble_seq_hash(\%input_seq_hash)};
# Function  : gets ref. of strings, scambles the elems.
# Example   :
# Warning   :
# Class     :
# Keywords  : make_scrambled_seq, make_scrambled_sequence
# Options   :
# Package   :
# Reference :
# Returns   : (\%hashout), or (\%hash1, \%hash2,,,,,)
# Tips      :
# Argument  : ref. of hash, eg(1, 'skdfj', 2, 'kdfjkdj', 3, 'kdfjk');
#
#             Input example:
#             ..
#             >HI0256
#             FLSANVLPIAPIINGGRTAVDNITQSVSDKPFVKDIGTKIKEAIALSKYSTQPQYISTTN
#             >HI0094
#             DILRTFVKMETGLKFPKKFKLKANLALFMNRRNKRPDTIMTAVADAGQKISEAKLNTTAK
#             ..
#
#             Output example: (scrambled :-)
#             ..
#             >HI0256_sc   <<-- note the added extension
#             ALDJFLKAJFJALSDJFLAJSLFJAKLSDFJLASJDFLAJSLDFJASJDFLJSDFJSDLJ
#             >HI0094_sc
#             LASJDFLKAJFJALSDJFLKSDJLFAJLKDJFLASJDFLKDFJKDJFKDJFKDJFKJDLJ
#             ..
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scramble_seq_hash{
   my($gap_char)='';
   my(@ran_hash_ref);
	for($i=0; $i< @_; $i++){
	  my(%in_hash)=%{$_[$i]};
	  my(@names)=keys %in_hash;
	  my($random,$ran_num,$ran_pos,@random );
	  srand(time()|$$);  # or use srand(time^$$);
	  for $name (@names){
		  if($in_hash{$name} =~ /\w\,\w\,/){ $gap_char=',';}else{ $gap_char=''; }
		  my(@input)=split(/$gap_char/,$in_hash{$name});
		  my($len1)=$#input+1;
		  my($len2)=$len1;
		  undef(@random);
		  for ($i=$len1; $i > 0 ; $i--){
			 $ran_pos = int(rand($i));
			 $ran_num=splice(@input, $ran_pos, 1);
			 push(@random, $ran_num);
		  }
		  $random=join("$gap_char", @random);
		  $ran_hash{"$name\_sc"}=$random;  }
	  push(@ran_hash_ref, \%ran_hash);  }
	if(@ran_hash_ref ==1){
	return($ran_hash_ref[0]);
	}else{ return(@ran_hash_ref);}
}

#________________________________________________________________________
# Title     : rand_sequence_mul_array  (not hash!)
# Usage     : @out = @{&rand_sequence_mul_array(\@input_mul_seq_array)};
# Function  : gets a ref. of an string, scambles the elem.
# Example   :
# Warning   : This scrambles sequences!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of  mul_array, eg. ('jfkdj', 'kdfjsdj', 'jjjkk')
# Tips      :
# Argument  : one ref. of mul_array, eg. ('lsjdfj', 'kdfjsdj', 'jjjkk')
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rand_sequence_mul_array{
  my(@in_array)=@{$_[0]};
  my(@ran_array, $random);
  srand(time()|$$);
  for ($i = 0; $i <=$#in_array ; $i++){
	my(@input)=split(//,$in_array[$i]);
	 my($len1)=$#input+1;
	 my($len2)=$len1;
	 my($ran_pos, $ran_num, $random, @random);
	 for ($k=$len1; $k > 0 ; $k--){ $ran_pos = int(rand($k));
		$ran_num=splice(@input, $ran_pos, 1); push(@random, $ran_num);  }
	 $random=join("",@random);
	 $ran_array[$i]=$random; }
  \@ran_array;
}
#________________________________________________________________________
# Title     : rand_sequence_one_string
# Usage     : @out = @{&rand_sequence_one_string(\$input_seq_string)};
# Function  : gets a ref. of a  string, scambles the elem.
# Example   :
# Warning   : This scrambles sequences!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of string,
# Tips      :
# Argument  : one ref. of string, eg ( 'ldkfjlsdjfsdjflj' )
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rand_sequence_one_string{
  my($input)=${$_[0]};
  my(@input)=split(//,$input);
  my($len1)=$#input+1;
  my($len2)=$len1;
  my($ran_pos, $ran_num, @random, $random);
  srand(time()|$$);
  for ($i=$len1; $i > 0 ; $i--){    $ran_pos = int(rand($i));
	 $ran_num=splice(@input, $ran_pos, 1);   push(@random, $ran_num); }
  $random=join("",@random);
  \$random;
}

#________________________________________________________________________
# Title     : rand_sequence_one_array
# Usage     : @out = @{&rand_sequence_one_array(\@input_seq_array)};
# Function  : gets a ref. of an array, scambles the elem.
# Example   :
# Warning   : This scrambles sequences!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array,
# Tips      :
# Argument  : one ref. of array, eg ('e', 'b', 'c', 'd')
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rand_sequence_one_array{ my(@input)=@{$_[0]};
  my($len1)=$#input+1;  my($len2)=$len1;  my($ran_num,@random,$ran_pos);
  srand(time()|$$);
  for ($i=$len1; $i > 0 ; $i--){   $ran_pos = int(rand($i));
	 $ran_num=splice(@input, $ran_pos, 1); push(@random, $ran_num); }
  \@random;
}

#________________________________________________________________________
# Title     : make_random_sequence
# Usage     : $protein = ${&make_random_sequence(1, 400)};
# Function  : gets one or more numbers for seq length and makes random sequences
#             It can handle proportional random sequenes according to the
#             amino acid occurance matrix.
# Example   : $out=${&make_random_sequence(@ARGV)};  While @ARGV can be '1 200 -p'
# Warning   :
# Class     :
# Keywords  : scramble_sequence, make_scrambled_sequence,
#             random_sequence, make_random_sequence, generate_random_protein_seq
#             create_random_sequene create_random_aa_sequence
# Options   : 'p' for proportional random sequence option
#             'f' for fastsa format output (returns one ref. of HASH)
# Package   :
# Reference :
# Returns   : one or more scalar references according to the input numbers.
# Tips      : Stolen from Sean's generate_aaseq.pl
# Argument  : 1 200 [-p] [@array_of_array_refs]
#             1 = num of seq, 200=leng of seq, -p =option, @arr.. = option
#             You can optionally give amino acid matrices
# Todo      :
# Author    : Sean Eddy, A Biomatic, A Bateman
# Version   : 1.4
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub make_random_sequence{
	#"""""""""""""""""< handle_arguments{ head Ver 1.5 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,
	$v,$w,$x,$y,$z);if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n"}
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my($seq_length, $residue, @out_seq_ref);
	if(@num_opt==1){
		$num_of_seq=1;
		$seq_length=$num_opt[0];
	}elsif(@num_opt ==2){
		$num_of_seq=$num_opt[0];
		$seq_length=$num_opt[1];
	}
	srand(time());
	if($char_opt=~/p/i){ ####### PROPORTIONAL random #####
	  my ($rand_protein_seq, $sum, $random);
	  if(@array>0){  # when matrices are given in @hash
		  @array1=@{$array[0]};
		  if($array1[0]=~/\d+/){
			  @aafq  =@array1;
			  @aminos=@{$array[1]};
		  }else{
			  @aminos=@array1;
			  @aafq  =@{$array[1]};
		  }
	  }else{
		  @aafq = (.08713, .03347, .04687, .04953, .03977,
				  .08861, .03362, .03689, .08048, .08536,
				  .01475, .04043, .05068, .03826, .04090,
				  .06958, .05854, .06472, .01049, .02992);

		  @aminos=("A",     "C",     "D",    "E",    "F",
				  "G",     "H",     "I",    "K",    "L",
				  "M",     "N",     "P",    "Q",    "R",
				  "S",     "T",     "V",    "W",    "Y");
	  }
	  if($debug==1){
		  printf("> rand%d random, from $0, len %d\n",
		  $i+1, $num_opt[0]);
	  }
	  for($j=0; $j<$num_of_seq; $j++){
		  my $rand_protein_seq, $random, $sum;
		  for($i=1; $i <= $seq_length; $i++){
			 $random=rand;
			 print "\n$random " if $debug ==1;
			 $sum =0;
			 for($x=0; $x< 20; $x++){
				$sum+=$aafq[$x];
				if( $sum >= $random){
					if($char_opt=~/f/i){
						$fasta{"rand${j}"} .=$aminos[$x]; last;
					}else{
						$rand_protein_seq .= $aminos[$x];
						last;
					}
				}
			 }
			 if($random > $sum){ $rand_protein_seq .= $aminos[19]; }
			 if( (!($i%60)) && ($char_opt=~/f/i) ){ $fasta{"rand${j}"} .= "\n" }
			 elsif( !($i%60) ){ $rand_protein_seq .= "\n" }
		  }
		  print "\nProportionasl Rand SEQ\n : $rand_protein_seq \n" if $debug ==1;
		  if($char_opt=~/f/i){ push(@fasta_out_ref, \%fasta) }
		  else{ push(@out_seq_ref, \$rand_protein_seq) }
	  }
	}else{
	  for($j=0; $j<$num_of_seq; $j++){
		 my $rand_protein_seq, $residue;
		 for $i (1..$seq_length) {
			$residue = pack("c", rand(128));
			redo unless $residue =~ /[ACDEFGHIKLMNPQRSTVWY]/i;
			if($char_opt=~/f/i){
				$fasta{"rand${j}"} .=$residue;
			}else{
				$rand_protein_seq .= $residue;
			}
			if( (!($i%60)) && ($char_opt=~/f/i) ){ $fasta{"rand${j}"} .= "\n" }
			elsif( !($i%60) ){ $rand_protein_seq .= "\n" }
		 }
		 $rand_protein_seq=~tr/a-z/A-Z/;
		 $fasta{"rand${j}"}=~tr/a-z/A-Z/;
		 if($char_opt=~/f/i){ push(@fasta_out_ref, \%fasta) }
		 else{ push(@out_seq_ref, \$rand_protein_seq) }
	  }
	}
	if($debug==1){ print "\n",%fasta, "\n" }
	if($char_opt=~/f/i){ return(@fasta_out_ref) }
	elsif(@out_seq_ref == 1){ return($out_seq_ref[0]); }
	elsif(@out_seq_ref > 1){ return(@out_seq_ref); }

}




#________________________________________________________________________
# Title     : rand_DNA_seq_generate  (produces randomized sequences)
# Usage     : $DNA = ${&rand_DNA_seq_generate(400)};
# Function  : gets one or more numbers for seq length and makes random sequences
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more scalar references according to the input numbers.
# Tips      :
# Argument  : (343) or (\$length)
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rand_DNA_seq_generate { my($seq_length,$rand_DNA_seq, @out_seq_ref,$i,$residue);
  for($i=0; $i<@_; $i++){
	 if( ref($_[$i]) && (ref($_[$i]) eq 'SCALAR') ){
		if(${$_[$i]} =~/\d+/){ $seq_length = ${$_[$i]}; }    }
	 elsif( !ref($_[$i]) ){ if($_[$i] =~/\d+/){ $seq_length = $_[$i]; }}
	 else{ print "\n rand_DNA_generate in $0 gets number\(s\) \n"; exit; }
	 srand(time()|$$);
	 for (1..$seq_length) {
		 $residue = pack("c", rand(128));  redo unless $residue =~ /[ACGT]/;
		 $rand_DNA_seq .= $residue;   }
	 push(@out_seq_ref, \$rand_DNA_seq);  }
  if(@out_seq_ref == 1){ return($out_seq_ref[0]); }
  elsif(@out_seq_ref > 1){ return(@out_seq_ref); }
}


#________________________________________________________________________
# Title     : rand_RNA_seq_generate  (produces randomized sequences)
# Usage     : $DNA = ${&rand_RNA_seq_generate(400)};
# Function  : gets one or more numbers for seq length and makes random sequences
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more scalar references according to the input numbers.
# Tips      :
# Argument  : (343) or (\$length)
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rand_RNA_seq_generate { my($seq_length,@out_seq_ref,$rand_RNA_seq, $i,$residue);
  for($i=0; $i<@_; $i++){
	 if( ref($_[$i]) && (ref($_[$i]) eq 'SCALAR') ){
		if(${$_[$i]} =~/\d+/){ $seq_length = ${$_[$i]}; }   }
	 elsif( !ref($_[$i]) ){ if($_[$i] =~/\d+/){ $seq_length = $_[$i]; } }
	 else{ print "\n rand_RNA_generate in $0 gets number\(s\) of them\n"; exit; }
	 srand(time()|$$);
	 for (1..$seq_length) {
		 $residue = pack("c", rand(128));  redo unless $residue =~ /[ACGU]/;
		 $rand_RNA_seq .= $residue;    }
	 push(@out_seq_ref, \$rand_RNA_seq);  }
  if(@out_seq_ref == 1){ return($out_seq_ref[0]); }
  elsif(@out_seq_ref > 1){ return(@out_seq_ref); }
}

#____________________________________________________________________________
# Title     : replace_text
# Usage     : &replace_text(\@input_array_of_filenames);
# Function  : finds patterns of text and replaces them in multiple input files
# Example   :
# Warning   : This produces a temporary file and rename it...
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : nothing
# Tips      :
# Argument  : reference of one array of file names in pwd
# Todo      :
# Author    : jong
# Version   : 1.3
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub replace_text{
  my ( @input_files );
  $|=1;
  my $old=shift ;
  my $new=shift;
  @input_files=@_;
  my($file);

  for $file(@input_files){
	 open (IN, "$file");
	 my @lines=<IN>;
	close(IN);
	 open (OUT, ">$file");
	 for (@lines){
		if($_=~/^(.*)($old)(.*)$/){
			print "\nmatched $_ in $file\n";
			$temp="$1$new$3\n";
			print OUT $temp;
		}else{
			print OUT $_;
		}
	 }
	 close OUT;
	 if($file =~/\.pl$/){ chmod 0755, $file; } # this makes it execu..
  }
}



#________________________________________________________________________
# Title     : get_av_seq_length
# Usage     : $std_devi_of_lengths = &get_av_seq_length(\%hash_ref);
# Function  : gets hash of sequence, compares lengths, and outs av.
# Example   :
# Warning   : uses a sub  &array_average(\@lengths);
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. for scaler digit.
# Tips      :
# Argument  : one hash reference for sequences.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_av_seq_length{
  my(%hash1)= %{$_[0]};
  my(@names)=keys %hash1;
  my($sequence, $len, @lengths, $av_seq_length);
  for $name (@names){  $sequence = $hash1{$name}; $sequence =~s/\W//g;
	 $len =length($sequence);  push(@lengths,$len); }
  $av_seq_length=&array_average(\@lengths);
  \$av_seq_length
}

#________________________________________________________________________
# Title     : get_sd_of_length_diff
# Usage     : $result = &get_sd_of_length_diff(\%input);
# Function  :
# Example   :
# Warning   : removes all non-char(.-, space....) in the input string
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one scaler digit
# Tips      :
# Argument  : gets one hash reference,
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_sd_of_length_diff{
  my(%hash1)= %{$_[0]};
  my(@names)=keys %hash1;
  my($sequence, $len, @lengths, $std_devi);
  for $name (@names){ $sequence = $hash1{$name};
	 $sequence =~s/\W//g; $len =length($sequence);
	 push(@lengths,$len); }
  $std_devi=&sd(\@lengths);
  \$std_devi;
}
#________________________________________________________________________
# Title     : get_av_and_sd_seq_length
# Usage     : $get_av_and_sd_seq_length= &get_av_seq_length(\%hash_ref);
# Function  : gets ref of hash of sequence, compares lengths, and outs av.
# Example   :
# Warning   : uses a sub  &array_average(\@lengths);
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : Two scaler digit.
# Tips      :
# Argument  : Two hash references for sequences.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_av_and_sd_seq_length{
  my(%hash1)= %{$_[0]};
  my(@names)=keys %hash1;
  my($sequence, $len, @lengths, $av_seq_length);
  for $name (@names){
	 $sequence = $hash1{$name}; $sequence =~s/\W//g; $len =length($sequence);
	 push(@lengths,$len); }
  $av_seq_length=${&array_average(\@lengths)};
  $std_devi=${&sd(\@lengths)};
  @av_seq_length_and_std_devi=($av_seq_length, $std_devi);
  return(\@av_seq_length_and_std_devi);
}

#________________________________________________________________________
# Title     : get_seq_hash_sans_gaps.pl
# Usage     : ($ref_out1, $ref_out2)=&get_seq_hash_sans_gaps(\%hash, \%hash);
#              %out=%{&get_seq_hash_sans_gaps(\%hash)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_seq_hash_sans_gaps{ my(@in)=@_; my(%in, @keys); my(@out_hash_ref, $k,%out_hash);
  for($k=0; $k<=$#in; $k++){  %in=%{$in[$k]}; @keys=keys %in;
	 for(@keys){ $in{$_}=~ s/[-.]//g;  $out_hash{$_}=$in{$_};  }
	 push(@out_hash_ref, \%out_hash);  }
  if($#out_hash_ref == 0){ return($out_hash_ref[0]); }
  elsif($#out_hash_ref > 0){  return(@out_hash_ref); }
}


#________________________________________________________________________
# Title     : get_posi_sans_gaps (get positions without after removing gaps)
# Usage     : @seq_position1 = &get_posi_sans_gaps($string1);
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : the positions of residues after removing gaps(but keeps pos).
#               used for analysis of shifted positions of seq. comparison.
# Tips      :
# Argument  : one scalar variable input of sequence string.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_sans_gaps{
  my($string) = ${$_[0]};
  my($char, @positions, $i);
  for($i=0; $i < length($string); $i++){
	 $char=substr($string,$i,1);
	 if(($char eq '-')||($char eq '.')){  next; }else{ push(@positions, $i); } }
  \@positions;
}

#________________________________________________________________________
# Title     : get_posi_shift_rate
# Usage     : $rate_final = &get_posi_shift_rate("perl.msf", "perl.jp");
# Function  :
# Example   :
# Warning   : sub  hash_common was unstable.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. for scalar value of shift rate of position for proteins.
# Tips      :
# Argument  : takes two file names for seq. and struc. alignment.
#             : Assumes the files are in the pwd.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_posi_shift_rate{
  my($test_seq_file, $struc_seq_file)=@_;
  my($string1, $string1, $av_rate, @rates, $rates_ref);
  $pwd = &pwd_path;
  $file1=$pwd.'/'.$test_seq_file;	# for clustalw alignment (usu, xxxx.msf)
  $file2=$pwd.'/'.$struc_seq_file;	# JPO's structural alignment (usu, xxxx.jp)
  if((-e $file1) && (-e $file2)){
		  %array1=&open_msf_files($file1);	# results are : %array1, %array2, @names1, @names2
		  %array2=&open_jp_files ($file2);
		  $ref_hash_1 = \%array1;
		  $ref_hash_2 = \%array2;
		  %array1 = &hash_common($ref_hash_1, $ref_hash_2);
		  %array2 = &hash_common($ref_hash_2, $ref_hash_1);
		  %array1 = &remov_com_column($ref_hash_1); # this removes wrong gaps(in '.' form, in MSF)
		  %array2 = &remov_com_column($ref_hash_2);
		  @names=sort keys %array1;print "\n\n";
		  $num_of_seq = $#names+1;  # <- this is true number of seq.
		  for($j=0; $j< $num_of_seq ; $j++){  # nf1 is the number of seq.
					  $name=$names[$j];
					  $string1=$array1{$name};
					  $string2=$array2{$name};
					  $ls=length($string1); 	# $ls is the whole length -1.
					  $ls2=length($string2);			# $string1 has the whole seq
					  $sum1=0; 		# $sum is for accumulating position difference
					  @seq_position1 = &get_posi_sans_gaps($string1);
					  @seq_position2 = &get_posi_sans_gaps($string2);
					  @position_diffs =&get_posi_diff(\@seq_position1, \@seq_position2);
					  $rate = &sd(@position_diffs);
					  push(@rates, $rate);
			}
			$rates_ref=\@rates;
			$av_rate = &array_average($rates_ref);
	}
	\$av_rate;
}

#________________________________________________________________________
# Title     : read_hssp_no_inserts
# Usage     : %anyarray = &read_hssp_no_inserts ($any_sequence_file_hssp_form);
# Function  : read hssp file and put sequences in a hash
# Example   :
# Warning   : It produces incomplete sequences when hssp seqs. have insertions.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   : read_hssp.pl, th_lib.pl,
# Enclosed  :
#--------------------------------------------------------------------
sub read_hssp_no_inserts {    								# reading hssp files. input is a file name.
	 my($input_file)=${$_[0]};	 # $_[0]=>input eg. $dir.$out_seq_no.hssp
	 my($whole_sequence,@names,%gaps,%second_hash,@chars);
	 my($c,$Sequence,$char,$no_of_seq, $AliNo, $first_part);
	 my($diff, $attachment, $second_part, $len_2nd_part);
	 unless (-e $input_file){
		 print chr(7);		     # beep warning for error
		 print "\n\n\t This is sub read_hssp_file  in th_lib.pl \n\n";
		 print "\n\n\t Fatal: The input file $file1 is not in the directory \n";
		 print "\n\n\t  !!! Program dies abnormally, bugs !!! \n";
		 &caller_info; print "\n"; exit;
	 }
	 open(FILE_1,"$input_file"); # reading in (hssp)
	 while(<FILE_1>){   		# file1 needs to be xxxx.hssp for the moment, automatic later
			 if (/PDBID\s+([\d\w]+)/){    # to get the test sequence file (mother sequence)
				 $names[0] = $1;           # put in an array as the first element.
				 next;                     # do not need to look at further.
			 }
			 if(/^\s+\d+ : ([\w_\d]+)\s+/){  # matching names part.
				 push(@names, $1);       # getting all other names of sequences.
				 next;                   # do not need to look at further.
			 }
			 $no_of_seq = $#names+1;        # true num. of seq. inc. mother sequence.
			 if(/^\s+\d+\s+\d+\s+([\w ]).+\d+ +\d+ +\d+  ([\w\t\s\.]+)$/){
				 $first_part  = $1;  # somehow this step is necessary(?)
				 $second_part = $2;  #
				 chomp($second_part);  # hssp has new line at the end. !! essential !!
				 $second_part =~ s/ /./g;  # converting all space to dots.
				 $len_2nd_part = length($second_part);
				 if ($len_2nd_part < $no_of_seq ){
						  $diff = ( $#names - $len_2nd_part);
						  $attachment = "."x($diff);  # filling spaces.
						  $second_part.=$attachment;
				 }
				 $whole_sequence .= $first_part.$second_part; # very long sequence.
				 $c+=1;             # counter for the whole lines
				 next;              # do not need to look at further.
			 } # <----the result of this if{} is a long string  $whole_sequence
			 if (/## SEQUENCE PROFILE AND ENTROPY/){
				 last;   # do not need to look at further.
			 }
	 }
	 @chars = split(//, $whole_sequence);  # putting into an array to handle
	 for ($i=0; $i < $c ; $i++){
		for ($k=0; $k<=$#names; $k++){
				  $char = shift( @chars);
				  $second_hash{$names[$k]} .= $char;
		}
	}
	\%second_hash; # this is the final output.
}
#________________________________________________________________________
# Title     : open_fasta_files
# Usage     : %fasta_seq=%{&open_fasta_files($fasta_file, ['MJ0084'])};
#             if you put additional seq name as MJ0084 it will
#             fetch that sequence only in the database file.
# Function  : open fasta files and put sequences in a hash
#             FASTA sequence file format is like this;
#
#             > 1st-seq
#             ABCDEFGHIJKLMOPABCDEFGHIJKLMOPABCDEFGHIJKLMOPABCDEFG
#             > 2nd.sequ
#             ABCDEFGHIJKLMOYYUIUUIUIYIKLMOPABCDEFGHIJKLMOPABCDEFG
#             ABCDEFGHIJKLMOPABCDEFGHIJKLMOPPABCDEFGHIJKLMOP
#
#             This can also return the sizes of sequences rather than seqs.
# Example   : %out = %{&open_fasta_files(@ARGV)};
#             while @ARGV at prompt was: 'GMJ.pep MJ0084'
# Warning   : well tested. It skips lines starting with blank, lines with '-' in them.
# Class     :
# Keywords  :
# Options   : Seq name to fetch the specified seq only.
#             as open_fasta_files.pl MY_SEQ_NAME Swissprot.fasta
#            -d  for giving back desc as well as the name. so it
#                gives  'HI0002 This is the description part'
#                as the key
#             If you put hash which is like('seq_name', ['20-30', '30-44',..])
#              it will produce hash which has got:
#              ( seq_name_20-30 'asdfasdfasdfasdfasd',
#                seq_name_30-44 'kljkljkjkjljkjljkll',
#                ....           .... )
#            -s for returning sequence size only
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 2.6
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_fasta_files{
	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   my %sequence, $S_start, $S_end, @seq_Names, %Sizes;
   for($i=0; $i< @file; $i++){
	  my($input_file) = ${$file[$i]} || $file[$i];

	  if($debug eq 1){ print "\n open_fasta_files: Inputfile is $input_file\n" };
	  unless (-e $input_file){
		  print chr(7);
		  print "\n\n\t This is sub open_fas_files in $0  \n\n";
		  print "\t Fatal: The input file $input_file is not in the directory \n";
	  }
	  open(FILE_1,"$input_file");
	  if(@hash >=1){
		 for($h=0; $h< @hash; $h++){
			@string=(@string, keys %{$hash[$h]});
		 }
	  }
	  if( (@_ > 1)&&(@string > 0) ){  # when seq to fetch is given
		my $seq_found;
		my $present_seq;
		while(<FILE_1>){         		# file1 needs to be xxxx.fasta for the moment, automatic later
		  for($j=0; $j<= @string; $j++){
			if(/^> *($string[$j]) *.*$/i){
			   $seq_found=1;
			   if($char_opt=~/[\-]?d/i){
				  $present_seq=$_;
			   }else{
				  $present_seq = $string[$j];
			   }
			   splice(@string, $j, 1); ## for optimization
			   last;
			}elsif( ($seq_found==1)&&(/^([\w\.\- ]+)$/) ){
			   $matched=$1;
			   $matched=~s/ //g;
			   $sequence{$present_seq}.= $matched if defined($present_seq);
			   last;
			}elsif(/^> *([\w\-\.]+) *.*$/i){
			   $seq_found=0;
			   $present_seq='';
			}
		  }
		}
	  }else{ # getting all seq in the given file(s)
		while(<FILE_1>){         		# file1 needs to be xxxx.fasta for the moment, automatic later
		  if(/^> *([\w\-\.]+) *.*$/){
			if($char_opt=~/[\-]?d/i){
			   $name=$_;
			}else{
			   $name=$1;
			}
		  }elsif(/^([\w\.\- ]+)$/){
			$matched=$1;
			$matched=~s/ //g;
			$sequence{$name}.= $matched if defined($name);
		  }else{  next; }
		}
	  }
	  close FILE_1;
   }
   if(defined(@range)){
	  %seq_fragments=%{&get_seq_fragments(\%sequence, \@range)};
	 return(\%seq_fragments);
   }elsif($char_opt=~/s/i){ # when SIZE return only option is set
	  @seq_Names=keys %sequence;
	  for($i=0; $i<@seq_Names; $i++){
		 $Sizes{$seq_Names[$i]}=length($sequence{$seq_Names[$i]});
	  }
	  return(\%Sizes);
   }elsif(@hash >=1){
	  for($h=0; $h< @hash; $h++){
	     my %hash=%{$hash[$h]};
		 my @Keys=keys %hash;
		 for($k=0; $k<@Keys; $k++){
			if(defined($hash{$Keys[$k]})){
			   ($S_start, $S_end)=$hash{$Keys[$k]}=~/(\d+)\-(\d+)/;
			   $sequence{$Keys[$k]}=substr($sequence{$Keys[$k]}, ($S_start-1), ($S_end-$S_start));
			}
		 }
	  }
	  return(\%sequence);
   }else{
	  return(\%sequence);
   }

}




#________________________________________________________________________
# Title     : open_pdbs_files
# Usage     : %fasta_seq_hash = &open_pdbs_files($any_sequence_file_fasta_form);
# Function  : open Tim Hubbard's pdbs_xx.seq files and put sequences in a hash
#             pdbs sequence file format is like this;
#            1cus   197 RTTRDDLINGNSASCADVIFIYARGSTETGNLGTLGPSIASNLESAFGKDGVWI
#
# Example   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_pdbs_files{
	$min_pep_leng=15; ## This is to filter very short peptide entries
							## pdb
	#=~~~~~~~~~( handle_arguments head 1.0 )~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#
	 my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	 my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	 my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	 my($i, $s, @names, %sequence, $flag,$name,$temp2);
	#=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#

	for($i=0; $i< @file; $i++){
		my($input_file) = ${$file[$i]} if ref($file[$i]);
		my($input_file) = $file[$i] if ! ref($file[$i]);
		if($debug eq 1){ print "\n inputfile is $input_file\n" };
		unless (-e $input_file){
		  print chr(7);
		  print "\n\n\t This is sub open_fas_files in $0  \n\n";
		  print "\t Fatal: The input file $input_file is not in the directory \n";
		}
		open(FILE_1,"$input_file");
		while(<FILE_1>){
		  if(/^(\w{4,10}) +\d+ +.*X.*/i){ next;}
		  if(/^(\w{4,10}) +\d+ +(\w{$min_pep_leng,})/){
			  $name=$1;
			  $sequence{$name}.= $2
		  }
		}
	}
	if($debug eq 1){
	  print __LINE__, " In open_fasta_files \%sequence is", %sequence ,"\n";
	}
	return(\%sequence);
}

#________________________________________________________________________
# Title     : msf_permute_hash_write
# Usage     : &msf_permute_hash_write(\%hash, $group_name); # void
# Function  : gets 2 references (one for %hash the other for group $name)
#             uses &msf_permute_array_write(\%hash, \$group_name)
#             the second arg is for output file name. can be anything.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub msf_permute_hash_write{ my(%hash)=%{$_[0]}; my($group_name)=${$_[1]};
  my(@array)= keys %hash;  &msf_permute_array_write (\@array, $group_name );
}

#________________________________________________________________________
# Title     : msf_permute_array_write
# Usage     : &msf_permu_array_write(\%hash, \$group_name); # void
# Function  :
#             the second arg is for output file name. can be anything.
#             used in &msf_permu_hash_write
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets 2 references
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub msf_permute_array_write{
  my(@array) =@{$_[0]};
  my($group_name)=${$_[1]};
  my($i,$j);
  for ($i=0;$i<@array;$i++) {
	 push(@result,$array[$i]);
	 if (@result>=2){
		  $count+=1;  # this is for the whole number of files(permutation) produced.
			for $key( @result){
			$input{$key}=$hash{$key};
		  }
		  $hash_ref_to_msfs_write=\%input;
					  #print %input;
					  @seq_names= (keys %input);
					  $seqno=($#seq_names) + 1;
					 #print $seqno;&n;
			$out_file_name="$group_name$count\-$seqno\.fas"; # output file name.
					  ###### eg. result file => perl1-2.fas, -2 means seq. no.
			&msf_write($hash_ref_to_msfs_write, $out_file_name);
	 }
		  %input=();
		  my(@input_array)=@array[$i+1..$#array];
		  &msf_permute_array_write(\@input_array) if $i<$#array;
			 #&msf_permu_array_write(@array[$i+1..$#array]) if $i<$#array;
		  pop(@result);  # <--this is essential.
  }
}

#________________________________________________________________________
# Title     : pir_permute_hash_write
# Usage     : &pir_permute_hash_write($hash_ref, $group_name); # void
# Function  : gets a reference of hash which has names and sequences as keys and values.
#             uses &pir_permute_array_write
#             the second arg is for output file name. can be anything.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pir_permute_hash_write{
  my(%hash);
  my($hash_ref)=$_[0];  my($group_name)=$_[1];
  %hash=%{$hash_ref};
  my(@array)= keys %hash;
  $array_ref1 = \@array;  &pir_permute_array_write ($array_ref1, $group_name );
}

#________________________________________________________________________
# Title     : fasta_permute_hash_write
# Usage     : &fasta_permute_hash_write($hash_ref, $group_name); # void
# Function  : gets a reference of a hash which has names and sequences as keys and values.
#             uses &fasta_permute_array_write
#             the second arg is for output file name. can be anything.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fasta_permute_hash_write{ my(%hash)=%{$_[0]}; my($group_name)=${$_[1]};
  my(@array)= keys %hash; $array_ref1 = \@array;
  &fasta_permute_array_write (\@array, \$group_name );
}
#________________________________________________________________________
# Title     : fasta_permute_array_write
# Usage     : &fasta_permu_array_write($hash_ref, $group_name); # void
# Function  : gets a reference of an array which has names and sequences as keys and values.
#             the second arg is for output file name. can be anything.
#             used in &fasta_permu_hash_write
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fasta_permute_array_write{
  my(@array)=@{$_[0]};
  my($group_name)=${$_[1]};
  my($i,$j, @result);
  for ($i=0;$i<@array;$i++) {
	 push(@result,$array[$i]);
	 if (@result>=2){
		$count+=1; # this is for the whole number of files produced.
		for $key( @result){
		  $input{$key}=$hash{$key};
		}
		$hash_ref_to_fastas_write=\%input;
		#print %input;
		@seq_names= (keys %input);
		$seqno=($#seq_names) + 1;
		#print $seqno;&n;
		$out_file_name="$group_name$count\-$seqno\.fas"; # output file name.
		###### eg. result file => perl1-2.fas, -2 means seq. no.
		&fastas_write($hash_ref_to_fastas_write, $out_file_name);
	 }
	 %input=();
		my(@input_array)=@array[$i+1..$#array];
		my($array_ref3)=\@input_array;
		&fasta_permute_array_write($array_ref3) if $i<$#array;
		#&fasta_permu_array_write(@array[$i+1..$#array]) if $i<$#array;
		pop(@result);  # <--this is essential.
	 }
}
#________________________________________________________________________
# Title     : ssp_permute_hash_write
# Usage     : &ssp_permute_hash_write($hash_ref, $group_name); # void
# Function  : gets a reference of hash which has names and sequences as keys and values.
#             uses &ssp_permute_array_write
#             the second arg is for output file name. can be anything.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub ssp_permute_hash_write{
  my(%hash);
  my($hash_ref)=$_[0]; my($group_name)=$_[1];
  %hash=%{$hash_ref}; my(@array)= keys %hash;
  $array_ref1 = \@array; &ssp_permute_array_write ($array_ref1, $group_name );
}

#________________________________________________________________________
# Title     : pir_permute_array_write
# Usage     : &pir_permu_array_write($hash_ref, $group_name); # void
# Function  : gets a reference of hash which has names and sequences as keys and values.
#             the second arg is for output file name. can be anything.
#             used in &pir_permu_hash_write
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pir_permute_array_write{
		  my($array_ref1)=$_[0];
		  my($group_name)=$_[1];
		  my($i,$j);
		  my(@array)=@{$array_ref1};
		  for ($i=0;$i<@array;$i++) {
					 push(@result,$array[$i]);
					 if (@result>=2){
								 $count+=1; # this is for the whole number of files produced.
								 for $key( @result){
											$input{$key}=$hash{$key};
								 }
								 $hash_ref_to_pirs_write=\%input;
								 #print %input;
								 @seq_names= (keys %input);
								 $seqno=($#seq_names) + 1;
								 #print $seqno;&n;
								 $out_file_name="$group_name$count\-$seqno\.fas"; # output file name.
											###### eg. result file => perl1-2.fas, -2 means seq. no.
								 &pir_write($hash_ref_to_pirs_write, $out_file_name);
					 }
					 %input=();
					 my(@input_array)=@array[$i+1..$#array];
					 my($array_ref3)=\@input_array;
					 &pir_permute_array_write($array_ref3) if $i<$#array;
						#&pir_permu_array_write(@array[$i+1..$#array]) if $i<$#array;
					 pop(@result);  # <--this is essential.
		  }
}
#________________________________________________________________________
# Title     : ssp_permute_array_write
# Usage     : &ssp_permu_array_write($hash_ref, $group_name); # void
# Function  : gets a reference of hash which has names and sequences as keys and values.
#             the second arg is for output file name. can be anything.
#             used in &ssp_permu_hash_write
#             ssp file is for PHD secondary structure prediction service.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub ssp_permute_array_write{
		  my($array_ref1)=$_[0];
		  my($group_name)=$_[1];
		  my($i,$j);
		  my(@array)=@{$array_ref1};
		  for ($i=0;$i<@array;$i++) {
					 push(@result,$array[$i]);
					 if (@result>=2){
								 $count+=1; # this is for the whole number of files produced.
								 for $key( @result){
											$input{$key}=$hash{$key};
								 }
								 $hash_ref_to_ssp_write=\%input;
								 #print %input;
								 @seq_names= (keys %input);
								 $seqno=($#seq_names) + 1;
								 #print $seqno;&n;
								 $out_file_name="$group_name$count\-$seqno\.fas"; # output file name.
											###### eg. result file => perl1-2.fas, -2 means seq. no.
								 &ssp_write($hash_ref_to_ssp_write, $out_file_name);
					 }
					 %input=();
					 my(@input_array)=@array[$i+1..$#array];
					 my($array_ref3)=\@input_array;
					 &ssp_permute_array_write($array_ref3) if $i<$#array;
						#&ssp_permute_array_write(@array[$i+1..$#array]) if $i<$#array;
					 pop(@result);  # <--this is essential.
		  }
}

#________________________________________________________________________
# Title     : permute
# Usage     : &permute(\@array);
# Function  : gets permutated array elements except single char elements.
#             fastest
# Example   :
# Warning   : from : Kenneth Albanowski <kjahds@kjahds.com> CIS: 70705,126)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub permute{ my(@array)= @{$_[0]}; my($i,$j);
	for ($i=0;$i<@array;$i++){ push(@result,$array[$i]);
		print join(" ",@result),"\n" if @result>=2;
		&permute(@array[$i+1..$#array]) if $i<$#array;
		pop(@result); }
}
#________________________________________________________________________
# Title     : permute_binary
# Usage     :
# Function  : outs permutated array elements
# Example   : &permute_binary(@array);
# Warning   : from : silly@ugcs.caltech.edu
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub permute_binary{  my(@a)=@_;
  for ($i = 1; $i < (1 << ($#a + 1)); $i++) {
  for ($tmp = $i, $bit = 0; $tmp; ($tmp >>= 1), $bit++) {
	 if ($tmp & 1) { print "@a[$bit]"; push (@result, @a[$bit]);}}
  print "\n"; }
}

#________________________________________________________________________
# Title     : ssp_write
# Usage     : two argments:  $seq_hash_reference  and $output_file_name
#             takes a hash which has got names keys and sequences values.
#             uses Perl5 pointers(references).
# Function  : writes multiple seqs. in fasta format (takes one or more than one seq.!!)
#             ssp is PHD server format.
# Example   : &ssp_write($hash_pointer, $out_file_name);
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub ssp_write{
			my($hash_ref1, $output_file)=@_;	# $name is the name of seq.
			my(%input)=%{$hash_ref1};
			open (SSP_WRITE,">$output_file");		# $string is the seq string.
			for $name(keys %input){
						my($ll)=0;								# $output_file is the name of output.
						$string=$input{$name};
						$string=~s/[ .-]//g;		# replaces all non-chars to null.
						$string=~tr/a-z/A-Z/;    # converts lower to upper cases.
						print SSP_WRITE "# $name.ssp\n";			# this writes only one seq. in one file.
						$ls2=length($string);					# use fasta_append for mul. lines of seq
						for($i=0; $i<$ls2; $i++){
								  $char=substr($string,$i,1);
								  print SSP_WRITE $char;
								  $ll++;
								  if($ll == 60){                # wraps at 60 char position.
											 $ll=0;
											 print SSP_WRITE "\n";
								  }
						}
						print SSP_WRITE "\n";
			}
}
#________________________________________________________________________
# Title     : pir_write
# Usage     : two argments:  $seq_hash_reference  and $output_file_name
#             takes a hash which has got names keys and sequences values.
#             uses Perl5 pointers(references).
# Function  : writes multiple seqs. in fasta format (takes one or more than one seq.!!)
#             pir is PHD server format.
# Example   : &pir_write($hash_pointer, $out_file_name);
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pir_write{
  my($hash_ref1, $output_file)=@_;	# $name is the name of seq.
  my(%input)=%{$hash_ref1};
  my(@names)=keys %input; my($name);
  open (pir_WRITE,">$output_file");		# $string is the seq string.
  print pir_WRITE "# PIR list  @names\n"; # This is !! essential for PHD !!!
  for $name(keys %input){
	 my($ll)=0;								# $output_file is the name of output.
	 $string=$input{$name};
	 $string=~s/[ .-]//g;		# replaces all non-chars to null.
	 $string=~tr/a-z/A-Z/;    # converts lower to upper cases.
	 print pir_WRITE ">P1;\n";
	 print pir_WRITE "$name\n";	# this writes only one seq. in one file.
	 $ls2=length($string);					# use fasta_append for mul. lines of seq
	 for($i=0; $i<$ls2; $i++){
		$char=substr($string,$i,1);
		print pir_WRITE $char;
		$ll++;
		if($ll == 60){                # wraps at 60 char position.
		  $ll=0;
		  print pir_WRITE "\n";
		}
	 }
	 print pir_WRITE "\n";
  }
}
#________________________________________________________________________
# Title     : msf_write
# Usage     : two argments:  $seq_hash_reference  and $output_file_name
#             takes a hash which has got names keys and sequences values.
#             uses Perl5 pointers(references).
# Function  : writes multiple seqs. in msf format (takes one or more than one seq.!!)
# Example   : &msf_write(\%hash, \$out_file_name);
#             - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#             PileUp
#
#
#             MSF: 1205  Type: P    Check:  9937   ..
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub msf_write{
	$| =1;
	my(%input)=%{$_[0]};
	my($output_file)=${$_[1]};
	my($string);
	open (msf_WRITE,">$output_file");		# $string is the seq string.

	print msf_WRITE '   MSF: 1205  Type: P    Check:  9937   .. '; ## This is dummy
	print msf_WRITE "\n\n";

	my(@names) = keys %input;
	my($larg)  = length($input{$names[0]});

	for $name (keys %input){
	  $len = length($input{$name});
	  printf msf_WRITE (" Name: %-15s oo  Len: %-5s Check:  9999  Weight:  1.00\n", $name, $len);
	}
	print msf_WRITE "\n";
	print msf_WRITE "\/\/\n\n\n\n";

###################################################
####             MSF file form           ##########
###################################################
format msf_WRITE =
@<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$names,         $seq
.
  for ($k=0; $k < $larg; $k+=50){    # 50 residues interval
	 for($i=0; $i < @names; $i++){    # number of sequences
		$names = $names[$i];
		$input{$names[$i]}=~ s/\n//g;
		$seq = substr($input{$names[$i]}, $k, 50);
		$seq = put_gaps_every_x_position_in_string($seq, 10, ' ');
		select (msf_WRITE); ## to print out to a FILE
		#$~='msf_WRITE';
		write msf_WRITE;
	 }
	 print "\n";                       # next block starts.
  }
}

#________________________________________________________________________
# Title     : pir_write
# Usage     : two argments:  $seq_hash_reference  and $output_file_name
#             takes a hash which has got names keys and sequences values.
#             uses Perl5 pointers(references).
# Function  : writes multiple seqs. in fasta format (takes one or more than one seq.!!)
# Example   : &pir_write($hash_pointer, $out_file_name);
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pir_write{
			my($hash_ref1, $output_file)=@_;	# $name is the name of seq.
			my(%input)=%{$hash_ref1};
			open (pir_WRITE,">$output_file");		# $string is the seq string.
			for $name(keys %input){
						my($ll)=0;								# $output_file is the name of output.
						$string=$input{$name};
						$string=~s/[ .-]//g;		# replaces all non-chars to null.
						$string=~tr/a-z/A-Z/;    # converts lower to upper cases.
						print pir_WRITE ">P1;\n";			# this writes only one seq. in one file.
						print pir_WRITE "$name\n";
						$ls2=length($string);					#
						for($i=0; $i<$ls2; $i++){
								  $char=substr($string,$i,1);
								  print pir_WRITE $char;
								  $ll++;
								  if($ll == 60){                # wraps at 60 char position.
											 $ll=0;
											 print pir_WRITE "\n";
								  }
						}
						print pir_WRITE "\n";
			}
}
#________________________________________________________________________
# Title     : write_fasta
# Usage     : many argments:  $seq_hash_reference  and $output_file_name
#             takes a hash which has got names keys and sequences values.
# Function  : writes multiple seqs. in fasta format (takes one or more seq.!!)
# Example   : &write_fasta(\%in1, \$out_file_name, \%in2, \%in3,..., );
#             << The order of the hash and scalar ref. doesn't matter. >>
# Warning   : The default output file name is 'default_out.fa' if you do not
#             specify output file name.
#             OUTput file should have xxxxx.fa or xxxx.any_ext NOT just 'xxxxx'
# Class     :
# Keywords  : write_fasta_file, print_fasta_file, write fasta file, fasta_write
#             show_fasta
# Options   : v for STD out.
# Package   :
# Reference :
# Returns   :
# Tips      : To print out each fasta seq into each single file, use
#             write_fasta_seq_by_seq
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.5
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_fasta{
	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my($string, $na,$out_file_name_provided);
	my($output_file) ='default_out.fa'; ### when no output file name is given, this is used
	if(@file>0){
	  $output_file = $file[0];
	}else{ $output_file='default_out.fa'; }

  for ($k=0; $k < @hash; $k++){
	  if (ref($hash[$k]) eq "HASH"){
		 (%{"input$k"})=%{$hash[$k]};
		 @{"names$k"}= sort keys(%{"input$k"});
		 for($i=0; $i < @{"names$k"}; $i++){
			 if (${"input$k"}{${"names$k"}[$i]} =~ /\,/){
				 ${"input$k"}{${"names$k"}[$i]}=~ s/\,//g;  # <<-- if there are
			 }  # eg)  ('A,B,C,D,E')--> (ABCDE)           # seperators like ','
		 }                                              # in seqs, this removes them
	  }
  }

  open (FASTAS_WRITE,">$output_file");		# $string is the seq string.
  for ($n=0 ; $n < @hash; $n ++){
	 for ($i=0; $i < @{"names$n"}; $i++){
		$na= ${"names$n"}[$i];
		$string = ${"input$n"}{$na};  # this equals ==  ${"input$n"}{${"names$n"}[$i]}
		$string=~s/[\n \.-]//g;	    # replaces all non-chars to null.
		$string=~tr/a-z/A-Z/;
		if($debug == 1){
			print ">$na\n";
			print FASTAS_WRITE ">$na\n";
	  }elsif($char_opt=~/v/){
		 print ">$na\n";
		 print FASTAS_WRITE ">$na\n";
		}else{
		   print  FASTAS_WRITE ">$na\n";
		}
		for($j=0; $j<length($string); $j+=60){
			if($debug == 1){
			printf "%.60s\n", substr($string,$j,60);
				printf FASTAS_WRITE "%.60s\n", substr($string,$j,60);
			}elsif($char_opt=~/v/){
			   printf "%.60s\n", substr($string,$j,60);
			   printf FASTAS_WRITE "%.60s\n", substr($string,$j,60);
		   }else{
			printf FASTAS_WRITE "%.60s\n", substr($string,$j,60);
			}
		}
	 }
  }
  close FASTAS_WRITE;
  if( $out_file_name_provided != 1){
	  print "\n\n You did not provided the output file name, default used\n";
  }
  if( -s $output_file){
	 print "\n Sequences were written in  $output_file ";
  }else{
	 print "\n The size of written outfile \"$output_file\" is 0, error \n\n" }
}


#________________________________________________________________________
# Title     : write_fasta_seq_by_seq
# Usage     : &write_fasta_seq_by_seq(\%hash, [\$extension]);
# Function  : accepts one hash of multiple sequences and writes many files
#             of single sequences by using the names as file names.
#             If $extension is provided, it writes an output as in
#             the below example (seq1_sc.fasta). If not, it just attach
#             'fasta' to files.
# Example   : with >xxxx
#                  ASDFASDFASDFASDFASDFASDFASDF
#                  >yyyy
#                  ASDFASDFASDFASDFASDFASDFSDAFSD
#
#             You will get two files (xxxx.fa, yyyy.fa)
# Warning   :
# Class     :
# Keywords  : write_each_fasta, write_single_fasta, write_fasta_single
#             single_fasta_write, write_fasta_files_seq_by_seq,
#             write_single_fasta_files,
# Options   : can specify extension name.
# Package   :
# Reference :
# Returns   : nothing.
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub write_fasta_seq_by_seq{
	 my(%temp_hash);
	 my(%input)     =%{$_[0]};
	 my($extension) =${$_[1]} if (@_ == 2);
	 my($extension) =$_[1] if ((@_ == 2)&& !(ref($_[1])) );
	 for $key (keys %input){
		%temp_hash =%{"$key"};
		$temp_hash{$key}=$input{$key};
		if (($key=~ /\_$extension$/)||($#_ == 0)){
			$output_file = "$key\.fa";
		}else{
			$output_file = "$key\_$extension\.fa";
		}
		&write_fasta(\%temp_hash, \$output_file);
	 }
}



#________________________________________________________________________
# Title     : show_in_fasta
# Usage     : &show_hash_in_fasta(\%in1, \%in2, \%in3, .... );
#             takes a hash which has got names keys and sequences values.
#             uses Perl5 pointers(references).
# Function  : shows multiple seqs. in fasta format (takes one or more seq.!!)
# Example   : &show_in_fasta(\%hash);
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub show_in_fasta{ my($k, $name, $string);
  for ($k=0; $k<=$#_; $k++){
	 my(%input) = %{$_[$k]};
	 for $name(keys %input){
		my($ll)=0;								# $output_file is the name of output.
		$string=$input{$name};
		$string=~s/\n//g;
		$string=~tr/a-z/A-Z/;   # converts lower to upper cases.
		print ">$name\n";	      # this writes only one seq. in one file.
		for($i=0; $i<length($string); $i+=60){
		  printf "%.60s\n", substr($string,$i,60);
		}
		print "\n";
	 }
  }
}



#________________________________________________________________________
# Title     : One_To_Three_Letter  ( amino acid code change)
# Usage     : %one_letter  = %{&One_To_Three_Letter};   # takes no arguments (void).
# Function  : a hash of one letter to 3 letter amino acid code , returns a hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub One_To_Three_Letter{  my(%one_letter) =
  ( "A", "Ala",  "C", "Cys",  "D", "Asp",  "E", "Glu",  "F", "Phe",
	 "G", "Gly",  "H", "His",  "I", "Ile",  "K", "Lys",  "L", "Leu",
	 "M", "Met",  "N", "Asn",  "P", "Pro",  "Q", "Gln",  "R", "Arg",
	 "S", "Ser",  "T", "Thr",  "V", "Val",  "W", "Trp",  "Y", "Tyr"   );
  return(\%one_letter);
}
#________________________________________________________________________
# Title     : ONE_TO_THREE_LETTER  ( amino acid code change)
# Usage     : %one_letter  = %{&ONE_TO_THREE_LETTER };   # takes no arguments (void).
# Function  : a hash of one letter to 3 letter amino acid code , returns a hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub ONE_TO_THREE_LETTER{  my(%one_letter) = (
	 "A", "ALA",  "C", "CYS",  "D", "ASP",  "E", "GLU",  "F", "PHE",
	 "G", "GLY",  "H", "HIS",  "I", "ILE",  "K", "LYS",  "L", "LEU",
	 "M", "MET",  "N", "ASN",  "P", "PRO",  "Q", "GLN",  "R", "ARG",
	 "S", "SER",  "T", "THR",  "V", "VAL",  "W", "TRP",  "Y", "TYR"   );
  return(\%one_letter);
}
#________________________________________________________________________
# Title     : one_to_three_letter  ( amino acid code change)
# Usage     : %one_letter  = %{&one_to_three_letter};   # takes no arguments (void).
# Function  : a hash of one letter to 3 letter amino acid code , returns a hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub one_to_three_letter{  my(%one_letter) = (
	 "a", "ala",  "c", "cys",  "d", "asp",  "e", "glu",  "f", "phe",
	 "g", "gly",  "h", "his",  "i", "ile",  "k", "lys",  "l", "leu",
	 "m", "met",  "n", "asn",  "p", "pro",  "q", "gln",  "r", "arg",
	 "s", "ser",  "t", "thr",  "v", "val",  "w", "trp",  "y", "tyr"   );
  return(\%one_letter);
}
#________________________________________________________________________
# Title     : THREE_TO_ONE_LETTER  ( amino acid code change)
# Usage     : %one_letter  = %{&THREE_TO_ONE_LETTER};   # takes no arguments (void).
# Function  : a hash of one letter to 3 letter amino acid code , returns a hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub THREE_TO_ONE_LETTER{  my(%AA);
	 $AA{"ALA"} = "A";  $AA{"MET"} = "M";  $AA{"ASP"} = "D";  $AA{"PRO"} = "P";
	 $AA{"CYS"} = "C";  $AA{"ASN"} = "N";  $AA{"GLU"} = "E";  $AA{"GLN"} = "Q";
	 $AA{"PHE"} = "F";  $AA{"ARG"} = "R";  $AA{"GLY"} = "G";  $AA{"SER"} = "S";
	 $AA{"HIS"} = "H";  $AA{"THR"} = "T";  $AA{"ILE"} = "I";  $AA{"VAL"} = "V";
	 $AA{"LYS"} = "K";  $AA{"TRP"} = "W";  $AA{"LEU"} = "L";  $AA{"TYR"} = "Y";
	return(%AA);
}
#________________________________________________________________________
# Title     : three_to_one_letter  ( amino acid code change)
# Usage     : %three_letter  = &three_to_one_letter ;   # takes no arguments (void).
# Function  : a hash of one letter to 3 letter amino acid code , returns a hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub three_to_one_letter{  my(%aa);
	 $aa{"ala"} = "a";  $aa{"met"} = "m";  $aa{"asp"} = "d";  $aa{"pro"} = "p";
	 $aa{"cys"} = "c";  $aa{"asn"} = "n";  $aa{"glu"} = "e";  $aa{"gln"} = "q";
	 $aa{"phe"} = "f";  $aa{"arg"} = "r";  $aa{"gly"} = "g";  $aa{"ser"} = "s";
	 $aa{"his"} = "h";  $aa{"thr"} = "t";  $aa{"ile"} = "i";  $aa{"val"} = "v";
	 $aa{"lys"} = "k";  $aa{"trp"} = "w";  $aa{"leu"} = "l";  $aa{"tyr"} = "y";
  return(\%aa);
}
#________________________________________________________________________
# Title     : Three_To_One_Letter  ( amino acid code change)
# Usage     : %Aa  = &Three_To_One_Letter ;   # takes no arguments (void).
#              $Aa('Ala');  will return 'A'
# Function  : a hash of one letter to 3 letter amino acid code , returns a hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub Three_To_One_Letter{ my(%Aa);
  $aa{"Ala"} = "A";  $aa{"Met"} = "M";  $aa{"Cys"} = "C";  $aa{"Asn"} = "N";
  $aa{"Asp"} = "C";  $aa{"Pro"} = "P";  $aa{"Glu"} = "E";  $aa{"Gln"} = "Q";
  $aa{"Phe"} = "F";  $aa{"Arg"} = "R";  $aa{"Gly"} = "G";  $aa{"Ser"} = "S";
  $aa{"His"} = "H";  $aa{"Thr"} = "T";  $aa{"Ile"} = "I";  $aa{"Val"} = "V";
  $aa{"Lys"} = "K";  $aa{"Trp"} = "W";  $aa{"Leu"} = "L";  $aa{"Tyr"} = "Y";
  return(\%Aa);
}


#________________________________________________________________________
# Title     : amino_acid_compos_id_percent
# Usage     : $percent = &amino_acid_compos_id_percent (%any_hash_with_sequences);
#             The way identity(composition) is derived is;
#
# Function  : gets amino acid composition identity of any given
#             number of sequences(at least 2).
# Example   :
# Warning   :
# Class     :
# Keywords  : get_amino_acid_composition, get_protein_composition, composition
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : hash of at least 2 sequences.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub amino_acid_compos_id_percent{
  my(%input)= %{$_[0]};
  my(@names)=keys (%input);
  my(@temp, $i, $j, $iden, @all_pairs_id, $iden_sum);
  my(%compos_table1, %compos_table2, $final_iden, $larger);
  for ($i=0; $i < @names; $i ++){  # putting seqs in arrays.
	 $input{$names[$i]}=~ tr/a-z/A-Z/;
	 $input{$names[$i]}=~ s/\W//g;
	 @{"string$i"}= split('', $input{$names[$i]});
	 $larger = @{"string$i"} if @{"string$i"} > $larger;
  }
  for ($i=0; $i < @names; $i++){   # to make permutated pairs.
	 for ($j=$i; $j < @names; $j ++){
		if ($j == $i){ next; }
		for ($k=0; $k < $larger; $k ++){  # getting composition tables for two seqs.
		  $compos_table1{${"string$i"}[$k]}++ if (${"string$i"}[$k] =~ /\w/);
		  $compos_table2{${"string$j"}[$k]}++ if (${"string$j"}[$k] =~ /\w/);
		}
		$iden = ${&common_compos_id_hash(\%compos_table1, \%compos_table2)};
		%compos_table1=();  %compos_table2=();
		push (@all_pairs_id,  $iden );
	 }
  }
  for $iden (@all_pairs_id){  $iden_sum+= $iden;  }
  if(@all_pairs_id == 0){ @all_pairs_id =1; }
  $final_iden=$iden_sum/@all_pairs_id;
  \$final_iden;
}

#________________________________________________________________________
# Title     : seq_id_percent_array  (more than 2 elements array)
# Usage     : $percent = &seq_id_percent_array(@any_array_sequences);
#             The way identity(pairwise) is derived is;
#
# Function  : produces amino acid composition identity of any given number of sequences.
# Example   :
# Warning   : This can handle 'common gaps' in the sequences
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub seq_id_percent_array{ my(@input, $denominator,@all_pairs_id, $percent_id);
	my($largest,$p,$i,$j,$k,$iden_residue_num,$iden,@temp,$iden_sum,$gap_num,$final_iden);
	for($d=0; $d<@_; $d++){
		if(ref($_[$d]) eq 'ARRAY'){ @input=@{$_[$d]}; }
		elsif( (ref($_[$d]) eq 'SCALAR') &&( ${$_[$d]}=~/^[aA]/) ){ $average_len_opt =1 }
		elsif( !(ref($_[$d])) && ( $_[$d] =~/^[aA]/) ){ $average_len_opt =1 } }
	if ((@input== 1)||( @input== 0)){
		print "\n\n \" $0 \"  requires at least 2 sequences\n\n";
		print "\n Abnormally dying at seq_id_percent_array in $0 \n\n"; print chr(7); exit;}
	$shortest=length($input[0]); my($sans_gap_seq, $length_sum, $average_seq_len);
	for($p=0; $p < @input; $p++){
		$input[$p]=~ tr/a-z/A-Z/; $sans_gap_seq=$input[$p];  $sans_gap_seq=~s/\W//g;
		$input[$p]=~ s/\W/./g;  (@{"string$p"})=split('', $input[$p]);
		$largest = length($input[$p]) if length($input[$p]) > $largest;
		$shortest = length($sans_gap_seq) if length($sans_gap_seq) < $shortest;
		$length_sum += length($sans_gap_seq);     }
	$average_seq_len = $length_sum/@input;
	for($i=0; $i< @input; $i++){
		for($j=$i+1; $j< @input; $j++){
			for ($k=0; $k <  $largest; $k ++){  # getting composition tables for two seqs.
				if ((${"string$i"}[$k] !~ /\W/)&&(${"string$i"}[$k] eq ${"string$j"}[$k])){
					$iden_residue_num++; }
				elsif((${"string$i"}[$k] =~ /\W/)&&(${"string$i"}[$k]=~ /\W/)){ $gap_num++; }}
			if( $average_len_opt == 1){ $denominator = $average_seq_len; }
			else{ $denominator = $shortest; }
			if($denominator == 0){ $denominator=1; }  # in the above it is 50% rather than 0.07%
			$percent_id=($iden_residue_num/($denominator))*100;
			push(@all_pairs_id, $percent_id);
			undef ($iden_residue_num, $gap_num); } }
	for (@all_pairs_id){  $iden_sum+=$_;    }
	$final_iden=$iden_sum/($#all_pairs_id+1); return( \$final_iden );
}

#________________________________________________________________________
# Title     : compos_id_percent_array  (more than 2 elements array)
# Usage     : $percent = &compos_id_percent_array(@any_array_sequences);
#             The way identity(composition) is derived is;
# Function  : produces amino acid composition identity of any given number of sequences.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   : get_windows_compos_and_seqid_rate_array,
#
# Enclosed  :
#--------------------------------------------------------------------
sub compos_id_percent_array{
   my(@input)=@{$_[0]};
   my($largest,$iden,@temp,$iden_sum,$final_iden, @all_pairs_id);
	for($i=0; $i<=$#input; $i++){  $input[$i]=~ tr/a-z/A-Z/;  $input[$i]=~ s/[\.\-\s]//g;
		@temp = split('', $input[$i]);  (@{"string$i"})= @temp;
		$largest = @{"string$i"} if @{"string$i"} > $largest;    }
	for($i=0; $i< @input; $i++){ #_________ permutating ___________
		for($j=$i+1; $j<=$#input; $j++){
			for ($k=0; $k <= $largest; $k ++){  # getting composition tables for two seqs.
				$compos_table1{${"string$i"}[$k]}++ if (${"string$i"}[$k] =~ /\w/);
				$compos_table2{${"string$j"}[$k]}++ if (${"string$j"}[$k] =~ /\w/);   }
			$iden =${&calc_compos_id_hash(\%compos_table1, \%compos_table2)};
			push(@all_pairs_id, $iden);  %compos_table1=();  %compos_table2=();   }   }
	for $iden (@all_pairs_id){  $iden_sum+=$iden;  }
	$final_iden=$iden_sum/(@all_pairs_id);
	#-----------------------------------------------------
	#  Input here is like :  %hash1= (A,3,B,3,C,4,D,4), %hash2= (A,4,B,1,C,4)
	sub  calc_compos_id_hash{  # input is like this;
	  my(%hash1)=%{$_[0]};
	  my(%hash2)=%{$_[1]};
	  my(%common_of_the_2)=();
	  my($common, $compos_id, $sum_residues, $sum_of_the_common_residue_no);
	  my(@values1) = values (%hash1);
	  my(@values2) = values (%hash2);
	  my(@combined_values)=(@values1,@values2);
	  for $elem (@combined_values){  $sum_residues += $elem;   }
	  if($sum_residues == 0){ $compos_id =0; } # to prevent Illegal division error.
	  else{ for $key1(keys %hash1){
				 $common=&smaller_one($hash1{$key1}, $hash2{$key1});
					 sub smaller_one{if ($_[0] > $_[1]){ $_[1];}else{$_[0];}}
				 $sum_of_the_common_residue_no += $common;     }
			 $compos_id = $sum_of_the_common_residue_no/($sum_residues/2)*100;   }
	  \$compos_id;
	}
	#-----------------------------------------------------
	return ( \$final_iden ); # final identity for any given set of strings(seq).
}

#________________________________________________________________________
# Title     : compos_id_percent_hash  (synonym of amino_acid_compos_id_percent)
# Usage     : $percent = &compos_id_percent_hash(%any_hash_with_sequences);
#             The way identity(composition) is derived is;
#
# Function  : gets amino acid composition identity of any given number of sequences.
# Example   :
# Warning   :
# Class     :
# Keywords  : get_amino_acid_composiiton
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub compos_id_percent_hash{ my(%input, @names);
  if(ref($_[0]) eq 'HASH'){  %input= %{$_[0]}; @names= keys  %input;  }
  else{ print "\n hash ref was not passed to compos_id_percent_hash\n"; exit; }
  my(@temp, $iden, @all_pairs_id, $i, $j, $k,$iden_sum);
  my(%compos_table1, %compos_table2, $final_iden, $larger);
  for ($i=0; $i < @names; $i ++){  $input{$names[$i]}=~ tr/a-z/A-Z/;
	 $input{$names[$i]}=~ s/\W//g;    @temp = split('', $input{$names[$i]});
	 (@{"string$i"})=@temp; $larger = @{"string$i"} if @{"string$i"}>$larger;}
  for ($i=0; $i < @names; $i++){
	 for ($j=$i; $j < @names; $j ++){
		if ($j == $i){ next; }
		for ($k=0; $k < $larger; $k ++){
		  $compos_table1{${"string$i"}[$k]}++ if (${"string$i"}[$k] =~ /\w/);
		  $compos_table2{${"string$j"}[$k]}++ if (${"string$j"}[$k] =~ /\w/); }
		$iden = ${&common_compos_id_hash(\%compos_table1, \%compos_table2)};
		%compos_table1=(); %compos_table2=(); push (@all_pairs_id, $iden); }}
  for $iden (@all_pairs_id){ $iden_sum+=$iden; }
  $final_iden=$iden_sum/(@all_pairs_id);
  \$final_iden;
}
#________________________________________________________________________
# Title     : common_compos_id_hash (BUG free)
# Usage     : %hash = &common_compos_hash(\%any_hash1, \%any_hash1);
# Function  : actual calculation of identity
# Example   : ('A', 200, 'C', 191, D, 99)
#                  ('A', 290, 'C', 199, D, 100)
#             uses only two sequences.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : ref. of a scaler (in percent)  eg)  95
# Tips      :
# Argument  : two references of hash of seqeunces.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub  common_compos_id_hash{
  my(%hash1)=%{$_[0]};
  my(%hash2)=%{$_[1]};
  my(%common_of_the_2)=();  my($common, $compos_id, $sum_of_the_common_residue_no);
  my(@values1) = values (%hash1);  my(@values2) = values (%hash2);
  my(@combined_values)=(@values1, @values2);
  my($sum_residues) = ${&sum_array(\@combined_values)};
  for $key1(keys %hash1){
	 $common=&smaller_one($hash1{$key1}, $hash2{$key1});
	 sub smaller_one{if ($_[0] > $_[1]){ $_[1];}else{$_[0];}}
	 $sum_of_the_common_residue_no += $common;
  }
  if( $sum_residues == 0){ $sum_residues =1 }
  $compos_id = $sum_of_the_common_residue_no/($sum_residues/2)*100;
  \$compos_id;
}


#________________________________________________________________________
# Title     : calc_compos_id_hash (the same as 'common_compos_hash')
# Usage     : %hash = &calc_compos_hash(\%any_hash1, \%any_hash1);
# Function  : actual calculation of identity
# Example   : ('A', 200, 'C', 191, D, 99)
#                  ('A', 290, 'C', 199, D, 100)
#             uses only two sequences.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : ref. of a scaler (in percent)  eg)  95
# Tips      :
# Argument  : two references of hash of seqeunces.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub  calc_compos_id_hash{ my(%hash1)=%{$_[0]}; my(%hash2)=%{$_[1]}; my(%common_of_the_2)=();
	  my($common, $compos_id, $sum_residues, $sum_of_the_common_residue_no);
	  my(@values1) = values (%hash1);   my(@values2) = values (%hash2);
	  my(@combined_values)=(@values1,@values2);
	  for $elem (@combined_values){
			$sum_residues += $elem;   }
	  if($sum_residues == 0){ $compos_id =0; } # to prevent Illegal division error.
	  else{
		  for $key1(keys %hash1){
			  $common=&smaller_one($hash1{$key1}, $hash2{$key1});
				  sub smaller_one{if ($_[0] > $_[1]){ $_[1];}else{$_[0];}}
			  $sum_of_the_common_residue_no += $common;     }
		  $compos_id = $sum_of_the_common_residue_no/($sum_residues/2)*100;   }
	  \$compos_id;
}
#________________________________________________________________________
# Title     : get_percentage
# Usage     : %out= %{&get_percentage(\%result, '1')};
# Function  : calculates the percentage content of any single char over the whole
#             length of strings in it.
# Example   : if the string is  'seq  ABCDEEEEEFFEFE' given in a hash
#             if you put 'A' as one argument, it counts the occurances of 'A'
#             and gets the percentage of it.
# Warning   : This converts array and string input as ref. into arbitrary hash and
#             returns hash
#             programmed by A Biomatic
# Class     :
# Keywords  :
# Options   : None yet.
# Package   :
# Reference :
# Returns   : Numerical Percentage
# Tips      : Made For Bissan.
# Argument  : ref. for Scalar string or Array of chars or Hash  AND 'the target char'
# Todo      :
# Author    :
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_percentage{
  my(@in, $k, $sort, $numerator, $residue, @out_hash_ref, %hash_out );
  ######################################
  ####### Sub argument handling ########
  ######################################
  for($k=0; $k< @_ ;$k++){
	  if( !ref($_[$k])&& (length($_[$k]) == 1 )){
		 $numerator = $_[$k];
	  }
	  elsif( (ref($_[$k]) eq 'SCALAR') && (length(${$_[$k]}) == 1 )){
		 $numerator = ${$_[$k]};
	  }
	  elsif(ref($_[$k]) eq "HASH")  { push(@in, $_[$k]); }
	  elsif(ref($_[$k]) eq "ARRAY") { push(@in, &convert_arr_and_str_2_hash($_[$k], $k));} #<-- conv array to hash.
	  elsif(ref($_[$k]) eq "SCALAR"){ push(@in, &convert_arr_and_str_2_hash($_[$k], $k));} #<-- conv array to hash.
  }
  ###########################################################
  ####### final output is => @in of hash ref elements #######
  ###########################################################
  for (@in){   my(%H) = %{$_}; my(@keys)= sort keys %H;
	 for $name(@keys){
		 my($numerator_count);
		 my($seq_len) = length($H{$name}); print  "\n $name Sequence length: ", $seq_len, "\n";
		 my(@string) = split(//, $H{$name});
		 for $residue (@string){  if($residue =~/^$numerator$/){ $numerator_count ++; }}
		 my($percent) = $numerator_count/$seq_len *100;
		 $hash_out{$name}=$percent;    }
	 push(@out_hash_ref, \%hash_out);  }
  if(@out_hash_ref ==1){ return($out_hash_ref[0]); }
  elsif( @out_hash_ref > 1){ return(@out_hash_ref); }
}


#________________________________________________________________________
# Title     : pairwise_percent_id  (pairwise sequence identity in percentage)
# Usage     : $identity = ${&pairwise_percent_id(%arrayinput)};
#
# Function  : takes a ref. of a hash of names and sequences, returns
#             percent identity.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pairwise_percent_id{ my($i,$j,$k, @iden_array_ref);
	for($i=0; $i< @_; $i++){  my %input= %{$_[$i]};  my @names= sort keys %input;
	  my(@temp, $iden, @all_pairs_id, $whole_seq_len, $residue_sum1,$residue_sum2);
	  my($final_av_iden, $larger, $percent_for_pair,@percent_for_pair, $iden_sum);
	  for ($i=0; $i < @names; $i ++){ $input{$names[$i]}=~ tr/a-z/A-Z/;
		 @temp = split('', $input{$names[$i]});  (@{"string$i"})=@temp;
		 $larger = @{"string$i"} if @{"string$i"} > $larger; }
			 for ($i=0; $i < @names; $i++){       # to make permutated pairs.
				for ($j=$i+1; $j < @names; $j ++){
					for ($k=0; $k < $larger; $k ++){  # getting composition tables for two seqs.
					  $iden+=2 if ((${"string$i"}[$k] eq ${"string$j"}[$k])&&(${"string$i"}[$k] =~ /\w/));
					  $residue_sum1++ if (${"string$i"}[$k] =~ /\w/);
					  $residue_sum2++ if (${"string$j"}[$k] =~ /\w/);  }
					$whole_seq_len =($residue_sum1+$residue_sum2);
					$percent_for_pair = $iden/$whole_seq_len*100;
					push(@percent_for_pair,$percent_for_pair);
					$residue_sum1=0; $residue_sum2=0; $iden=0; } }
			 for $iden (@percent_for_pair){ $iden_sum+=$iden;}
	  $final_av_iden=$iden_sum/( @percent_for_pair );
	  push(@iden_array_ref, \$final_av_iden);  }
	if(@iden_array_ref ==1){ return($iden_array_ref[0]);}else{ return(@iden_array_ref);}
}
#________________________________________________________________________
# Title     : get_seq_identity  (pairwise sequence identity in percentage)
# Usage     : $identity = ${&get_seq_identity(%arrayinput)};
#
# Function  : takes a ref. of a hash of names and sequences, returns
#             percent identity.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : hash(es) of sequences.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_seq_identity{
	my($i,$j,$k, @iden_array_ref);
	for($i=0; $i< @_; $i++){
	  my %input= %{$_[$i]};
	  my @names= sort keys %input;
	  my(@temp, $iden, @all_pairs_id, $whole_seq_len, $residue_sum1,$residue_sum2);
	  my($final_av_iden, $larger, $percent_for_pair,@percent_for_pair, $iden_sum);
	  for ($i=0; $i < @names; $i ++){
		 $input{$names[$i]}=~ tr/a-z/A-Z/;
		 @temp = split(//, $input{$names[$i]});
		 @{"string$i"}=@temp;
		 $larger = @{"string$i"} if @{"string$i"} > $larger; }
			 for ($i=0; $i < @names; $i++){       # to make permutated pairs.
				for ($j=$i+1; $j < @names; $j ++){
					for ($k=0; $k < $larger; $k ++){  # getting composition tables for two seqs.
					  $iden+=2 if ((${"string$i"}[$k] eq ${"string$j"}[$k])&&(${"string$i"}[$k] =~ /\w/));
					  $residue_sum1++ if (${"string$i"}[$k] =~ /\w/);
					  $residue_sum2++ if (${"string$j"}[$k] =~ /\w/);  }
					$whole_seq_len =($residue_sum1+$residue_sum2);
					$percent_for_pair = $iden/$whole_seq_len*100;
					push(@percent_for_pair,$percent_for_pair);
					$residue_sum1=0; $residue_sum2=0; $iden=0; } }
			 for $iden (@percent_for_pair){ $iden_sum+=$iden;}
	  $final_av_iden=$iden_sum/( @percent_for_pair );
	  push(@iden_array_ref, \$final_av_iden);  }
	if(@iden_array_ref ==1){ return($iden_array_ref[0]);}else{ return(@iden_array_ref);}
}

#________________________________________________________________________
# Title     : get_correct_percent_alignment_rate  (made for Bissan)
# Usage     : &get_correct_percent_alignment_rate(\$file1, \$file2);
# Function  : accepts two files and prints out the sequence identities of the alignment.
# Example   :
# Warning   : Alpha version,  A Biomatic , made for Bissan
# Class     :
# Keywords  :
# Options   : h  # for help
#             v  # for verbose printouts(prints actual sequences)
# Package   :
# Reference :
# Returns   : reference of Scalar for percentage correct alignment(for already
#             aligned sequences)
# Tips      :
# Argument  : two sequence files which have identical sequence names.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_correct_percent_alignment_rate{
	 my($i, $j, $k, $verbose, @string1, @string2, $larger, $seq_pair_id, @seq_pair_ids );
	 my(%inputhash1) = %{&read_any_seq_files($_[0])};
	 my(%inputhash2) = %{&read_any_seq_files($_[1])};
	 my(@names)= sort keys %inputhash1;
	 ######################################
	 ####### Sub argument handling ########
	 ######################################
	 for($k=0; $k< @_ ;$k++){
		if( !ref($_[$k])&& (length(${$_[$k]}) < 5)){  # when inputs are not ref.
		  if($_[$k]=~ /^[\-vV]$/){ $verbose = 1; next;}
		}
		elsif((ref($_[$k]) eq "SCALAR")&&(length(${$_[$k]})<5)){  #  when inputs are  ref.
		  if(${$_[$k]}=~ /^[\-vV]$/){$verbose = 1;next;}          # should shorter than 5
		}
	 }
	 for($i =0; $i < @names; $i++){
		print "\n\n==== Processing structural $names[$i] against artificial $names[$i]\n";
		$inputhash1{$names[$i]} =~ tr/a-z/A-Z/;
		$inputhash2{$names[$i]} =~ tr/a-z/A-Z/;
		@string1=split(//, $inputhash1{$names[$i]});
		@string2=split(//, $inputhash2{$names[$i]});
		print "\n The string1 is  ",@string1,"\n" if $verbose ==1;
		print "\n The string2 is  ",@string2,"\n" if $verbose ==1;
		(@string2 > @string1) ? ($larger=@string2, $smaller=@string1) : ($larger=@string1, $smaller=@string2);
		$true_seq=$inputhash1{$names[$i]};
		$true_seq=~s/\W//g;
		$true_len=length($true_seq);
		print "\n True seq length:   $true_len  , Whole length inc gap: $larger\n";
		for($j = 0; $j < $larger; $j++){
		  $iden_sum++ if ($string1[$j] eq $string2[$j])&& !($string1[$j]=~/\W/); }
		$seq_pair_id =($iden_sum/$true_len) * 100;
		print "\nID between structural and artifical alignment is  $seq_pair_id \%" , "\n";
		push(@seq_pair_ids, $seq_pair_id);
		undef( $iden_sum, $seq_pair_id );
	 }
	 print "\n", "_"x88, "\n";
	 my($whole_average_of_the_id)=${&array_average(\@seq_pair_ids)};
	 print "The whole average is; $whole_average_of_the_id\n";
	 if(@seq_pair_ids == 1){ return( \$seq_pair_ids[0] ); }
	 elsif(@seq_pair_ids > 1){ return( \@seq_pair_ids ); }
}


#________________________________________________________________________
# Title     : amino_acid_compos_id_percent_trend
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub amino_acid_compos_id_percent_trend{ my(%input) = %{$_[0]};
  my(@common, @string,@accumu_percent_iden)=(); my(%common_so_far, %compos_table);
  my($percent_id_so_far, $length_of_one_seq,$length_of_all_seq, $seq_no)=0;
  for $key(keys %input){
			$input{$key}=~s/[. \d-]//g;
			@string= split(//, $input{$key});
			print @string; print "\n";
			$length_of_one_seq = $#string+1;
			$length_of_all_seq +=$length_of_one_seq;
			$seq_no += 1;
			%compos_table  = &composition_table(@string);
			@check = keys (%common_so_far);
			if  ($#check < 0){ %common_so_far = %compos_table; }
			else{ %common_so_far= %{&common_compos_2_hash(\%common_so_far,\%compos_table)};}
			for $value(values %common_so_far){ $common_residue_sum +=$value; }
			$final_percent_id = $common_residue_sum/($length_of_all_seq/$seq_no)*100;
			$common_residue_sum =0;  }
  for $value(values %common_so_far){ $common_residue_sum +=$value; }
  $final_percent_id = $common_residue_sum/($length_of_all_seq/$seq_no)*100;
  \$final_percent_id;
}

#________________________________________________________________________
# Title     : composition_table   (can handle both nucleic and protein seq)
# Usage     : %output = %{&compos_table(@input_array1, @input_array2,,,,)};
#             example input
#
# Function  : returns a table of alphabet with occurances.
#             can handle any char, this converts char to upper case.
# Example   :
# Warning   : converts all SMALL letters to Capital letters before counting!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : %hash1 = ('A',3, 'C',2, 'D',1, 'Q',2, 'S',1), %hash2,,,
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub composition_table{
  my($i, @input,%input,$input,$j,@ref_out);
  for($i=0;$i<@_; $i++){
	 my(%alphabet)=();
	 if( ref($_[$i]) eq 'ARRAY'){ @input=@{$_[$i]}; undef(%alphabet);
		 for ($j=0; $j<=$#input; $j++){ $input[$j] =~ tr/a-y/A-Y/;
			 $alphabet{$input[$j]}+=1 if ($input[$j] =~/[A-Y]/) }
		 push(@ref_out, \%alphabet); }
	 elsif( ref($_[$i]) eq 'HASH'){ %input=%{$_[$i]};@input=keys %input;undef(%alphabet);
		 for ($j=0; $j< @input; $j++){ $input[$j] =~ tr/a-y/A-Y/;
			 $alphabet{$input[$j]}+=1 if ($input[$j] =~/[A-Y]/) }
		 push(@ref_out, \%alphabet); }
	 elsif( ref($_[$i]) eq 'SCALAR'){ $input=${$_[$i]}; $input=s/\,//g if $input=~/\,/;
		 @input=split('', $input); undef(%alphabet);
		 for ($j=0; $j<@input; $j++){ $input[$j] =~ tr/a-y/A-Y/;
			 $alphabet{$input[$j]}+=1; }
		 push(@ref_out, \%alphabet); }    }
  if(@ref_out ==1){
	 return($ref_out[0]);
  }else{ return(@ref_out); }
}

#________________________________________________________________________
# Title     : common_compos_2_hash
# Usage     : %hash = &common_compos_hash(\%any_hash1, \%any_hash1);
# Function  :
# Example   : common gaps means only '.' (dots, not alphabets!!)
#             AAA....BBCB
#             AAAB..B.BCC  --> A.A.....BC. (as in an array)
#             A.AAA...BCA
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a hash (string1, number1, string2, number2, string3, number3, ...)
# Tips      :
# Argument  : two references of hash of seqeunces.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub  common_compos_2_hash{ my(%hash1)=%{$_[0]}; my(%hash2)=%{$_[1]};
  my(%common_of_the_2)=(); my($common)=0;
  for $key1(keys %hash1){
	 $common=&smaller_one($hash1{$key1}, $hash2{$key1});
	 if ($common =~ /\d+/){
		$common_of_the_2{$key1}=$common; } }
  \%common_of_the_2;
}


#________________________________________________________________________
# Title     : pair_percent_id_trend
# Usage     : @array = &pair_percent_id_trend (%arrayinput);
# Function  :
# Example   : common gaps means only '.' (dots, not alphabets!!)
#             AAA....BBCB
#             AAAB..B.BCC  --> A.A.....BC. (as in an array)
#             A.AAA...BCA
#             The resulting array XXXXX..XXXX is literally like so.
#             This is to detect absurd gaps in the above.
#
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pair_percent_id_trend{
  my(%input) = %{$_[0]};
  my(@common, @string,@accumu_percent_iden)=();
  my($percent_id_so_far)=0;
  for $key(keys %input){
	  my($len) = &smaller_one($#common, $#string) unless $#common < 0;
	  $input{$key}=~s/ //g;
	  @string= split(//, $input{$key});
	  $length_of_one_seq = $#string+1;
	  $length_of_all_seq +=$length_of_one_seq;
	  $seq_no += 1;
	  for ($k=0; $k <= $len;$k++){
		  if($#common == -1){
			 @common = @string;
			 last;
		  }
		  elsif (($string[$k] =~ /^(\W)/)&&($1 ne $previous_non_char)){
			 $non_char_count +=1;
			 $previous_non_char=$1;
		  }
		  elsif ( $string[$k] eq $common[$k] ){
			 $common[$k] = $string[$k];
			 $identical_count +=1;
		  }elsif( $string[$k] ne $common[$k]){
			 $common[$k]='.';
		  }
	  }
	  $num_of_iden_char = &count_num_of_char(\@common);
	  $av_seq_no = $length_of_all_seq/$seq_no;
	  $percent_id_so_far = $num_of_iden_char/$av_seq_no*100;

	  print "\n percent_id so far = $percent_id_so_far \n";
	  push(@accumu_percent_iden,$percent_id_so_far);

  } # end of for (after all sequences have been run).
  $num_of_iden_char = &count_num_of_char(@common);
  $av_seq_no = $length_of_all_seq/$seq_no;
  $percent_id_so_far = $num_of_iden_char/$av_seq_no*100;
  print "\n percent_id so far = $percent_id_so_far \n";
  \@accumu_percent_iden; # final ids array.
}
#________________________________________________________________________
# Title     : smaller_one
# Usage     : $smaller = & smaller_one($var, $var2);
#
# Function  : gets smaller value of the two inputs
# Example   : will return   5   with  &smaller_one(5, 50);
# Warning   : gets only digits!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub smaller_one{
  if (($_[0], $_[1]=~/\d+/)||($_[0] > $_[1])){
	 return $_[1];
  }elsif(($_[0], $_[1]=~/\d+/)||($_[0] <= $_[1])){
	 return $_[0];
  }else{
	 print "\n I am sub 'smaller_one', the input were not digits \n";
  }
}

#________________________________________________________________________
# Title     : count_num_of_char
# Usage     : $num_char = &count_num_of_char(@input_array_of_single_char);
# Function  : takes only ARRAY and counts the number of char. Each elem should be
#             a single char.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub count_num_of_char{
	 my(@input)={$_[0]};
	 my($num_of_char)=0;
	 for $elem(@input){  # this is for the percentage of TWO seqs.
		 if ($elem =~ /\w/){
					 $num_of_char +=1;
		 }
	 }
	 $num_of_char;
}
#________________________________________________________________________
# Title     : remov_com_column2  (this is the older and slower version)
# Usage     : %new_string = %{&remov_com_column2(\%input_hash)};
# Function  :
# Example   : seq1  ABCDE------DDD         seq1  ABCDE--DDD
#             seq2  ABCDEE-----DD-  ==>    seq2  ABCDEE-DD-
#             seq3  ---DEE----DDE-         seq3  ---DEEDDE-
#                         ^^^^
#             from above the 4 columns of gap will be removed
#             To remove absurd gaps in multiple sequence alignment
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a hash.
#
#               <input hash>                   <out hash>
#
# Tips      :
# Argument  : accepts reference for a hash.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub remov_com_column2{
  my(%input) = %{$_[0]};
  my(@common)=();
  my($len)=0;
  my(@string)=();
  my(@new_string)=();
  my(@string2)=();
  my(%new_string);

  ########## Finds common gaps ###########
  for $key(keys %input){
	  $len  = &smaller_one($#common, $#string) unless $#common < 0;
		  sub smaller_one{if ($_[0] > $_[1]){ $_[1];}else{$_[0];}}
	  @string = split(/|| /, $input{$key});
	  for ($k=0; $k <= $len;$k++){
		  if($#common == -1){
			  @common = (@string);
			  last;
		  }
		  if (($string[$k] eq '.')&&($common[$k] eq '.')){
			  $common[$k]='.';
		  }else{
			  $common[$k]='X';
		  }
	  }
  }

  ########## removes gaps ###########
  for $key2 (keys %input){
		@string2 = split(//, $input{$key2});
		for ($i=0; $i <= $#string2; $i++){
		  if ($common[$i] eq $string2[$i]){
			  print;
		  }else{
			  push(@new_string, $string2[$i]);
		  }
		}
		$new_string{$key2}= join("", @new_string);
		@new_string = ();
  }
  \%new_string;
}
#________________________________________________________________________
# Title     : get_common_column   (similar to overlay_seq_for_identical_chars )
# Usage     : %out =%{&get_common_column(\%hash1, \%hash2, '-')};
# Function  : (name1         --EHH--HHEE-- )
#             (name2         --HHH--EEEE-- ) ==> result is;
#
#             (name1_name2   -- HH--  EE-- )
#             to get the identical chars in hash strings of sequences.
#
# Example   : %out =%{&get_common_column(\%hash1, \%hash2, '-')};
#             output> with 'E' option >>> "name1     --HHH--1232-"
#   Following input will give;
#   %hash1 = ('s1', '--EHH-CHHEE----EHH--HHEE----EHH--HHEE----EHH-CHHEE--');
#   %hash2 = ('s2', '--EEH-CHHEE----EEH-CHHEE----EEH-CHHEE----EEH-CHHEE--');
#   %hash3 = ('s3', '-KEEH-CHHEE-XX-EEH-CHHEE----EEH-CHHEE----EEH-CHHEE--');
#   %hash4 = ('s4', '-TESH-CHEEE-XX-EEH-CHHEE----EEH-CHHEE----EEH-CHHEE--');
#
#     s1_s2_s3_s4    --E-H-CH-EE----E-H--HHEE----E-H--HHEE----E-H-CHHEE--
#
# Warning   : This gets more than 2 hashes. Not more than that!
#
# Class     : get_common_column, get_common_column_in_seq,
#             get common column in sequence, superpose_secondary_structure,
#             get_common_secondary_structure,
#             for secondary structure only representation.
# Keywords  : Overlap, superpose hash, overlay identical chars, superpose_seq_hash
#             get_common_column, get_com_column, get_common_sequence,
#             get_common_seq_region, multiply_seq_hash,
# Options   :
# Package   : Array_Util
# Reference :
# Returns   : one hash ref. of the combined key name (i.e., name1_name2). Combined by '_'
# Tips      :
# Argument  : 2 or more ref for hash of identical keys and value length.
#             One optional arg for replacing space char to the given one.
# Todo      :
# Author    : A Biomatic
# Version   : 1.5
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_common_column{
  my($i, $k,$j, $name1, $name2, @in, %out, @out_chars, $gap_chr, @str1, @str2);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #  Sub argument handling     $gap_chr here can be 'HE' etc.
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""
  for($k=0; $k< @_ ;$k++){
	  if( ( !ref($_[$k]) )&&($_[$k]=~ /^(.)$/) ){
		  $gap_chr  .= $1;    }
	  elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(.)$/) ){
		  $gap_chr  .= $1;    }
	  elsif(ref($_[$k]) eq "HASH") { push(@in,  $_[$k]); }    }

  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #"  Checking if the input hashes were right
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if( (@in < 2) && ( ref($in[0]) eq 'HASH') ){
	  print "\n", __LINE__, " # get_common_column usually needs 2 hashes. Error \n";
	  print "\n", __LINE__, " # get_common_column : Anyway, I will just return the single input hash:  @in. \n";
	  %out=%{$in[0]}; # <--- This is essential to return the single input hash!!
	  goto FINAL;
  }

  %out = %{$in[0]};  ## Initializing %out
  print "\n",__LINE__, " # get_common_column hashes given are: @in \n" if $debug eq 1;

  for( $k=1; $k < @in; $k++){
		my(@out_chars);   ## <-- Necessary to prevent concatenation.
		my(%hash1)=%out;
		my(%hash2)=%{$in[$k]};
		my(@names1)= sort keys %hash1;
		my(@names2)= sort keys %hash2;
		$name1 = $names1[0];
		$name2 = $names2[0];
		@str1=split(/||\,/, $hash1{$names1[0]});
		@str2=split(/||\,/, $hash2{$names2[0]});
		for($i=0; $i < @str1; $i++){
			if($str1[$i] eq $str2[$i] ){
				push(@out_chars, $str1[$i]); }
			elsif( defined($gap_chr) ){ push(@out_chars, $gap_chr); }
			else{ push(@out_chars, ' '); }
		}
		if( $name2 < $name1){      ## To make an ordered name output eg.  seq1_seq2, than  seq2_seq1
			%out='';
			$out{"$name2\_$name1"}= join("", @out_chars); }
		else{
			%out='';
			$out{"$name1\_$name2"}= join("", @out_chars); }
  }
  FINAL:
  if ($debug eq 1){
	  print "\n",__LINE__, " # get_common_column Final res. \%out :\n",
	  &show_hash(%out);
  }
  \%out;
}
#________________________________________________________________________
# Title     : overlay_seq_for_identical_chars
# Usage     : %out =%{&overlay_seq_for_identical_chars(\%hash1, \%hash2, '-')};
# Function  : (name1         --EHH--HHEE-- )
#             (name2         --HHH--EEEE-- ) ==> result is;
#
#             (name1_name2   -- HH--  EE-- )
#             to get the identical chars in hash strings of sequences.
#
# Example   : %out =%{&overlay_seq_for_identical_chars(\%hash1, \%hash2, '-')};
#             output> with 'E' option >>> "name1     --HHH--1232-"
# Warning   : Works only for 2 sequence hashes.
# Class     :
# Keywords  : Overlap, superpose hash, overlay identical chars, superpose_seq_hash
# Options   :
# Package   : Array_Util
# Reference :
# Returns   : one hash ref. of the combined key name (i.e., name1_name2). Combined by '_'
# Tips      :
# Argument  : 2 ref for hash of identical keys and value length. One optional arg for
#             replacing space char to the given one.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub overlay_seq_for_identical_chars{
  my($i, $k,$j, $name1, $name2, @in, %out, @out_chars, $gap_chr, @str1, @str2);
  ######################################
  ####### Sub argument handling ########  $gap_chr here can be 'HE' etc.
  ######################################
  for($k=0; $k< @_ ;$k++){
	  if( ( !ref($_[$k]) )&&($_[$k]=~ /^(.)$/) ){
		  $gap_chr  .= $1;    }
	  elsif((ref($_[$k]) eq "SCALAR")&&(${$_[$k]}=~ /^(.)$/) ){
		  $gap_chr  .= $1;    }
	  elsif(ref($_[$k]) eq "HASH") { push(@in,  $_[$k]); }    }

  if(@in < 2){ print "\n overlay_seq_for_identical_chars needs 2 hashes. Error \n"; exit; }
  my(%hash1)=%{$in[0]}; my(%hash2)=%{$in[1]};
  my(@names1)=sort keys %hash1; my(@names2)= sort keys %hash2;
  $name1 = $names1[0]; $name2 = $names2[0];
  @str1=split(/|\,/, $hash1{$names1[0]}); @str2=split(/|\,/, $hash2{$names2[0]});
  for($i=0; $i < @str1; $i++){
	  if($str1[$i] eq $str2[$i] ){
		  push(@out_chars, $str1[$i]); }
	  elsif( defined($gap_chr) ){ push(@out_chars, $gap_chr); }
	  else{ push(@out_chars, ' '); }
  }
  if( $name2 gt $name1){
	  $out{"$name1\_$name2"}= join(",", @out_chars); }
  else{  $out{"$name2\_$name1"}= join(",", @out_chars); }
  \%out;
}

#________________________________________________________________________
# Title     : remov_com_column
# Usage     : %new_string = %{&remov_com_column(\%hashinput)};
#             @out=@{&remov_com_column(\@array3)};
# Function  : removes common gap column in seq.
# Example   :
# Warning   :
# Class     :
# Keywords  : remove_com_column, remove_common_column,
#             remove_common_gap_column, remov_common_gap_column,
#             remove com column
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of  hash(es) and array(s).
#
#             name1   ABCDE....DDD       name1  ABCDE..DDD
#             name2   ABCDEE..DD..  -->  name2  ABCDEEDD..
#             name3   ...DEE..DDE.       name3  ...DEEDDE.
#
#             (ABC....CD, ABCD...EE) --> (ABC.CD, ABCDEE)
#             from above the two column of dot will be removed
#             To remove absurd gaps in multiple sequence alignment. for nt6-hmm.pl
# Tips      :
# Argument  : accepts reference for hash(es) and array(s).
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub remov_com_column{
  my(@hash_ref_out, $d, $gap_char);
  for($d=0; $d < @_; $d++){
	  if(ref($_[$d]) eq 'HASH'){
	      my($len,@string,@new_string,@string2);
		  my(%input)=%{$_[$d]};
		  my(@common);
		  for (keys %input){
			  @string = split('', $input{$_});
			  if(!(defined(@common))){ @common = (@string);  }
			  else{ for ($k=0; $k < @string; $k++){
				 if (($string[$k] =~ /\W/ )&&($common[$k] =~ /(\W)/)){ $common[$k]= $1;}
				 elsif(($string[$k] =~ /(\W)/)&&(!(defined($common[$k])))){ $common[$k]=$1;}
				 else{ $common[$k]='X';} } } }
		  for (keys %input){ @string2 = split(//, $input{$_});
			  for ($i=0; $i < @string2; $i++){
				 if ($common[$i] ne $string2[$i]){ push(@new_string, $string2[$i]); } }
			  $new_string{$_}= join('', @new_string); @new_string = ();      }
		  push(@hash_ref_out, \%new_string);
	  }
	  elsif(ref($_[$d]) eq 'ARRAY'){
	      my( $k, $y, $x,@string_array, @string);
		  my(@input)=@{$_[$d]};  @common=();
		  for($y=0; $y< @input; $y++){
			  @string = split('', $input[$y]);
			  if(!(defined(@common))){  @common = @string;  }
			  else{
				 for ($k=0; $k < @string; $k++){
					 if (($string[$k]  =~ /(\W)/)&&($common[$k]  =~ /(\W)/)){ $common[$k]=$1;}
					 elsif(($string[$k] =~ /(\W)/)&&(!(defined($common[$k])))){ $common[$k]=$1;}
					 else{ $common[$k]='X';}
				 }
			  }
		  }
		  for($x=0; $x < @input; $x++){
		      my($new_string, @string2);
			  @string2 = split(//, $input[$x]);
			  for ($i=0; $i < @string2; $i++){
				  if ($common[$i] ne $string2[$i]){ $new_string.= "$string2[$i]"; }
			  }
			  push(@string_array, $new_string);
		  }
		  push(@hash_ref_out, \@string_array);
	  }
  }
  if(@hash_ref_out ==1) { return( $hash_ref_out[0] ); }
  elsif(@hash_ref_out>1){ return( @hash_ref_out ) }
}

#________________________________________________________________________
# Title     : remov_common_gap
# Usage     : %result = &remov_common_gap (*common_pos_arr, *target_hash_of_sequence);
# Function  : XXX...XXX, and an hash input. removes all the common gap(dots) in targets.
# Example   : XXX...XXX with AAA.....BBBB, The common positions of 3,4,5 deleted
#             XXX...XXX will be removed in AAA.....BBBB --> AAA..BBBB
#             XXX...XXX is an @array, while AAA.....BBBB is a value of the input hash
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub remov_common_gap{
	my(@common)=@{$_[0]}; my(%input)=%{$_[1]};
	for $key2 (keys %input){
		my(@string2)  = split(//, $input{$key2});
		for ($i=0; $i <= $#string2; $i++){
		  if ($common[$i] eq $string2[$i]){shift;}else{ push(@new_string, $string2[$i]);}}
		$new_string{$key2}= join("", @new_string);
		@new_string = (); }
	\%new_string;
}


#________________________________________________________________________
# Title     : com_gap_pos_hash
# Usage     : @array = @{&com_elem_pos_hash(%arrayinput)};
# Function  : returns X...XXXX, as an array. '.' means common elements.
# Example   : common gaps means only '.' (dots, not alphabets!!)
#             AAA....BBBB
#             AABB....BBC  --> XXXXX..XXXX (as in an array)
#             ..AAA...BCA
#             This is to detect absurd gaps in the above.
# Warning   :
# Class     :
# Keywords  : common_gap_pos_hash
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets a ref. of a hash of sequences
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub com_gap_pos_hash{
  my(%input) = %{$_[0]};
  for $key(keys %input){
	my($len) = &smaller_one($#common, $#string) unless $#common < 0;
	  sub smaller_one{if ($_[0] > $_[1]){ $_[1];}else{$_[0];}}
	@string= split(//, $input{$key});
	for ($k=0; $k <= $len;$k++){
	  if($#common == -1){
	     my(@common) = @string;
		 last;
	  }
	  if (($string[$k] ne '.')||($common[$k] ne '.')){
	     $common[$k]='X';
	  }
	}
  }
  \@common;
}
#________________________________________________________________________
# Title     : pairwise_iden_pos
# Usage     : @array = &pairwise_iden_pos(%arrayinput);
# Function  :
# Example   : common gaps means only '.' (dots, not alphabets!!)
#             AAA....BBCB
#             AAAB..B.BCC  --> A.A.....BC. (as in an array)
#             A.AAA...BCA
#             The resulting array XXXXX..XXXX is literally like so.
#             This is to detect absurd gaps in the above.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pairwise_iden_pos{
  my(%input) = %{$_[0]};
  my(@common, @string)=();
  for $key(keys %input){
	  my($len) = &smaller_one($#common, $#string) unless $#common < 0;
	  sub smaller_one{if ($_[0] > $_[1]){ $_[1];}else{$_[0];}}
	  @string= split(//, $input{$key});
	  for ($k=0; $k <= $len;$k++){
					  if($#common == -1){
								 @common = @string;
								 last;
					  }
					  elsif (($string[$k] =~ /^(\W)/)&&($1 ne $previous_non_char)){
								 $non_char_count +=1;
								 $previous_non_char=$1;
					  }
					  elsif ( $string[$k] eq $common[$k] ){
						$common[$k] = $string[$k];
					  }elsif( $string[$k] ne $common[$k]){
								 $common[$k]='.';
					  }
	  }
	}
	\@common;	# returns an array.
}
#________________________________________________________________________
# Title     : open_pdb_files  (read the sequences only)
# Usage     : %out = %{&open_pdb_files(\$VAR)};
# Function  : Convert a PDB structure file to FASTA format sequences.
# Example   :
# Warning   : (read the sequences only)
# Class     :
# Keywords  : read_pdb_files{, read pdb files, open pdb files
# Options   :
# Package   :
# Reference :
# Returns   : One ref. for a hash of sequences(DNA, RNA, PROTEIN (IN diff chains)
#             If the two chains are identical, it rids of one of them and returns
#             a name with out chain note-->  2tma, not 2tmaA and 2tmaB
# Tips      :
# Argument  : one ref. for an inputfile (absolute
#             >>> PDB example >>>
#             SEQRES   1 A  284  MET ASP ALA ILE LYS LYS LYS MET GLN MET LEU LYS LEU  2TMA  51
#             SEQRES   2 A  284  ASP LYS GLU ASN ALA LEU ASP ARG ALA GLU GLN ALA GLU  2TMA  52
#
# Todo      :
# Author    : A Biomatic
# Version   : 1.6
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_pdb_files{
  my($input)=${$_[0]} if(ref($_[0]) eq 'SCALAR');
  my($input)=$_[0];
  if($input=~/\.fa/){ print "\n You have put fasta file to PDB prog\n" }
  my $input=${&find_seq_files(\$input)};
  my($i, $j, $keys, $temp,$outseq, $SEQRES, $res_numb, $structure, %outhash, @fields,
	  %AA, @residues);
	 $AA{"ALA"} = "A";  $AA{"MET"} = "M";  $AA{"ASP"} = "D";  $AA{"PRO"} = "P";
	 $AA{"CYS"} = "C";  $AA{"ASN"} = "N";  $AA{"GLU"} = "E";  $AA{"GLN"} = "Q";
	 $AA{"PHE"} = "F";  $AA{"ARG"} = "R";  $AA{"GLY"} = "G";  $AA{"SER"} = "S";
	 $AA{"HIS"} = "H";  $AA{"THR"} = "T";  $AA{"ILE"} = "I";  $AA{"VAL"} = "V";
	 $AA{"LYS"} = "K";  $AA{"TRP"} = "W";  $AA{"LEU"} = "L";  $AA{"TYR"} = "Y";
  open(INPUT_PDB_FILE, "$input");
  while (<INPUT_PDB_FILE>){
	 my($chain, $seq_size, $residues, $pdb_name);
	 if(/^SEQRES +\d+ +(.*) +(\d+) +(.{51,53}) +(\w\w\w\w)[\w]* +\d+/){
		$SEQRES = 1;
		$chain =$1;
		$seq_size = $2;
		$residues = $3;
		$pdb_name=$4;
		@residues=split(' ', $residues);
		if($residues[0]=~/^[A-U]$/){
			for(@residues){$outhash{"\L$pdb_name\U$chain\E"}.=$_;}
		}else{
			for(@residues){$outhash{"\L$pdb_name\U$chain\E"}.=$AA{$_};}  ## use %AA matrix
		}
	 }elsif( ($SEQRES != 1)&&(/^ATOM +\d+ +\w+ +(\w\w\w) (.) +(\d+).+ +(\w\w\w\w) *\d+/) ){
		if($res_numb == $3){ next;
		}else{
		  $chain = $2;
		  $res_numb = $3;
		  $pdb_name=$4;
		  $outhash{"\L$pdb_name\U$chain\E"}.= $AA{"$1"};
		}
	 }
  }
  @keys=keys %outhash;
  if ($chain=~/[A-Z]/){
	 for ($i=0; $i < @keys; $i++){
		for ($j=$i+1; $j < @keys; $j++){
		  if ($outhash{$keys[$i]} eq $outhash{$keys[$j]}){
			 delete($outhash{$keys[$j]});
			 $temp=$keys[$i];
			 chop($temp);
			 $outhash{$temp}=$outhash{$keys[$i]};
			 delete($outhash{$keys[$i]});
		  }
		}
	 }
  }
  return( \%outhash );
}

#________________________________________________________________________
# Title     : open_brk_files (read the sequences only)(the same as open_pdb_files
# Usage     : %out = %{&open_brk_files(\$VAR)};
# Function  : Convert a PDB structure file to FASTA format sequences.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : One ref. for a hash of sequences(DNA, RNA, PROTEIN (IN diff chains)
#             If the two chains are identical, it rids of one of them and returns
#             a name with out chain note-->  2tma, not 2tmaA and 2tmaB
# Tips      :
# Argument  : one ref. for an inputfile (absolute
#             >>> PDB example >>>
#
#             SEQRES   1 A  284  MET ASP ALA ILE LYS LYS LYS MET GLN MET LEU LYS LEU  2TMA  51
#             SEQRES   2 A  284  ASP LYS GLU ASN ALA LEU ASP ARG ALA GLU GLN ALA GLU  2TMA  52
#             SEQRES   3 A  284  ALA ASP LYS LYS ALA ALA GLU ASP ARG SER LYS GLN LEU  2TMA  53
#
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_brk_files{    my($input)=${$_[0]};  $input=${&find_seq_files(\$input)};
  my($outseq, $structure, %outhash, @fields, %AA, $chain, $residues);
	 $AA{"ALA"} = "A";  $AA{"MET"} = "M";  $AA{"ASP"} = "D";  $AA{"PRO"} = "P";
	 $AA{"CYS"} = "C";  $AA{"ASN"} = "N";  $AA{"GLU"} = "E";  $AA{"GLN"} = "Q";
	 $AA{"PHE"} = "F";  $AA{"ARG"} = "R";  $AA{"GLY"} = "G";  $AA{"SER"} = "S";
	 $AA{"HIS"} = "H";  $AA{"THR"} = "T";  $AA{"ILE"} = "I";  $AA{"VAL"} = "V";
	 $AA{"LYS"} = "K";  $AA{"TRP"} = "W";  $AA{"LEU"} = "L";  $AA{"TYR"} = "Y";
  open(INPUT_PDB_FILE, "$input");
  while (<INPUT_PDB_FILE>){
	 if(/^HELIX/ || /^ATOM/ || /^FTNOTE/ || /^HET/){ last; };
	 if(/^SEQRES +\d+ +(.) +(\d+) +(.+)\s+(\w+)\s+\d+.+$/){
		$chain =$1; $seq_size = $2; $residues = $3; $pdb_name=$4;
		@residues=split(' ', $residues);
		if($residues[0]=~/[A-U]/){ # <-- Check if it is DNA/RNA seq.
		  for(@residues){  $outhash{"\L$pdb_name\U$chain\E"}.=$_;  }
		}else{
		  for (@residues){  $outhash{"\L$pdb_name\U$chain\E"}.=$AA{$_}; } } }
  }
  @keys=keys %outhash;
  if ($chain=~/[A-Z]/){
	 for ($i=0; $i < @keys; $i++){
		for ($j=$i+1; $j < @keys; $j++){
		  if ($outhash{$keys[$i]} eq $outhash{$keys[$j]}){
			 delete($outhash{$keys[$j]});  $temp=$keys[$i];
			 chop($temp);  $outhash{$temp}=$outhash{$keys[$i]};
			 delete($outhash{$keys[$i]});}}}}  return( \%outhash  );
}

#________________________________________________________________________
# Title     : open_msf_jp_files
# Usage     : &open_msf_jp_files($file1, $file2);
# Function  : makes two hashes from  ...msf and ..jp files. %array1 is for msf
# Example   :
# Warning   : !!! not very general bettter not use.
#             msf file is meant to be seq
#             jp file is meant to be structural alignment (correct seq
#
#             msf format is
#
#             cofi_human  ATFVKM
#             ici2_horvu  RVRLFVDKLD NIA
#             ici3_horvu  RVRLFVDRLD NIA
#
#             jp format is;
#
#             ycah_ecoli  RNVEIV----VID-GVRRFGNIA
#             icis_vicfa  RVRLYVDESNKVV-RAAPIGNIA
#             ier1_lyces  RVRLFVNLLDIVV-QTPKVGNIA
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_msf_jp_files{
	my($file1, $file2) = @{$_[0]};  my(@return);
	open(F1,"$file1");
	while(<F1>){
	  if(/^([\w_]+)[\t]* +(.+)$/){	# matching patterns
		 if(!$array1{$1}){      		# if hash %array1 is not defined,
			$names1[++$nf1]=$1;
		 }
		 $array1{$1}.=$2;   }   }
	open(F2,"$file2");  			# reading in (JP) file
	while(<F2>){
		if(/^([\w]+)[\t]* +([\w-]+[ ]+)$/){
			substr($_,11)=~ s/ /-/g;      }
		if(/^([\w]+)  +([\w-]+)$/){
			if(!$array2{$1}){
				$names2[++$nf2]=$1;
			}
			$array2{$1}.=$2; }  }
	@return =(\%array1, \%array2);
	\@return;
}



#________________________________________________________________________
# Title     : scoring
# Usage     :
# Function  :
# Example   :
# Warning   : not general, !!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub scoring{
  $hash_subt{$subt}++; 	# this is for individual seq.
																		  # if $subt is 1, $hash_subt{1} will increase
																		  # its value(not key) by one, etc.
  $hash_subt_all{$subt}++;  # for the wholesome of seqs.
}
#______________________________________________________________________
# Title     : sort_hash_by_value_and_make_array
# Usage     : @values_sorted =@{&sort_hash_by_value_and_make_array(\%assoc)};
# Function  : sorts any hash by its values and returns ref. of sorted hash values
# Example   :
# Warning   : The same values will be overwritten.
# Class     :
# Keywords  : sort_hash_by_value, sort_hash, sort_by_values,
# Options   : -n  for numerical sort(not working yet)
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#------------------------------------------------------------------
sub sort_hash_by_value_and_make_array{
  my $i, $j, $num_sort;
  my %hash = %{$_[0]};
  my @keys = keys %hash;
  sub numerically{  $a <=> $b;  }
  for($i=0; $i<@ARGV; $i++){ # if numerically option is set.
	  if($ARGV[$i]=~/^\-n$/){
		  $num_sort =1;
		  splice(@ARGV, 0, 1);
	  }
  }
  for($i=0; $i < @keys; $i ++){
	  ${"long_string$i"} = "$hash{$keys[$i]} $keys[$i]";
	  #push(@array, ${"long_string$i"});
  }
  for($i=0; $i < @keys; $i++){
	  for($j=1; $j < @_; $j ++){
		  %hash2 = %{$_[$j]};
		  ${"long_string$i"} .= "  $hash2{$keys[$i]}";
	  }
	  push(@array, ${"long_string$i"});
  }
  if($num_sort==1){
	  @array_sorted = sort numerically @array;
  }else{ @array_sorted = sort  @array; }
  \@array_sorted;
}
#________________________________________________________________________
# Title     :  sort_by_hash_values
# Usage     : @values_sorted =@{sort_by_by_values(\%assoc)};
# Function  : sorts any hash by its values and returns ref. of sorted hash values
# Example   :
# Warning   : The same values will be overwritten.
# Class     :
# Keywords  : sort_hash_by_value, sort_hash,
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sort_by_hash_values{
  my(%hash) = %{$_[0]};
  @values = sort values %hash;
  \@values
}
#________________________________________________________________________
# Title     :  sort_by_keys
# Usage     : @values_sorted =@{sort_by_by_values(\%assoc)};
# Function  : sorts any hash by its values and returns ref. of sorted hash values
# Example   :
# Warning   :
# Class     :
# Keywords  : sort_hash_by_keys, sort_hash, key_sort
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sort_by_keys{
  my(%hash) = %{$_[0]};
  @values = sort keys %hash;
  \@values
}

#________________________________________________________________________
# Title     :  sort_hash_by_keys
# Usage     : @values_sorted =@{sort_by_by_values(\%assoc)};
# Function  : sorts any hash by its values and returns ref. of sorted hash values
# Example   :
# Warning   :
# Class     :
# Keywords  : sort_hash_by_keys, sort_hash, key_sort
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sort_hash_by_keys{
  my(%hash) = %{$_[0]};
  @values = sort keys %hash;
  \@values
}


#________________________________________________________________________
# Title     : sort_hash_by_value
# Usage     : @values_sorted =@{sort_by_by_values(\%assoc)};
# Function  : sorts any hash by its values and returns ref. of sorted hash values
# Example   :
# Warning   :
# Class     :
# Keywords  : sort_hash_by_value, sort_hash, value_sort,
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sort_hash_by_value{
  my(%hash) = %{$_[0]};
  @values = sort values %hash;
  \@values
}


#________________________________________________________________________
# Title     : by_values
# Usage     : for $key(sort by_values(values %assoc)){print $assoc{$key},"\n";}
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub by_values{
  $hash{$a} cmp  $hash{$b}
}

#______________________________________________________________________
# Title     : sort_string_by_length (synonym of sort_str_by_length  )
# Usage     : @output = &sort_string_by_length(@any_input_strings, [-r], @more);
# Function  : sorts strings in array according to their sizes
#             bigger comes first.
# Example   :
# Warning   :
# Class     :
# Keywords  : sort_array_by_length, sort_str_by_length, sort_array_string_by
#             sort_string_by_leng,
# Options   : -r  reverse the order
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#-------------------------------------------------------------------
sub sort_string_by_length{
  my(@input, $small_first, @output);
  for($i=0; $i<@_; $i++){
	if( $_[$i]=~/^\-?r$/i){
	   $small_first =1;
	   splice(@_, $i, 1);
	}elsif(ref($_[$i]) eq 'ARRAY'){
	   push(@input, @{$_[$i]});
	}elsif(ref($_[$i]) eq 'SCALAR'){
	   if(${$_[$i]}=~/^\-?r$/i){
		  $small_first=1;
		  splice(@_, $i, 1);
	   }else{
		  push(@input, ${$_[$i]});
	   }
	}elsif( !ref($_[$i]) ){
	   push(@input, $_[$i]);
	}
  }
  if($small_first ==1){
	 @output = sort {length($a) <=> length($a) || ($b cmp $a)} @input;
  }else{
	 @output = sort {length($b) <=> length($a) || ($a cmp $b)} @input;
  }
  return (\@output);
}


#________________________________________________________________________
# Title     : get_host_by_addr
# Usage     : ($name,$aliases,$addrtype,$length,@addrs)=&get_host_by_addr('131.111.137.11'); or
# Function  :
# Example   : ($name,$aliases,$addrtype,$length,@addrs)=&get_host_by_addr($var); while $var = "13.13.12.12";
# Warning   :
# Class     :
# Keywords  : get_host_by_address, get_hostname_by_address
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_host_by_addr{
   my $addr, @output;
   if(ref($_[0]) eq 'SCALAR'){
	   $addr= ${$_[0]};
   }elsif(!ref($_[0])){
	  $addr=$_[0];
   }
	my(@addr) = split(/\./, $addr);
	my($address) = pack("C4",@addr);
   my($name,$alias,$addrtype,$leng,@addrs)= gethostbyaddr($address,2);
   push(@output, $name,$alias,$addrtype,$leng,@addrs);
   return(\@output);
}

#________________________________________________________________________
# Title     : get_host_by_name
# Usage     : ($name,$aliases,$addrtype,$length,@addrs)=&get_host_by_name('ind4'); or
# Function  :
# Example   : ($name,$aliases,$addrtype,$length,@addrs)=&get_host_by_name($var);
#             while $var = "ind4";
# Warning   : ! not working yet.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_host_by_name{
	my($name)=$_[0];
	my($name,$alias,$addrtype,$leng,@addrs)= gethostbyname($name);
}

#________________________________________________________________________
# Title     : word_wrap
# Usage     : &word_wrap($line_to_format)
# Function  :
# Example   :
# Warning   :
#             The following subroutine does word wrapping on a text string
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
#             The string with newlines replacing spaces in appropriate places.
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub word_wrap {
	 local ($_) = @_;            # Access the argument.
	 s/(.{60}\S+)\s+/$1\n/g;     # Wrap on first space after 60th char.
										  # (This isn't the best algorithm, but it's
										  # simple.)
	 $_ && "$_\n";               # Append a newline if there's any text.
}
#________________________________________________________________________
# Title     : show_array
# Usage     : &show_array(\@input_array);
# Function  : for debugging purpose. Shows any array elem line by line.
# Example   : Output:      item1
#             Output:      item2
#             Output:      item3
# Warning   : can handle scalar ref, too.
# Class     :
# Keywords  :
# Options   : -h  for horizontal display of elements
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 2.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub show_array{
  my($k, $i, $t, @in, @in2, $in, $show_horizontally);
  my(@in)=@_;

  ## This is to get the option of 'horizontal' to make horizontal output.
  for($t=0; $t < @in ; $t++){
	 if($in[$t] =~/\-[hH][orizontal]*$/){   ### No ref.
		 $show_horizontally = "h";
		 splice(@in, $t, 1);  $t--;
	 }elsif(${in[$t]} =~/-[hH][orizontal]*$/){  ### ref.
		 $show_horizontally = "h";
		 splice(@in, $t, 1);  $t--;
	 }
  }

  for($k=0; $k < @in; $k++){
	 if(ref($in[$k]) eq 'ARRAY'){
		 &show_array(@{$in[$k]}, "\-$show_horizontally" );
	 }elsif(ref($in[$k]) eq 'SCALAR'){
		 if($show_horizontally eq "h"){
			 print ${$_[$k]}, "\,  ";
		 }elsif(  $show_horizontally ne "h"){
			 print ${$_[$k]}, "\n";
		 }
	 }elsif( !ref($in[$k]) ){
		 if($show_horizontally eq 'h'){
			 print  $_[$k] , "\,  ";
		 }elsif(  $show_horizontally ne "h"){
			 print  $_[$k] , "\n";
		 }
	 }
  }
  print "\n"; #### This is necessary to distinguish different arrays.
}

#________________________________________________________________________
# Title     : array_most_occur
# Usage     : $median = ${&array_most_occur(\@array)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :  median_array, get_median_array, get_array_median, array_median
# Options   :
# Package   : Calc_Util
# Reference :
# Returns   : \$median
# Tips      :
# Argument  : \@array
# Todo      :
# Author    : Ian Philips, A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub array_most_occur{
  my(%hash, @keys, $i, $most, $most_key);
  my(@array)=@{$_[0]};
  for($i=0; $i<@array; $i++){
		$hash{$array[$i]}++;
  }
  @keys = keys %hash;
  #&show_array(@keys);
  $most = $hash{$keys[0]};
  for($i=1; $i<@keys; $i++){
		if($hash{$keys[$i]} > $most){
	  $most_key=$keys[$i];
			 $most    =$hash{$keys[$i]};
		}
  }
  \$most_key;
}

#________________________________________________________________________
# Title     : array_least_occur
# Usage     : $median = ${&array_least_occur(\@array)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :  median_array, get_median_array, get_array_median, array_median
# Options   :
# Package   : Calc_Util
# Reference :
# Returns   : \$median
# Tips      :
# Argument  : \@array
# Todo      :
# Author    : Ian Philips, A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub array_least_occur{
  my(%hash, @keys, $i, $least, $least_key);
  my(@array)=@{$_[0]};
  for($i=0; $i<@array; $i++){
		$hash{$array[$i]}++;
  }
  @keys = keys %hash;
  #&show_array(@keys);
  $least = $hash{$keys[0]};
  for($i=1; $i<@keys; $i++){
		if($hash{$keys[$i]} < $least){
	  $least_key=$keys[$i];
			 $least    =$hash{$keys[$i]};
		}
  }
  \$least_key;
}


#________________________________________________________________________
# Title     : show_hash
# Usage     : &show_hash(\@input_array);
# Function  : for debugging purpose. Shows any array elem line by line.
#             the line is 60 elements long (uses recursion)
# Example   : Output:      item1
#             Output:      item2
#             Output:      item3
# Warning   : There is a global variable:  $show_hash_option
#             It tries to detect any given sting which is joined by ','
# Class     :
# Keywords  :
# Options   : -s or -S or s or S for spaced output. Eg)
#             seq1       1 1 1 1 1 1 1 1 1 1 1 1
#
#             instead of
#             seq1       111111111111
#
#             -h or -H or h or H for horizontal line of '---------...'
#
# Package   : Array_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.4
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub show_hash{
  my($k, $i, $t, @in, @in2, $in, $LEN, %TEM ); ## You should not put $show_hash_option
  my(@in)=@_;                     ## and $horizontal_line  in my !!!
  my($KL)=2; # default keys string length;
  my($VL)=80; # default values string length;
  my($GAP)=2;  # default space between keys and values

  ## This is to get the option of 'space' to make spaced output.
  for($t=0; $t < @in; $t++){
	 if($in[$t] =~/^[-]+[sS][pace]*$/){
		 $show_hash_optionXX = 1;
		 splice(@in, $t, 1);
	 }elsif(${in[$t]} =~/^[-]+[sS][pace]*$/){
		 $show_hash_optionXX = 1;
		 splice(@in, $t, 1);
	 }elsif($in[$t] =~/^[-]+[hH][rR]*$/){
		 $horizontal_line = 1;
		 splice(@in, $t, 1);
	 }elsif(${in[$t]} =~/^[-]+[hH][rR]*$/){
		 $horizontal_line = 1;
		 splice(@in, $t, 1);
	 }
  }

  ######## Main loop #################
  if($horizontal_line ==1){  ## This puts the delimiter '--------------(  )'
	  $Hash_counter ++;
	  print "\n","-"x78,"(${Hash_counter}th hash)", "\n";
  }

  for($k=0; $k < @in; $k++){
	 if(ref($in[$k]) eq 'ARRAY'){  ### When the hashes were given in array ref.
		 &show_hash(@{$in[$k]}, $show_hash_optionXX, $horizontal_line);
		 print "\n";
	 }
	 elsif(ref($in[$k]) eq 'HASH'){  ### recursion
		 &show_hash(%{$in[$k]});
		 print "\n";
	 }
	 elsif(ref($in[$k+1]) eq 'HASH'){  ### recursion
		 &show_hash(%{$in[$k+1]}); print "\n";
	 }
	 elsif(ref($in[$k]) eq 'SCALAR'){  print ${$_[$k]}, "\n";  }
	 elsif( !ref($in[$k]) ){
		 if( !ref($in[$k+1]) && defined($in[$k+1])  ){
			 if($show_hash_optionXX == 1){  #### space option checking.
				 if($in[$k+1] =~ /\,.+\,/){  #### if the string is joined with ','
					 @line = split(/\,/, $_[$k+1]);
				 }else{
					 @line = split(//, $_[$k+1]);
				 }
				%TEM = @in;
				$LEN = ${&max_elem_string_array_show_hash(keys %TEM)};
				 if($LEN > $KL){ $KL = $LEN + $GAP };
				 printf ("%-${KL}s ", $in[$k]);  $k++;
				 printf ("%-${VL}s\n","@line");
			 }else{                        ### If not option is set, just write
				%TEM = @in;
				$LEN = ${&max_elem_string_array_show_hash( keys %TEM)};
				 if($LEN > $KL){ $KL = $LEN + $GAP };
				 printf ("%-${KL}s ", $in[$k]);  $k++; # print $in[$k], "\t";  $k++;
				 printf ("%-${VL}s\n",$in[$k]);        # print $in[$k], "\n";
			 }
		 }
		  #________________________________________________________
		  # Title    : max_elem_string_array_show_hash
		  # Keywords : largest string length of array
		  # Function : gets the largest string length of element of any array of numbers.
		  # Usage    : ($out1, $out2)=@{&max_elem_array(\@array1, \@array2)};
		  #            ($out1)       =${&max_elem_array(\@array1)          };
		  # Argument : numerical arrays
		  # returns  : one or more ref. for scalar numbers.
		  # Version  : 1.0
		  #-------------------------------------------------------
		  sub max_elem_string_array_show_hash{
			 my(@input, $i, $max_elem);
			 @input = @{$_[0]} if ref($_[0]) eq 'ARRAY';
			 @input = @_       if ref($_[0]) ne 'ARRAY';
			 for($i=0; $i< @input ; $i++){
					$max_elem = length($input[0]);
					if (length($input[$i]) > $max_elem){
						$max_elem = length($input[$i]);
					}
			 }
			 \$max_elem;
		  }
		  #####################################insert_gaps_in_seq_hash
	 }
  }
}



#_________________________________________________________
# Title     :  open_predator_files
# Usage     :
# Function  : gets sec. str. prediction of predator and puts in hash
#             If 's' option is given, it also gives sequence hash ref
#             as the second output ref.
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : open_prd_files, predator, secondary structure prediction file
# Options   : 's' for sequence output as well (\%sec_str, \%seq)
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/bioperl.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#----------------------------------------------------
sub open_predator_files{
  my($name, $file, %seq, %sec_str);
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.3 >"""""""""""""""""""
	my(@A )=&handle_arguments( @_ );my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "\n   \@hash has \"@hash\"\n   \@raw_string has   \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has   \"@char_opt\"\n   \@file has \"@file\"
	\@string has \"@string\""; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  for($i=0; $i< @file; $i++){
	 $file = $file[$i];
	 open(IN, "$file");
	 while(<IN>){
		if(/\> *(\S+)/){
			$name=$1;
		}elsif(/^[\t ]{1,88}(\w+)$/){
		  $sec_str{$name}.=$1;
		}elsif( ($char_opt=~/s/i)&&(/[ \t]*\d+[ \t]*(\w+)[\t ]*\d+/)){
		  $seq{$name}.=$1;
		}
	 }
  }
  print "\n \%sec_str is: ", %sec_str, "\n" if ($debug == 1);
  if($char_opt=~/s/i){ return(\%sec_str, \%seq)}
  else{  return(\%sec_str) }
}


#________________________________________________________________________
# Title     : open_phd_files
# Usage     : &open_phd_files(\$file_name, $options,,,,,);
#             :
# Function  : open phd files and put sequences in a hash(s) (run open_phd_files.pl to
#             get some ideas on how this works. type  'open_phd_files.pl xxx.phdo s',
#             it will produce 5 different hashes of secondary structure pred.
# Example   :
# Warning   : All the spaces are converted to '_'
# Class     :
# Keywords  :
# Options   : $secondary, $access, $PHD_sec, $Rel_sec, $prH_sec, $prE_sec, $prL_sec,
#                  $prL_sec, $SUB_sec, $P_3_acc, $PHD_acc, $Rel_acc, $SUB_acc);
# Package   :
# Reference :
# Returns   : one or more hashes(ref.) secondary structure prediction of PHD server
#             --- The PHD secondary server output which are read by open_phd_files -----
#             1 =>       PHD sec |         HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH     HHHHHHH|
#             2 =>       Rel sec |987544342178899999999987678999998478999999999995679771688999|
#             3 =>       prH sec |001222323478899999999987778999998678999999999986110115788999
#             4 =>       prE sec |000010000101000000000000010000000000000000000000000000010000
#             5 =>       prL sec |987666565410000000000001110000001211000000000002789774100000
#             6 =>       SUB sec |LLLL
#             7 =>       P_3 acc |eeeeeeeeee bbeeebbbebbbbebeeee b bbebbebb eebeebe eee eebbeb|
#             8 =>       PHD acc |988787787630066600060000606667515007007005760671847885760160
#             9 =>       Rel acc |979685546222352421667053233245604127749164753790316552446141
#             0 =>       SUB acc |eeeeeeeee
# Tips      : As a short cut, you can use numbers, 1,2,3,4,... to retrieve different
#             types of PHD output, like 1 for 'PHD sec', 2 for 'Rel sec' etc.
# Argument  : one or more file names and options. Files should be PHD server's result.
# Todo      :
# Author    :
#
# Version   : 1.1
#
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_phd_files{
  my(@names, $i, $j,$n, $s, @in, @out_hash_ref_list, @option);
  my($secondary, $access, $PHD_sec, $Rel_sec, $prH_sec, $prE_sec, $prL_sec, $prL_sec,
	  $SUB_sec, $P_3_acc, $PHD_acc, $Rel_acc, $SUB_acc);
  for($i=0; $i < @_; $i ++){
	 if  ( (ref($_[$i]) eq 'SCALAR' )&&(-f ${$_[$i]}) ){ push(@in, ${$_[$i]}) }
	 elsif( ref($_[$i]) eq 'ARRAY' ){
		 for($j=0; $j< @{$_[$i]}; $j ++){
			 if( -f ${$_[$i]}[$j]){ push (@in, ${$_[$i]}[$j]) }
		 }
	 }
	 elsif((ref($_[$i]) eq 'SCALAR' ) && ($_[$i]=~/^[\-]*\w+/) ){ push(@option, ${$_[$i]}); }
	 elsif(!ref($_[$i]) && (-e $_[$i]) ){  push(@in, $_[$i]) }
	 elsif(!ref($_[$i]) && ($_[$i]=~/^[\-]*\w+/) ){ push(@option, $_[$i]); }
  }
  ## option handling ##
  if(@option == 0){ $PHD_sec_on = 1; } # if no option is given. default is single PHD_sec output.
  elsif(@option >= 1){ $PHD_sec_on = 0;
		for($i=0; $i < @option; $i ++){
		  if( $option[$i] =~ /^[sS]$/){
			  $PHD_sec_on = 1;  $Rel_sec_on = 1; $prH_sec_on = 1;
			  $prE_sec_on = 1;  $prL_sec_on = 1; $SUB_sec_on = 1; 	}
		  elsif( $option[$i] =~ /^[aA]$/){
			  $P_3_acc_on = 1; $PHD_acc_on = 1; $Rel_acc_on = 1;  $SUB_acc_on = 1; 	}
		  elsif( $option[$i] =~ /^PHD_sec$/){ $PHD_sec_on = 1}
		  elsif( $option[$i] =~ /^Rel_sec$/){ $Rel_sec_on = 1}
		  elsif( $option[$i] =~ /^prH_sec$/){ $prH_sec_on = 1}
		  elsif( $option[$i] =~ /^prE_sec$/){ $prE_sec_on = 1}
		  elsif( $option[$i] =~ /^prL_sec$/){ $prL_sec_on = 1}
		  elsif( $option[$i] =~ /^SUB_sec$/){ $SUB_sec_on = 1}
		  elsif( $option[$i] =~ /^P_3_acc$/){ $P_3_acc_on = 1}
		  elsif( $option[$i] =~ /^PHD_acc$/){ $PHD_acc_on = 1}
		  elsif( $option[$i] =~ /^Rel_acc$/){ $Rel_acc_on = 1}
		  elsif( $option[$i] =~ /^SUB_acc$/){ $SUB_acc_on = 1}
		}
  }## option handling END ##

  for($i=0; $i < @in; $i++){
	  open(FILE_1, "$in[$i]");    ########  This pattern matching is most buggy !! ####
		  while(<FILE_1>){
			 if   (      /^# +(\w+) *$/     )  { $name     =$1 }
			 elsif( (/^ +PHD +sec +\|([\w\. ]+)[\|]+ *$/)&&($PHD_sec_on==1) ){ $PHD_sec .=$1 }
			 elsif( (/^ +Rel +sec +\|([\w\. ]+)[\|]* *$/)&&($Rel_sec_on==1) ){ $Rel_sec .=$1 }
			 elsif( (/^ +prH +sec +\|([\w]+)[\|]* *$/) &&($prH_sec_on==1) ){ $prH_sec .=$1 }
			 elsif( (/^ +prE +sec +\|([\w]+)[\|]* *$/) &&($prE_sec_on==1) ){ $prE_sec .=$1 }
			 elsif( (/^ +prL +sec +\|([\w]+)[\|]* *$/) &&($prL_sec_on==1) ){ $prL_sec .=$1 }
			 elsif( (/ +SUB +sec +\|([\w\. ]+)[\|]+ *$/)&&($SUB_sec_on==1) ){ $SUB_sec .=$1 }
			 elsif( (/ +P_3 +acc +\|([\w\. ]+)[\|]* *$/)&&($P_3_acc_on==1) ){ $P_3_acc .=$1 }
			 elsif( (/ +PHD +acc +\|([\w\. ]+)[\|]* *$/)&&($PHD_acc_on==1) ){ $PHD_acc .=$1 }
			 elsif( (/^ +Rel +acc +\|([\w\. ]+)[\|]* *$/)&&($Rel_acc_on==1) ){ $Rel_acc .=$1 }
			 elsif( (/ +SUB +acc +\|([\w\. ]+)[\|]* *$/)&&($SUB_acc_on==1) ){ $SUB_acc .=$1 }
		 }
		 if ($PHD_sec_on==1){ $PHD_sec =~s/ /_/g; $PHD_sec{"$name"._PHD_s} = $PHD_sec }
		 if ($Rel_sec_on==1){ $Rel_sec =~s/ /_/g; $Rel_sec{"$name"._Rel_s} = $Rel_sec }
		 if ($prH_sec_on==1){ $prH_sec =~s/ /_/g; $prH_sec{"$name"._prH_s} = $prH_sec }
		 if ($prE_sec_on==1){ $prE_sec =~s/ /_/g; $prE_sec{"$name"._prE_s} = $prE_sec }
		 if ($prL_sec_on==1){ $prL_sec =~s/ /_/g; $prL_sec{"$name"._prL_s} = $prL_sec }
		 if ($SUB_sec_on==1){ $SUB_sec =~s/ /_/g; $SUB_sec{"$name"._SUB_s} = $SUB_sec }
		 if ($P_3_acc_on==1){ $P_3_acc =~s/ /_/g; $P_3_acc{"$name"._P_3_a} = $P_3_acc }
		 if ($PHD_acc_on==1){ $PHD_acc =~s/ /_/g; $PHD_acc{"$name"._PHD_a} = $PHD_acc }
		 if ($Rel_acc_on==1){ $Rel_acc =~s/ /_/g; $Rel_acc{"$name"._Rel_a} = $Rel_acc }
		 if ($SUB_acc_on==1){ $SUB_acc =~s/ /_/g; $SUB_acc{"$name"._SUB_a} = $SUB_acc }
		 push(@out_hash_ref_list, \%PHD_sec) if $PHD_sec_on==1;
		 push(@out_hash_ref_list, \%Rel_sec) if $Rel_sec_on==1;
		 push(@out_hash_ref_list, \%prH_sec) if $prH_sec_on==1;
		 push(@out_hash_ref_list, \%prE_sec) if $prE_sec_on==1;
		 push(@out_hash_ref_list, \%prL_sec) if $prL_sec_on==1;
		 push(@out_hash_ref_list, \%SUB_sec) if $SUB_sec_on==1;
		 push(@out_hash_ref_list, \%P_3_acc) if $P_3_acc_on==1;
		 push(@out_hash_ref_list, \%PHD_acc) if $PHD_acc_on==1;
		 push(@out_hash_ref_list, \%Rel_acc) if $Rel_acc_on==1;
		 push(@out_hash_ref_list, \%SUB_acc) if $SUB_acc_on==1;
	 }
	 if(@out_hash_ref_list == 1){ $out_hash_ref_list[0] }
	 else{ return(@out_hash_ref_list) }
}
#________________________________________________________________________
# Title     : open_swissprot_seq_files
# Usage     :
# Function  : open swiss files and puts ONLY the sequences in a hash(s)
# Example   :
# Warning   : ONLY the seq.
# Class     :
# Keywords  : open_swiss_seq_files, open_swiss_seq, read_swissprot_seq_files,
#            read_swiss_seq, get_swissprot_seq, take_swissprot_seq,
# Options   : 'v' for STDOUT printout as well.
# Package   :
# Reference :
# Returns   :
# Tips      : For better parsing look at open_swissprot_files
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_swissprot_seq_files{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.3 >"""""""""""""""""""
	my(@A )=&handle_arguments( @_ );my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "\n   \@hash has \"@hash\"\n   \@raw_string has   \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has   \"@char_opt\"\n   \@file has \"@file\"
	\@string has \"@string\""; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  my(@names, $i, $name, $n, $seq, $s, %hash, @out_hash_ref_list);
  for($i=0; $i< @file; $i++){
	 open(FILE_1, "$file[$i]");
	 undef(%hash);
	 while(<FILE_1>){      # file1 needs to be xxxx.msf
		 if(/^ID +(\w+) */){
			 $name=$1;
			 if($char_opt =~ /v/i){ print "\>$name\n"; }
		 }elsif(/^ +([\w ]+)$/){
			 $seq.=$1;
		 }elsif(/^\/\//){
			 $seq=~s/ //g;
			 if($char_opt =~ /v/i){ print "$seq\n"; }
			 $hash{$name}=$seq;
			 push(@out_hash_ref_list, \%hash);
			 $seq='';
		 }
	 }
  }
  if(@out_hash_ref_list  == 1 ){ return(\%hash); }
  elsif(@out_hash_ref_list > 1){ return(@out_hash_ref_list); }
}
#________________________________________________________________________
# Title     : open_msf_files
# Usage     : (*out, *out2) = @{&open_msf_files(\$inputfile1, \$inputfile2)};
#             : %hash_seq = %{&open_msf_files(\$inputfile1)};
#             : (@out)        = @{&open_msf_files(\$inputfile1, \$inputfile2)};
#             ---------- Example of MSF ---
#             PileUp
#
#             MSF:   85  Type: P    Check:  5063   ..
#
# Function  : open msf files and put sequences in a hash(s)
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : (*out, *out2)  or (@out_array_of_refs)
# Tips      :
# Argument  : (\$inputfile1, \$inputfile2, .... )};
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_msf_files{
	#""""""""""""""""""""""< handle_arguments{ head Ver 1.3 >"""""""""""""""""""
	my(@A )=&handle_arguments( @_ );my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "\n   \@hash has \"@hash\"\n   \@raw_string has   \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has   \"@char_opt\"\n   \@file has \"@file\"
	\@string has \"@string\""; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  my(@names, $i, $n, $s, %hash, @out_hash_ref_list);
  for($i=0; $i< @file; $i++){
	 open(FILE_1, "$file[$i]");
	 undef(%hash);
	 while(<FILE_1>){      # file1 needs to be xxxx.msf
		 if((/^([\S]+)\t* +$/)||(/^\#/)||(/^\-+/)){ next; }
		 if(/^([\S]+)\t* +([\.\w ]+)[\n]$/){
			 $n=$1;
			 $s=$2;
			 $s=~s/ //g;
			 $hash{$n}.= $s;
		 }
	 }
	 push(@out_hash_ref_list, \%hash);
  }
  if(@out_hash_ref_list  == 1 ){ return(\%hash); }
  elsif(@out_hash_ref_list > 1){ return(@out_hash_ref_list); }
}

#__________________________________________________________________
# Title     : open_msp_files.pl
# Usage     :
# Function  : opens Erik Sonhammer's MSPcrunch file output.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : _  for debugging.
#             #  for debugging.
#            s -s S -S  for size return only
#
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.2
# Used in   :
# Enclosed  :
#---------------------------------------------------------------------
sub open_msp_files{
	#"""""""""""""""""< handle_arguments{ head Ver 3.9 >"""""""""""""""""""
	my(@A)=&handle_arguments(@_);my($num_opt)=${$A[7]};my($char_opt)=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};
	my(@raw_string)=@{$A[9]};my(%vars)=%{$A[10]};my(@range)=@{$A[11]};
	my($i,$j,$c,$d,$e,$f,$g,$h,$k,$l,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z);
	if($debug==1){print "\n\t\@hash=\"@hash\"
	\@raw_string=\"@raw_string\"\n\t\@array=\"@array\"\n\t\@num_opt=\"@num_opt\"
	\@char_opt=\"@char_opt\"\n\t\@file=\"@file\"\n\t\@string=\"@string\"\n" }
	#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   my %matched_seq, @MSP, %Sizes;
   for($i=0; $i< @file; $i++){
	  my($input_file) = ${$file[$i]} || $file[$i];

	  if($debug eq 1){ print "\n inputfile is $input_file\n" };
	  unless (-e $input_file){
		  print chr(7);
		  print "\n\n\t This is sub open_msp_files in $0  \n\n";
		  print "\t Fatal: The input file $input_file is not in the directory \n";
	  }
	  open(FILE_1,"$input_file");
	  @MSP=<FILE_1>;

	  for($j=0; $j<@MSP; $j++){
		 #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		 #                   $1                 $2     $3    $4      $5     $6    $7     $8
		 #                   171     41.18      6      73  HI1690    9      76  HI0736 sodium...
		 #,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
		 if($MSP[$j]=~/^ *(\d+) +\d+\.*\d* +(\d+) +(\d+) +(\w+) +(\d+) +(\d+) +(\w+) +(.+)/i){
			if($4 eq $7){
			  $query_name=$7;
			  $query_leng=$3;
			  my $matched_seq;
			  for($k=0; $k<$query_leng; $k++){
				$query[$k]=0;
			  }
			  $query_fasta="$query_name\.fa";
			  open(QUERY_FASTA, "$query_fasta");
			  my @QUERY_FASTA=<QUERY_FASTA>;
			  for(@QUERY_FASTA){
				 if(/\>$query_name/){
					$query_found=1; next;
				 }elsif(($query_found==1)&&(/^(\w{10,})$/)){
					$matched_seq .=$1;
				 }
			  }
			  $matched_seq{$query_name}=$matched_seq;
			  close(QUERY_FASTA);
			}elsif($4 ne $7){
			   if($match_name ne $7){
				  $match_name=$7;
				  my $matched_seq;
				  push(@matched_members, $7);
				  $matched_fasta="$match_name\.fa";
				  open(MATCHED_FASTA, "$matched_fasta")|| die "\n No $matched_fasta\n";
				  my @MATCHED_FASTA=<MATCHED_FASTA>;
				  for(@MATCHED_FASTA){
					if(/\>$match_name/){
					  $found=1; next;
					}elsif(($found==1)&&(/^(\w{10,})$/)){
					  $matched_seq .=$1;
					}
				  }
				  $matched_seq{$match_name}=$matched_seq;
			   }
			 }
		  }
	  }
   }
   if(defined(@range)){
	  %seq_fragments=%{&get_seq_fragments(\%matched_seq, \@range)};
	  return(\%seq_fragments);
   }elsif($char_opt=~/s/i){ # when SIZE return only option is set
	  @seq_Names=keys %matched_seq;
	  for($i=0; $i<@seq_Names; $i++){
		 $Sizes{$seq_Names[$i]}=length($matched_seq{$seq_Names[$i]});
	  }
	  return(\%Sizes);
   }else{
	  return(\%matched_seq);
   }
}

#________________________________________________________________________
# Title     : open_dssp_files
# Usage     : (*out, *out2) = @{&open_dssp_files(\$inputfile1, \$inputfile2, \$H, \$S,,,,)};
#             (@out)        = @{&open_dssp_files(\$inputfile1, \$inputfile2, \$H, \$S,,,,)};
# Function  : open dssp files and put sequences in a hash(s)
#              It can take options for specific secondary structure types. For example,
#              if you put an option $H in the args of the sub with the value of 'H'
#              open_dssp_files will only read secondary structure whenever it sees 'H'
#              in xxx.dssp file ignoring any other sec. str. types.
#              If you combine the options of 'H' and 'E', you can get only Helix and long
#              beta strand sections defined as segments. This is handy to get sec. str. segments
#              from any dssp files to compare with pdb files etc.
#             With 'simplify' option, you can convert only all the 'T', 'G' and 'I' sec. to
#              'H' and 'E'.
# Example   :
# Warning   : 6taa.dssp  and 6taa are regarded as the same.
# Class     :
# Keywords  :
# Options   : H, S, E, T, I, G, B, P, C, -help
# $H        =        'H' by   -H or -h or H or h  # to retrieve 4-helix (alpha helical)
# $S        becomes  'S' by   -S or -s or S or s  # to retrieve Extended strand, participates in B-ladder
# $E        becomes  'E' by   -E or -e or E or e  # to retrieve residue in isolated Beta-bridge
# $T        becomes  'T' by   -T or -t or T or t  # to retrieve H-bonded turn
# $I        becomes  'I' by   -I or -i or I or i  # to retrieve 5-helix (Pi helical) segment output
# $G        becomes  'G' by   -G or -g or G or g  # to retrieve 3-helix (3-10 helical)
# $B        becomes  'B' by   -B or -b or B or b  # to retrieve only B segment
# $simplify becomes   1  by   -p or P or -P, p
# $comm_col becomes  'c' by   -c or c or C or -C or common
# $HELP     becomes   1  by   -help   # for showing help
#
# Package   :
# Reference :
# Returns   : (*out, *out2)  or (@out_array_of_refs)
# Tips      :
# Argument  : files names like (6taa, 6taa.dssp) If you put just '6taa' without extension, it
#             searches if there is a '6taa.dssp' in both PWD and $DSSP env. set directory.
#             ---------- Example of dssp ---
#             **** SECONDARY STRUCTURE DEFINITION BY THE PROGRAM DSSP, VERSION JUL
#             REFERENCE W
#             HEADER    RIBOSOME-INACTIVATING PROTEIN           01-JUL-94   1MRG
#             COMPND    ALPHA-MOMORCHARIN COMPLEXED WITH ADENINE
#             SOURCE    BITTER GOURD (CUCURBITACEAE MOMORDICA CHARANTIA) SEEDS
#             AUTHOR    Q
#             246  1  0  0  0 TOTAL NUMBER OF RESIDUES, NUMBER OF CHAINS, NUMBER OF SS-BRIDGES(TOTAL,INTRACHAIN,INTERCHAIN)                .
#             112 95.0   ACCESSIBLE SURFACE OF PROTEIN (ANGSTROM**2)                                                                         .
#             171 69.5   TOTAL NUMBER OF HYDROGEN BONDS OF TYPE O(I)-->H-N(J)  , SAME NUMBER PER 100 RESIDUES                              .
#             12   4.9   TOTAL NUMBER OF HYDROGEN BONDS IN     PARALLEL BRIDGES, SAME NUMBER PER 100 RESIDUES                              .
#             36  14.6   TOTAL NUMBER OF HYDROGEN BONDS IN ANTIPARALLEL BRIDGES, SAME NUMBER PER 100 RESIDUES                              .
#             1    0.4   TOTAL NUMBER OF HYDROGEN BONDS OF TYPE O(I)-->H-N(I-5), SAME NUMBER PER 100 RESIDUES                              .
#             1    0.4   TOTAL NUMBER OF HYDROGEN BONDS OF TYPE O(I)-->H-N(I-4), SAME NUMBER PER 100 RESIDUES                              .
#             74  30.1   TOTAL NUMBER OF HYDROGEN BONDS OF TYPE O(I)-->H-N(I+4), SAME NUMBER PER 100 RESIDUES                              .
#             5    2.0   TOTAL NUMBER OF HYDROGEN BONDS OF TYPE O(I)-->H-N(I+5), SAME NUMBER PER 100 RESIDUES                              .
#             1    2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30     *** HISTOGRAMS OF ***           .
#             0    0  0  0  1  1  0  2  0  0  1  0  0  1  0  0  0  0  0  2  0  0  0  0  0  0  0  0  0  0    RESIDUES PER ALPHA HELIX         .
#             1    0  0  2  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0    PARALLEL BRIDGES PER LADDER      .
#             2    0  1  2  0  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0    ANTIPARALLEL BRIDGES PER LADDER  .
#             2    0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0    LADDERS PER SHEET                .
#             #   RESIDUE AA STRUCTURE BP1 BP2  ACC   N-H-->O  O-->H-N  N-H-->O  O-->H-N    TCO  KAPPA ALPHA  PHI   PSI    X-CA   Y-CA   Z-CA
#             1    1   D              0   0  132    0, 0.0   2,-0.3   0, 0.0  49,-0.2   0.000 360.0 360.0 360.0 153.4   44.0   96.9  -23.8
#             2    2   V  E     -a   50   0A  10   47,-1.5  49,-2.8   2, 0.0   2,-0.3  -0.889 360.0-163.3-115.9 151.4   43.1  100.4  -22.5
#             3    3   S  E     -a   51   0A  63   -2,-0.3   2,-0.3  47,-0.2  49,-0.2  -0.961  10.3-172.8-131.0 152.3   44.8  103.7  -23.4
#             4    4   F  E     -a   52   0A   8   47,-2.2  49,-2.3  -2,-0.3   2,-0.4  -0.985   6.9-161.2-143.2 139.5   45.0  107.2  -22.0
#             5    5   R  E     -a   53   0A 144   -2,-0.3   4,-0.2  47,-0.2  49,-0.2  -0.993   9.7-156.0-121.0 125.9   46.6  110.2  -23.6
#             6    6   L  S    S+     0   0    1   47,-2.3   2,-0.5  -2,-0.4   3,-0.4   0.644  73.2  90.9 -73.3 -22.4   47.5  113.2  -21.4
#             7    7   S  S    S+     0   0   81   47,-0.3   3,-0.1   1,-0.2  -2,-0.1  -0.695 106.0   5.2 -75.5 121.0   47.4  115.6  -24.4
#             8    8   G  S    S+     0   0   72   -2,-0.5  -1,-0.2   1,-0.3   5,-0.1   0.269  97.6 147.8  90.2 -10.7   43.9  117.0  -24.7
#             9    9   A        +     0   0   10   -3,-0.4  -1,-0.3  -4,-0.2  -3,-0.1  -0.256  16.8 166.8 -58.8 142.4   42.9  115.2  -21.5
#             (\$inputfile1, \$inputfile2, .... )};
# Todo      :
# Author    : A Biomatic
# Version   : 2.9
#             $debug feature has been added to make it produce error messages with '#' option.
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_dssp_files{
  #""""""""""""""""""""""< handle_arguments head Ver 1.0 >""""""""""""""""""""""""""""""""""""""
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z, $gap_char,
	  $dir, $file, $line, $name, $ori_name, @keys, @names,  $str_input, $C, @out_hash_ref_list,
	  @temp, $temp, %hash, %input, %com_col_hash, $ref_hash_out, $BASE );
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my $gap_char = '_';

  if($char_opt !~ /[HEBGIST]/i){  ## This is default sec. str type setting. (full representation)
		$char_opt = 'HEBGIST';
  }
  if ($debug eq 1){
	  print __LINE__, " # open_dssp_files : \$simplify     is  $simplify\n" ;
	  print __LINE__, " # open_dssp_files : \@file given   is  @file \n" ;
	  print __LINE__, " # open_dssp_files : \@string given is  @string\n" ;
  }
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ### Big main loop for input argument handling   ####
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #  This is to check if the given file is not in pwd but in ENV var $DSSP
  #  Or if the file name was given only by the base name of seq(eg. 1cdg rather
  #  than 1cdg.dssp
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  for ($i=0; $i < @string; $i ++){
		 print __LINE__, " ${i}th string input is  $string[$i] \n" if $debug eq 1;
		 $string[$i] = "$string[$i]\.dssp"; ## adding  .dssp extension
		 print __LINE__, " ${i}th string inputwith \.dssp is now, $string[$i] \n" if $debug eq 1;

		 if(-f $string[$i]){
			 print chr(7) if $debug eq 1;
			 print __LINE__, " Your input filename exist in this File: $string[$i]\n" if $debug eq 1;
			 unshift(@file, "$string[$i]");
		 }
		 elsif(-l $string[$i]){
			 print chr(7) if $debug eq 1;
			 print "\n Your input filename exist as a Link to : $string[$i]\n" if $debug eq 1;
			 unshift(@file, "$string[$i]");
		 }
		 elsif( -d $ENV{'DSSP'} ){
			 $string[$i] =~ s/(\w+)\.dssp$/$1/; ## stripping .dssp extension
			 if( -e "$ENV{'DSSP'}\/$string[$i]\.dssp" ){
				unshift(@file, "$ENV{'DSSP'}\/$string[$i]\.dssp");
				$BASE = $string[$i];
			 }else{
				 print chr(7);
				 print __LINE__, " !! Error your DSSP env setting seems wrong. \n";
				 print __LINE__, " !! Your DSSP env path is also a link. \n" if (-l $ENV{'DSSP'});
				 print __LINE__, " I can't find  $ENV{'DSSP'}\/$string[$i] \n\n";
			 }
		 }
		 elsif( -l $ENV{'DSSP'} ){ #"""""""  IF $DSSP was a link
			 print __LINE__, " !! Your DSSP env path is also a link. \n" if $debug eq 1;
			 if( -e "$ENV{'DSSP'}\/$string[$i]\.dssp" ){
				unshift(@file, "$ENV{'DSSP'}\/$string[$i]\.dssp");
				$BASE = $string[$i];
			 }
			 elsif( -e "$ENV{'DSSP'}\/$string[$i]" ){
				unshift(@file, "$ENV{'DSSP'}\/$string[$i]\.dssp");
			 }
		 }
  }

  @file=@{remove_dup_in_array(\@file)};

  if ($debug eq 1){
	  print __LINE__, " # open_dssp_files : ENV set for dssp is $ENV{'DSSP'} \n" ;
	  print __LINE__, " # open_dssp_files : Final \@file given are \" @file \"\n" ;
  }
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #  END of File and string input checking in searching for the right dssp file.
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #"""""""""""""""""""""""" MAIN """"""""""""""""""""""""""""""""""""""
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  for($i=0; $i< @file; $i++){  ## <<-- loops over the input files.
		 my($flag, %hash, $name, $s, $matched, $ori_name, $chain);
		 my($real_file) = $file[$i];
		 $file[$i] =~ s/(.*\/)(\w+)\.(\w+)$/$2/; ## stripping .dssp extension
		 $file[$i] =~ s/(\w+)\.(\w+)$/$1/;       ## stripping .dssp extension
		 $ori_name = $name = $file[$i];
		 print "\n",__LINE__, " VAR \$ori_name is  $ori_name , \$file\[\$i\] is $file[$i]\n" if $debug eq 1;
		 unless(-e $real_file){
			print "\n",__LINE__,"  !!! ERROR $real_file does not exists as the final filename\n" if $debug eq 1;
			splice(@file, $i, 1); $i--;
			print "\n",__LINE__,"  Skipping to the next file to open" if $debug eq 1;
			next;
		 }

		 open(FILE_1,"$real_file");
		 print "\n",__LINE__, " ${i}th file $real_file is being opened from \@file \n" if $debug eq 1;
		 print "_"x86,"\n", if $debug eq 1;

		 while(<FILE_1>){
			 if(/^[\s]*\#\s+RESIDUE/){
				 $flag =1;
				 print __LINE__," \"#  RESIDUE\"   string found at line $. in $real_file\n" if $debug eq 1;
				 next
			 }  ##   '#  RESIDUE' is the starting key

			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 #    Matching the column
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

			 if(  ($flag==1) && (/^[\s]*-*\d+\s+-*\d*\s+[\w]\s\s([\w ]) /)  ){
				 $matched = $1;
				 print __LINE__," \"$matched\" is matched\n" if $debug2 eq 1;

				 if( $char_opt =~ /$matched/){ ## Here OPTIONS affect the operation.
					 $s .= $matched;    ## $match_option is like 'HE'. If the
					 next;              ## single char $matched is H or E, it will be
				 }else{                ## annexed to $s as an output.
					 $s .= $gap_char;
					 next;
				 }  # <-- this is necessary to get the right length (not to ignore
			 }     #     not matched char by converting them to ' '.

			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 #    When there are chains like A, B, ,,,
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 elsif( ($flag==1) && (/^[\s]*-*\d+\s+-*(\d+)[\s\w]+(\w)\s+[\w]\s\s([\w ]) /) ){
				 $chain = $2;   ## $flag  is for the starting key
				 # ${"chain_start$name$2"} = $1 unless defined(${"chain_start$name$2"});
				 my($matched_chain) = $3;
				 if( $char_opt =~ /$matched_chain/){
					$s .= $matched_chain;   next; }
				 else{
					$s .= $gap_char; next; }
			 }elsif( (/^\s+\d+\s+\!/)&&($chain =~/\w/) ){
				 $name="$name$chain";
				 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
				 ##   IF simplify  option is set
				 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
				 if($simplify eq 1){
					 $s =~ tr/TGI/EHH/;   ### change the characters.
					 print __LINE__," Simplifying TGI to EHH by \"tr\"\n" if $debug eq 1;
				 }
				 if($debug eq 1){ print __LINE__, " Name of seq:  $name \n"; }
				 $hash{$name}=$s; $s='';
				 $name=$ori_name; next;
			 }
		 }
		 close(FILE_1);  ##<<---- Reading finished.

		 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		 ##  Naming procedure
		 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		 if($chain =~/^\w$/){     # when there are chains, put A,B, etc to seq. names.
			 $name="$name$chain";  ## <<-- This is for the last chain entry.
			 if($debug eq 1){ print __LINE__, " Name of seq:  $name, There were Chains !\n"; }
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 ##   IF simplify  option is set
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 if($simplify eq 1){
				 $s =~ tr/TGI/EHH/;   ### change the characters.
				 print __LINE__," Simplifying TGI to EHH by \"tr\"\n" if $debug eq 1;
			 }
			 $hash{$name}=$s;
			 $s='';   ##<<--- This is essential, a former bug!
			 $name=$ori_name;
		 }else{      # <<-- Without chains option.
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 ##   IF simplify  option is set
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 if($simplify eq 1){
				 $s =~ tr/TGI/EHH/;   ### change the characters.
				 print __LINE__," Simplifying TGI to EHH by \"tr\"\n" if $debug eq 1;
			 }
			 $hash{$name}=$s;
			 if($debug eq 1){ print __LINE__, " Name of seq:  $name \n"; }
			 $s='';   #<<--- This is essential, a former bug!
		 }

		 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		 ### OUTput format determination according to options #####
		 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		 if($debug eq 1){ print "\n", __LINE__, " The Hash out of \"$real_file\" is \n ";
			 &show_hash(%hash);
		 }
		 push(@out_hash_ref_list, \%hash) if ref(\%hash) eq 'HASH';
  }
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #"""""""""""" END of Main """""""""""""""""""""""""""
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  if($comm_col =~ /c/i){ # $comm_col  is a global
	  if($debug eq 1){
		  print "\n", __LINE__;
		  print " # open_dssp_files : you have put 'c' option for common column only\n";
		  $temp = @out_hash_ref_list;
		  print __LINE__, " # open_dssp_files : No. of hashes passed to get_common_column is: $temp\n";
		  print __LINE__, " # open_dssp_files : The hash are(is) : @out_hash_ref_list\n";
	  }
	  $ref_hash_out = &get_common_column(@out_hash_ref_list);
	  return($ref_hash_out);
  }else{
	  if(@out_hash_ref_list == 1){ return($out_hash_ref_list[0]); }
	  elsif(@out_hash_ref_list > 1){ return(@out_hash_ref_list);  }
  }
}

#________________________________________________________________________
# Title     : open_dna_files  (genbank file opener)
# Usage     : ($out, $out2) = @{&open_dna_files(\$inputfile1, \$inputfile2)};
#             : (@out)        = @{&open_dna_files(\$inputfile1, \$inputfile2)};
#             ---------- Example of dna file --- dna files are genbank file format
#
#
#             1 ggatcttgct gaatacatgg tggcacaatt gaaattagat ccgcgaattt
#               tcatcaaaac
#             61 agcgggatta tggtcaacaa atccgtaaaa atgaaaagcc tgtcttgcga
#               caggcttttt
#             121 tatttgaatg taatcctcac tggtaaacgt ttaacgccaa agacaaaggg
#               actagggatc
#             181 gcttcaagct tttcatcatg agcagctttt tcgatacaag ctgacattga
#
# Function  : open dna files and put sequences in a hash(s)
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : (@out_array_of_refs)
# Tips      :
# Argument  : (\$inputfile1, \$inputfile2, .... )};
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_dna_files{  my(@in)=@_; my(@names, $i,$n, $s, %hash,@out_hash_ref_list);
  for($i=0; $i<=$#in; $i++){
	 if(ref($in[$i])){ unless (-e ${$_[$i]}){ next; }
		 open(FILE_1,"${$_[$i]}");  undef(%hash);
		 while(<FILE_1>){      # file1 needs to be xxxx.msf for the moment, automatic later
			 if(/Name\:\s+(\S+)\s+/){ $n=$1; $n=~s/\,//g; }
			 if((/\s+\d+\s([acgt ]+)$/)||(/\s\s\s\s+([acgt ]+)$/)){
				$s=$1; $s=~s/ //g; $s=~tr/a-z/A-Z/; $hash{$n}.=$s; }     }
		 push(@out_hash_ref_list, \%hash); } }
  if(@out_hash_ref_list  == 1 ){ return(\%hash); }
  elsif(@out_hash_ref_list > 1){ return(@out_hash_ref_list); } # <-- contains (\%out_seq0, \%out_seq1, \%out_seq2, .... )
}
#________________________________________________________________________
# Title     : open_tem_files
# Usage     : ($r1, $r2, $r3, $r4, $r5)=&open_tem_files(\$infile1, \$inputfile2..)};
#             ---------- Example of xxxx
#             >P1;1cdg
#             sequence
#             APDTSVSNKQNFSTDVIYQIFTDRFSDGNPANNPTGAAFDGTCTN-LRLYCGGDWQGIINKINDGYLTGMGVTAI
#             >P1;1cdg
#             secondary structure and phi angle
#             CCCCCCCCCCCCCCCCEEECCHHHHCCCCHHHCCCPHHCCCCPCC-CCCCCPCCHHHHHHHHHCPHHHHHPCCEE
#             >P1;1cdg
#             solvent accessibility
#             TTTTTTTTTTTFFFFFFFFFFFFFFTTTTTTTTTTTTTTTTTFTT-TTTTFFFFFTFFTTTFTTTFFTTFTFTFF
#             >P1;1cdg
#             DSSP
#             CCCCCCCCCCCCCCCCEEECCHHHHCCCCGGGCCCGGGCCCCCCC-CCCCCCCCHHHHHHHHHCCHHHHHCCCEE
#             >P1;1cdg
#             percentage accessibility
#             67523272360000000000000002213792129b722248085-14110000030015105660028040200
#             2ltn           ----TETTSFLITKFSPDQQNLIFQGDGYTT-KEKLTLTK------AVKNTVGRALYSSP
#             1loe           ----TETTSFSITKFGPDQQNLIFQGDGYTT-KERLTLTK------AVRNTVGRALYSSP
#
#             2ltn           ----CEEEEEEECCCCCCCCCEEEEPCCEEP-PPCEEEEC------CCCPCEEEEEECCC
#             1loe           ----CEEEEEEECCCCCCCCCEEEEPCCEEE-PPEEEEEC------CCCPCEEEEEECCC
#
#             2ltn           ----TTTTTTTTTTFTTTTTTFTTTTTFTFT-TTTFTFFT------TTTTTTFFFFTTTT
#             1loe           ----TTTTTTTTTTFTTTTTTFTTTTTFTFT-TTTFFFFT------TTTTTTFFFFTTTT
#
#             2ltn           ----CEEEEEEECCCCCCCCCEEEEECCEEC-CCCEEEEC------CCCCCEEEEEECCC
#             1loe           ----CEEEEEEECCCCCCCCCEEEEECCEEE-CCEEEEEC------CCCCCEEEEEECCC
#
#             2ltn           ----543251b16504681c50422650502-75201006------35681200001453
#             1loe           ----6532e1508a07981b50422750404-8a200006------36672200001453
# Function  : opens JPO's xxxx.tem file, stores in 5 hashes. (usually one tem file)
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : -n, n, or N for removing any gaps in the sequences.
#             -s, s, or S for getting only the sequences.
# Package   :
# Reference :
# Returns   : ($r1, $r2, $r3, $r4, $r5) <= these are references for hashes.
# Tips      :
# Argument  : (\$inputfile1, \$inputfile2, .... )};
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_tem_files{
  my($a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r,
	  $s, $t, $u, $v, $w, $x, $y, $z, $pwd, $file, $dir, $output, $in_dir,
	  %hash, @keys, @array, @hash, $option_string, $string, @in, $line,
	  $name, %out, $gap_chr, @str1, @str2, $num_opt, @file, @dir,
	  $char_opt, $char_opt_given, $num_opt_given,
	  @char_options, @file, $original_dir, @read_files, %array_msf, %array_jp,
	  $jp_file, $error_rate, $id_compos, @dir, @names, $name, $name_found,
	  @outref, %sequence, %secondary,%solvent_access, %DSSP, %percent_accessibility,
	  $name_found,$type_seq, $type_secon, $type_sol, $type_DSSP, $type_acc
  );
  ##################################################
  ##### Start of  general argument handling   ######
  ##################################################
  for($k=0; $k< @_ ;$k++){
	  if( !ref($_[$k]) ){
			  if($_[$k]=~ /^[\-]*(\w)$/){
				  $char_opt  .= "\,$1";
				  $char_opt_given =1;
			  }elsif($_[$k]=~ /^\-(\w\w+)$/){       ## When multiple option is given,
				  my(@char_options) = split(/|\,/, $1); ## '-' should be used. eg. '-HEGI'
				  $char_opt .= join("\,", @char_options);  ## as an option string.
				  $char_opt_given = 1;
			  }elsif($_[$k]=~ /^([\-]*\d)$/){
				  $num_opt   .= "\,$1";  ## delimiter is ','
				  $num_opt_given = 1;
			  }elsif(-f $_[$k]){     ## When file is given,
				  push(@file, \$_[$k] );
			  }elsif(-d $_[$k]){     ## When dir is given,
				  push(@dir, \$_[$k] );    }
	  }elsif( ref($_[$k]) ){
			if(ref($_[$k]) eq "SCALAR")
				{if(${$_[$k]} =~ /^[\-]*(\w)$/){  ## check if it has '-' before option char
					$char_opt  .= "\,$1";  ## delimiter for option char is ','
					$char_opt_given = 1;
				}elsif(${$_[$k]}=~ /^\-(\w\w+)$/){       ## When multiple option is given,
					my(@char_options) = split(/|\,/, $1); ## '-' should be used. for eg. '-HEGI'
					$char_opt  .= join("\,", @char_options);  ## as an option string.
					$char_opt_given =1;
				}elsif(${$_[$k]}=~ /^([\-]*\d)$/){
					$num_opt   .= "\,$1";  ## delimiter is ','
					$num_opt_given = 1;
				}elsif(-f ${$_[$k]}){     ## When file is given,
					push(@file, $_[$k] );
				}elsif(-d ${$_[$k]}){     ## When dir is given,
					push(@dir, $_[$k] );  }
			}elsif(ref($_[$k]) eq "ARRAY"){  ## When ARRAY is given,
					push(@array, $_[$k]);
			}elsif(ref($_[$k]) eq "HASH"){   ## When HASH is given,
					push(@hash, $_[$k]);
			}
	  }
	  ###################################################
	  ## The output of this option handling section is
	  ## one or combination of these:
	  ## $char_opt_given   ##<<-- Simple boolean '1' or none
	  ## $num_opt_given    ##<<-- Simple boolean '1' or none
	  ## $char_opt, as ('A,B,C')
	  ## $num_opt,  as ('1,-2,3')
	  ## @file          as (\file1, \file2,...)
	  ## @dir           as (\dir1, \dir2,...)
	  ## @array         as (\array1, \array2,,,)
	  ## @hash          as (\hash1, \hash2,,,,)
	  ###################################################
  }
  ################################################
  ##### END of  general argument handling   ######
  ################################################

  for($i=0; $i < @file; $i++){
	 if(ref($file[$i])){ unless(-T ${$file[$i]}){ next; }
		 open(FILE_1, "${$file[$i]}");
		 while(<FILE_1>){
			 if(/^\>P1\;([\w\-]+)/){ $name=$1; #=================== SEQUENCE
				($type_seq, $type_secon, $type_sol, $type_DSSP, $type_acc)=();
			 }elsif(/^sequence/){  $type_seq = 1;
			 }elsif(($type_seq ==1)&&(/^([\w\-]+)[\*]*$/)){
				my($line) = $1;
				if( $char_opt =~ /[nN]/){  ## to remove the gaps etc.
					$line=~s/\W//g;
					$sequence{$name}.=$line;
				}else{
					$sequence{$name}.=$line;
				} #from below ============== SECONDARY
			 }elsif(/^secondary structure and phi angle/){  $type_secon = 1;
			 }elsif(($type_secon ==1)&&(/^([\w\-]+)[\*]*$/)){
				$secondary{$name}.=$1;     #from below============= SOLVENT ACCESSIBILITY
			 }elsif(/^solvent accessibility/){  $type_sol = 1;
			 }elsif(($type_sol ==1)&&(/^([\w\-]+)[\*]*$/)){
				$solvent_access{$name}.=$1;     #from below========= DSSP
			 }elsif(/^DSSP/){  $type_DSSP = 1;
			 }elsif(($type_DSSP ==1)&&(/^([\w\-]+)[\*]*$/)){
				$DSSP{$name}.=$1;     #from below=================== PERCENTAGE ACCESSIBILITY
			 }elsif(/^percentage accessibility/){  $type_acc = 1;
			 }elsif(($type_acc ==1)&&(/^([\w\-]+)[\*]*$/)){
				$percent_accessibility{$name}.=$1;  } }
		  push(@outref,\%sequence,\%secondary,\%solvent_access,\%DSSP,\%percent_accessibility);
	  }  }
  if( ($char_opt =~ /[sS]/) || ( @outref  == 1 ) ){
	  return(\%sequence); }
  elsif( @outref > 1){ return(@outref); } # <-- contains (\%sequence,\%secondary,....)
}

#________________________________________________________________________
# Title     : open_hlx_files
# Usage     :
# Function  :
#             Example of hlx file (For Bo Nielson)
#             Residue Frame Score Probability
#             1 M   a  1.00563E+00 2.05479E-03
#             2 T   b  1.01814E+00 2.52053E-03
#             3 R   c  1.01814E+00 2.52053E-03
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : list of ref. for hash(es)
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_hlx_files{  my(@in)=@_; my(@names, $i,$n, $s, %hash,@out_hash_ref_list);
  for($i=0; $i< @in; $i++){
	 if(ref($in[$i])){ unless(-e ${$in[$i]}){ next; }}
	 open(FILE_1, "${$in[$i]}");
	 while(<FILE_1>){
		if(/^[\s]+([\d]+)\s+(\w+)\s+(\w+)\s+\S+\s+(\S+)$/){
		  $hash_residue{$1}=($2); # residue num is key, residue is value.
		  $hash_frame{$1}=($3);   # residue num is key, frame is  value.
		  $hash_prob{$1}=($4);    # residue num is key, probability is  value.
		}
	 }
	 push(@out_hash_ref_list, \%hash_residue, \%hash_frame, \%hash_prob);
  }
  if($#out_hash_ref_list  == 0 ){ return(\%hash_residue); }
  elsif($#out_hash_ref_list > 0){ return(@out_hash_ref_list); }
}


#________________________________________________________________________
# Title     : open_jp_files  (bug free!!)
# Usage     : %out_hash=%{&open_jp_files(\$file_name)};
# Function  : reads jp files and stores results in a hash.
# Example   :
# Warning   : All the spaces  '-' !!!
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a reference of a hash for names and  their sequences.
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_jp_files{
  #""""""""""""""""""""""< handle_arguments head Ver 1.0 >""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my(%hash_out, $s, $n, $s1);
	open(FILE_JP, "$file[0]");
	while(<FILE_JP>){    if(/^CLUSTAL/){ next; }
		if((/^([\S]+)[\t]* +$/)||(/^\#/)){ next; }
		if(/^([\w\.\-\=\+]+) +\t*(\S+)[\n]$/){ $n=$1; $s=$2; $hash_out{$n}.= $s; }
	}
	#&show_hash(%hash_out);
	\%hash_out;
}

#________________________________________________________________________
# Title     : open_ali_files
# Usage     : %anyhash = %{&open_ali_files(\$filename)};
# Function  : open fasta files and put sequences in a hash
#             FASTA sequence file format is like this;
#
#             >P1;1abp
#             structureX:1abp:   1 : : 306 : :L-arabinose-binding protein:Escherichia coli: 2.40:-1.00
#             ENLKLGFLVKQPEEPWFQTEWKFADKAGKDLG-FEVIKIAV-PDGEKTLNAIDSLAASGAKGFVICTPDPKLGSA
#             TEGQGFKAADIIGIGINGVDAVSELSKAQATGFYGSLLPSPDVHGYKSSEMLYNWVAK--------DVEPPKFTE
#             VTDVVLITRDNFKEELEKKGLGGK*
#             >P1;2gbp
#             structureX:2gbp:   1 : : 309 : :D-galactose/D-glucose-bind:Escherichia coli: 1.90:14.60
#             ADTRIGVTIYKYDDNFMSVVRKAIEQDAKAAPDVQLLMNDSQNDQSKQNDQIDVLLAKGVKALAINLVDPAAAGT
#             LKAHNKS-SIP-VFGVDA--LPEALALVKSGALAGTVLNDANNQAKATFDLAKNLADGKGAADGTNWKIDNKVVR
#             VP-YVGVDKDNLAEFSKK------*
#
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_ali_files{    my($input_file)=${$_[0]}; my(@names, %sequence, $flag,$name,$temp2);
	unless (-e $input_file){     print chr(7);
	  print "\n\n\t This is sub open_ali_files in th_lib.pl \n\n";
	  print "\n\n\t Fatal: The input file $input_file is not in the directory \n"; exit; }
	open(FILE_1,"$input_file");
	while(<FILE_1>){         		# file1 needs to be xxxx.fasta for the moment, automatic later
	  if(/^\>\S\S\;([\w\-\.]+)$/){ $name=$1; next; }
	  elsif(/\:/){ next; }
	  elsif(/^([\w\-]+)[\*]*$/){ $sequence{$name}.= $1; }
	  else{  next; }    }
	return(\%sequence);
}
#________________________________________________________________________
# Title     : open_pir_files  (nearly the same as .ali file)
# Usage     : %anyhash = &open_pir_files($any_sequence_file_fasta_form);
# Function  : open fasta files and put sequences in a hash
#             FASTA sequence file format is like this;
#
#             >P1;1abp
#             structureX:1abp:   1 : : 306 : :L-arabinose-binding protein:Escherichia coli: 2.40:-1.00
#             ENLKLGFLVKQPEEPWFQTEWKFADKAGKDLG-FEVIKIAV-PDGEKTLNAIDSLAASGAKGFVICTPDPKLGSA
#             VTDVVLITRDNFKEELEKKGLGGK*
#             >P1;2gbp
#             structureX:2gbp:   1 : : 309 : :D-galactose/D-glucose-bind:Escherichia coli: 1.90:14.60
#             LKAHNKS-SIP-VFGVDA--LPEALALVKSGALAGTVLNDANNQAKATFDLAKNLADGKGAADGTNWKIDNKVVR
#             VP-YVGVDKDNLAEFSKK------*
#
# Example   :
# Warning   : well tested. It skips lines starting with blank, lines with '-' in them.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_pir_files{
	my($input_file)=${$_[0]};
	my(@names, %sequence, $flag,$name,$temp2);
	unless (-e $input_file){     print chr(7);
	  print "\n\n\t This is sub open_ali_files in th_lib.pl \n\n";
	  print "\n\n\t Fatal: The input file $input_file is not in the directory \n"; exit; }
	open(FILE_1,"$input_file");
	while(<FILE_1>){         		# file1 needs to be xxxx.fasta for the moment, automatic later
	  if(/^\>\S\S\;([\w\-\.]+)$/){ $name=$1; next; }
	  elsif((/\:/)||(/^\*/)){ next; }
	  elsif(/^([\w\-]+)[\*]*$/){ $sequence{$name}.= $1; }
	  else{  next; }    }
	%sequence=%{&remov_com_column(\%sequence)};
	return(\%sequence);
}

#________________________________________________________________________
# Title     : open_aln_files
# Usage     : %out_hash=%{&open_aln_files(\$file_name)};
# Function  : reads jp files and stores results in a hash.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a reference of a hash for names and  their sequences.
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_aln_files{       my(%hash_out, $s, $n, $s1);
  open(FILE_JP, "${$_[0]}");  # reading in (JP) file
  while(<FILE_JP>){       if(/^CLUSTAL/){ next; }
	 if((/^([\S]+)[\t]* +$/)||(/\#/)){ next; }
	 if(/^([\w\.\-\=\+]+) +\t*(.+)[\n]$/){ $n=$1; $s=$2; $hash_out{$n}.= $s; }}
  \%hash_out;
}


#________________________________________________________________________
# Title     : open_sst_files (also look at "open_sst_files_with_gap")
# Usage     : %out_sst_hash =%{&open_sst_files(\$jp_file_dir_and_name)};
# Function  : gets the name of a file(jp file) with its absolute dir path
#             reads the sequence names in the jp file and looks up all
#             the sst files in the same directory. Puts sst sequences
#             in a hash with keys of sequence names.
#
# Example   : jp file  ==  seq1 ABDSF--DSFSDFS   <- true sequence
#                              seq2 lkdf-jlsjlsjf
#
#                 sst files == seq1.sst, seq2.sst
#
#                 output hash == seq1 hHHHHHHHttEEEEEEEE
#                                seq2 hHHHHHHHHHEEEEEEhh
#
# Warning   : $jp_file_dir_and_name should be absolute dir and file name
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for a hash
# Tips      :
# Argument  : a ref. for scaler of "jp file name"
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_sst_files{
  my($dir)=${$_[0]};
  my(%jp_file)=%{&open_jp_files($_[0])};
  my(%out_sst_seq_hash, $directory);
  if (${$_[0]} =~/^(.+\/)\w+\.jp$/){
	  $directory = $1;   }
  my(@keys)= (keys %jp_file);
  for $seq_name (@keys){
	  my($sst_file_name)="$directory$seq_name\.sst";
	  my($sst_seqs);
	  open(SST, "$sst_file_name");
	  while(<SST>){
		  if(/^  summary  (.*)  summary  $/){
			 $sst_seqs.=$1;  }   }
	  $out_sst_seq_hash{$seq_name}=$sst_seqs;   }
  \%out_sst_seq_hash;
}
#________________________________________________________________________
# Title     : read_sst_files  (synonym of open_sst_files )
# Usage     : %out_sst_hash =%{&read_sst_files(\$jp_file_dir_and_name)};
# Function  : gets the name of a file(jp file) with its absolute dir path
#             reads the sequence names in the jp file and looks up all
#             the sst files in the same directory. Puts sst sequences
#             in a hash with keys of sequence names.
#
# Example   : jp file  ==  seq1 ABDSF--DSFSDFS   <- true sequence
#                              seq2 lkdf-jlsjlsjf
#
#                 sst files == seq1.sst, seq2.sst
#
#                 output hash == seq1 hHHHHHHHttEEEEEEEE
#                                seq2 hHHHHHHHHHEEEEEEhh
#
# Warning   : $jp_file_dir_and_name should be absolute dir and file name
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. for a hash
# Tips      :
# Argument  : a ref. for scaler of "jp file name"
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_sst_files{  my($dir)=${$_[0]};  my(%jp_file)=%{&open_jp_files($_[0])};
  my(%out_sst_seq_hash, $directory);
  if (${$_[0]} =~/^(.+\/)\w+\.jp$/){
	  $directory = $1;   }
  my(@keys)= (keys %jp_file);
  for $seq_name (@keys){
	  my($sst_file_name)="$directory$seq_name\.sst";
	  my($sst_seqs);
	  open(SST, "$sst_file_name");
	  while(<SST>){
		  if(/^  summary  (.*)  summary  $/){
			 $sst_seqs.=$1;  }   }
	  $out_sst_seq_hash{$seq_name}=$sst_seqs;   }
  \%out_sst_seq_hash;
}


#________________________________________________________________________
# Title     : open_slx_files
# Usage     : %anyarray = &open_slx_files(\$any_sequence_file_slx_form);
# Function  : open slx files and put sequences in a hash
# Example   : selex file (foo.slx) looks like this:
#
#         #=SQ GLB_TUBTU  5.9393 - - 0..0::0 -
#         #=SQ GGZLB      20.9706 - - 0..0::0 -
#
#         HAHU        .........VLSPADKTNVKAAWGKVGA......HAGEYGAEALERMFLS
#         HBA3_PANTR  .........VLSPADKTNVKAAWGKVGA......HAGZYGAEALERMFLS
#
# Warning   : The slx FORMAT SHOULD BE AT LEAST 30 residue long
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a hash
# Tips      :
# Argument  : takes one ref. for a file.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_slx_files{
	my(@names, $n, $s, %hash);
	if ((-z ${$_[0]})|| (-B _) || (-x _)){   print chr(7);
		print "\n\t I am $0: Input file $file1 isn't in the dir \n"; exit;
	}
	open(FILE_1,"${$_[0]}");  	# reading in (slx)
	while(<FILE_1>){         	# file1 needs to be xxxx.slx for the moment, automatic later
	  if((/^([\S]+)[\t]* +$/)||(/^\#/)){ next; }
	  if(/^(\w+)\s+([\w\.\-]+)$/){
		  $n=$1; $s=$2; $hash{$n}.= $s;  }}
	return( \%hash );
}

#________________________________________________________________________
# Title     : open_out_files
# Usage     : %anyarray = &open_out_files(\$any_out_file);
# Function  : open out files and put their sequences in a hash
# Example   :
# Warning   : well tested. It skips lines starting with blank, lines with '-' in them.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a hash
#             Output example in a hash(fills the space)
#
#             3aat       --mfe---aapadp----adlfraderpGk---gigvY--etgktpvltS
#             1ama       ---eamiaakkmdkeylpiaGladFtraSA----eAfksgryVTV
#
# Tips      :
# Argument  : takes one ref. for a file.
#             >>Out file looks like this===>
#
#             3aat         mfe   aapadp----adlfraderpGk   gigvY--etgktpvltS
#             1ama       sswwshvemgppdp  krdtns--kkMnLG---YrddngkpyvLnC-
#
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub open_out_files{    			# opening msf files. input is a file name.
	my($flag, %hash, @names, $n, $s);
	unless (-e ${$_[0]}){
	  print chr(7);	# beep warning for error
	  print "\n\n\t This is sub open_out_files in th_lib.pl \n\n";
	  print "\n\n\t I am $0: The input file $file1 is not in the directory \n";
	  exit; # these subs are in th_lib.pl
	}
	open(FILE_1,"${$_[0]}");  	# reading in (MSF)
	while(<FILE_1>){         	# file1 needs to be xxxx.msf for the moment, automatic later
	  if (/^pairwise sequence distances/){  # <<---!! recognising que !!
		 $flag =1;}
	  if((/^(...........)([\s\w\-]+)[\n]$/) && ($flag == 1)){ 	# matching patterns (includin tab space)
		 $n=$1; $s=$2; $n=~ s/ //g; $s=~ s/ /-/g;
		 $hash{$n}.= $s;   		# may and concatenate second set to first set(name)
	  }
	}
	%hash=%{&fill_ending_space(\%hash)};  ### << filling the ending gaps !!
	return ( \%hash );
}


#________________________________________________________________________
# Title     : package Roman;
# Usage     :
# Function  : Roman.pm : Roman <-> Arabic conversion package
# Example   :
# Warning   : From: ozawa@prince.pe.u-tokyo.ac.jp (OZAWA Sakuro)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
package Roman;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(isroman arabic Roman roman);
sub isroman{
	 my($arg) = @_;
	 $arg ne '' and $arg =~ /^(?: M{0,3})           (?: D?C{0,3} | C[DM])
									  (?: L?X{0,3} | X[LC]) (?: V?I{0,3} | I[VX])$/ix;
}
%roman2arabic = qw(I 1 V 5 X 10 L 50 C 100 D 500 M 1000);
sub arabic{
	 my($last_digit, $arg) = (1000, @_);
	 isroman $arg or return undef;
	 my($arabic);
	 foreach (split(//, uc $arg)) {
		  my($digit) = $roman2arabic{$_};
		  $arabic -= 2 * $last_digit if $last_digit < $digit;
		  $arabic += ($last_digit = $digit);
	 }
	 $arabic;
}
%roman_digit = qw(1 IV 10 XL 100 CD 1000 MMMMMM);
@figure = reverse sort keys %roman_digit;
grep($roman_digit{$_} = [split(//, $roman_digit{$_}, 2)], @figure);
sub Roman{
	 my($arg) = @_;
	 0 < $arg and $arg < 4000 or return undef;
	 my($x, $roman);
	 foreach (@figure){
		  my($digit, $i, $v) = (int($arg / $_), @{$roman_digit{$_}});
		  if (1 <= $digit and $digit <= 3) {
				$roman .= $i x $digit;
		  } elsif ($digit == 4) {
				$roman .= "$i$v";
		  } elsif ($digit == 5) {
				$roman .= $v;
		  } elsif (6 <= $digit and $digit <= 8) {
				$roman .= $v . $i x ($digit - 5);
		  } elsif ($digit == 9) {
				$roman .= "$i$x";
		  }
		  $arg -= $digit * $_;
		  $x = $i;
	 }
	 $roman;
}
sub roman{
	 lc Roman @_;
}
1;
package main;


#________________________________________________________________________
# Title     : time_date
# Usage     :
# Function  : returns current time & date as 05/15/95 23:22:41
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub time_date{ my($sec, $min, $hour, $day, $mon, $year) = localtime(time);
	 sprintf("%.2d/%.2d/%.2d %.2d:%.2d:%.2d", $mon+ 1, $day, $year, $hour, $min, $sec);
}
#________________________________________________________________________
# Title     : sep
# Usage     : &sep;
# Function  : separater. \n#________________________________\n
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sep{ print "\n#___________________________________________#\n"; }


#________________________________________________________________________
# Title     : diff_dates
# Usage     : $output = &diff_dates("05/15/1994", "05/15/1995")
# Function  : gets number of days between two dates ( "05/15/94" )
# Example   :
# Warning   : modified (originally from reb@serf.nsc.com (Edward Brown))
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub diff_dates{
		  print "\nNote: diff_dates subroutine accepts 00/00/0000 format \n";
		  print " If you put 11/15/94, diff_dates understands it as 11/15/0094 \n\n";
		  my($date1, $date2)  = @_;
		  my($absolute_days1) = &toJulian($date1);
		  my($absolute_days2) = &toJulian($date2);
		  my($diff_of_days)   = abs($absolute_days1 - $absolute_days2);
		  $diff_of_days;
}

#________________________________________________________________________
# Title     : fromJulian
# Usage     :
# Function  : taking the days between two dates.
# Example   : print &fromJulian(34469), "\n";
# Warning   : got from reb@serf.nsc.com (Edward Brown)
#             require "julian
#             $Value1 = &toJulian("05/15/1994");        # Assign $Value1 a Julian Day
#             print "$Value1\n";
#             $Value2 = &toJulian("05/20/1994");        # Assign Value2 a Julian Day
#             print "$Value2\n";
#             $Days = $Value2 - $Value1;              #Difference in Days
#             print "$Days\n";
#             print &fromJulian(34469), "\n";         # Give a Julian Day, give the date
#             print &fromJulian(34474), "\n";
#             What is the Date 25 Days from Today?  (You can get format from `date`)
#
#             $Value = &toJulian("05/16/1995");
#             $Value +=  25;
#             print &fromJulian($Value), "\n";
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fromJulian{
		  print "\n Note: fromJulian subroutine accepts any numbers for days \n";
		  print " It counts from 0000 year. \n\n";
		  my ($value) = @_;
		  my ($yr, $mo, $dy, $julian, $leapflag, $holdjulian)=0;
		  $yr = 0; 	$mo = 1;	$dy = 1;	 $julian = 0;
		  while ($yr>=0){
								$holdjulian = $julian;
								$leapflag = "FALSE";
								if ($yr % 400 == 0){
													 $julian += 365;
								} elsif ($yr % 4 == 0){
													 $leapflag = "TRUE";
													 $julian += 366;
								} else {
													 $julian += 365;
								}
								if ($value < $julian){
													 $julian = $holdjulian;
													 last;
								};
								++$yr;
		  }
		  $julian = $value - $julian;
		  while ($mo){
								$holdjulian = $julian;
								if ($mo == 1 || $mo == 3 || $mo == 5 ||
													 $mo == 7 || $mo == 8 || $mo == 10 ||
													 $mo == 12) {
													 $julian -= 31;
								} elsif ( $mo == 4 || $mo == 6 ||
													 $mo == 9 || $mo == 11) {
													 $julian -= 30;
								} elsif ($leapflag eq "TRUE") {
													 $julian -= 29;
								} else {
													 $julian -= 28;
								}

								if ($julian < 0 ){
													 $julian = $holdjulian;
													 last;
								};
		  ++$mo;
		  }
		  $dy = $julian;
		  $julRetDate = sprintf("%02d/%02d/%04d", $mo, $dy, $yr);
}
#________________________________________________________________________
# Title     : toJulian
# Usage     :
# Function  : taking the days between two dates.
# Example   : $Value1 = &toJulian("05/15/94"); print "$Value1\n";
# Warning   : got from reb@serf.nsc.com (Edward Brown)
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub toJulian {
		  print "\n Note: toJulian subroutine accepts 00/00/0000 format \n";
		  print " If you put 11/15/94, 'toJulian' understands it as 11/15/0094 \n\n";
		  my ($value) = @_;
		  my ($yr, $mo, $dy, $julian, $leapflag, $holdjulian)=0;
		  ($mo, $dy, $yr) = split(/\//, $value);
		  # checking if $mo, $dy, $yr are numbers.
		  if (!($mo =~ /^[\d]+$/)||!($dy =~ /^[\d]+$/)||!($yr =~ /^[\d]+$/)){
					 print "\nInputs to sub toJulian and sub diff_dates must be numbers.\n";
					 print "\nExiting sub toJulian \n";
					 &caller_info;
					 exit;
		  }
		  if ($yr % 400 == 0){
								$leapflag = "FALSE";
		  } elsif ($yr % 4 == 0){
								$leapflag = "TRUE";
		  } else {
								$leapflag = "FALSE";
		  }
		  $julian = 0;
		  for ($i = 0; $i < $yr; ++$i){
								if ($i % 400 == 0){
													 $julian += 365;
								} elsif ($i % 4 == 0){
													 $julian += 366;
								} else {
													 $julian += 365;
								}
		  }
		  for ($i = 1; $i < $mo; ++$i){
								if ($i == 1 || $i == 3 || $i == 5 ||
													 $i == 7 || $i == 8 || $i == 10 ||
													 $i == 12) {
													 $julian += 31;
								} elsif ( $i == 4 || $i == 6 ||
													 $i == 9 || $i == 11) {
													 $julian += 30;
								} elsif ($leapflag eq "TRUE"){
													 $julian += 29;
								} else {
													 $julian += 28;
								}
		  }
		  $julian += $dy;
}

#________________________________________________________________________
# Title     : opendir_and_go
# Usage     : &opendir_and_go($input_dir); #$inputdir='/nfs/ind4/ccpe1/people/A Biomatic /jpo/align';
# Function  : open dir and process all files if you wish, and then go in any sub
#             dir of it. Using recursion. created by A Biomatic
#             if any file is linked, it skips that file.
# Example   : as in my 'indexing.pl' for perl file indexer.
# Warning   : Seems to work fine.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub opendir_and_go{
		  my($original_dir)=$_[0];
		  my(@read_files)=&read_any_dir($original_dir);
		  foreach $file(@read_files){
					 my($dir)=$split_path[$#split_path];
					 if (-l $realfile1){
								next;
					 }elsif (-d $realfile1){
						  &opendir_and_go($realfile1);
					 }elsif (-f $realfile1){ #<<------ This is where things match
								chdir($original_dir);
						 if($realfile1 =~/(\d+\-$no\.msf)$/){
											@dir=split(/\//, $realfile1);
											$dir=$dir[($#dir-1)];  # where am I ?
										  # $jp_file = $original_dir.'/'.$dir.'.jp';
										  # %array_msf =&open_msf_files($realfile1);
										  # %array_jp  =&open_jp_files ($jp_file);
										  # $array_ref_msf = \%array_msf;
										  # $array_ref_jp  = \%array_jp;
										  # $error_rate =&get_posi_shift_hash($array_ref_msf, $array_ref_jp);
										  # $id_compos  =&amino_acid_compos_id_percent($array_ref_jp);
										  # push(@rates_accumu,$error_rate);
										  # push(@compos_id,$id_compos);
						 }
					 }
					 else
					 {
								next;
					 }
		  }
}
#________________________________________________________________________
# Title     : occurances
# Usage     : sort occurances (@any_array_with_repeating_element);
# Function  : this is for sort, to sort things according to the higher num. of occu.
# Example   :
# Warning   : This is from 21 DAYS book, page 373.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub occurances{
	 $occurance_hash{$a} <=> $occurance_hash{$b};
}

#________________________________________________________________________
# Title     : extract_ori_seq
#             nt5
# Usage     : &extract_ori_seq($input_file, $output_file, $out_seq_no, *array2);
# Function  : extract seqs. which are from struc. alignment only. to be analysed.
#             after mul. alignment with added seq. you can extract original str.
#             sequ. by using this. The output always has ...msff  ext.
#             *array_ali is the JPO's or true alignment hash.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub extract_ori_seq{
	 local($input_file, $output_file, $out_seq_no, *array1, *array2) = @_; # something like $dir.$mul_factor.msf
		  local(%array_ext) = &open_msf_files("$input_file");
		  %array_ext = &hash_substract(*array_ext, *array2); # getting rid of added seq.
		  %array_ext = &hash_common(*array_ext, *array1);
		  open(OUTPUT, ">$output_file"); # this is different from $dir.msff
	 printf OUTPUT "PileUp\n\n\n";
	 printf OUTPUT "  MSF:%5d  Type: P                     Check:    0  ..\n",$ls;
	 print  OUTPUT "\n\n";
		  my(@keys3) = ( keys %array_ext );
		  $max = &max_str_value_hash(%array_ext);
	 $ls = $max;
	 $seq3 = ($#keys3+1);
	 for($j=0; $j < $seq3 ;$j++){
					 $name3=$keys3[$j];
					 printf OUTPUT " Name: %10s     Len: %5d  Check:    0  Weight:  1.00\n",$name3,$ls;
	 }
	 print OUTPUT "\n//\n\n";
	 for($seq_len = 0;$seq_len < $ls;$seq_len = $seq_len + 50){
				print OUTPUT "\n";
				foreach $name(keys %array_ext){
						  $string=$array_ext{$name};
						  if (length($name)<= 7){
									 $out=$name."\t    ";
						  }elsif(length($name)==8){
									 $out=$name."    ";
						  }elsif(length($name)== 9){
									 $out=$name."   ";
						  }elsif(length($name)== 10){
									 $out=$name."  ";
						  }elsif(length($name)== 11){
									 $out=$name." ";
						  }else{
									 $out=$name."\t";
						  }
						  # loop over blocks of 10
						  $is=$seq_len;
						  $ie=$seq_len+50;
						  $ie=$ls if $ie > $ls;
						  while($is < $ie){
										  $iee=$is+10;
										  $iee=$ls if $iee > $ls;
										  $out.=' ';
										  while($is < $iee){
													 $char=substr($string,$is,1);
													 if($char ne ' '){
													 $char =~ tr/a-z/A-Z/;
													 $out.=$char;
													 $char='.' if $char eq '-';
													 }
													 $is++;
										  }
						  }
				print OUTPUT "$out\n";
				}
				print OUTPUT "\n";	# open(OUTPUT, ">$dir.msff");
	 }
}	#  end of extract_ori_seq
#________________________________________________________________________
# Title     : get_pair_homol_array
# Usage     : $hom_out_count = ${&get_pair_homol_array(\@any_array_of_2_elem)};= @ar=(ABCDE..., CDEGA..)
# Function  : get pair wise seq. !! Number of pair identical residues.
# Example   :
# Warning   : reliable, but input seq. strings shouldn't contain spaces.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_pair_homol_array{
	 my(@input)=@{$_[0]};
	 $input[0] =~ tr/a-z/A-Z/; # capitalizing.
	 $input[1] =~ tr/a-z/A-Z/; # capitalizing.
	 my(@string1)= split(//,$input[0]);
	 my(@string2)= split(//,$input[1]);
	 if (($#string1 == -1) || ($#string2 == -1)){
		  print "\n One of the string is empty O.K. ? \n";
	 }
	 my($larger)= &max($#string1, $#string2);
	 my($id_counter, $gap_counter, $non_equal_counter, $sum)=0;
	 for ($i = 0; $i<=$larger; $i++){
		  if (($string1[$i] eq '.')|| ($string2[$i] eq '.')){
				$gap_counter+=1;
		  }elsif ($string1[$i] eq $string2[$i]){
				$id_counter +=1;
		  }else{
				$non_equal_counter += 1;
		  }
	 }
	 $sum = ($id_counter + $gap_counter + $non_equal_counter);
	 if ($sum != ($larger+1)){
		  print "\n There is something wrong in getting homology in get_pair_homol \n";
		  &caller_info;
	 }
	 \$id_counter; # $id_counter is the homology counter;
}
#________________________________________________________________________
# Title     : get_percent_homol_arr
# Usage     : $homology_out = ${&get_pair_homol(\@any_array_of_2_elem)};= @ar=(ABCDE..., CDEGA..)
# Function  : get pair wise seq. identity of any two strings, outputs a scalar (%)
# Example   :
# Warning   : reliable, but input seq. strings shouldn't contain spaces.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_percent_homol_arr{
	 my(@input)=@{$_[0]};
	 $input[0] =~ tr/a-z/A-Z/; # capitalizing.
	 $input[1] =~ tr/a-z/A-Z/; # capitalizing.
	 my(@string1)= split(//,$input[0]);
	 my(@string2)= split(//,$input[1]);
	 if (($#string1 == -1) || ($#string2 == -1)){
		  print "\n One of the string is empty O.K. ? \n";
	 }
	 my($larger)= &max($#string1, $#string2);
	 my($id_counter, $gap_counter, $non_equal_counter, $sum,$percent_homol)=0;
	 for ($i = 0; $i<=$larger; $i++){
		  if (($string1[$i] eq '.')|| ($string2[$i] eq '.')){
				$gap_counter+=1;
		  }elsif ($string1[$i] eq $string2[$i]){
				$id_counter +=1;
		  }else{
				$non_equal_counter += 1;
		  }
	 }
	 $sum = ($id_counter + $gap_counter + $non_equal_counter);
	 if ($sum != ($larger+1)){
		  print "\n There is something wrong in getting homology in get_pair_homol \n";
		  &caller_info;
	 }else{
		  $percent_homol=($id_counter/$sum)*100;
	 }
	 \$percent_homol; # $id_counter is the homology counter;
}

#________________________________________________________________________
# Title     : get_pair_homol_hash
# Usage     : $homology_out = & get_pair_homol (%any_hash); , eg) %hash = (name1, ABCDE..., name2, CDEGA..)
# Function  : get pair wise seq. identity as a scalar count
# Example   :
# Warning   : reliable, but input seq. strings shouldn't contain spaces.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_pair_homol_hash{
	 my(%input)=@_;
	 &hash_chk(\%input);
	 my(@keys_input)= keys (%input);
	 my(@values_input) = values (%input);
	 $values_input[0] =~ tr/a-z/A-Z/; # capitalizing.
	 $values_input[1] =~ tr/a-z/A-Z/; # capitalizing.
	 my(@string1)= split(//,$values_input[0]);
	 my(@string2)= split(//,$values_input[1]);
	 if (($#string1 == -1) || ($#string2 == -1)){
					 print "\n One of the string is empty O.K. ? \n";
	 }
	 my($larger)= &max($#string1, $#string2);
	 my($id_counter, $gap_counter, $non_equal_counter)=0;
	 for ($i = 0; $i<=$larger; $i++){
		  if (($string1[$i] eq '.')|| ($string2[$i] eq '.')){
				$gap_counter+=1;
		  }elsif ($string1[$i] eq $string2[$i]){
				$id_counter +=1;
		  }else{
				$non_equal_counter += 1;
		  }
	 }
	 my($sum) = ($id_counter + $gap_counter + $non_equal_counter);
	 if ($sum != ($larger+1)){
		 print "\n There is something wrong in getting homology in get_pair_homol \n";
		 &caller_info;
			}
	 return ($id_counter); # $id_counter is the homology counter;
}
#________________________________________________________________________
# Title     : get_percent_homo_hash
# Usage     : $homology_out = &get_pair_homol_hash(%any_hash); , eg) %hash = (name1, ABCDE..., name2, CDEGA..)
# Function  : get pair wise seq. identity(%) of any two strings put in as a hash
# Example   :
# Warning   : reliable, but input seq. strings shouldn't contain spaces.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_percent_homo_hash{
	 my(%input)=@_;
	 &hash_chk(\%input);
	 my(@keys_input)= keys (%input);
	 my(@values_input) = values (%input);
	 $values_input[0] =~ tr/a-z/A-Z/; # capitalizing.
	 $values_input[1] =~ tr/a-z/A-Z/; # capitalizing.
	 my(@string1)= split(//,$values_input[0]);
	 my(@string2)= split(//,$values_input[1]);
	 if (($#string1 == -1) || ($#string2 == -1)){
					 print "\n One of the string is empty O.K. ? \n";
	 }
	 my($larger)= &max($#string1, $#string2);
	 my($id_counter, $gap_counter, $non_equal_counter,$percent_homol,)=0;
	 for ($i = 0; $i<=$larger; $i++){
		  if (($string1[$i] eq '.')|| ($string2[$i] eq '.')){
				$gap_counter+=1;
		  }elsif ($string1[$i] eq $string2[$i]){
				$id_counter +=1;
		  }else{
				$non_equal_counter += 1;
		  }
	 }
	 my($sum) = ($id_counter + $gap_counter + $non_equal_counter);
	 if ($sum != ($larger+1)){
		  print "\n There is something wrong in getting homology in get_pair_homol \n";
		  &caller_info;
	 }else{
		  $percent_homol=($id_counter/$sum)*100;
	 }
	 return ($percent_homol);
}

#________________________________________________________________________
# Title     : comp_max_ar_elem_no
# Usage     : $bigger_value = &comp_max_ar_elem_no(*array1, *array2);
# Function  : gets the largest element no. of input arrays of two.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
#sub comp_max_ar_elem_no
#{
#    local(*array1, *array2)=@_;
#    my($array1_elem_no) = $#array1;
#    my($array2_elem_no) = $#array2;
#    my($lager_one) = &max($array1_elem_no, $array2_elem_no);
#}

#________________________________________________________________________
# Title     : file_size
# Usage     : $outputfilesize = &file_size($input_file_name);
# Function  : returns the size of any single testing file
# Example   :
# Warning   : Q is for quality of this sub. This can't be wrong.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub file_size { my($infile)=$_[0];
  if ( $size=(-s "$infile")){ return $size; }
}

#________________________________________________________________________
# Title     : seq_comp_percent2
# Usage     : @outarray = &seq_comp_percent2(@any_input_string_array);
# Function  : get string seq COMPOSITION identities(a to z). gets array
#             of strings and outs array of % numbers
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub seq_comp_percent2{   	# simple and basic seq. id. eg. ABC on ABCABC is 50 % identical.
	my(@input)=@_;
	my(@array_of_ids2, $id2, @char1, @char2);
	&array_chk(sort @input);
	my($longest_str_size)  = &get_long_str_size (@input), "\n";
	my($shortest_str_size) = &get_short_str_size(@input), "\n";
	print "longest_str_size",$longest_str_size;
	print "shortest_str_size",$shortest_str_size;
	if (($longest_str_size/$shortest_str_size) > 4){
		  print "\n  The shortest string is less than 1/4 of the longest\n";
		  print "  This is quite meaningless, but will go on\n";
	}
	for ($i = 0; $i <= $#input ; $i++){
		  if ($input[$i]=~/(\W)/){
			  &remove_non_char($input[$i]);
		  }
		  @char1 = split(/|\s+|\.+|\-+/, $input[$i]);   # splitting into char.
		  foreach $char (@char1){
			  if ($char eq ' '){
					 next;
			  }
			  $charcount1{$char} +=1; # making array of ['A' => 6, 'B'=>2...]
		  }
		  for($j = $i+1 ; $j <= $#input; $j++){
			  if ($input[$j]=~/(\W)/){
				  &remove_non_char($input[$j]);
			  }
			  @char2 = split(/|\s+|\.+|\-+/, $input[$j]); # splitting into char.
			  for $char (@char2){
				  $charcount2{$char} +=1; 	 # making ary of ['A' => 6, ..]
			  }
			  $id2 = &get_id_among_2_2(*charcount1, *charcount2); # gets % id.
			  push (@array_of_ids2, $id2);
			  %charcount2=();
		  }
		  %charcount1=();
	}
	@array_of_ids2;
}

######################################################################################
###########  file and dir handling stuff #################
###############################################################################

#________________________________________________________________________
# Title     : get_full_file_name
# Usage     : $any_path = ${&get_full_dir_path($any_directory)}; or &dir_path('.') for pwd.
# Function  : returns full directory path (= pwd ), eg.  /nfs/ind4/ccpe1/people/A Biomatic
# Example   :
# Warning   :
# Class     :
# Keywords  : get_long_path_name, get_complete_path_name
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_full_file_name{
  my($pwd)=`pwd`;
  chomp($pwd);
  \$pwd;
  my($full_file_name) = "$pwd\/$_[0]";
  return(\$full_file_name);
}


#________________________________________________________________________
# Title     : dir_path  (same as  pwd_path )
# Usage     : $any_path = &dir_path($any_directory); or &dir_path('.') for pwd.
# Function  : returns directory path (= pwd ), eg.  /nfs/ind4/ccpe1/people/A Biomatic
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub dir_path{   my($pwd)=`pwd`;  chomp($pwd);	return( \$pwd ); }


#________________________________________________________________________
# Title     : full_pwd_path  (same as dir_path)
# Usage     : $any_path = ${&full_dir_path($any_directory)}; or &dir_path('.') for pwd.
# Function  : returns full directory path (= pwd ), eg.  /nfs/ind4/ccpe1/people/A Biomatic
# Example   :
# Warning   :
# Class     :
# Keywords  : get_long_path_name, get_complete_path_name
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub full_pwd_path{  my($pwd)=`pwd`; 	chomp($pwd);	\$pwd;  }

#________________________________________________________________________
# Title     : get_full_pwd_path  (same as dir_path)
# Usage     : $any_path = ${&get_full_dir_path($any_directory)}; or &dir_path('.') for pwd.
# Function  : returns full directory path (= pwd ), eg.  /nfs/ind4/ccpe1/people/A Biomatic
# Example   :
# Warning   :
# Class     :
# Keywords  : get_long_path_name, get_complete_path_name
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_full_pwd_path{  my($pwd)=`pwd`; 	chomp($pwd);	\$pwd;  }

#________________________________________________________________________
# Title     : get_whole_pwd_path  (same as dir_path)
# Usage     : $any_path = ${&get_whole_dir_path($any_directory)}; or &dir_path('.') for pwd.
# Function  : returns full directory path (= pwd ), eg.  /nfs/ind4/ccpe1/people/A Biomatic
# Example   :
# Warning   :
# Class     :
# Keywords  : get_long_path_name, get_complete_path_name
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_whole_pwd_path{  my($pwd)=`pwd`; 	chomp($pwd);	\$pwd;  }

#________________________________________________________________________
# Title     : pwd_path  (same as dir_path)
# Usage     : $any_path = ${&dir_path($any_directory)}; or &dir_path('.') for pwd.
# Function  : returns directory path (= pwd ), eg.  /nfs/ind4/ccpe1/people/A Biomatic
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pwd_path{  my($pwd)=`pwd`; 	chomp($pwd);	\$pwd;  }


#________________________________________________________________________
# Title     : get_pwd_dir  (same as pwd_dir_base)
# Usage     : $dir = &get_pwd_dir($anydir); # to return say,  'perl' .
# Function  : returns present working dir base
# Example   :
# Warning   : well tested.
# Class     :
# Keywords  :
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_pwd_dir{  my(@pwd)=split(/\//,`pwd`);  my($dir)=$pwd[$#pwd];
	chomp($dir);   return( \$dir  );
}

#________________________________________________________________________
# Title     : dir_name  (same as pwd_dir_base)
# Usage     : $dir = &pwd_dir($anydir); # to return say,  'perl' .
# Function  : returns present working dir base
# Example   :
# Warning   : well tested.
# Class     :
# Keywords  :
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub dir_name{  	my(@pwd)=split(/\//,`pwd`);  my($dir)=$pwd[$#pwd];  # take last one.
	chomp($dir);    return( \$dir  );
}

#________________________________________________________________________
# Title     : pwd_dir_name  (same as  pwd_dir)
# Usage     : $dir = &pwd_dir($any_absolute_path_dir);
# Function  : returns present working dir name
# Example   : returns 'jong' with the input of '/nfs/ind5/A Biomatic '
# Warning   : well tested.
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub pwd_dir_name{   my(@pwd)=split(/\//,`pwd`); my($dir)=$pwd[$#pwd];
	chomp($dir);	 \$dir;
}
#________________________________________________________________________
# Title     : get_pwd_dir_name  (same as  pwd_dir)
# Usage     : $dir = &get_pwd_dir($any_absolute_path_dir);
# Function  : returns present working dir name
# Example   :
# Warning   : well tested.
# Class     :
# Keywords  :
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_pwd_dir_name{   my(@pwd)=split(/\//,`pwd`); my($dir)=$pwd[$#pwd];
	chomp($dir);	 \$dir;
}


#________________________________________________________________________
# Title     : get_full_path_dir_names  (same as  pwd_dir)
# Usage     : @full_path_dirs = @{&get_full_path_dir_names(@short_dir_name)};
# Function  : returns full path dir names with given short dir names.
# Example   : with 'jong' it gives '/nfs/ind5/jong', '/nfs/ind4/ccep1/people/A Biomatic '...
#             when 'jong' is in /nfs/ind4/jong/Perl, it returns /nfs/ind4/A Biomatic
# Warning   : when 'jong' is in /nfs/ind4/jong/Perl, it returns /nfs/ind4/A Biomatic
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_full_path_dir_names{ my(@in)=@_; my($pwd)=`pwd`; chomp($pwd);
	my(@ENV_dirs)=@{&get_all_dirs_from_ENV};
	for ($i=0; $i <@in; $i++){
		if( ref($in[$i]) eq 'SCALAR' ){
			for $each_dir(@ENV_dirs){
				if( $each_dir =~/${$in[$i]}$/){
					push(@out_full_path_dirs, $each_dir);  }
				elsif( $each_dir =~/${$in[$i]}/ ){
					push(@out_full_path_dirs, "$`$&");
				}  ## when 'jong' is in /nfs/ind4/jong/Perl, it returns /nfs/ind4/A Biomatic
			}
		}
		elsif( !ref($in[$i]) ){
			for $each_dir(@ENV_dirs){
				if( $each_dir =~/$in[$i]$/){
					push(@out_full_path_dirs, $each_dir);  }
				elsif( $each_dir =~/$in[$i]/ ){
					push(@out_full_path_dirs, "$`$&");     }
			}
		}
	}
	return(\@out_full_path_dirs);
}

#________________________________________________________________________
# Title     : get_base_names
# Usage     : $base =${&get_base_names(\$file_name)};
#             :   or @bases = &get_base_names(\@files);  # <-- uses `pwd` for abs directory
# Function  : produces the file base name(eg, "evalign"  out of "evalign.pl" ).
# Example   : $base => 'test'  with 'test.txt' or '/home/dir/of/mine/text.txt'
# Warning   :
# Class     :
# Keywords  : get_base_name{, base_name, file_base_name ,  get_file_base_name
#             get_basename, basename
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  : handles both ref and non-ref.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_base_names{
	my($x, @out_file, $file, @file, $base, @base);
	@file=@{$_[0]} if (ref($_[0]) eq 'ARRAY');
	@file=@_ if !(ref($_[0]) eq 'ARRAY');
	for($x=0; $x < @file; $x ++){
		if( ref($file[$x]) ){
			$file = ${$file[$x]};
			@out_file=split(/\./, $file);
			$base = $out_file[0];
		}else{
			$file = $file[$x];
			@out_file=split(/\./, $file);
			$base = $out_file[0];
		}
		push(@base, $base);
	}
	if(@base == 1 ){ \$base[0] }else{ @base }
}

#________________________________________________________________________
# Title     : get_base_name
# Usage     : $base =${&get_base_name(\$file_name)};
#             :   or @bases = &get_base_names(\@files);  # <-- uses `pwd` for abs directory
# Function  : produces the file base name(eg, "evalign"  out of "evalign.pl" ).
# Example   : $base => 'test'  with 'test.txt' or '/home/dir/of/mine/text.txt'
# Warning   : same as get_base_names,
# Class     :
# Keywords  : get_base_name{, base_name, file_base_name ,  get_file_base_name
#             get_basename, basename, get_base_names
# Options   :
# Package   : Jong_Util
# Reference :
# Returns   :
# Tips      :
# Argument  : handles both ref and non-ref.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_base_name{
	my($x, @out_file, $file, @file, $base, @base);
	@file=@{$_[0]} if (ref($_[0]) eq 'ARRAY');
	@file=@_ if !(ref($_[0]) eq 'ARRAY');
	for($x=0; $x < @file; $x ++){
		if( ref($file[$x]) ){
			$file = ${$file[$x]};
			@out_file=split(/\./, $file);
			$base = $out_file[0];
		}else{
			$file = $file[$x];
			@out_file=split(/\./, $file);
			$base = $out_file[0];
		}
		push(@base, $base);
	}
	if(@base == 1 ){ \$base[0] }else{ @base }
}


#________________________________________________________________________
# Title     : read_file_names_only
# Usage     : @all_files_list=@{&read_file_names_only(\$abs_path_dir_name, ..)};
# Function  : read any file names and REMOVES the '.', '..' and dir entries.
#             And then put in array.
# Example   :
# Warning   : This does not report '.', '..'
#             Only file names are reported. Compare with &read_any_dir
# Class     :
# Keywords  : filename only, filename_only, read_files_only, read files
#             get_file_names_only, get_files_only, read_files_only
# Options   : "extension name". If you put , 'pl' as an option, it will show
#             files only with '.pl' extension.
#             '-p'  for path also included resulting in '/path/path/file.ext'
#                  rather than 'file.ext' in output @array
# Package   :
# Reference :
# Returns   : one ref. of array.
# Tips      :
# Argument  : takes one or more scaler references. ('.', \$path, $path, ... )
# Todo      :
# Author    :  A Biomatic
# Version   : 1.5
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_file_names_only{
  my($in_dir, $i,$k, @final_files, @possible_dirs, $ext, @extensions,
	  $path_include, $pwd, $extension_given, @read_files);
  $pwd=`pwd`; chomp($pwd);
  $in_dir=$pwd;
  for($k=0; $k < @_; $k++){
	 if   ( $_[$k] eq '.'){  $in_dir=$pwd;  }
	 elsif( !(ref($_[$k]))){
		if( -d $_[$k]){
			$in_dir=$_[$k];
		}elsif( !(-f $_[$k]) && ($_[$k] =~ /^[\-]?p/i ) ){
			$path_include=1;
		}elsif(!(-f $_[$k]) && ($_[$k] =~ /^\w{1,6}/ ) ){
		  $extension_given =1;
		  push(@extensions, $_[$k]);
		}
	 }
	 elsif(ref($_[$k])){
		if( -d ${$_[$k]}){
		  $in_dir=${$_[$k]};
		}elsif(!(-f $_[$k]) && (${$_[$k]} =~ /^\w{1,6}/ ) ){
		  $extension_given = 1;
		  push(@extensions, ${$_[$k]});
		}
	 }
	 if($in_dir =~ /^([\w\-\.]+)$/){  $in_dir="$pwd\/$in_dir"; }
  }
  ##########  Main READING PART ##########

	 opendir(DIR1,"$in_dir");
	 @read_files = readdir(DIR1);
	 for($i=0; $i < @read_files; $i ++){
		if( -f "$in_dir\/$read_files[$i]" ){
		  if($extension_given ==1 ){
			 for $ext (@extensions){
				if( $read_files[$i] =~ /\.$ext$/){
					if($path_include==1){
						push(@final_files, "$in_dir\/$read_files[$i]" );
					}else{
						push(@final_files, "$read_files[$i]" );
					}
				}
			 }
		  }else{
			  push(@final_files, $read_files[$i]);
		  }
		}
	 }

  sort @final_files; chomp(@final_files);
  return(\@final_files);
}




#________________________________________________________________________
# Title     : read_dir_names_only
# Usage     : @all_dirs_list = @{&read_dir_names_only(\$absolute_path_dir_name, ....)};
# Function  : read any dir names and and then put in array.
# Example   :
# Warning   : This does not report '.', '..'
#             Only file names are reported. Compare with &read_any_dir
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array.
# Tips      :
# Argument  : takes one or more scaler references. ('.', \$path, $path, ... )
# Todo      :
# Author    : A Biomatic
# Version   : 3
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_dir_names_only{
  my($in_dir, $i,$k, @possible_dirs,
	  @final_files, $full_dir, $pwd, $path,@read_files);
  $pwd=`pwd`; chomp($pwd); $full_dir=1;
  for($k=0; $k < @_; $k++){
	 if   ( ($_[$k] eq '.') || !(defined($_[$k]))){  $in_dir=$pwd;  }
	 elsif(!(ref($_[$k]))){   $in_dir=$_[$k];   }
	 elsif(ref($_[$k])){      $in_dir =${$_[$k]};    }
	 if($in_dir =~ /^([\w\-\.]+)$/){  $in_dir="$pwd\/$in_dir"; $full_dir = 0; }
	 else{ $full_dir =1; }
	 ##########  Main READING PART ##########
	 opendir(DIR1,"$in_dir");
	 @read_files = readdir(DIR1);
	 for($i=0; $i < @read_files; $i ++){
		$read_files[$i]="$in_dir\/$read_files[$i]";
		if( ($read_files[$i] !~ /\/\.\.?$/) && ( -d $read_files[$i]) ){
		  push(@final_files, "$read_files[$i]");
		}
	 }
  }
  sort @final_files;  \@final_files;
}
#________________________________________________________________________
# Title     : get_dir_names_only
# Usage     : @all_dirs_list = @{&get_dir_names_only(\$absolute_path_dir_name, ....)};
# Function  : read any dir names and and then put in array.
# Example   :
# Warning   : This does not report '.', '..'
#             Only file names are reported. Compare with &read_any_dir
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array.
# Tips      :
# Argument  : takes one or more scaler references. ('.', \$path, $path, ... )
# Todo      :
# Author    : A Biomatic
# Version   : 3
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_dir_names_only{
  my($in_dir, $i,$k, @possible_dirs,
	  @final_files, $full_dir, $pwd, $path,@read_files);
  $pwd=`pwd`; chomp($pwd); $full_dir=1;
  for($k=0; $k < @_; $k++){
	 if   ( ($_[$k] eq '.') || !(defined($_[$k]))){  $in_dir=$pwd;  }
	 elsif(!(ref($_[$k]))){   $in_dir=$_[$k];   }
	 elsif(ref($_[$k])){      $in_dir =${$_[$k]};    }
	 if($in_dir =~ /^([\w\-\.]+)$/){  $in_dir="$pwd\/$in_dir"; $full_dir = 0; }
	 else{ $full_dir =1; }
	 ##########  Main READING PART ##########
	 opendir(DIR1,"$in_dir");
	 @read_files = readdir(DIR1);
	 for($i=0; $i < @read_files; $i ++){
		$read_files[$i]="$in_dir\/$read_files[$i]";
		if( ($read_files[$i] !~ /\/\.\.?$/) && ( -d $read_files[$i]) ){
		  push(@final_files, "$read_files[$i]");
		}
	 }
  }
  sort @final_files;  \@final_files;
}

#________________________________________________________________________
# Title     : get_subdir_names
# Usage     : @all_sub_dirs_list = @{&read_dir_names_only(\$absolute_path_dir_name, ....)};
# Function  : Gets all subdir and subsubsub...dir names in absolute path names.
# Example   : <output example with   "get_subdir_names.pl /A Biomatic /Perl/Bio_Seq" at prompt
#                  It is an array shown in lines.
#
#             /A Biomatic /Perl/Bio_Seq/Evalign
#             /A Biomatic /Perl/Bio_Seq/Seq_hash_handling
#             /A Biomatic /Perl/Bio_Seq/Apple
#             /A Biomatic /Perl/Bio_Seq/Genome
#             /A Biomatic /Perl/Bio_Seq/Open_xxx_files
#             /A Biomatic /Perl/Bio_Seq/Open_xxx_files/Evalign
#
#             tk
#             ch1
#             sub2
#             sub3
#             xxxx.cong
#             whatever_sub_dir
# Warning   : This does not report '.', '..' ,  Also, this does not show full path
#             Only file names are reported. Compare with &read_any_dir
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array. (NOT full path names), refer  'read_full_dir_names'
# Tips      :
# Argument  : takes one or more scaler references. ('.', \$path, $path, ... )
# Todo      :
# Author    : A Biomatic
# Version   : 3
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_subdir_names{
  my(@in, $in_dir, $in_dir2, $i, $k, $in_dir, $pwd, @sub_dirs,
		@final_dirs, @read_dirs);
  my($pwd)=`pwd`; chomp($pwd);
  for($k=0; $k< @_ ;$k++){
	  if( !ref($_[$k]) ){
		  push(@in, $_[$k]);    }
	  elsif( ref($_[$k]) eq "ARRAY" ){
		  push(@in, @{$_[$k]});    }
	  elsif( ref($_[$k]) eq "SCALAR" ){
		  push(@in, ${$_[$k]});    }
	  elsif(ref($_[$k]) eq "HASH") {
		  push(@in, %{$_[$k]}); }
  }

  for($k=0; $k < @in; $k++){
	  if ( !ref($in[$k]) ){
		  if( $in[$k] eq '.'){ $in_dir = $pwd; }
		  else{  $in_dir =$in[$k]; }
	  }
	  elsif(ref($in[$k])){  $in_dir =${$in[$k]};  }
	  chop($in_dir) if $in_dir =~ /\/$/;
	  @read_dirs = @{&read_dir_names_only(\$in[$k])};
	  @final_dirs= @read_dirs;
	  for($i=0; $i < @read_dirs; $i ++){
		  push(@final_dirs, @{&get_subdir_names(\$read_dirs[$i])});
	  }
  }
  sort @final_dirs;  \@final_dirs;
}

#________________________________________________________________________
# Title     : read_full_dir_names
# Usage     : @all_files_list = @{&read_full_dir_names(\$absolute_path_dir_name, ....)};
# Function  :
# Example   : input>> &read_full_dir_names('/nfs/ind4/ccpe1/people/A Biomatic /perl');
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/code
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/tk
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/ch1
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/sub2
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/sub3
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/xxxx.cong
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/whatever
# Warning   : This does not report '.', '..'
#             Only file names are reported. Compare with &read_any_dir
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array.
# Tips      :
# Argument  : takes one or more scaler references. ('.', \$abs_path, $path, ... )
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_full_dir_names{
  my($in_dir, $i,$k, @possible_dirs, $full_dir, $path,@read_files, @final_files);
  my($pwd)=`pwd`; chomp($pwd);
  for($k=0; $k < @_; $k++){
	 if   ( ($_[$k] eq '.') || !(defined($_[$k]))){  $in_dir=$pwd;  }
	 elsif( !ref($_[$k]) ){   $in_dir=$_[$k];     }
	 elsif(ref($_[$k]))   {   $in_dir =${$_[$k]}; }
	 if($in_dir =~ /\//){  $full_dir =1;}
	 elsif($in_dir =~ /^([\w\-\.]+)$/){ $in_dir="$pwd\/$in_dir";  }
	 ##########  Main READING PART ##########
	 chop($in_dir) if ($in_dir=~/[\/\\]+$/);
	 opendir(DIR1,"$in_dir");
	 @read_files = readdir(DIR1); shift( @read_files);  shift( @read_files);
	 if( $full_dir==1 ){
		for($i=0; $i < @read_files; $i ++){
		  $read_files[$i]="$in_dir\/$read_files[$i]";
		  if( -d "$read_files[$i]"){
			  push(@final_files, $read_files[$i]);
		  }
		}
	 }elsif($full_dir != 1){
		for($i=0; $i < @read_files; $i ++){
		  $read_files[$i]="$pwd\/$read_files[$i]";
		  if( -d "$read_files[$i]"){
			  push(@final_files, $read_files[$i]);
		  }
		}
	 }
  }
  sort @final_files;  \@final_files;
}

#________________________________________________________________________
# Title     : get_full_dir_names
# Usage     : @all_files_list = @{&read_full_dir_names(\$absolute_path_dir_name, ....)};
# Function  :
# Example   : input>> &get_full_dir_names('/nfs/ind4/ccpe1/people/A Biomatic /perl');
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/code
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/tk
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/ch1
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/sub2
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/sub3
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/xxxx.cong
#             /tmp_mnt/nfs/ind4/ccpe1/people/A Biomatic /perl/whatever
# Warning   : This does not report '.', '..'
#             Only file names are reported. Compare with &read_any_dir
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array.
# Tips      :
# Argument  : takes one or more scaler references. ('.', \$abs_path, $path, ... )
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_full_dir_names{
  my($in_dir, $i,$k, @possible_dirs, $full_dir, $path,@read_files, @final_files);
  my($pwd)=`pwd`; chomp($pwd);
  for($k=0; $k < @_; $k++){
	 if   ( ($_[$k] eq '.') || !(defined($_[$k]))){  $in_dir=$pwd;  }
	 elsif( !ref($_[$k]) ){   $in_dir=$_[$k];     }
	 elsif(ref($_[$k]))   {   $in_dir =${$_[$k]}; }
	 if($in_dir =~ /\//){  $full_dir =1;}
	 elsif($in_dir =~ /^([\w\-\.]+)$/){ $in_dir="$pwd\/$in_dir";  }
	 ##########  Main READING PART ##########
	 chop($in_dir) if ($in_dir=~/[\/\\]+$/);
	 opendir(DIR1,"$in_dir");
	 @read_files = readdir(DIR1); shift( @read_files);  shift( @read_files);
	 if( $full_dir==1 ){
		for($i=0; $i < @read_files; $i ++){
		  $read_files[$i]="$in_dir\/$read_files[$i]";
		  if( -d "$read_files[$i]"){
			  push(@final_files, $read_files[$i]);
		  }
		}
	 }elsif($full_dir != 1){
		for($i=0; $i < @read_files; $i ++){
		  $read_files[$i]="$pwd\/$read_files[$i]";
		  if( -d "$read_files[$i]"){
			  push(@final_files, $read_files[$i]);
		  }
		}
	 }
  }
  sort @final_files;  \@final_files;
}

#________________________________________________________________________
# Title     : read_any_dir_simple
# Usage     : @file_list = @{&read_any_dir(\$absolute_path_dir_name)};
# Function  : read any dir and REMOVES the '.' and '..' entries. And then put in array.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array.
# Tips      :
# Argument  : takes one scaler reference.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_any_dir_simple {  				# returns the subdir and files names
	 my($in_dir);
	 if( ref($_[0]) ){
		 $in_dir=${$_[0]};
	 }else{
		 $in_dir= $_[0];
	 }
	 opendir(DIR1,"$in_dir");
	 my(@read_files) = readdir(DIR1);	# readdir() is perl func.
	 closedir(DIR1);
	 splice(@read_files, 0, 2);  # this gets rid of leading . and ..
	 \@read_files;   				# to return arrays
}
#____________________________________________________________
# Title     : read_any_dir
# Function  : read any dir and REMOVES the '.' and '..' entries.
#             And then put in array.
# Usage     : @file_list = @{&read_any_dir(\$absolute_path_dir_name)};
# Argument  : takes one scaler reference.
# Returns   : one ref. of array. for the files in the given directory.
# Keywords  :
# Options   :
# Package   :
# Reference :
# Version   : 1.2
# Warning   :
#----------------------------------------------------------
sub read_any_dir{
	 my($in_dir, @possible_dirs, @read_files);
	 if( ($_[0] eq '.') || !(defined($_[0]))){
		$in_dir='.';
	 }else{  $in_dir=${$_[0]} || $_[0];	 }

	 if($in_dir =~ /^([\w\-\.]+)$/){
		 $in_dir="\.\/$in_dir";
	 }elsif($in_dir =~/\/([\w\-\.]+)$/){
		 $in_dir="\.\/$1";  # adjust to pwd.
	 }
	 opendir(DIR1, "$in_dir" );
	 @read_files = readdir(DIR1);
	 closedir(DIR1); splice( @read_files, 0, 2 );
	 \@read_files;
}


#________________________________________________________________________
# Title     : read_any_dir2
# Usage     : @file_list = @{&read_any_dir(\$absolute_path_dir_name, ....)};
# Function  : read any dir and REMOVES the '.' and '..' entries. And then put in array.
# Example   :
# Warning   : This does not report '.', '..', '#xxxx', ',xxxx', etc. only legitimate
#             file and dir names are reported.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of array.
# Tips      :
# Argument  : takes one or more scaler references.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_any_dir2{   my($in_dir, $i,$k, @possible_dirs, @read_files);
  for($k=0; $k < @_; $k++){
	 if   ( ($_[$k] eq '.') || !(defined($_[$k]))){    $in_dir='.';  }
	 elsif(!(ref($_[$k]))){   $in_dir=$_[$k];     }
	 elsif(ref($_[$k])){      $in_dir =${$_[$k]};    }

	 if($in_dir =~ /^([\w\-\.]+)$/){  $in_dir="\.\/$in_dir";   # if it is a short dir name
		 unless(-d $in_dir){ $in_dir=${&dir_search_special(\$in_dir)} } }
	 elsif($in_dir =~/\/([\w\-\.]+)$/){ $in_dir="\.\/$1";  # adjust to pwd.
		 unless(-d $in_dir){ $in_dir=${&dir_search_special(\$in_dir)}  }}

	 sub dir_search_special{   my($in_dir)=${$_[0]};  my(@ENV_dir, @probable_dir_list, @dirs,@possible_dirs, $final_dir);
		if($in_dir =~ /\/([\w\.\-]+)$/){   $in_dir = $1; }
		@probable_dir_list=('ALIGN', 'PDB', 'PATH', 'HOME', 'JPO', 'PIRDIR', 'PDBSST','PDBENT',
								  'BLASTDB', 'PIRDIR', 'SWDIR');
		for (@probable_dir_list){ @dirs=split(':', $ENV{$_});
		  for (@dirs){ if (/$in_dir$/){ $final_dir = $_; } }
		}
		if(@possible_dirs <1){  # goes up one level and tries to find dir.
		  my($pwd)=`pwd`; chomp($pwd); my(@temp)=split('/', $pwd);
		  pop(@temp);  my($up_pwd)=join('/', @temp);
		  $in_dir="$up_pwd\/$in_dir";  $final_dir=$in_dir if (-d $in_dir);
		}
		\$final_dir
	 }
	 opendir(DIR1,"$in_dir");
	 @read_files = sort readdir(DIR1);
	 for($i=0; $i < @read_files; $i ++){
		if( ($read_files[$i]=~/^[\W]+$/)||($read_files[$i] =~ / +/)){
			splice( @read_files, $i, 1 ); $i--  }
		if( ($read_files[$i]=~/\.\.+/)||($read_files[$i] =~ /\#+/)||($read_files[$i]=~/\,+/)){
			splice( @read_files, $i, 1 ); $i-- }
	 }
	 push(@final_files, @read_files);
  }
  \@final_files;
}


### ##############################################

#________________________________________________________________________
# Title     : max_str_value_hash   	#$max = &max_str_value_hash(%array1);
# Usage     : $largest_str_length_of_values = &max_value_hash(%any_hash);
# Function  : gets the largest 'string' length in values of any one hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub max_str_value_hash{	my(%hash)=@_; my($len,$max);
	&hash_chk(\%hash);		# checks if %hash is valid.
	foreach $s1 (values %hash){
		$len =length($s1);
		$max = $len  if $len > $max;
	}
	$max;
}
#________________________________________________________________________
# Title     : max_str_key_hash   	#$max = &max_str_value_hash(%array1);
# Usage     : $largest_str_length_of_values = &max_value_hash(%any_hash);
# Function  : gets the largest 'string' length in keys of any one hash
# Example   :
# Warning   :
# Class     :
# Keywords  : largest key length,
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub max_str_key_hash{
	my(%hash)=%{$_[0]};
	my($len,$max);
	#&hash_chk(\%hash);		# checks if %hash is valid.
	foreach $s1 (keys %hash){
		$len = length($s1);
		$max = $len  if $len > $max;
	}
	$max;
}
#________________________________________________________________________
# Title     : min_string_value_hash  #$max = &min_str_value_hash(%array1);
# Usage     : $small_str_length_of_values = &min_str_value_hash(%any_hash);
# Function  : gets the smallest 'string' length in values of any one hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub min_str_value_hash{
	my(%hash)=%{$_[0]};
	&hash_chk(\%hash);		# checks if %hash is valid.
	my($len)=0;
	my(@keys) = keys %hash;
	my($min) = length($hash{$keys[0]});
	for ($s1=1; $s1 <= $#keys; $s1++){
		$len =length($hash{$keys[$s1]});
		$min = $len  if ($len < $min);
	}
	$min;
}
#________________________________________________________________________
# Title     : min_str_key_hash  #$max = &min_str_value_hash(%array1);
# Usage     : $small_str_length_of_values = &min_str_value_hash(%any_hash);
# Function  : gets the smallest 'string' length in values of any one hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub min_str_key_hash{
	my(%hash)=%{$_[0]};
	#&hash_chk(\%hash);		# checks if %hash is valid.
	my($len)=0;
	my(@keys) = keys %hash;
	my($min) = length($keys[0]);
	for ($s1=1; $s1 < @keys; $s1++){
		$len =length($keys[$s1]);
		$min = $len  if ($len < $min);
	}
	$min;
}
#________________________________________________________________________
# Title     : min_string_key_hash  #$max = &min_str_value_hash(%array1);
# Usage     : $small_str_length_of_values = &min_str_value_hash(%any_hash);
# Function  : gets the smallest 'string' length in values of any one hash
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub min_str_key_hash{
	my(%hash)=%{$_[0]};
	#&hash_chk(\%hash);		# checks if %hash is valid.
	my($len)=0;
	my(@keys) = keys %hash;
	my($min) = length($keys[0]);
	for ($s1=1; $s1 < @keys; $s1++){
		$len =length($keys[$s1]);
		$min = $len  if ($len < $min);
	}
	$min;
}
#________________________________________________________________________
# Title     : fasta_append
# Usage     : &fasta_append($name, $string, $output_file);
# Function  : append addtional one fasta format sequence.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fasta_append{
	 my($name, $string, $output_file)=@_;	# $name is the name of seq.
	 open (FASTA_APPEND,">>$output_file");	# $string is the seq string.
	 my($ll)=0;								# $output_file is the name of output.
	 print FASTA_APPEND ">$name\n";			# this appends seq. in one file.
	 $ls2=length($string );
	 for($i=0; $i<$ls2; $i++){
		  $char=substr($string ,$i,1);
		  if(($char ne ' ') && ($char ne '.')){
			  print FASTA_APPEND $char;
			  $ll++;
			  if($ll == 60){
				  $ll=0;
				  print FASTA_APPEND "\n";
			  }
		  }
	 }
	 print FASTA_APPEND "\n";
}

#________________________________________________________________________
# Title     : fasta_output
# Usage     : &fasta_output($dir.$mul_factor.fasta,  $whole_seq, *array_ali, *array1);
# Function  : prints fasta format output which is using $mul_factor
#             $seq is the whole sequence number(largest).
#             $dir.$mul_factor.fasta can be any output name,
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fasta_output{
		  local($dir.$mul_factor.fasta, $seq_number, *array_ali, *array1)=@_;
		  my($output_file) = "$dir.$mul_factor.fasta";
		  my(@keys1)= keys (%array_ali);
		  my(@keys2)= keys (%array1);
		  unlink <"$output_file">;	# removing previous file to prevent appending.
		  foreach $name(keys %array_ali){
					 $dir  = &pwd_dir;
					 $string=$array_ali{$name};
					 print "\n\nchecking fasta write $name, $string\n\n"; &beep;
					 &fasta_append($name, $string, $output_file);
		  }
		  foreach $key1(@keys1){
					 $counter=0;
					 foreach $key2(@keys2){
								if ($key1 eq $key2){
										  splice(@keys2, $counter,1);
								}
								$counter+=1;
					 }
		  }
		  if ( $seq_number => ($#keys2+1) ){
					 $seq_number = $#keys2;
		  }
		  for ($x=0; $x <= $seq_number ;$x++){
					 $name2=$keys2[$x];
					 $string2=$array1{$name2};
					 print "\n seq number is = $seq_number \n";
					 print "\n\nchecking fasta write $name2, $string2\n\n"; &beep;
					 $dir  = &pwd_dir;
					 &fasta_append($name2, $string2, $output_file);
		  }
}
#________________________________________________________________________
# Title     : fasta_out_seq_no
# Usage     : &fasta_out_seq_no($dir, $out_seq_no, $seq, *array2, *array1);
# Function  : prints fasta format output with specified seq no from whole seq. no.
#             $seq is the whole sequence number(largest). $out_seq_no is the target
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub fasta_out_seq_no{
  my($dir, $out_seq_no, $seq_number);
  ($dir, $out_seq_no, $seq_number, *array1, *array2)=@_;
  &hash_chk(\%array1);&hash_chk(\%array2);
  %array2    = &hash_substract(*array2, *array1);
  %array_1_2 = &hash_catenate (*array1, *array2);
  &hash_chk(\%array_1_2);
  my($output_file) = "$dir\_$out_seq_no.fas"; 	# " is essential.
  my(@keys1)= keys (%array1);
  my(@keys2)= keys (%array2);
  my(@keys_1_2) = keys (%array_1_2);
  unlink <"$output_file">;						# this is essential as I use &fasta_append
  if (($#keys1+1) > $out_seq_no){					# if out_seq_no is less than structural
	  for ($no = 0; $no < $out_seq_no; $no++){	# appending first seq. set.
		  my($name1) = $keys1[$no];				# array1 first
		  $dir  = &pwd_dir;
		  my($string1) = $array1{$name1};
		  &fasta_append($name1, $string1, $output_file);
	  }
  }else{
	  for ($no1 = 0; $no1  <= $#keys1; $no1++){	# appending first seq. set.
		  my($name1) = $keys1[$no1];				# array1 first
		  $dir  = &pwd_dir;
		  my($string1) = $array1{$name1};
		  &fasta_append($name1, $string1, $output_file);
	  }
	  for ($no2 = 0; $no2  < ($out_seq_no-$#keys1-1); $no2++){	# appending first seq. set.
		  my($name2) = $keys2[$no2];			# array1 first
		  $dir  = &pwd_dir;
		  my($string2) = $array2{$name2};
		  &fasta_append($name2, $string2, $output_file);
	  }
  }
}
#________________________________________________________________________
# Title     : ctime
# Usage     : $Date = &ctime(time);
# Function  : a simple Perl emulation for the well known ctime(3C) function.
# Example   : $Date = &ctime(time);
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : Waldemar Kebsch, Federal Republic of Germany, November 1988
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub ctime{
	 @DoW = ('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
	 @MoY = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

	 local($time) = @_;
	 local($[) = 0;
	 my($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst);

	 # Determine what time zone is in effect.
	 # Use GMT if TZ is defined as null, local time if TZ undefined.
	 # There's no portable way to find the system default timezone.

	 $TZ = defined($ENV{'TZ'}) ? ( $ENV{'TZ'} ? $ENV{'TZ'} : 'GMT' ) : '';
	 ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
		  ($TZ eq 'GMT') ? gmtime($time) : localtime($time);

	 # Hack to deal with 'PST8PDT' format of TZ
	 # Note that this can't deal with all the esoteric forms, but it
	 # does recognize the most common: [:]STDoff[DST[off][,rule]]

	 if($TZ=~/^([^:\d+\-,]{3,})([+-]?\d{1,2}(:\d{1,2}){0,2})([^\d+\-,]{3,})?/){
		  $TZ = $isdst ? $4 : $1;
	 }
	 $TZ .= ' ' unless $TZ eq '';

	 $year += 1900;
	 sprintf("%s %s %2d %2d:%02d:%02d %s%4d\n",
		$DoW[$wday], $MoY[$mon], $mday, $hour, $min, $sec, $TZ, $year);
}
#________________________________________________________________________
# Title     : get_time
# Usage     : $Date = &get_time(time);
# Function  : a simple Perl emulation for the well known ctime(3C) function.
# Example   : "Nov30 4:37 1995"
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : Waldemar Kebsch, Federal Republic of Germany, November 1988
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_time{
	 @DoW = ('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
	 @MoY = ('Jan','Feb','Mar','Apr','May','Jun',
				'Jul','Aug','Sep','Oct','Nov','Dec');

	 my($time) = @_;
	 local($[) = 0;
	 local($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst,$final_time);

	 # Determine what time zone is in effect.
	 # Use GMT if TZ is defined as null, local time if TZ undefined.
	 # There's no portable way to find the system default timezone.

	 $TZ = defined($ENV{'TZ'}) ? ( $ENV{'TZ'} ? $ENV{'TZ'} : 'GMT' ) : '';
	 ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
		  ($TZ eq 'GMT') ? gmtime($time) : localtime($time);

	 # Hack to deal with 'PST8PDT' format of TZ
	 # Note that this can't deal with all the esoteric forms, but it
	 # does recognize the most common: [:]STDoff[DST[off][,rule]]

	 if($TZ=~/^([^:\d+\-,]{3,})([+-]?\d{1,2}(:\d{1,2}){0,2})([^\d+\-,]{3,})?/){
		  $TZ = $isdst ? $4 : $1;
	 }
	 $TZ .= ' ' unless $TZ eq '';

	 $year += 1900;
	 ############### This is the original format ##################
	 #$final_time=sprintf("%s %s% 2d %2d:%02d:%02d %s %4d\n",
	 #            $DoW[$wday], $MoY[$mon], $mday, $hour, $min, $sec, $TZ, $year);

	 $final_time=sprintf("%s%2d% 2d:%02d %4d\n",
					  $MoY[$mon], $mday, $hour, $min, $year);
	 return(\$final_time);
}


#________________________________________________________________________
# Title     : get_date
# Usage     : @outformat = &get_date;  eg result >  (010595 1-May-1995)
# Function  : returns date: $date6d (6 digit format) and
#             $datec (dd-mmm-yyyy format), Tim's version is 'getdate' in th_lib.pl
# Example   : 30-Nov-1995
# Warning   : Perl5.002
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : (\$datec);
# Tips      :
# Argument  :
# Todo      :
# Author    : by A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_date{
	 my(@time) = localtime(time);
	 my($ty,$tm,$td) = ($time[5],$time[4],$time[3]);
	 my($year) = '19' . $ty;
	 my($mon) = (Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec)[$tm];
	 my($day) = $td;
	 if($day < 10){
		  $day = ' ' . $day;
	 }
	 $datec = $day.'-'.$mon.'-'.$year;
	 $tm++;
	 if($tm < 10){
		  $tm = '0'.$tm;
	 }
	 if($td < 10){
		  $td = '0'.$td;
	 }
	 $date6d = $td.$tm.$ty;
	 #return ($date6d,$datec);
	 return (\$datec);
}

#________________________________________________________________________
# Title     : array_chk
# Usage     : &array_chk(\@any_array_to_chk);
# Function  : checks if any inputting array is empty or with one element.
# Example   : This is used only with subs which accepts array inputs.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : nothing, prints out messages to STDOUT
# Tips      :
# Argument  : gets on ref. of array.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub array_chk{  my(@input)=@{$_[0]};
  if (@input == 0){
	 &caller_info;
	 print "\n >>> $0 \n";
	 print "\n >>> Error: Input array to this subroutine was empty\n", chr(7);
	 print "\n To continue prog. type \'y\', or \'n\' to quit (with enter).\n ---->";
	 $key = ${&yes_or_no};
	 if($key ne 'y'){  print "\n !! Aborting the operation !! \n"; exit(0); }}
  elsif ($#input == 0){
	 print "\n >>> Warn: Input array to this subroutine was only one, O.K ?\n";
	 print "\n >>> It means your input was not an array at all, probable	error\n";
	 &caller_info;
	 #________________________________________________________
	 # Title    : caller_info
	 # Function : tells you calleing programs and sub's information with file, subname, main, etc
	 # Usage    : &caller_info; (just embed anywhere you want to check.
	 #----------------------------------------------------------------------
	 sub caller_info{	    # caller(1), the num. tells you which info you choose
		my($i)=1;
		while(($pack, $file, $line, $subname, $args) = caller($i++)){
		  my($level) = $i-1;
		  print "\n", chr(169)," This sub info was made by \&caller_info subroutine";
		  print "\n ", chr(164)," Package  from => $pack ";
		  print "\n ", chr(164)," Exe. file was => $file ";
		  print "\n ", chr(164)," Line was  at? => $line (in $file)";
		  print "\n ", chr(164)," Name of  sub? => $subname";
		  print "\n ", chr(164)," How many arg? => $args";
		  print "\n ", chr(164)," Level of sub? => $level (1 is for where \&caller_info is )\n\n";
		}
	 }
	 #________________________________________________________
	 #________________________________________________________
	 # Title    : yes_or_no
	 # returns  : ref. of a Scalar for 'y' or 'n'
	 # Usage    : $yes_or_no = ${&yes_or_no};
	 #---------------------------------------------------------
	 sub yes_or_no{
		my($key)=getc;
		if (($key eq 'y') || ($key eq 'Y')){
		  return(\$key);
		}elsif(($key eq 'n') || ($key eq 'N')){
		  return(\$key);
		}else{
		  print chr(7), "\n Type only (y or n) ----> ";
		  &yes_or_no;
		}
	 }
	 #________________________________________________________
  }
}

#________________________________________________________________________
# Title     : hash_chk
# Usage     : &hash_chk(\%input_hash);
# Function  : checks hash input of any subroutine.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_chk{ my(@input)=%{$_[0]};
  if ( @input == 0){
	  &caller_info;
	  print "\n >>> $0 \n", chr(7);
	  print "\n >>> Error: Input hash to this subroutine was empty\n";
	  print "\n To continue prog. type \'y\', or \'n\' to quit (with enter).\n ----> ";
	  $key = ${&yes_or_no};
	  if($key ne 'y'){
		 exit(0);
	  }
  }elsif ( @input == 1){
	  &caller_info;
	  print "\n >>> $0 \n", chr(7);
	  print "\n >>> Warn: Input hash to this subroutine was only one, O.K ?\n";
	  print "\n To continue prog. type \'y\', or \'n\' to quit (with enter).\n ----> ";
	  $key = &{&yes_or_no};
	  if($key ne 'y'){
		  exit(0);
	  }
  }
}
#________________________________________________________________________
# Title     : hash_output_chk
# Usage     : &hash_output_chk(\%outing_hash);
# Function  : checks hash output of any subroutine.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_output_chk{
  for($i=0; $i<= $#_; $i++){
	 my(%tem)=%{$_[$i]};  my(@keys)=keys %tem;
	 for ($j =0; $j<@keys; $j++){
		unless(($keys[$j]=~/[\s\S]+/)&&($tem{$keys[$j]}=~/[\s\S]+/)){
		  print "\n Err. at Hash_output_chk at $0 \n", chr(7); exit;
		}
	 }
  }
}

#________________________________________________________________________
# Title     : n
# Usage     : &n;
# Function  : puts one single new line
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub n{  print "\n";  }


#________________________________________________________________________
# Title     : cls
# Usage     : &cls;
# Function  : clears screen
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub cls{   my($cls) = `clear`;  print $cls;  }


#________________________________________________________________________
# Title     : seq_comp_percent1
# Usage     : @outarray = &seq_comp_percent1(@any_input_string_array);
# Function  : get string seq identities(a to z). gets array of strings and outs array of % numbers
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one ref. of an array
# Tips      :
# Argument  : one ref. of an array
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub seq_comp_percent1{ 		# this is affected by seq. length
		  my(@input)=@{$_[0]};
		  my(@array_of_ids1, $id1, @char1, @char2);
		  &array_chk(\@input);
		  @input = sort (@input);
		  $longest_str_size  = &get_long_str_size (@input), "\n";
		  $shortest_str_size = &get_short_str_size(@input), "\n";
		  if (($longest_str_size/$shortest_str_size) > 4){
					 print "\n The shortest string is less than 1/4 of the longest\n";
					 print " This is quite meaningless, but will go on\n";
		  }
		  for ($i = 0; $i <= $#input ; $i++){
					 if ($input[$i]=~/(\W)/){
								print "\n Warn: seq($input[$i] contains non char\n";
								&remove_non_char($input[$i]);
					 }
					 @char1 = split(/|\s+|\.+|\-+/, $input[$i]);  # splitting into char.
					 foreach $char (@char1){
								$charcount1{$char} +=1; # making array of ['A' => 6, 'B'=>2...]
					 }
					 for($j = $i+1 ; $j <= $#input; $j++){
								if ($input[$j]=~/(\W)/){
										  print "\n Warn: seq($input[$i] contains non char\n";
										  &remove_non_char($input[$j]);
								}
								@char2 = split(/|\s+|\.+|\-+/, $input[$j]);  # splitting into
								foreach $char (@char2){
										  $charcount2{$char} +=1; # making array of ['A' => 6, 'B'=>2...]
								}
								$id1 = &get_id_among_2_1(*charcount1, *charcount2); # gets % id.
								# print %charcount1,"\n";
								push (@array_of_ids1, $id1);
								%charcount2=();
					 }
					 %charcount1=();
		  }
		  \@array_of_ids1;
}


#________________________________________________________________________
# Title     : get_id_among_2_1
# Usage     : $id = &get_id_among_2(*charcount1, *charcount2) <- hashes
# Function  : gets the % id of any two sequences, returns in  100.0% format.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_id_among_2_1{ 	# 66.67 % if ABC with ABCABC  (due to diff. seq. length.)
	 local(*hash1, *hash2)= @_;
	 my($identity, $no_of_same, $sum_of_same, $av);
	 my(@num_char1)=values %hash1;
	 my(@num_char2)=values %hash2;
	 for $key1 (sort keys %hash1){
					 for $key2 (sort keys %hash2){
								if ($key1 eq $key2){
										  $no_of_same = &min($hash1{$key1},$hash2{$key2});
										  $sum_of_same += $no_of_same;
										  last;
								}
					 }
	 }
	 $identity = $sum_of_same*2/(&sum_array(@num_char1,@num_char2))*100;
	 # print "percent iden = ", $identity, "\n";
}
#________________________________________________________________________
# Title     : get_id_among_2_2
# Usage     : $id = &get_id_among_2(*charcount1, *charcount2) <- hashes
# Function  : gets the % id of any two sequences, returns in  100.0% format.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_id_among_2_2{       #  eg) 50% if ABC with AABBCC or ABCABC
	 local(*hash1, *hash2)= @_;
	 my($identity, $no_of_same, $sum_of_same, $av);
	 #print %hash1,"\n";
	 #print %hash2,"\n";
	 my(@num_char1)=values %hash1;
	 my(@num_char2)=values %hash2;
	 for $key1 (sort keys %hash1){
			for $key2 (sort keys %hash2){
				if ($key1 eq $key2){
					 $no_of_same = &min($hash1{$key1},$hash2{$key2});
					 $sum_of_same += $no_of_same;
					 last;
				}
			}
	 }
	 $seq1=&sum_array(@num_char1);
	 $seq2=&sum_array(@num_char2);
	 $longer_seq = &max($seq1, $seq2);
	 $identity = $sum_of_same/$longer_seq*100;
	 #print "percent iden = ", $identity, "\n";
}
#________________________________________________________________________
# Title     : av_array
# Usage     : $output = &av_array(\@any_array);
# Function  :
# Example   :
# Warning   : synonim of array_average
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : single scaler digit.
# Tips      :
# Argument  : takes one array reference.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub av_array{
  my(@input)= @{$_[0]};
  my $int_option = ${$_[1]} if ref($_[1]);
  my $int_option =  $_[1]  if !ref($_[1]);
  my($item,$average,$num,$sum);
  my $num_of_elem = @input;

  for $item(@input){
	 if( $item =~ /^$/ ){  ## If it matches nothing. '$item == 0' does not work !!!
		$num_of_elem --; ## This is to make sure that the denominator does not
	 }                  ## count blank element. (to get correct element number)
	 else{ $sum += $item;  }
  }
  if($num_of_elem ==0){ $num_of_elem =1; }  ## To prevent 'Division by 0' error
  if($int_option =~ /[\-]*i[nt]*/){
	  $average= int( $sum/$num_of_elem );
  }else{   $average = $sum/$num_of_elem }

  \$average;
}

#________________________________________________________________________
# Title     : array_average
# Usage     : $output = &array_average(\@any_array);
# Function  : (the same as average_array)
# Example   :
# Warning   : If divided by 0, it will automatically replace it with 1
# Class     :
# Keywords  : get_array_average, av_array, average_array, get_average_array
#             average_of_array, average_array
# Options   :
# Package   :
# Reference :
# Returns   : single scaler digit.
# Tips      :
# Argument  : takes one array reference.
# Todo      :
# Author    : A Biomatic
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub array_average{
  my(@input)= @{$_[0]};
  my $int_option = ${$_[1]} || $_[1];
  my($item,$average,$num,$sum);
  my $num_of_elem = @input;

  for $item(@input){
	 if( $item =~ /^$/ ){  ## If it matches nothing. '$item == 0' does not work !!!
		$num_of_elem --; ## This is to make sure that the denominator does not
	 }                  ## count blank element. (to get correct element number)
	 else{ $sum += $item;  }
  }
  if($num_of_elem ==0){ $num_of_elem =1; }  ## To prevent 'Division by 0' error
  if($int_option =~ /[\-]*i[nt]*/){
	  $average= int( $sum/$num_of_elem );
  }else{   $average = $sum/$num_of_elem }

  return(\$average);
}

#________________________________________________________________________
# Title     : average_array
# Usage     : $output = &average_array(\@any_array);
# Function  : (the same as array_average)
# Example   :
# Warning   : If divided by 0, it will automatically replace it with 1
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : single scaler digit.
# Tips      :
# Argument  : takes one array reference.
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub average_array{
  my(@input)= @{$_[0]};
  my $int_option = ${$_[1]} if ref($_[1]);
  my $int_option =  $_[1]  if !ref($_[1]);
  my($item,$average,$num,$sum);
  my $num_of_elem = @input;

  for $item(@input){
	 if( $item =~ /^$/ ){  ## If it matches nothing. '$item == 0' does not work !!!
		$num_of_elem --; ## This is to make sure that the denominator does not
	 }                  ## count blank element. (to get correct element number)
	 else{ $sum += $item;  }
  }
  if($num_of_elem ==0){ $num_of_elem =1; }  ## To prevent 'Division by 0' error
  if($int_option =~ /[\-]*i[nt]*/){
	  $average= int( $sum/$num_of_elem );
  }else{   $average = $sum/$num_of_elem }

  \$average;
}

#________________________________________________________________________
# Title     : average_of_array (the same as array_average)
# Usage     : $output = &average_of_array(\@any_array);
# Function  :
# Example   :
# Warning   : If divided by 0, it will automatically replace it with 1
#             '$item == 0' does not work !!! in the following
# Class     :
# Keywords  :
# Options   : -int to make the resultant numbers shown in integer
# Package   :
# Reference :
# Returns   : single scaler digit.
# Tips      :
# Argument  : takes one array reference.
# Todo      :
# Author    : A Biomatic
# Version   : 2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub average_of_array{
  my(@input)= @{$_[0]};
  my $int_option = ${$_[1]} if ref($_[1]);
  my $int_option =  $_[1]  if !ref($_[1]);
  my($item,$average,$num,$sum);
  my $num_of_elem = @input;

  for $item(@input){
	 if( $item =~ /^$/ ){  ## If it matches nothing. '$item == 0' does not work !!!
		$num_of_elem --; ## This is to make sure that the denominator does not
	 }                  ## count blank element. (to get correct element number)
	 else{ $sum += $item;  }
  }
  if($num_of_elem ==0){ $num_of_elem =1; }  ## To prevent 'Division by 0' error
  if($int_option =~ /[\-]*i[nt]*/){
	  $average= int( $sum/$num_of_elem );
  }else{   $average = $sum/$num_of_elem }

  \$average;
}
#________________________________________________________________________
# Title     : hash_average
# Usage     : %out=%{&hash_average(\%in)};  or
#             ($out1, $out2)=&hash_average(\%in,\%in2);
# Function  :
# Example   : %in=(1, "13242442", 2, "92479270", 3, "2472937439");
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : %out =(1, 2.13242, 2, 5.2702, 3, 1.72937439); <-- somethins like
# Tips      : The denominator is adjusted to the actual numbers of
#             numbers. So, undefined array element is not counted
#             This is more correct.
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_average{
  my(@out_av_hash, $v, $sum, $num_of_elem);
  for($v=0; $v< @_; $v++){
	  my(%input)=%{$_[$v]};
	  for(keys(%input)){
		 if($input{$_} =~ /\,/){ $split_char=',' }
		 else{ $split_char='' }
		 my(@num_arr)=split(/$split_char/, $input{$_});
		 $num_of_elem = @num_arr;
		 for $elem(@num_arr){
			 if( $elem == '' ){
				$num_of_elem -- ; ## This is to make sure that the denominator does not
			 }                   ## count blank element. (to get correct element number)
			 else{ $sum += $elem;  }
		 }
		 my($av)=$sum/$num_of_elem;
		 $out_hash{$_}=$av;
		 $sum=0;
	  }
	  push(@out_av_hash, \%out_hash);
  }
  if( @out_av_hash==1 ){  return($out_av_hash[0]); }
  elsif( @out_av_hash > 1){  return(@out_av_hash);  }
}
#________________________________________________________________________
# Title     : hash_stat_for_all
# Usage     : %out=%{&hash_average(\%in, \%in2,..)};
# Function  : gets the min, max, av, sum for the whole values of ALL the
#             hashes put in. (grand statistics)
# Example   : %in =(1, "13242442", 2, "92479270", 3, "2472937439");
#             %in2=(1, "28472", 2, "23423240", 3, "123412342423439");
#
#             %in =(name1, "1,3,2,4,2,4,4,2", name2, "9,2,4,7,9,2,7,0");
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : normal array of ($min, $max, $sum, $av)
#             Example  out:>                 |  min max sum  av
#                            -----------------------------------
#                            of the whole    |   0   9  110   6
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_stat_for_all{ package hash_stat_for_all;
  my($elem,@out_av_hash, @out_array,$v,@num_arr,$sum,$min, $av,$num_all, $max,$split_char);
  for($v=0; $v<@_; $v++){ my(%input)=%{$_[$v]};
	  for $name(keys(%input)){
		 if($input{$name} =~ /\,/){ $split_char=','; }
		 else{ $split_char=''; } @num_arr=split(/$split_char/, $input{$name});
		 for $elem(@num_arr){
			if($elem =~/[\-]*\d+/){   $min=$elem unless(defined($min));
				$min =$elem if $elem < $min; $max =$elem if $elem > $max;
				$sum+=$elem; $num_all++; } } } }
  if($num_all == 0){ $av=0; $sum=0; $min=0; $max=0; }
  else { $av=$sum/$num_all; }
  push(@out_array, ($min, $max, $sum, $av));
  package main; return(@out_array);
}

#________________________________________________________________________
# Title     : min
# Usage     : $min = &min (37, 24, 3,1,5, \@array, @array2, \$arr_ref);
# Function  : accepts ref of array, scalar and normal digits to
#             find the min. Only gets numbers. If you put something
#             like 'H333333', it gets digits '333333' only and returns it.
#             this uses RECURSION.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub min{
  my(@in) = @_; my($i, @min, $min);

  for($i=0; $i < @in; $i++){
	 if( (ref($in[$i]) eq 'SCALAR') && (${$in[$i]} =~/([\-]?\d+)/) ){
		push(@min,  $1);    }
	 elsif(ref($in[$i]) eq 'ARRAY'){
		$min=&min(@{$in[$i]});
		push(@min, $min);    }
	 elsif( ( !ref($in[$i]) )&& ($in[$i] =~/([\-]?\d+)/)  ){
		push(@min, $1); }
  }

  for (@min) { $min = $_ if $min > $_; }
  $min;
}

#________________________________________________________________________
# Title     : max
# Usage     : $max = &max (37, 24, 3,1,5, \@array, @array2, \$arr_ref);
# Function  : accepts ref of array, scalar and normal digits to
#             find the min. Only gets numbers. If you put something
#             like 'H333333', it gets digits '333333' only and returns it.
#             this uses RECURSION.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub max{
  my(@in) = @_; my($i, $max, @max, $min);

  for($i=0; $i < @in; $i++){
	 if( (ref($in[$i]) eq 'SCALAR') && (${$in[$i]} =~/([\-]?\d+)/) ){
		push(@max,  $1);    }
	 elsif(ref($in[$i]) eq 'ARRAY'){
		$max = &max(@{$in[$i]});
		push(@max, $max);    }
	 elsif( ( !ref($in[$i]) )&& ($in[$i] =~/([\-]?\d+)/)  ){
		push(@max, $1); }
  }

  for (@max) { $max = $_ if $max < $_; }
  $max;
}
#________________________________________________________________________
# Title     : get_longest_str_size
# Usage     : $long_str_size = &get_long_str_size (\@any_array_of_string);
# Function  : get_longest_str_size in an array. eg. get ABCDE among (A, CAB, CDE, ABCDE)
# Example   :
# Warning   :
# Class     :
# Keywords  : get_the_largest_string_size, get_largest_string_size, largest_string_size,
#             get_long_str_size, get_longest_string_size, lonest_string_size
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets one reference of an array of strings.
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_longest_str_size{
  	#""""""""""""""""""""""< handle_arguments{ head Ver 1.3 >"""""""""""""""""""
	my(@A )=&handle_arguments( @_ );my( $num_opt )=${$A[7]};my( $char_opt )=${$A[8]};
	my(@hash)=@{$A[0]};my(@file)=@{$A[4]};my(@dir)=@{$A[3]};my(@array)=@{$A[1]};
	my(@string)=@{$A[2]};my(@num_opt)=@{$A[5]};my(@char_opt)=@{$A[6]};my(@raw_string)=@{$A[9]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p, $q, $r, $s, $t, $u, $v, $w, $x,$y,$z);
	if($debug==1){ print "\n   \@hash has \"@hash\"\n   \@raw_string has   \"@raw_string\"
	\@array has \"@array\"\n   \@char_opt has   \"@char_opt\"\n   \@file has \"@file\"
	\@string has \"@string\"\n   \@num_opt has \"@num_opt\"\n"; }
	#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	my(@input)=@{$array[0]};
	my $factor,$max,$len;
	if( (@input<1)&&(@_ > 1) ){
	  @input=@_;
	}
	if(@num_opt < 1){ @num_opt=0..$#input; $factor=0 }
	else{ $factor =1 }
	print "\nPositions compared are: @num_opt\n" if $debug==1;
	for($j=0; $j < @num_opt; $j++){
  	   $len = length($input[$num_opt[$j]-$factor]);
	   $max = $len if ($len > $max);
	}
	\$max;
}



#________________________________________________________________________
# Title     : get_shortest_str_size
# Usage     : $short_str_size = &get_short_str_size (\@any_array_of_string);
# Function  : get_shortest_str_size in an array. eg. get A among (A, CAB, CDE, ABCDE)
# Example   :
# Warning   : once debugged. 1st May/95
# Class     :
# Keywords  : get_short_str_size, get_short_string_size, shortest_string_size,
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets one reference of an array of strings.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_shortest_str_size{
  my(@input)=@{$_[0]}; my($min,$len);
  $min=length($input[0]);
  for ($i = 1; $i <=$#input; $i++){ $len = length($input[$i]); $min = $len if ($len < $min); }
  \$min;
}

#________________________________________________________________________
# Title     : get_id_among_2
# Usage     : $id = &get_id_among_2(\%charcount1, \%charcount2) <- hashes
# Function  : gets the % id of any two sequences
# Example   : %hash1=('A', 30, 'B', 99, 'C', 15 .....)
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : gets two references of hashes of chars and their occurances.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_id_among_2{  my(%hash1)=%{$_[0]}; my(%hash2)=%{$_[1]};
  my($identity, $no_of_same, $sum_of_same, $av);
  for $key1 (sort keys %hash1){
  $k1 +=1;
	 for $key2 (sort keys %hash2){  $k2 +=1;
		if ($key1 eq $key2){
		  $no_of_same = &min($hash1{$key1},$hash2{$key2});
		  $sum_of_same +=$no_of_same;  last;  } } }
  if ($k1 == $k2){  $av = $k1;  }
  else{  $av = &array_average($k1, $k2); }
  $identity = ($sum_of_same/$av)*100;
  \$identity;
}

#________________________________________________________________________
# Title     : extract_num_to_array
# Usage     : @my_outarray = &extract_num_to_array($any_input_string);
# Function  : extract only numbers(including negatives) from a string and put into an array
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub extract_num_to_array{
  my($input) =${$_[0]};
  my(@input) =split(/\s+/, $input);
  my(@out_array);
  print "@input", "\n";
  for ($i=0; $i <=$#input; $i++){
		  if ($input[$i] =~ /^(-\d+\.\d+)$/) # for negatives( -3.5555)
		  {
					 push(@out_array	, $1);
		  }
		  elsif ($input[$i] =~ /^(\d+\.\d+)$/)  # for positives ( 33.5534 )
		  {
					 push(@out_array	, $1);
		  }
		  elsif ($input[$i] =~ /^(-\d+)$/) # sor single nega digit ( -1 )
		  {
					 push(@out_array	, $1);
		  }
		  elsif ($input[$i] =~ /^(\d+)$/) # sor single nega digit ( 25 )
		  {
					 push(@out_array	, $1);
		  }
  }
  \@out_array;
}
#________________________________________________________________________
# Title     : weighted_average
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub weighted_average{
	 my(@input)=@{$_[0]};
	 my(@array_av_diff,@array_diff, $sum, $num,);
		  my($diff,$weight,$average,$sum_of_av_diffs,$weight_x_input_item);
		  my($final_weighted_av) = 0;
					 for($i=0; $i<=$#input ; $i++){
								for ($j=0; $j<=$#input ; $j++)
								{
										  next if ($i==$j); # remove the self - self. !!
										  $diff=abs($input[$i]-$input[$j]);
										  push (@array_diff, $diff);
								}
								for $item(@array_diff){
								  $sum+=$item;
								}
								$num=$#array_diff+1;
								$average = $sum/$num;

								push(@array_av_diff, $average);
								$average=0; $sum=0;
								@array_diff=();
					 }
					 $sum_of_av_diffs = ${&sum_array(\@array_av_diff)};
					 if ($sum_of_av_diffs == 0){
								$sum_of_av_diffs =1;
								$final_weighted_av = $input[0];
								goto END_point;
					 }
					 for ($k=0; $k <= $#input ; $k++){
								$weight= (($array_av_diff[$k])/$sum_of_av_diffs);
								$weight_x_input_item  = ($input[$k])*$weight;
								$final_weighted_av  = $final_weighted_av + $weight_x_input_item;
					 }
			END_point:
	 \$final_weighted_av;  # for return
}
#________________________________________________________________________
# Title     : weighted_av
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub weighted_av{
	my(@input)=@{$_[0]};
	my(@array_av_diff,@array_diff, $sum, $num,);
		  my($diff,$weight,$average,$sum_of_av_diffs,$weight_x_input_item);
		  my($final_weighted_av) = 0;
					 for($i=0; $i<=$#input ; $i++){
								for ($j=0; $j<=$#input ; $j++)
								{
										  next if ($i==$j); # remove the self - self. !!
										  $diff=abs($input[$i]-$input[$j]);
										  push (@array_diff, $diff);
								}
								for $item(@array_diff){
								  $sum+=$item;
								}
								$num=$#array_diff+1;
								$average = $sum/$num;

								push(@array_av_diff, $average);
								$average=0; $sum=0;
								@array_diff=();
					 }
					 $sum_of_av_diffs = ${&sum_array(\@array_av_diff)};
					 if ($sum_of_av_diffs == 0){
								$sum_of_av_diffs =1;
								$final_weighted_av = $input[0];
								goto END_point;
					 }
					 for ($k=0; $k <= $#input ; $k++){
								$weight= (($array_av_diff[$k])/$sum_of_av_diffs);
								$weight_x_input_item  = ($input[$k])*$weight;
								$final_weighted_av  = $final_weighted_av + $weight_x_input_item;
					 }
			END_point:
	 \$final_weighted_av;  # for return
}


#________________________________________________________________________
# Title     : sum_array (the same as array_sum)
# Usage     : $out =  ${&sum_array(\@anyarray)};
# Function  : sum of all the  elements of an array .
# Example   :
# Warning   :
# Class     :
# Keywords  : get_array_sum get_sum_array, get sum of array
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a scaler.
# Tips      :
# Argument  : ref. of an array of numbers.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sum_array{
  my($sum, $item);
  foreach $item(@{$_[0]}){ $sum += $item; }
  \$sum;
}
#________________________________________________________________________
# Title     : sum_of_array (the same as array_sum)
# Usage     : $out =  ${&sum_of_array(\@anyarray)};
# Function  : sum of all the  elements of an array .
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : -int for integerised output.
# Package   :
# Reference :
# Returns   : a ref. of a scaler.
# Tips      :
# Argument  : ref. of an array of numbers.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sum_of_array{
  my $int_option = ${$_[1]} if ref($_[1]);
  my $int_option = $_[1] if !ref($_[1]);
  my($sum, $item);
  foreach $item(@{$_[0]}){
	 $sum += $item; }
  if($int_option =~ /[\-]*i[nt]*/){
	 $sum = int($sum);
  }
  \$sum;
}

#________________________________________________________________________
# Title     : array_sum (the same as sum_array)
# Usage     : $out =  ${&sum_array(\@anyarray)};
# Function  : sum of all the  elements of an array .
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a scaler.
# Tips      :
# Argument  : ref. of an array of numbers.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub array_sum{ my($sum, $item);
  foreach $item(@{$_[0]}){ $sum += $item; }
  \$sum;
}


#________________________________________________________________________
# Title     : sum_hash
# Usage     : $out = &sum_array(%anyhash);
# Function  : sum of all the  numbers in valuse of a hash
# Example   : %hashinput= ( name1, '12..3e',
#                            name2, '...234');
#             $result = 1+2+3+2+3+4 = 15 (from above example)
# Warning   : It only gets digits in the input strings and sums them up.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a scaler.
# Tips      :
# Argument  : ref. of an array of numbers.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sum_hash{ my($elements) = join(',', values (%{$_[0]}));
	my(@elements) = split(',',$elements);  my($sum);
	foreach $item(@elements){ if ($item =~ /[\-\d+]/){ $sum += $item; } }
	\$sum;
}


#________________________________________________________________________
# Title     : key_ready
# Usage     :
# Function  : detects keyboard input without reading it
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      : 4.27) How can I detect keyboard input without reading it?
#             You should check out the Frequently Asked Questions list in
#             comp.unix.* for things like this: the answer is
#             essentially the same.
#             It's very system dependent.  Here's one solution that
#             works on BSD systems:
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub key_ready{  my($rin, $nfd); vec($rin, fileno(STDIN), 1) = 1;
  return $nfd = select($rin,undef,undef,0);
}

#________________________________________________________________________
# Title     : round
# Usage     :
# Function  : gives rounded numbers
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub round{
	my(@numbers);
	my($num);
	@numbers  = @{$_[0]} if ref($_[0]) eq 'ARRAY';
	push(@numbers, ${$_[0]}) if ref($_[0]) eq 'SCALAR';

	for $num (@numbers){
		$num  = int($num + .5);
	}
	if(@numbers > 1){ \@numbers }elsif( @numbers == 1 ){ \$numbers[0] }
}
#________________________________________________________________________
# Title     : round_number
# Usage     :
# Function  : gives rounded integer numbers. 9.5 will be 10, 9.4 will be 9
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub round_number{
	my(@numbers);
	my($num);
	@numbers  = @{$_[0]} if ref($_[0]) eq 'ARRAY';
	push(@numbers, ${$_[0]}) if ref($_[0]) eq 'SCALAR';

	for $num (@numbers){
		$num  = int($num + .5);
	}
	if(@numbers > 1){ \@numbers }elsif( @numbers == 1 ){ \$numbers[0] }
}
#________________________________________________________________________
# Title     : round_numbers  (same as  round_number )
# Usage     : @output=@{&round_numbers(\@input_numbs)};
#             or  $output=${&round_numbers(\$input_numbs)};
# Function  : gives rounded integer numbers. 9.5 will be 10, 9.4 will be 9
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub round_numbers{
	my(@numbers);
	my($num);
	@numbers  = @{$_[0]} if ref($_[0]) eq 'ARRAY';
	push(@numbers, ${$_[0]}) if ref($_[0]) eq 'SCALAR';

	for $num (@numbers){
		$num  = int($num + .5);
	}
	if(@numbers > 1){ \@numbers }elsif( @numbers == 1 ){ \$numbers[0] }
}



#________________________________________________________________________
# Title     : trim_numbers
# Usage     : @output=@{&trim_numbers(\@input_numbs, \$size_of_posi)};
# Function  : gives trimmed numbers (not rounded)
# Example   : given num array( 1.33333, 3.555242424, 0.2342324, 4.9234723747)
#             >>>            (1.33,  3.56,  0.23,  4.92 )
#
# Warning   : If you put '1' with trimming value of 2 it will be '1.00'
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub trim_numbers{
	my(@numbers) = @{$_[0]};
	my($num);
	my($position)= ${$_[$#_]} if ref($_[$#_]);  ### last input arg is the trimming value
	my($position)=  $_[$#_]  if ! ref($_[$#_]);
	if (@_ < 2){ $position =4; }
	for $num (@numbers){
		$num  = sprintf("%-.$position f", $num);
	}
	\@numbers;
}

#________________________________________________________________________
# Title     : min_elem_array
# Usage     : ($out1, $out2)=@{&min_elem_array(\@array1, \@array2)};
#             ($out1)       =${&min_elem_array(\@array1)          };
# Function  : gets the smallest element of any array of numbers.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more ref. for scalar numbers.
# Tips      :
# Argument  : numerical arrays
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub min_elem_array{
  my(@out_min_elem, @input, $min_elem);
  for($i=0; $i< @_; $i++){
	 @input=@{$_[$i]};
	 $min_elem=$input[$#input];
	 for (@input){
		 $min_elem=$_ if ((/[\-\d]+/)&&($_ < $min_elem));
	 }
	 push(@out_min_elem, $min_elem);
  }
  if(@_ == 1){  return( \$min_elem ); }
  elsif(@_ > 1 ){  return( \@out_min_elem ) };
}

#________________________________________________________________________
# Title     : max_elem_array
# Usage     : ($out1, $out2)=@{&max_elem_array(\@array1, \@array2)};
#             ($out1)       =${&max_elem_array(\@array1)          };
# Function  : gets the largest element of any array of numbers.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more ref. for scalar numbers.
# Tips      :
# Argument  : numerical arrays
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub max_elem_array{
  my(@out_max_elem, $i, @input, $max_elem);
  for($i=0; $i< @_; $i++){
	 @input=@{$_[$i]}; $max_elem=$input[$#input];
	 for (@input){
		 $max_elem = $_ if ((/[\-\d]+/)&&($_ > $max_elem));    }
	 push(@out_max_elem, $max_elem);}
  if(@_ == 1){ return( \$max_elem ); }
  elsif(@_ > 1 ){  return( \@out_max_elem ) };
}

#________________________________________________________________________
# Title     : max_elem_string_array
# Usage     : ($out1, $out2)=@{&max_elem_array(\@array1, \@array2)};
#             ($out1)       =${&max_elem_array(\@array1)          };
# Function  : gets the largest string length of element of any array of numbers.
# Example   :
# Warning   :
# Class     :
# Keywords  : largest string length of array
# Options   :
# Package   :
# Reference :
# Returns   : one or more ref. for scalar numbers.
# Tips      :
# Argument  : numerical arrays
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub max_elem_string_array{
  my(@input, $i, $max_elem);
  @input = @{$_[0]} if ref($_[0]) eq 'ARRAY';
  @input = @_       if ref($_[0]) ne 'ARRAY';
  for($i=0; $i< @input ; $i++){
		 $max_elem = length($input[0]);
		 if (length($input[$i]) > $max_elem){
			 $max_elem = length($input[$i]);
		 }
  }
  \$max_elem;
}

#________________________________________________________________________
# Title     : min_elem_string_array
# Usage     : ($out1, $out2)=@{&max_elem_array(\@array1, \@array2)};
#             ($out1)       =${&max_elem_array(\@array1)          };
# Function  : gets the largest string length of element of any array of numbers.
# Example   :
# Warning   :
# Class     :
# Keywords  : shortest string length of array
# Options   :
# Package   :
# Reference :
# Returns   : one or more ref. for scalar numbers.
# Tips      :
# Argument  : numerical arrays
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub max_elem_string_array{
  my(@input, $i,  $min_elem);
  @input = @{$_[0]} if ref($_[0]) eq 'ARRAY';
  @input = @_ unless ref($_[0]) eq 'ARRAY';

  for($i=0; $i< @input ; $i++){
		 $min_elem = length($input[$#input]);
		 if (length($input[$i]) < $min_elem){
			 $min_elem = length($input[$i]);
		 }
  }
  \$min_elem;
}


#________________________________________________________________________
# Title     : maximum
# Usage     : $biggest = &maximum(37, 24);
# Function  : another way of finding maximum
# Example   :
# Warning   :
# Class     :
# Keywords  : get_maximum, get_bigger, get_largest
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub maximum{ if ($_[0] > $_[1]){ $_[0];  } else{ $_[1];  }  }

#________________________________________________________________________
# Title     : minimum
# Usage     : $biggest = &maximise(37, 24);
# Function  : another way of finding minimum
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub minimum{ if ($_[0] > $_[1]){$_[1];} else{ $_[0]; }  }

#______________________________________________________________
# Title     : get_largest_element
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  : get_largest_value, get_biggest_value,
#             get_maximum_element, get_largest_number,
#             get_largest_number_element
# Options   : _  for debugging.
#             #  for debugging.
# Package   : Bio
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Scientist
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------
sub get_largest_element{
  my @arr=@{$_[0]};
  for($i=0; $i< @arr; $i++){
	$max=$arr[$i] if $max < $arr[$i];
  }
  return(\$max);
}




#________________________________________________________________________
# Title     : sqrt_array
# Usage     :
# Function  : sqrt all elements of an array
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sqrt_array{
  my(@input)= @{$_[0]};
  my($sqrt_item);
  foreach $item(@input){ $item = sqrt($item); }
  \@input;
}
#________________________________________________________________________
# Title     : square_array
# Usage     :
# Function  : converts all the elements of an array to squared values.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub square_array{ my(@input)= @{$_[0]}; my($sqrt_item);
  foreach $item(@input){ $item = $item*$item; }
  \@input;
}

#________________________________________________________________________
# Title     : sum_of_squared_array
# Usage     : $out = &sum_of_squared_array(@anyarray);
# Function  : sum of all the squared elements of an array .
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sum_of_squared_array{ my(@input)= @{$_[0]};	my($sqrt_item);	my($sum);
  for $item(@input){ $item = $item*$item; $sum += $item;}
  \$sum;
}
#________________________________________________________________________
# Title     : x_mul_y_arrays
# Usage     : @out_array = &x_mul_y_arrays(*array1,*array2);
# Function  : multiplies each item of two arrays .
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub x_mul_y_arrays{ my(@ar1)=@{$_[0]}; my(@ar2)=@{$_[1]};
	$num_of_element = ($#ar1 + 1);
	for ($c=0; $c <= $num_of_element;$c++){ $multiplied = ($ar1[$c])*($ar2[$c]);
		push(@multiple, $multiplied);  }
	\@multiple;
}
#________________________________________________________________________
# Title     : sum_x_mul_y_arrays
# Usage     : $out = &sum_x_mul_y_arrays(*array1,*array2);
# Function  : sums up multiplied items of two arrays .
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sum_x_mul_y_arrays{ my(@arr1)=@{$_[0]}; my(@arr2)=@{$_[1]};
  my($sum_xy, $multiplied);
  for ($k=0;$k <=$#arr1;$k++){ $multiplied = ($arr1[$k])*($arr2[$k]);
	 $sum_xy += $multiplied; }
  \$sum_xy;
}

#________________________________________________________________________
# Title     : corelation_coefficient
# Usage     : $cc = &corelation_coefficient(\@array_not_hash1, \@array_not_hash2);
# Function  : gets corelation_coefficient of two equal length arrays
# Example   :
# Warning   : uses references for ARRAY.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub corelation_coefficient{
	my($final_cc,$av1,$av2,$sum_of_squared_ar1,
		$sum_of_squared_ar2,$sum_of_xy,$upper_half, $under_half);
	my(@array1)=@{$_[0]};
	my(@array2)=@{$_[1]};
	$num_of_elem = @array1;
	$av1=${&array_average(\@array1)};
	$av2=${&array_average(\@array2)};

	$sum_of_squared_ar1=${&sum_of_squared_array(\@array1)};
	$sum_of_squared_ar2=${&sum_of_squared_array(\@array2)};
	$sum_of_xy= ${&sum_x_mul_y_arrays(\@array1,\@array2)};
	$upper_half=($sum_of_xy -($num_of_elem*($av1*$av2)));
	$under_half=sqrt(($sum_of_squared_ar1-($num_of_elem*($av1*$av1)))*($sum_of_squared_ar2-($num_of_elem*($av2*$av2))));

	if ($under_half ==0){ $under_half=1; }
	$final_cc  = $upper_half/$under_half;
	print "\n CC = $final_cc\n";
	\$final_cc;
}

#________________________________________________________________________
# Title     : cc
# Usage     : $cc = &cc(\@array_not_hash1, \@array_not_hash2);
# Function  : synonmym of  corelation_coefficient
# Example   :
# Warning   : uses references for ARRAY
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub cc{ my(@array1)=@{$_[0]};  my(@array2)=@{$_[1]};
	my($final_cc, $av1, $av2,$sum_of_squared_ar1, $sum_of_squared_ar2,$sum_of_xy, $upper_half, $under_half);
	$num_of_elem = @array1;
	$av1=&array_average(@array1);    $av2=&array_average(@array2);
	$sum_of_squared_ar1=${&sum_of_squared_array(\@array1)};
	$sum_of_squared_ar2=${&sum_of_squared_array(\@array2)};
	$sum_of_xy= ${&sum_x_mul_y_arrays(\@array1,\@array2)};
	#----- comment out if you do not want STDOUT of these vars. ----#
	print "Number of elem in the array for cc $num_of_elem  ", $num_of_elem,"\n";
	print "Average of array1  ", $av1, "\n";
	print "Average of array2  ", $av2,"\n";
	print "sum_of_squared_ar1 = $sum_of_squared_ar1  ", $sum_of_squared_ar1, "\n";
	print "sum_of_squared_ar2 = $sum_of_squared_ar2  ", $sum_of_squared_ar2, "\n";
	print "sum_of_xy = $sum_of_xy", $sum_of_xy, "\n";
	$upper_half=($sum_of_xy -($num_of_elem*($av1*$av2)));
	$under_half=sqrt(($sum_of_squared_ar1-($num_of_elem*($av1*$av1)))*($sum_of_squared_ar2-($num_of_elem*($av2*$av2))));
	$final_cc  = $upper_half/$under_half;
	\$final_cc;
}

#________________________________________________________________________
# Title     : sd
# Usage     : $sd=${&sd(\@array_of_numbers)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  : standard deviation, get_standard_deviation,
#             standard_deviation,
# Options   :
# Package   :
# Reference :
# Returns   : a ref. of a scaler
# Tips      :
# Argument  : array references are accepted. outputs scalar single val.
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub sd{
  my(@array)=@{$_[0]};
  my($i, $variance,$average, $deviation,$number,$sum,$standard_deviation,
	  $squared_deviation, $sum_of_squared_deviation );
  for($i=0 ; $i< @array ; $i++){ $sum=$sum+$array[$i]; }
  $average=($sum/@array);
  for($i=0 ; $i< @array ; $i++){ $deviation=($array[$i]-$average);
	 $squared_deviation=($deviation*$deviation);
	 $sum_of_squared_deviation = $sum_of_squared_deviation + $squared_deviation;  }
  $variance=($sum_of_squared_deviation/@array);
  $standard_deviation = sqrt($variance);
  return(\$standard_deviation);
}


#________________________________________________________________________
# Title     : se
# Usage     :
# Function  : gets standard error of any given array
# Example   :
# Warning   :
# Class     :
# Keywords  : standard error
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : ref. for an array.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub se{
  my(@array)=@{$_[0]};
  my($i,$j,$variance,$average);
  my($deviation,$number,$sum,$standard_deviation,$squared_deviation)=0;
  $number=@array;
  for($i=1; $i<=$number; $i++){ $sum=$sum+$array[$i];  }
  $average=($sum/$number);
  for($j=1;$j<=$number;$j++){  $deviation=($array[$i]-$average);
	 $squared_deviation=($deviation*$deviation);
	 $sum_of_squared_deviation = $sum_of_squared_deviation + $squared_deviation;  }
  $variance=($sum_of_squared_deviation/$number);
  $standard_deviation=sqrt($variance); $standard_error = $standard_deviation/(sqrt($number));
  \$standard_error;
}

#________________________________________________________________________
# Title     : remove_non_char
# Usage     : $outstring = &remove_non_char($input_string);
# Function  : removes non chars on any input string. (scaler context)
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub remove_non_char{ my($input)=${$_[0]};$input =~ s/\W//g; \$input;}


#________________________________________________________________________
# Title     : numerically
# Usage     : sort numerically (@array);
# Function  : sorts elements by nemerical size.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub numerically{  $a <=> $b;  }

#________________________________________________________________________
# Title     : abs_numerically
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub abs_numerically{ abs($a) <=> abs($b); }

#________________________________________________________________________
# Title     : rev_abs_numerically
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub rev_abs_numerically{  abs($b) <=> abs($a);  }

#___________________________________________________________________
# Title     : randomise_lines
# Usage     : To randomize th_lib.pl just type &random_lines(300,500,"th_lib.pl");
#             &random_lines(300, 50, "th_lib.pl"); <-- to get 300 lines
#                                                      from 50 numbers
# Function  :
#             outs line numbers with lines
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#---------------------------------------------------------------
sub randomise_lines{
	my($len)=$_[0];
	my($len_1)=$_[1];
	my($inputfile)=$_[2];
	srand(time()^$$);
	for ($i=1;$i<=$len;$i++){
	    $r2=int(rand($len_1));
	    push(@random, $r2);
		 $random{$i}=$random[$i];
	}
	$counter=-1;
	open(IN,"$inputfile");
	while(<IN>){
	    $counter+=1;
	    $input{$counter}=$_;
	}
	for $elem(@random){
		for $key(keys %input){
		   if ($elem == $key){
		     print $key,"\t";
		     print $input{$key};
		   }
		}
	}
}


#___________________________________________________________________
# Title     : pick_random_hash_pairs
# Usage     : %hash2 = %{&pick_random_hash_pairs(\%hash1, \$xx)};
# Function  : randomly pick any num of pairs of hash elements.
#             outs line numbers with lines
# Example   : in signature roation or FVWM rc file menu color rotation.
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   : rotate_fvwm_menu_color.pl
# Enclosed  :
#---------------------------------------------------------------
sub pick_random_hash_pairs{
  my %hash = %{$_[0]};
  my @keys = keys %hash;
  my $num_of_pick = ${$_[1]};
  my %pairs, $random_num, $i;
  srand(time()^$$);

  for($i=0; $i<$num_of_pick; $i++){
	 $random_num= int( rand( @keys ) );
	 print $random_num, "\n";
	 %pairs=(%pair, $keys[$random_num], $hash{$keys[$random_num]});
  }
  \%pairs;
}


#________________________________________________________________________
# Title     : hash_substract
# Usage     : %hash1 = %{&hash_substract(\%hash1, \%hash2)};
# Function  : removes overlapping entries in hashes.
# Example   : %hash1 = %hash1 - %hash2, ==> (4,4)=(2,2, 4,4) - (2,2)
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_substract{my(%hash1)=%{$_[0]}; my(%hash2)=%{$_[1]};
  grep($hash2{$_} && $hash1{$_} && delete $hash1{$_}, keys %hash2);
  \%hash1;
}
#________________________________________________________________________
# Title     : subtract_array
# Usage     : @subs = @{&subtract_array(\@array1, \@array2)};
# Function  : removes any occurances of certain elem. of the first
#             input array with second input array.
# Example   : Following will produce (A C);
#		@array1= qw( A B K B B C);
#  		@array2= qw( B E D);
#  		@subs = @{&subtract_array(\@array1, \@array2)};
# Warning   :
# Class     :
# Keywords  : array_subtract, substract_array
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub subtract_array{
  my($i, $j);
  my(@array1)=@{$_[0]}; my(@array2)=@{$_[1]};
  for ($i=0; $i< @array1 ; $i++){
	 for ($j=0; $j< @array2 ; $j++){
		if($array1[$i] eq $array2[$j]){
			splice(@array1, $i, 1,); $i--;
		}
	 }
  }
  \@array1;
}

#________________________________________________________________________
# Title     : hash_catenate
# Usage     : %output = %{&hash_catenate(\%hash1, \%hash2)};
# Function  : removes overlapping entries in hashes.
# Example   :
# Warning   : one bug caught.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_catenate{
  my(%hash_1)=%{$_[0]};
  my(%hash_2)=%{$_[1]};
  %hash1=(%hash_1, %hash_2);
  \%hash1;
}
#________________________________________________________________________
# Title     : merge_hash  (same as hash_catenate)
# Usage     : %output = %{&merge_hash(\%hash1, \%hash2)};
# Function  : removes overlapping entries in hashes.
# Example   :
# Warning   : one bug caught.
# Class     :
# Keywords  : merge_hash_elements,add_hash, merge two hashes.
#             merge hashes, merge_hashes.
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub merge_hash{
  my %out, $i, $j;
  for($i=0; $i< @_; $i++){
	 %{"hash$i"}=%{$_[$i]};
	 $j=$i+1;
	 %out=(%out, %{"hash$i"}, %{"hash$j"});
  }
  \%out;
}

#________________________________________________________________________
# Title     : superpose_hash
# Usage     : %output = %{superpose_hash(\%template, \%target));
# Function  : superpose hash keys and values to another hash. %target
#             is the superposing hash(new ones will have the values of
#             this target hash. For example, if you superpose
#                (1, 123, 2, 343)
#             to (1, 111, 2, 2222, 3, 3333), you will get
#                (1, 123, 2, 343,  3, 3333) as the result.
#             Template provide blank key entries.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   : correct_head_box
# Enclosed  :
#--------------------------------------------------------------------
sub superpose_hash{
  ##########################################################
	my($c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r,
	  $s, $t, $u, $v, $w, $x, $y, $z,
	  $average1, $dir, $file, $in_dir, $end_found, $entry, $entry_match,
	  $error_rate, $gap_chr, $half_win, $id_compos, $jp_file, $length, $line,
	  $name, $name_found, $name_found, $type_seq, $offset, $option_string,
	  $original_dir, $output, $out_string, $pre, $pwd, $string, $string1,
	  $sum, $sum1, $type_secon, $type_sol, $title_found, $type_DSSP,
	  $type_acc, $variable_string, $win_size,
	  @arg_output, @string, @k, @keys, @names, @out_hash,
	  @out_hash_final, @output_box, @outref, @read_files, @str1, @str2,  @string1,
	  @Tem_keys, @whole_file,
	  %correct_head_box_entry, %dummy, %Final_out, %hash, %input, %out_hash, %out_hash_final,
	  %template,   %target
	 );
  ##########################################################
	%template=%{$_[0]};
	%target  =%{$_[1]};
	my(%out_hash);
	@Tem_keys = keys %template;
	for($i=0; $i < @Tem_keys; $i ++){
		$out_hash{$Tem_keys[$i]}= $target{$Tem_keys[$i]};
	}
	\%out_hash;
}

#________________________________________________________________________
# Title     : hash_common2
# Usage     : %output = &hash_common($ref1, $ref2);
# Function  :
# Example   : %hashout= %hash1 - %hash2, ==> (4,4)=(2,2, 4,4) - (2,2)
# Warning   : NOT working
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : a ref of a hash.
# Tips      :
# Argument  : accepts only two references of hashes
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_common2 { my($h1, $h2)=@_; my(%h1)=%{$h1};  my(%h2)=%{$h2};
  my(%h3); grep(($h1{$_} eq $h2{$_}) && ($h3{$_}=$h1{$_}) , keys %h1);
  \%h3;
}

#________________________________________________________________________
# Title     : reverse_hash
# Usage     : %out=%{&reverse_hash(\%input_hash)};
# Function  : exchanges the value and key of any hashes
# Example   :
# Warning   : Takes ALIGNED sequences.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more hash ref.
# Tips      :
# Argument  : one or more hash ref.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub reverse_hash{
  my(@out_hash_ref, %reverse);
  for($i=0; $i<@_; $i++){
	  if(ref($_[$i])  eq 'HASH'){
		  my(%input)=%{$_[$i]};
		  my($key, $val);
		  while (($key,$val) = each %input) {
		     $reverse{$val} = $key;
		  }
		  push(@out_hash_ref, \%reverse);
	  }else{
	     print "\n reverse_hash accepts only hash ref. in $0\n";
		  print chr(7); exit;
	  }
  }
  if(@out_hash_ref ==1){ $out_hash_ref[0];}elsif(@out_hash_ref >1){@out_hash_ref;}
}

#________________________________________________________________________
# Title     : hash_common
# Usage     : %hash1_value = %{&hash_common(\%hash1, \%hash2,...)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : the VALUES OF THE FIRST HASH which occur in later hashes
#             are returned
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_common{
  my(%common)=();
  for($i=0; $i< @_; $i++){  my(%common2)=();
	  if( !(defined(%common) )){ %common=%{$_[$i]}; next;}
	  elsif(defined(%common)){ %h1=%{$_[$i]};
		 for(keys %common){ $common2{$_}=$common{$_} if (defined $h1{$_});}
	  %common=%common2;}  }
  \%common;
}
#________________________________________________________________________
# Title     : hash_common_by_keys
# Usage     : %hash1_value = %{&hash_common_by_keys(\%hash1, \%hash2,...)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : the VALUES OF THE FIRST HASH which occur in later hashes
#             are returned
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_common_by_keys{  my(%common)=();
  for($i=0; $i< @_; $i++){  my(%common2)=();
	  if( !(defined(%common) )){ %common=%{$_[$i]}; next;}
	  elsif(defined(%common)){ %h1=%{$_[$i]};
		 for(keys %common){ $common2{$_}=$common{$_} if (defined $h1{$_});}
	  %common=%common2;}
	  undef(%common2);  }
  \%common;
}

#________________________________________________________________________
# Title     : get_common_hash_keys
# Usage     : @output_array_of_keys = @{&get_common_hash_keys(\%hash1, \%hash2)};
# Function  : gets the common hash keys of two hashes.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_common_hash_keys{@array1 = keys %{$_[0]}; @array2 = keys %{$_[1]};
  grep($common{$_}++, @array1); @common_keys=grep($common{$_}, @array2);
  \@common_keys;
}


#________________________________________________________________________
# Title     : hash_no_common
# Usage     : %output = &hash_catenate(*hash1, *hash2);
# Function  : removes overlapping entries in hashes.
# Example   : %hashout= %hash1 - %hash2, ==> (4,4)=(2,2, 4,4) - (2,2)
# Warning   : surely working, This grep version is faster than for and defined loop.
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub hash_no_common{ local(*h1, *h2)=@_;
  grep(($h1{$_} eq $h2{$_}) && delete $h1{$_} && delete $h2{$_},  keys %h1);
  local(%h_no_com) = (%h1, %h2);
}

#________________________________________________________________________
# Title     : beep
# Usage     : &beep;
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub beep{  print chr(7);  }

#________________________________________________________________________
# Title     : capitalize_word.pl
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  : capitalise word,  capitalise_word
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : jeffg@ptp.hp.com (Jeff Gruszynski)
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub capitalize_word{
	my($sentence, $tmp);
	if(ref($_[0])){
		$sentence=${$_[0]};
	}else{ $sentence=$_[0]; }
	$sentence =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
	\$sentence;
}
#________________________________________________________________________
# Title     : capitalize_sentence.pl
# Usage     :
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : jeffg@ptp.hp.com (Jeff Gruszynski)
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub capitalize_sentence{
	my($sentence, $tmp);
	if(ref($_[0])){
		$sentence=${$_[0]};
	}else{ $sentence=$_[0]; }
	$sentence =~ s#^\S|\s(\S)#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#ge;
	\$sentence;
}

#________________________________________________________________________
# Title     : chop_word_recursively
# Usage     : @new_lines=chop_word_recursively(\@lines, '/'); or
#             @new_lines=chop_word_recursively(\@lines, '\W'); or
#             @new_lines=chop_word_recursively(\@lines, 'a-zA-Z'); or
#             @new_lines=chop_word_recursively(\@lines, '/', 2); <--- for multiple chop unit
#             or $new_line = chop_word_recursively(\$line, '.'); <--- for scalar input.
# Function  : chop lines word by word. This needs delimiter like '/' or '.'
#             and stores the resulting arrays. This is to get all the possible
#             directories.
#             For example, with /nfs/A Biomatic /perl/temp/here  input, you get
#             (  /nfs/A Biomatic /perl/temp,
#                /nfs/A Biomatic ,
#                /nfs,  )  in an array.
# Example   : @new_lines=chop_word_recursively(\@lines, '/-', 2); to chop off lines two words
#             with the two delimiters of '/' and '-'.
#             /jong1/perl-jong2/perl-jong3  will become   /jong1/perl-A Biomatic 2
#              /bin/-kkk/-jjj/-jj will become  /jong1/perl-A Biomatic 2 by
#             @out=@{&chop_word_recursively($testline, '/-', 2)};
#             You can use perl regexp patterns for  $delimiter as it is directly
#              used in a pattern matching in the sub. So, you canuse '\W'
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : SCALAR or ARRAY refs. and delimitor ('/', '.', '-'.....)
#             delimitor can be multi line => '#$%/=.'
#             default delimiter is space ' ';
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub chop_word_recursively{
  my(@in)=@_; my($i, @input_lines, $delimiter, @chopped_line, @output_lines);
  my($multi_chop)=1; ### default is 1 (one word chopping)
  for($i=0; $i < @in; $i++){
	 if(ref($in[$i]) eq 'ARRAY'){
		 push(@input_lines, @{$in[$i]}); }
	 elsif(ref($in[$i]) eq 'SCALAR'){
		 if( length(${$in[$i]}) > 2 ){
			 push(@input_lines, ${$in[$i]}); }
		 elsif( ${$in[$i]} =~ /^\W+$/ ){
			 $delimiter .= ${$in[$i]};  }
		 elsif( ${$in[$i]} =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= ${$in[$i]};  }   }
	 elsif( !ref($in[$i]) ){
		 if( length($in[$i]) > 2 ){
			 push(@input_lines, $in[$i]); }
		 elsif( $in[$i] =~/^\W+$/ ){
			 $delimiter .= $in[$i];  }
		 elsif( $in[$i] =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= $in[$i];  }   }
  }

  if( $delimiter =~/^$/ ){ $delimiter = ' '; }  ## default delimiter is space
  for($i=0; $i<@input_lines; $i++){
	  @chopped_line = split(/([$delimiter]+)/, $input_lines[$i]);
	  while(@chopped_line > 1){
		  splice(@chopped_line, @chopped_line-$multi_chop*2 );
		  push(@output_lines, join("$1", @chopped_line) );
	  }
  }
  \@output_lines;
}
#________________________________________________________________________
# Title     : shift_word_recursively
# Usage     : @new_lines=shift_word_recursively(\@lines, '/'); or
#             @new_lines=shift_word_recursively(\@lines, '\W'); or
#             @new_lines=shift_word_recursively(\@lines, 'a-zA-Z'); or
#             @new_lines=shift_word_recursively(\@lines, '/', 2); <--- for multiple chop unit
#             or $new_line = shift_word_recursively(\$line, '.'); <--- for scalar input.
# Function  : shift lines word by word. This needs delimiter like '/' or '.'
#             and stores the resulting arrays. This is to get all the possible
#             directories.
#             For example, with /nfs/A Biomatic /perl/temp/here  input, you get
#             (  /A Biomatic /perl/temp/here,   /perl/temp/here ,
#             temp/here, /here, )  in an array.
#
# Example   : @new_lines=shift_word_recursively(\@lines, '/-', 2); to chop lines
#             off two words with the two delimiters of '/' and '-'.
#             /jong1/perl-jong2/perl-jong3  will become   /perl-jong2/perl-A Biomatic 3
#             /bin/-kkk/-jjj/-jj will become  /-kkk/-jjj/-jj
#             @out=@{&shift_word_recursively($testline, '/-', 2)};
#             You can use perl regexp patterns for  $delimiter as it is directly
#             used in a pattern matching in the sub. So, you canuse '\W'
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  : SCALAR or ARRAY refs. and delimitor ('/', '.', '-'.....)
#             delimitor can be multi line => '#$%/=.'
#             default delimiter is space ' ';
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub shift_word_recursively{
  my(@in)=@_; my($i, @input_lines, $delimiter, @chopped_line, @output_lines);
  my($multi_chop)=1; ### default is 1 (one word chopping)
  for($i=0; $i < @in; $i++){
	 if(ref($in[$i]) eq 'ARRAY'){
		 push(@input_lines, @{$in[$i]}); }
	 elsif(ref($in[$i]) eq 'SCALAR'){
		 if( length(${$in[$i]}) > 2 ){
			 push(@input_lines, ${$in[$i]}); }
		 elsif( ${$in[$i]} =~ /^\W+$/ ){
			 $delimiter .= ${$in[$i]};  }
		 elsif( ${$in[$i]} =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= ${$in[$i]};  }    }
	 elsif( !ref($in[$i]) ){
		 if( length($in[$i]) > 2 ){
			 push(@input_lines, $in[$i]); }
		 elsif( $in[$i] =~/^\W+$/ ){
			 $delimiter .= $in[$i];  }
		 elsif( $in[$i] =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= $in[$i];  }
	 }
  }

  if( $delimiter =~/^$/ ){ $delimiter = ' '; }  ## default delimiter is space
  for($i=0; $i<@input_lines; $i++){
	  @chopped_line = split(/([$delimiter]+)/, $input_lines[$i]);
	  while(@chopped_line > 1){
		  splice(@chopped_line, 1, $multi_chop*2 );
		  push(@output_lines, join("$1", @chopped_line) );
	  }
  }
  \@output_lines;
}
#________________________________________________________________________
# Title     : shift_word
# Usage     : @new_lines=shift_word(\@lines, '/'); or
#             @new_lines=shift_word(\@lines, '\W'); or
#             @new_lines=shift_word(\@lines, 'a-zA-Z'); or
#             @new_lines=shift_word(\@lines, '/', 2); <--- for multiple chop unit
#             or $new_line = shift_word(\$line, '.'); <--- for scalar input.
# Function  : shift lines word by word. This needs delimiter like '/' or '.'
# Example   : @new_lines=shift_word(\@lines, '/-', 2); to shift off lines two words
#             with the two delimiters of '/' and '-'.
#             /jong1/perl-jong2/perl-jong3  will become   /jong1/perl-A Biomatic 2
#             /bin/-kkk/-jjj/-jj will become  /jong1/perl-A Biomatic 2 by
#             @out=@{&shift_word($testline, '/-', 2)};
#             You can use perl regexp patterns for  $delimiter as it is directly
#             used in a pattern matching in the sub. So, you canuse '\W'
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  : SCALAR or ARRAY refs. and delimitor ('/', '.', '-'.....)
#             delimitor can be multi line => '#$%/=.'
#             default delimiter is space ' ';
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub shift_word{
  my(@in)=@_; my($i, @input_lines, $delimiter, @chopped_line, @output_lines);
  my($multi_chop)=1; ### default is 1 (one word chopping)
  for($i=0; $i < @in; $i++){
	 if(ref($in[$i]) eq 'ARRAY'){
		 push(@input_lines, @{$in[$i]}); }
	 elsif(ref($in[$i]) eq 'SCALAR'){
		 if( length(${$in[$i]}) > 3 ){
			 push(@input_lines, ${$in[$i]}); }
		 elsif( ${$in[$i]} =~ /^\W+$/ ){
			 $delimiter .= ${$in[$i]};  }
		 elsif( ${$in[$i]} =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= ${$in[$i]};  }
	 }
	 elsif( !ref($in[$i]) ){
		 if( length($in[$i]) > 3 ){
			 push(@input_lines, $in[$i]); }
		 elsif( $in[$i] =~/^\W+$/ ){
			 $delimiter .= $in[$i];  }
		 elsif( $in[$i] =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= $in[$i];  }    }
  }
  if( $delimiter =~/^$/ ){ $delimiter = ' '; }  ## default delimiter is space
  for($i=0; $i<@input_lines; $i++){
	  @chopped_line = split(/([$delimiter]+)/, $input_lines[$i]);
	  splice(@chopped_line, 1, $multi_chop*2 );  ## *2 is essential.
	  push(@output_lines, join("$1", @chopped_line) );
  }
  \@output_lines;
}
#________________________________________________________________________
# Title     : chop_word
# Usage     : @new_lines=chop_word(\@lines, '/'); or
#             @new_lines=chop_word(\@lines, '\W'); or
#             @new_lines=chop_word(\@lines, 'a-zA-Z'); or
#             @new_lines=chop_word(\@lines, '/', 2); <--- for multiple chop unit
#             or $new_line = chop_word(\$line, '.'); <--- for scalar input.
# Function  : chop lines word by word. This needs delimiter like '/' or '.'
# Example   : @new_lines=chop_word(\@lines, '/-', 2); to chop off lines two words
#             with the two delimiters of '/' and '-'.
#             /jong1/perl-jong2/perl-jong3  will become   /jong1/perl-A Biomatic 2
#             /bin/-kkk/-jjj/-jj will become  /jong1/perl-A Biomatic 2 by
#             @out=@{&chop_word($testline, '/-', 2)};
#             You can use perl regexp patterns for  $delimiter as it is directly
#             used in a pattern matching in the sub. So, you canuse '\W'
# Warning   : The returning value is not the chopped off word.
# Class     :
# Keywords  :
# Options   : -w, w, Word, etc,  for getting the chopped off word(s) rather
#             than the original lines minus the word.
# Package   : File_Utils
# Reference :
# Returns   :
# Tips      :
# Argument  : SCALAR or ARRAY refs. and delimitor ('/', '.', '-'.....)
#             delimitor can be multi line => '#$%/=.'
#             default delimiter is space ' ';
# Todo      :
# Author    : A Biomatic
# Version   : 2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub chop_word{
  my(@in)=@_;
  my($i, @input_lines, $delimiter, @chopped_line, @output,
	  @chopped_word_list, $get_chopped_word_option);
  my($multi_chop)=1; ### default is 1 (one word chopping)
  for($i=0; $i < @in; $i++){
	 if(ref($in[$i]) eq 'ARRAY'){
		 push(@input_lines, @{$in[$i]}); }
	 elsif(ref($in[$i]) eq 'SCALAR'){
		 if( length(${$in[$i]}) > 3 ){  ### the delimiter can be upto 3 chars by
			 push(@input_lines, ${$in[$i]}); }  ## one arg input.
		 elsif( ${$in[$i]} =~ /^\W+$/ ){
			 $delimiter .= ${$in[$i]};  }
		 elsif( ${$in[$i]} =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( ${$in[$i]} =~/^\-?[wW][ord]*$/ ){  ## for -w option
			 $get_chopped_word_option = 1;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= ${$in[$i]};  }
	 }
	 elsif( !ref($in[$i]) ){
		 if( length($in[$i]) > 3 ){
			 push(@input_lines, $in[$i]); }
		 elsif( $in[$i] =~/^\W+$/ ){
			 $delimiter .= $in[$i];  }
		 elsif( $in[$i] =~/^\d$/ ){
			 $multi_chop = $&;  }
		 elsif( $in[$i] =~ /^\-?[wW][ord]*$/ ){  ## for -w option
			 $get_chopped_word_option = 1;  }
		 elsif( length(${$in[$i]}) < 4 ){
			 $delimiter .= $in[$i];  }
	 }
  }
  if( $delimiter =~/^$/ ){ $delimiter = ' '; }  ## default delimiter is space

  if($get_chopped_word_option == 1){
	  for($i=0; $i< @input_lines; $i++){
		  @chopped_line = split(/([$delimiter]+)/, $input_lines[$i]);
		  push(@output, $chopped_line[$#chopped_line] );
	  }  }
  else{  ## when original lines minus the chopped word are wanted.(default).
	  for($i=0; $i<@input_lines; $i++){
		  @chopped_line = split(/([$delimiter]+)/, $input_lines[$i]);
		  splice(@chopped_line, @chopped_line-$multi_chop*2 );
		  push(@output, join("$1", @chopped_line) );
	  }
  }
  if(@output == 1){ return($output[0]);
  }elsif(  @output > 1 ){ return(@output); }
}

#________________________________________________________________________
# Title     : get_median
# Usage     : $median = ${&get_median(\@array)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :  median_array, get_median_array, get_array_median, array_median
# Options   :
# Package   : Calc_Util
# Reference :
# Returns   : \$median
# Tips      :
# Argument  : \@array
# Todo      :
# Author    : Ian Philips, A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_median{
  my(@array)=@{$_[0]};
  $median=( sort { $a <=> $b } @array )[ @array/2 ];
  \$median;
}


#________________________________________________________________________
# Title     : array_median
# Usage     : $median = ${&array_median(\@array)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :  median_array, get_median_array, get_array_median, array_median
# Options   :
# Package   : Calc_Util
# Reference :
# Returns   : \$median
# Tips      :
# Argument  : \@array
# Todo      :
# Author    : Ian Philips, A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub array_median{
  my(@array)=@{$_[0]};
  my $median=( sort { $a <=> $b } @array )[ @array/2 ];
  \$median;
}

#________________________________________________________________________
# Title     : get_median
# Usage     : $median = ${&get_median(\@array)};
# Function  :
# Example   :
# Warning   :
# Class     :
# Keywords  :  median_array, get_median_array, get_array_median, array_median
# Options   :
# Package   : Calc_Util
# Reference :
# Returns   : \$median
# Tips      :
# Argument  : \@array
# Todo      :
# Author    : Ian Philips, A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_median{
  my(@array)=@{$_[0]};
  $median=( sort { $a <=> $b } @array )[ @array/2 ];
  \$median;
}



#________________________________________________________________________
# Title     : push_if_not_already
# Usage     : @out=@{&push_if_not_already(@mother_array, @adding_array )};
#             @out=@{&push_if_not_already(@mother_array, $adding_scalar)};
# Function  : returns ref. of an array for a list of non-repetitive entry.
# Example   :
# Warning   :
# Class     : Utility
# Keywords  :
# Options   :
# Package   : Bio
# Reference :
# Returns   : a ref. of an array.
# Tips      :
# Argument  : two references. The first should be an array ref. The 2nd can be either
#             scalar or array reference.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub push_if_not_already{
	my($already_in, $already, $i, @push_items_given);
	my(@out_array)=@{$_[0]};
	push(@push_items_given, ${$_[1]}) if(ref($_[1]) eq 'SCALAR');
	@push_items_given=@{$_[1]} if(ref($_[1]) eq 'ARRAY');
	for $already (@out_array){  ## This for is to remove repetitive
	  for ($i=0; $i< @push_items_given; $i++){
		 if($already eq $push_items_given[$i]){ splice(@push_items_given,$i); }
	  }
	}
	push(@out_array,@push_items_given); \@out_array;
}

#________________________________________________________________________
# Title     : replace_lines
# Usage     : &replace_lines(@files, 'removing_string', 'match_str' );
# Function  : replace_lines in any txt files
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub replace_lines{ my(@in)=@_; my($i, $file, @lines);
	my($replacing_lines     ) = pop(@in);
	my($matching_line_string) = pop(@in) unless (-f $in[$#in]);
	print "\n $matching_line_string";
	for $file (@in){
	  open(FILE, "$file");
	  @lines=<FILE>;
	  for($i=0; $i <@lines; $i++){
		  if($lines[$i]=~/$matching_line_string/){ print "\n;lkjasljf \n";
			  $lines[$i]="$replacing_lines\n";
		  }
	  }
	  open(NEW_FILE, ">$file");
	  print NEW_FILE @lines;
	}
}


#________________________________________________________________________
# Title     : insert_lines_anywhere
# Usage     : &insert_lines_anywhere(\@files, \$inst_str,'after', \@match_str);
# Function  : insert lines anywhere in any txt files
# Example   :
# Warning   : Case Insensitive by default.
# Class     :
# Keywords  : insert_text, insert_lines, insert_something
# Options   : 'after'  only two options exactly in the middle of two strings.
#             'before'
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    :
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub insert_lines_anywhere{
	my(@in)=@{$_[0]};
	my $new_lines=${$_[1]};
	my($option_string)=$_[2];
	my(@match_patterns)=@{$_[3]};

	for $file (@in){
	  open(FILE, "$file");
	  @lines=<FILE>;
	  if($option_string =~/[Aa]fter/){
		  for($i=0; $i <@lines; $i++){
			  for($j=0; $j< @match_patterns; $j++){
			     if(($lines[$i]=~/$match_patterns[$j]/)&&
			     ($lines[$i+1] !~ /$inserting_lines/i)){
					  $lines[$i]=$lines[$i]."$new_lines\n";
					  $last;
				  }
			  }
		  }
	  }
	  elsif( $option_string =~/[Bb]efore/){
		  for($i=@lines; $i > -1; $i--){
			  for($j=0; $j< @match_patterns; $j++){
	 			  if(($lines[$i]=~/$match_patterns[$j]/)&&
	   		  ($lines[$i-1] !~ /$inserting_lines/i)){
		   		  $lines[$i]="$new_lines".$lines[$i];
		   		  last;
			     }
			  }
		  }
	  }
	  open(NEW_FILE, ">$file");
	  print NEW_FILE @lines;
	}
}




#________________________________________________________________________
# Title     : get_all_dirs_from_ENV
# Usage     : my(@default_env_dirs) = @{&get_all_dirs_from_ENV};
# Function  : extracts all the directories from %ENV  setting.
# Example   : my(@default_env_dirs) = @{&get_all_dirs_from_ENV}; in handle_arguments
# Warning   : produces repetitive pathes (ie, can output identical path several times)
# Class     :
# Keywords  :
# Options   : None
# Package   : Jong_Util
# Reference :
# Returns   : a ref. of an array of directories.
# Tips      : Used to find files in the path
# Argument  : NONE
# Todo      :
# Author    : Jong
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_all_dirs_from_ENV{  my($each_dir, $i, @default_env_dirs);
	  my($pwd)=`pwd`; chomp($pwd); unshift(@default_env_dirs, $pwd);
	  push(@default_env_dirs,  split(/:/, join(":", (values %ENV)) ));
	  for ($i=0; $i < @default_env_dirs; $i++){
		  $each_dir=$default_env_dirs[$i];
		  $each_dir =~ s/^\.$//;
		  unless( -d $each_dir ){
			 splice(@default_env_dirs, $i, 1); $i--; next; }  ## remove if it is not a directory.
		  elsif( (-d $each_dir) && ($each_dir=~/\/$/) ){
			 chop($each_dir);  }  ## removing all the last back slash in  .../xxx/
	  }
	  @default_env_dirs=@{&remove_dup_in_array(\@default_env_dirs)};
	  \@default_env_dirs;
}


#________________________________________________________________________
# Title     : get_path_dirs_from_ENV
# Usage     : my(@default_env_dirs) = @{&get_path_dirs_from_ENV};
# Function  : extracts path directories from %ENV  setting.
# Example   : my(@default_env_dirs) = @{&get_path_dirs_from_ENV}; in handle_arguments
# Warning   : Replaces '.' to $pwd.
# Class     :
# Keywords  :
# Options   : None
# Package   : Jong_Util
# Reference :
# Returns   : a ref. of an array of directories.
# Tips      : Used to find files in the path
# Argument  : NONE
# Todo      :
# Author    : Jong
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_path_dirs_from_ENV{  my($each_dir, $i, @default_path_dirs);
	  my($pwd)=`pwd`; chomp($pwd);

	  if(defined($ENV{'path'}) )   {  ## if 'path' is used,
		  push(@default_path_dirs, $pwd, split(/:/, $ENV{'path'}) ) }
	  elsif(defined($ENV{'PATH'}) ){  ## if 'PATH' is used,
		  push(@default_path_dirs, $pwd, split(/:/, $ENV{'PATH'})) }
	  elsif(defined($ENV{'Path'}) ){  ## if 'Path' is used,
		  push(@default_path_dirs, $pwd, split(/:/, $ENV{'PATH'})) }

	  for ($i=0; $i < @default_path_dirs; $i++){
		  $each_dir=$default_path_dirs[$i];
		  $each_dir =~ s/^\.$//;
		  unless( -d $each_dir ){
			 splice(@default_path_dirs, $i, 1); $i--; next; }  ## remove if it is not a directory.
		  elsif( (-e $each_dir) && ($each_dir=~/\/$/) ){
			 chop($each_dir);  }  ## removing all the last back slash in  .../xxx/
	  }
	  @default_env_dirs=@{&remove_dup_in_array(\@default_env_dirs)};
	  \@default_env_dirs;
}


#________________________________________________________________________
# Title     : handle_arguments_old
# Usage     : my(@in)=&handle_arguments_old(\@input_args);   Do not dereference it.
# Function  : Sub argument handling for opening files with options. General
#             form of 'handle_arguments_xxxx', while xxxx can be files, hashes, arrays,,,,
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   : None yet, extendable by adding refs. of something.
# Package   :
# Reference :
# Returns   : an array of refs for file names, hashes, arrays and  the opion string
# Tips      :
# Argument  : one single ref. (\@input_args);
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub handle_arguments_old{
  my($i, @in, @out, $k, @names, $chain, $n  );
  my($real_file, $s, @out_hash_ref_list);
  my(@input_options);
  my($default_option_string)='ETSIBHG'; # This is the string for the default option chars.
  my($full_option_string)='ETSIBHGR'; # This is the string of all the option chars.
  my($match_option);  # <-- This is for option handling at prompt. If you put -e -h at
							 #    the prompt, you will have $match_option value of 'EH' to match
  my(@extension_db)=('sst','msf','fasta','jp','fas','aln','brk','pdb', 'rms',
							'dssp', 'hssp', 'fssp', 'phd', 'ent','slx','fa');

  ##########################################
  ##  Getting just directories from ENV   ##
  ##########################################
  my(@default_env_dirs) = @{&get_all_dirs_from_ENV};
  my($pwd)=`pwd`; chomp($pwd);  # This is necessary for full path '$real_file' var.

  if(ref($_[0])){  @in=@{$_[0]}; }elsif(!ref($_[0])){ @in=@_; }

  for($k=0; $k< @in ;$k++){  my($file_found);
	  #######################
	  ##   If it is ref.   ##
	  #######################
	  if( ref($in[$k]) ){
		  if( ref($in[$k]) eq 'SCALAR' ){
			  if ((-f ${$in[$k]})&&(${$in[$k]}=! /\//) ){
					push( @out, \"$pwd\/${$in[$k]}" ); $file_found=1; last; }  # push as a ref.
			  elsif ((-f ${$in[$k]})&&(${$in[$k]}=~ /\//) ){
					push( @out, \"${$in[$k]}" ); $file_found=1; next; }
			  for $ENV_dir (@default_env_dirs){
					 if (-f "$ENV_dir\/${$in[$k]}"){
						 push(@out, \"$ENV_dir\/${$in[$k]}"); $file_found=1; last ;
					 }
			  }
			  if($file_found != 1){ my($ext, $ENV_dir);
				  for $ENV_dir (@default_env_dirs){
					 for $ext (@extension_db){
						 if (-f "$ENV_dir\/${$in[$k]}\.$ext"){
							 push(@out, \"$ENV_dir\/${$in[$k]}\.$ext" ); $file_found=1; last ;  }
					 }
				  }
			  }
		  }
		  elsif( ref($in[$k]) eq 'HASH'  ){ push(@out, $in[$k]);   }
		  elsif( ref($in[$k]) eq 'ARRAY' ){ push(@out, $in[$k]);   }
		  ########################################################################
		  ############  Following is to get option strings              ##########
		  ########################################################################
		  elsif( (ref($in[$k]) eq 'SCALAR') && (length(${$_[$k]}) < 4 )){
			  if(${$in[$k]}=~ /^([\w]+)$/){  ## <-- Adding options to a one string vAR.
				  my($opt)=$1; $opt=~tr/a-z/A-Z/; $match_option  .= $opt; next;
			  }
		  }
	  }
	  #######################
	  ##  If it is no ref. ##
	  #######################
	  elsif( !ref($in[$k]) ){  my($file_found);
			if( (-f $in[$k])&&($in[$k] =!/\//) ){
				 push( @out, \"$pwd\/$in[$k]" ); next; }
			elsif( (-f $in[$k])&&($in[$k] =~/\//) ){
				 push( @out, \"$in[$k]" );  next; }
			for $ENV_dir (@default_env_dirs){
				 if (-f "$ENV_dir\/$in[$k]"){
					push(@out, \"$ENV_dir\/$in[$k]"); $file_found=1; last ;
				 }
			}
			if($file_found != 1){ my($ext, $ENV_dir);
			  X2: for $ENV_dir (@default_env_dirs){
					  for $ext (@extension_db){
						  if (-f "$ENV_dir\/$in[$k]\.$ext"){
							 push(@out, \"$ENV_dir\/$in[$k]\.$ext" ); $file_found=1; last X2;  }
					  }
					}
			}
			elsif( length($in[$k]) < 4 ){   # <<-- number 3 limits the option char size.
			  if($in[$k]=~ /^([\w]+)$/){ ## <-- Adding options to a one string vAR.
				 local($opt)=$1; $opt=~tr/a-z/A-Z/; $match_option  .= $opt; next;
			  }
			}
	  }
  } ## <<-- End of for loop
  if($match_option =~ /^$/){
	  $match_option = $default_option_string;  } # <<-- When there is no options given, use full options.
  return(@out, $match_option); # The last elem. is the option string
}


#________________________________________________________________________
# Title     : cp
# Usage     : &cp( \$srcFile, \$dstFile); or  &cp( $srcFile, $dstFile);
#             or &cp(FILEHANDLE1, FILEHANDLE2),  or  &cp(FILEHANDLE1, $output)
# Function  : copies files fast, replacement of 'system("cp xxx xxxx"); '
# Example   : cp("cp.pl", *STDOUT);  # This will print cp.pl contents to your screen.
# Class     : File
# Keywords  : copy files fast.
# Options   :
# Package   : File
# Reference :
# Returns   :
# Tips      :
# Argument  : 2 references of file name or  2 file names.
# Todo      :
# Author    : originally by Larry Wall
# Version   : 1.3
# Used in   : bio_lib.pl
# Warning   : 27 times slower than 'cp' at prompt.  using system is 32 times slower
# Enclosed  :
#--------------------------------------------------------------------
sub cp{
  croak(" Usage: cp ($file1, $file2)" ) unless(@_ >= 2);

  my($in)=$_[0];
  my($out)=$_[1];

  if( (ref($in) eq 'GLOB') || (ref($in) eq 'FileHandle')){
	  *IN_CP = *$in; }  ## for  \*STDOUT like input
  elsif( ref(\$in) eq 'GLOB'){
	  *IN_CP = $in;  }
  else{ open(IN_CP, "<$in") or die "Can't open output $in: $!\n";  }

  if( (ref($out) eq 'GLOB') || (ref($_[1]) eq 'FileHandle')){
	  *OUT_CP = *$out;   }
  elsif( ref(\$out) eq 'GLOB'){  print "\n2\n";
	  *OUT_CP = $out;  ## for  *STDOUT like input
  }else{  open(OUT_CP, ">$out") or die "Can't open output $out: $!\n";  }

  my ($access,$mod) = (stat IN_CP)[8,9];
  syswrite(OUT_CP, $buf, $len) while $len = sysread(IN_CP, $buf, 8192);
  close IN_CP;
  close OUT_CP;
  utime $access, $mod, $dstFile;
}


#________________________________________________________________________
# Title     : wh
# Usage     :
# Function  : shows the path for a file you want
#             similar to which in UNIX
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
for $file (@ARGV){
  for $dir (split(/:/, $ENV{PATH})){
	 -e ($path="$dir/$file") && print "$path\n";
  }
}

#________________________________________________________________________
# Title     : condense_script
# Usage     : condense_script.pl  xxxxxx.pl
# Function  : makes compact size subroutines of developed perl codes
# Example   : condense_script.pl th_lib.pl th-test.pl xxx xxxx ....
# Warning   : The only condition is that you need to have 'sub xxxxx' from the
#             first column and the last '}' should be again at the first column
#             This is due to the pattern matching for any sub routines.
# Class     :
# Keywords  :
# Options   : None
# Package   :
# Reference :
# Returns   : xxxxxx.pl.out  but sub routines condensed.
# Tips      : This strips off comments for the moment.
# Argument  : one or more files.
# Todo      :
# Author    :
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub condense_script{ my($k, $f, @in, $file, $outfile, $format_found);
  my($sub_contents, $sub_found); $sub_found=0; $format_found=0;
  for($k =0; $k < @_; $k++){
	 if(ref($_[$k]) eq 'ARRAY'){
		 @in = @{$_[$k]};
	 }
  }
  for $f (@in){
	 open(FILE, "$f");
	 $outfile = "$f"."\.exe";
	 open(FILE_OUT, ">$outfile"); $|=1;
	 while(<FILE>){
		if(/^#!\//){ print FILE_OUT "$_"; next;}
		if(/^\#/){ next; }
		if(/^[\s]*$/){ next; }
		#$_ =~ s/(.+)\#.*$/$1/g;
		if(/^format +[\w]* *\=/){ $format_found =1; $_="\n$_"; }
		if(/^\.[\#.]*$/){ $format_found =0; $_="$_\n";}
		if( (/^\} *$/) || (/^\} *\#.*/) ){
		  chomp($_);
		  print FILE_OUT "$sub_contents\}";
		  $sub_found =0; $sub_contents =''; next;}
		if(/^sub +(\w+) *\{/){
		  $_ =~s/[ ]+$//;
		  $sub_contents .= $_;
		  $sub_found=1; next;}
		if($sub_found == 0){
		  print FILE_OUT "$_"; next;  }
		if($sub_found==1){
		  if($format_found == 0){
			 #chomp($_);
			 $_ =~s/^[ ]+//g;
			 $_ =~s/[ ]+$//g;
			 #$_ =~s/(\W)\s+(\W)/$1$2/g;
			 #$_ =~s/\s*(\{)\s*/$1/g ;
			 #$_ =~s/(\})[\s]*$/$1/g;
			 $_ =~s/[\s]*(\})/$1/g;
			 $_ =~s/\t//g;
		  }
		  $sub_contents .= $_; next;
		}
	 }
  }
}

#________________________________________________________________________
# Title     : initialize_code   28/11/1995, jong, /nfs/ind5/A Biomatic /Perl/Utils
# Usage     : &initialze_code;
# Function  : initialize all developing codes by putting Header section infor
# Example   :
# Warning   : This writes over the program you run (itself). temp file is ini_code.temp
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : None
# Tips      :
# Argument  : None
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub initialize_code{
  my($user)=getlogin();      my($perl_version) = "Perl$]";
  my($date)=${&get_time(time)};    my($pwd)=`pwd`;   chomp($date, $pwd);
  my($i, @header, @whole_prog, $sepa_line,$date_line,$auth_line);
  my($head_found)=0;
  $sepa_line1 = "#"."_"x88;
  $sepa_line2 = "#"."-"x88;
  $| =1;  ## <<--  no buffer
  my(@head)=( "$sepa_line1\n",
				  "\# Title    : $0  by $pwd, Last Mod: $date\n",    	# 1
				  "\# Function : \n",                     			# 2
				  "\# Usage    : $0 @ARGV\n",            	 		# 3
				  "\# Argument : @ARGV\n",                			# 4
				  "\# Example  : \n",                     			# 5
				  "\# Argument : \n",                     			# 6
				  "\# Returns  : \n",                     			# 7
				  "\# Options  : \n",                     			# 8
				  "\# Tips     : \n",                     			# 9
				  "\# Author   : by $user\n",             			# 10
# Version  :
# Package  :
				  "\# Warning  : $perl_version\n",        			# 11
				  "$sepa_line2\n",    );

  open(SELF, "<$0");
  @whole_prog = <SELF>;

  for ($i=1; $i < @whole_prog; $i++){
	  if( ($whole_prog[$i]=~ /^#_+$/)&&($whole_prog[$i+1] =~ /^(# +[Tt]itle +: *)([\w\.\-]+pl) +/) ){
	  ###############################################################
		  $head_found =1;
		  if($0 == $2){
			  $whole_prog[$i+1] ="$1$0 , $pwd, Last Mod: $date\n"; $i++; next;  } }
	  ###############################################################
	  elsif( ($whole_prog[$i]=~ /^#_+$/)&&($whole_prog[$i+1] =~ /^(# +[Tt]itle +: *)$/) ){
		  $whole_prog[$i+1] ="$1$0 , $pwd, Last Mod $date\n"; $i++; next; }
	  ###############################################################
	  elsif(($whole_prog[$i]=~ /^#_+$/) &&
			  ($whole_prog[$i+1] =~/^(# +[Tt]itle +[:] *[\w\-\.]+ *[Last Mod:]* +[\d+\/\d+\/\d+], +\w+)/)){
		  $i++; next;    }   # <-- when the date is in 11/11/95 format,
	  elsif(($whole_prog[$i]=~ /^#_+$/) &&
			  ($whole_prog[$i+1] =~/^(# +[Tt]itle +[:] *[\w\-\.]+ *[Last Mod:]* +[\d+\-\w+\-\d+], +\w+)/)){
		  $i++; next;    }   # <-- when the date is in 1-Nov-1995 format,
	  elsif(($whole_prog[$i]=~ /^#_+$/) &&                   # Nov30 4:39 1995
			  ($whole_prog[$i+1] =~/^# +[Tt]itle +[:] *[\w\-\.]+ *[Last Mod:]* +[\w+\d+ +\d+:\d+ +\d+]/)){
		  $i++; next;    }   # <-- when the date is in Nov30 4:39 1995 format,
	  ###############################################################
	  elsif( $whole_prog[$i] =~ /^# +[Uu]sage +[:] +$/ ){
		  $whole_prog[$i] = "# Usage    : $0 @ARGV\n"; next;    }
	  ###############################################################
	  elsif( ($head_found==1)&&($whole_prog[$i]=~ /^# +[Ww]arning +:/) &&
				($whole_prog[$i+1] =~ /^#\-+$/) ){  $head_found=2; last; } }
	  ###############################################################

  #####################
  ###  Final writing ##
  #####################
  if(   $head_found ==2 ){
	  open (SELF, ">$0"); print SELF @whole_prog; close; }
  elsif($head_found ==0){
	  open (SELF, ">$0"); splice(@whole_prog, 1, 0, @head); print SELF @whole_prog; close; }
}

#________________________________________________________________________
# Title     : parse_arguments  # this is the sub routine for parse_arguments.pl
# Usage     : &parse_arguments; or  (file1, file2)=@{&parse_arguments};
# Function  : Parse and assign any types of arguments on prompt in UNIX to
#             the various variables inside of the running program.
#             This is more visual than getopt and easier.
#             just change the option table_example below for your own variable
#             setttings. This program reads itself and parse the arguments
#             according to the setting you made in this subroutine or
#             option table in anywhere in the program.
# Example   : &parse_arguments(1);
# Warning   : HASH and ARRAY mustn't be like = (1, 2,3) or (1,2 ,3)
# Class     :
# Keywords  :
# Options   : '0'  to specify that there is no argument to sub, use
#              &parse_arguments(0);
#             parse_arguments itself does not have any specific option.
#             '#' at prompt will make a var  $debug set to 1. This is to
#              print out all the print lines to make debugging easier.
# Package   :
# Reference :
# Returns   : Filenames in a reference of array
#             and input files in an array (file1, file2)=@{&parse_arguments};
# Tips      :
# Argument  : uses @ARGV
# Todo      :
# Author    : A Biomatic
# Version   : 1.5
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub parse_arguments{
  my( $c, $d, $f, $arg_num, $option_table_seen, $n, $option_filtered,
		$option_table_example, $input_line, @input_files);
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #   Checks if there were arguments
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if( @ARGV < 1 ){ #<-- If Argument is not given at prompt
	  for(@_){
		 if($_ eq '0'){
			 last;
		 }else{
			 print "\n \"$0\" requires at least one Argument, suiciding.\n\n";
			 print chr(7); #<-- This is beeping
			 print "  To get help type \"$0  h\"\n\n\n ";
			 exit;
		 }
	  }
  }
  #""""""""""""""""""""""""""""""""""""""""""""""""""
  #   Some DEFAULT $debug variables for debugging purposes
  #""""""""""""""""""""""""""""""""""""""""""""""""""
  &set_debug_option;
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #  If there is only one prompt arg. and is [-]*[hH][elp]*, it calls
  #   &default_help and exits
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if( ( @ARGV == 1 ) && ($ARGV[0] =~ /^[\-]*[hH\?][elp ]*$/) ){
		&default_help;   exit;
  }
  for($f=0; $f < @ARGV; $f++){
	  if( ($ARGV[$f] =~ /^\w+[\-\.\w]+$/)&&(-f $ARGV[$f]) ){
		 push(@input_files, $ARGV[$f] ); next;  }
  }
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #     Reading the running program script
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""
  &assign_options_to_variables;
  if($HELP == 1){ &default_help }
  return(\@input_files);
}
#________________________________________________________________________
# Title     : assign_options_to_variables
# Usage     : &assign_options_to_variables(\$input_line);
# Function  : Assigns the values set in head box to the variables used in
#             the programs according to the values given at prompt.
#             This produces global values.
# Example   : When you want to set 'a' char to a variable called '$dummy' in
#             the program, you put a head box commented line
#             '#  $dummy    becomes  a  by  -a '
#             Then, the parse_arguments and this sub routine will read the head
#             box and assigns 'a' to $dummy IF you put an argument of '-a' in
#             the prompt.
# Warning   :
# Class     :
# Keywords  :
# Options   : '#' at prompt will make a var  $debug set to 1. This is to
#              print out all the print lines to make debugging easier.
# Package   : Bio::Utils
# Reference :
# Returns   : Some globaly used variables according to prompt options.
# Tips      : Used with 'parse_arguments'
# Argument  : None.
# Todo      :
# Author    : A Scientist
# Version   : 2.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub assign_options_to_variables{
  my($i, $j, $op, $z, $n,);
  my($var, %val, @val, $option_table_example, @input_options);

  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #      Defining small variables for option table reading
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my($g)='gets';                my($if)='if';
  my($is)='is';                 my(@input_files);
  my($o)='or';   my(@arguments) = sort @ARGV;

  #""""""""""""""""""""""""""""""""""""""""""""""""""
  #   Some DEFAULT $debug variables for debugging purposes
  #""""""""""""""""""""""""""""""""""""""""""""""""""
  &set_debug_option;

  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  #   The main processing of self
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  open(SELF, "$0");    ## opens the program you ran to get the options table.
  while(<SELF>){

	  if( $first_border_and_title > 6 ){  ## This is to make it read only the first headbox.
		  last;                            #  $first_border_and_title is an incremental counter.
	  }elsif( (/^ *#[_\*\-]{15,}$/) || (/^ *# *[Tt][itle]*[ :]*/) ){
		  $first_border_and_title++;
		  print __LINE__, " # assign_options_to_variables : Title line found\n" if $debug eq 1;
	  }elsif(/^ {0,6}# {0,80}[\$\%\@].+$/){
		  $op = $&;  ## $op is for the whole input option line which has $xxxx, @xxx, %xxxx format
		  $op =~ s/^( *\# *)(\W\w+.+)$/$2/;  ## This is removing '#  ' in the line.
		  $op =~ s/^(\W\w+.+)(\s+\#.*)$/$1/;  ## This is removing any comments in the line.
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 ## matching the following line input format.
			 ## $av_sc_segment     becomes    a  by  a  # To smooth the SC rates. Gets the averages of
			 ## $ARG_REG is for arguments regular expression variable.
			 ##  This reg. exp. matches = 'a or A or E or e' part
			 ##  which represents alternative prompt arguments possibilities. \=$b$g$is$e$set
			 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
			 $ARG_REG ='([\-\w\.\d]+[=\w*\d\.\d]*)[\;\.]* *[or\=\,\']* *([-\w\.\d]*) *[\=or\,\']* *([-\w\.\d]*) *[\=or\,\']* *([-\w\.\d]*)';
			 if($op=~/^([\$\@\%])([\w\-]+) {0,8}[=|$g|$is] *[\'\(\[\$\@\%]*([\- \w\.\d]+)[\)\]\']? *[bB]y +$ARG_REG/){
							 ## $sym     $var        becomes            a [$a...]                                by            a -a -A
				  my $sym = $1;  #### The symbols like ($, @, %), '$' in the above.
				  my $var = $2;  #### Actual variable name 'var' from $var, 'av_sc_segment' in the above.
				  my $val = $3;  #### The becoming value  first 'a' in the above.
				  my @arg = ($4, $5, $6, $7);  ## The alternative prompt arguments, second 'a' in the above..

			      print "\n $sym $var $val \n" if $debug==1;
			      print "\n \@arg are @arg \n" if $debug==1;

				  #""""""""""""""""""""""""""""""""""""""""""""""""""""
				  #  Going through the PROMPT args.
				  #""""""""""""""""""""""""""""""""""""""""""""""""""""
				  for($z=0; $z < @arguments; $z++){     ## $arguments[$z]  is from @ARGV
				      $arguments[$z] =~ s/\-// if $arguments[$z]=~/\-/;
					  for ($i=0; $i < @arg; $i ++ ){
						 if( ("$arg[$i]" eq "$arguments[$z]" )&& !($arg[$i] =~ /\=/)
						     && ($sym eq '$') ){
					         ${"$var"}="$val";
							 if($debug == 1){
								 print __LINE__," \$${var} is set to \"$1\"\n";
							 }

						 }#'''''''''''''''' $arg = by s=  syntax
						 elsif( ( $arg[$i] =~ /^(\w+) *\=/ )&&
									( $arguments[$z] =~ /^${1}= *([\w\.*\-*]+)$/)&&
									( $sym eq '$') ){
							 ${"$var"}="$1";
							 if($debug eq 1){
								 print __LINE__,"\$${var} is set to \"$1\"\n";
							 }
						 }elsif( $arguments[$z]=~
						         /^(\w+)=([\w\d\.\-]+)$/){## This is to make
						    ${"$1"}=$2;                   #  any arbitrary var
						 }                                #  if you put var=100
					  }                                  # at prompt without $var
				  }                                     # at headbox, it will still
			  }                                        # create $var variable with 100 assigned
		}
	}
}



#________________________________________________________________________
# Title     : read_head_box
# Usage     : %entries = %{&read_head_box([\$file_to_read, \@BOXED ] )};
# Function  : Reads the introductory header box(the one you see on top of sub routines of
#             Jong's programs.). Make a hash(associative array) to put entries
#             and descriptions of the items. The hash values have new lines '\n' are
#             attached, so that later write_head_box just sorts Title to the top
#             and prints without much calculation.
#             This is similar to read_head_box, but
#             This has one long straight string as value(no \n inside)
#             There are two types of ending line one is Jong's #---------- ...
#             the other is Astrid's  #*************** ...
# Example   : Output is something like
#             ('Title', 'read_head_box', 'Tips', 'Use to parse doc', ...)
# Warning   :
# Class     :
# Keywords  : open_head_box, open_headbox, read_headbox
# Options   : 'b' for remove blank lines. This will remove all the entries
#             with no descriptions
# Package   : File_Util
# Reference :
# Returns   : A hash ref.
# Tips      :
# Argument  : One or None. If you give an argu. it should be a ref. of an ARRAY
#              or a filename, or ref. of a filename.
#             If no arg is given, it reads SELF, ie. the program itself.
# Todo      :
# Author    :  A Biomatic
# Version   : 2.6
# Used in   : default_help
# Enclosed  : Following commented lines are an additional attachment !
#--------------------------------------------------------------------
sub read_head_box{
  my($i, $c, $d, $j, $s, $z, @whole_file, $title_found, %Final_out,
	  $variable_string, $TITLE, $title, @keys, $end_found, $line, $entry,
	  $entry_match, $End_line_num, $remove_blank,  $title_entry_null,
	  $end_found, $Enclosed_entry, $Enclosed_var, $blank_counter,
	  $title_entry_exist, $entry_value, $temp_W, $Warning_part
	);

  if(ref($_[0]) eq 'ARRAY'){ ## When array is given
	  @whole_file = @{$_[0]};
  }elsif(-e ${$_[0]}){       ## When filename is given in a ref
	  open(FILE, "${$_[0]}");
	  @whole_file=(<FILE>);
  }elsif(-e $_[0]){          ## When filename is given
	  open(FILE, "$_[0]");
	  @whole_file=(<FILE>);
  }elsif( $_[0] eq 'b'){          ## When filename is given
	  $remove_blank = 1;
  }elsif( ${$_[0]} eq 'b'){          ## When filename is given
	  $remove_blank = 1;
  }else{
	  open(SELF, "$0");
	  @whole_file=(<SELF>);
  }
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  for($i=0; $i<@whole_file; $i++){
	 $whole_file[$i] =~ tr/\t/ {7}/;  ## This is quite important to some parsing!!!
	 #########################################
	 ##  The first and second line of box 1 ##
	 #########################################
	 if( ($whole_file[$i]=~/^#[_\*]{20,}$/)&&    ##  '#______' is discarded
		 ($whole_file[$i+1]=~/ *\# {0,3}([TitlNam]+e) {0,8}: {1,10}([\w\.:]*) *(Copyright.*)/i) ){
		 $TITLE = $1;      $title = "$2\n";   $Final_out{'Warning'}.="$3\n";
		 $entry_match=$TITLE; ## The very first $entry_match is set to 'Title' to prevent null entry
		 if($TITLE =~ /^Title|Name$/i){   #
			  if( ($title=~/^\s+$/)||( $title eq "\n") ){
				  $title_entry_null =1;  $title = '';  }    }
		 $Final_out{$TITLE}=$title;
		 $title_found ++ ;   $i++;  ## << this is essential to prevent reading the same line again.
		 last if $title_found > 1;    }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ## The first and second line of box 2, #__________ or #**************
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1)&&($whole_file[$i]=~/^#[_\*]{20,}$/)&&
		 ($whole_file[$i+1]=~/^# {1,3}(\w{1,6}\s{0,2}\w+) {0,7}: {1,5}(.*) */i) ){
		 $title_found ++ ;        $i++;
		 $entry_match=$1;       $entry_value=$2;
		 $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;  ## Capitalize words
		 $Final_out{$entry_match}.= "$entry_value\n";
		 last if $title_found > 1;  next;   }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ##  'Enclosed' : section. After this, everything is read without discrimination ##
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($Enclosed_entry == 1)&&($whole_file[$i] =~/^#{1,} {1,}(.*)$/) ){
		 $Final_out{$Enclosed_var}.= "$1\n";    }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ##  With proper entry 1 : for  'eg)'
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1)&&($title_found==1)&&
		 ($whole_file[$i]=~ /^# {1,12}(eg ?\)) {0,8}(.*)/i)){
		 $entry_match='Example';
		 $Final_out{$entry_match}.= "$2\n";
	 }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ##  With PROPER entry 2 : descriptins like. 'Ussage : ssssssxxjkk  kj'
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1)&&($title_found==1)&&
		 ($whole_file[$i]=~ /^# {1,2}(\w{1,4}\s{0,2}\w{1,7}) {0,8}[:\)] {0,6}(.*) */i)){
		 $entry_match=$1;       $entry_value=$2;
		 $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
		 $Final_out{$entry_match}.= "$entry_value\n";
		 if($entry_match=~/^(Enclosed?)$/i){
			  $Enclosed_entry = 1;  $Enclosed_var=$1;        }    }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 #  With proper entry 3 : descriptins like. 'Ussage :', But blank description ##
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1)&&($title_found==1)&&
		 ($whole_file[$i]=~ /^# {1,2}(\w{1,4}\s{0,2}\w{1,7}) {0,8}[:\)]( {0,})$/i)){
		 $entry_match=$1;       $entry_value=$2;
		 $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
		 $Final_out{$entry_match}.= " $entry_value\n";
		 if($entry_match=~/^(Enclosed?)$/i){
			  $Enclosed_entry = 1;  $Enclosed_var=$1;      }    }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 #  $option variable matching                ##
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1) && ($title_found==1) &&
		 ($whole_file[$i]=~ /^# {1,15}([\$\@]\w+ +[\w=\>]+ +\S+ \w+ \S+ *.*)/ )){
		 $Final_out{$entry_match} .= "$1\n";  }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ###  all space line matching                 ##
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1)&&  ##<----- If blank line is matched. Take the line
		 ($title_found==1)&&($whole_file[$i]=~/^# {0,}$/) ){
		 $blank_counter++;
		 if($blank_counter > 2){ $blank_counter--; }
		 else{ $Final_out{$entry_match}.= " \n";  }     }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ###  Anything after 3 space to 12 positions  ##
	 ###  To match 'examples' etc. INC. ':'       ##
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1)&&
		 ($title_found==1)&&($whole_file[$i]=~/^#( {2,12})(.+)/) ){
		 $Final_out{$entry_match}.= "$1$2\n"; $blank_counter=0; }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ###  Anything after 1 space to 11 positions  ##
	 ###  To match 'examples' etc. EXC. ':'       ##
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($end_found != 1)&&
		 ($title_found==1)&&($whole_file[$i]=~/^# {1,12}([^:.]+)/) ){
		 $Final_out{$entry_match}.= "$1\n"; $blank_counter=0;}

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 ###-------End of the read_box reading--------##
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( ($title_found==1)&&
		 ($whole_file[$i]=~ /^#[\*\-]{15,}/)){  ## to match '#-----..' or '#*******..'(Astrid's)
		 $End_line_num = $i;       $end_found++;
		 last;      }

	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 #  <<<<  Check if there is option table >>>>  #
	 #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	 elsif( (/^#{10,} option table of this program   #{10,}/)&&($end_found >=1) &&($title_found==1)){
		 $option_tb_found++; ### This is a global var.
	 }
  } ## < End of for loop


  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ### If title is not there at all     ####
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  @keys=keys %Final_out;
  for(@keys){
	  if(/^Title$/i){    ## No Entry of Title at all??
		  $TITLE =$&;
		  $title_entry_exist = 1;
		  if($Final_out{$_}=~/^ *$/){   ## if Title => Null or just space
			  $title_entry_null = 1;    }  }  }

  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ### When title entry is not there    ####
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if( $title_entry_exist != 1){
		for($s=$End_line_num+1; $s < $End_line_num+20; $s++){
			if( $whole_file[$s] =~ /^sub {1,5}([\w\.]+) {0,6}\{/){
				$Final_out{'Title'} = "$1\n";   last;       }
			elsif( $whole_file[$s] =~/^#________________________+/){
				#######################################
				## Uses running file name as titile  ##
				#######################################
				$Final_out{'Title'} = "$0";     last;
			}else{
				#######################################
				## Uses running file name as titile  ##
				#######################################
				$Final_out{'Title'} = "$0";
			}
		}
  }
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ### When title is blank              ####
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  elsif($title_entry_null ==1){  ## It looks for 'sub xxxxx{ ' line to get title
		### $End_line_num is the last line read.
		for($s = $End_line_num+1; $s < $End_line_num+20; $s++){
			if( $whole_file[$s] =~ /^sub {1,5}(\w+\.*\w*) {0,7}{/){
				$Final_out{$TITLE} = "$1\n";    last;     }
			elsif( $whole_file[$s] =~/^#________________________+/){
				#######################################
				## Uses running file name as titile  ##
				#######################################
				$Final_out{$TITLE} = "$0";     last;
			}else{
				#######################################
				## Uses running file name as titile  ##
				#######################################
				$Final_out{$TITLE} = "$0";
			}
		}
  }
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ## Error handling, if no head box is found   ####
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if($title_found < 1){ print "\nFatal: No headbox found by read_head_box2 sub.\n";  }
  \%Final_out;
}               ##<<--- ENd of the sub read_head_box

#________________________________________________________________________
# Title     : read_first_head_box
# Usage     : %entries = %{&read_first_head_box(\$file_to_read )};
# Function  : Reads the header box(the one you see on top of sub routines of
#             Jong's programs.)
#             There are two types of ending line one is Jong's #---------- ...
#             the other is Astrid's  #*************** ...
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 2
# Used in   : default_help
# Enclosed  :
#--------------------------------------------------------------------
sub read_first_head_box{
  my($title_found, %Final_out, $variable_string, $end_found, $line,
	  $entry, $entry_match );

  open(SELF, "${$_[0]}");
  my(@whole_file)=(<SELF>);
  for(@whole_file){
	 if($title_found > 2){ ### This is to stop reading the file while it has found a box
		 last;              ### already.
	 }elsif( / *\# *([Tt]*itle) *\: *(.*)$/){
		 $Final_out{$1}=$2;
		 $title_found ++
	 }elsif( ($end_found != 1)&&($title_found==1)&&(/^\#(         +[:]* +)(.+)$/) ){
		 $Final_out{$entry_match}.= "\n $1$2";
		# attaches to the last @entry_list element(ref)
	 }elsif( ($end_found < 1)&&($title_found==1)&&(/ *\# *(\w\w\w+) *\: *(.*)/)){
		 $entry_match=$1;
		 ${"count$1"}++;
		 if( ${"count$1"} > 1){
			 $Final_out{$1}.="\n             $2";
		 }else{
			 $Final_out{$entry_match}.= $2; }

	 ### Following is when entry line '# $certain_var = 1 by t'
	 }elsif( ($end_found != 1) && ($title_found==1) && (/^\# *([\$\@\%]+.+)/) ){
		 $line = $1;
		 if($entry_match =~ /[Oo]ption/){  ## if last entry was '# Option :', attach the variable directly.
			 $Final_out{$entry_match} .= "\n             $line";
		 }else{                            ## if last entry wasn't '# Option :', find Option
			 for $entry (keys %Final_out){  ##  and attach the variable to it
				 if ($entry =~ /[Oo]ption/){
					 $Final_out{$entry} .= "\n             $line";
				 }
			 }
		 }
	 }elsif( ($title_found==1)&&(/ *\#[\*\-]{12,}/)){  ## to match '#-----..' or '#*******..'(Astrid's)
		 $end_found++;
	 }elsif( (/^#{10,} option table of this program   #{10,}/)&&($end_found >=1) &&($title_found==1)){
		 $option_tb_found++; ### This is a global var.
	 }
  }
  \%Final_out;
}                  ##<<--- ENd of the sub read_first_head_box


#________________________________________________________________________
# Title     : read_head_boxes
# Usage     : %entries = %{&read_head_box(\$file_to_read, ,,, )};
# Function  : Reads the introductory header box(the one you see on top of sub routines of
#             Jong's programs.). Make a hash(associative array) to put entries
#             and descriptions of the items.
# Example   : @hashes = @{&read_head_boxes(@ARGV)};
#             $num_of_sub = @hashes;
#             print "\n Number of subs was $num_of_sub\n";
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   : A hash ref.
# Tips      :
# Argument  : one or more filenames
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_head_boxes{
  my($i, $c, $d, $j, $s, $z, @whole_file, $title_found, %Final_out,
	  $variable_string, $TITLE, $title, @keys, $end_found, $line, $entry,
	  $entry_match, $End_line_num, $remove_blank,  $title_entry_null,
	  $end_found, $Enclosed_entry, $Enclosed_var, $blank_counter,
	  $title_entry_exist, $entry_value, $temp_W, $Warning_part, @arr_of_hash
	);
  for($s=0; $s < @_; $s ++){
	 if( -e $_[$s]){
		open (IN, "$_[$s]");
		my @whole_file=<IN>;
		my ($end_found, $blank_counter, $TITLE, $title, $entry_match );
		for($i=0; $i< @whole_file; $i++){
	$whole_file[$i] =~ tr/\t/ {7}/ if($whole_file[$i] =~/\t/);  ## This is important!
	if( ($whole_file[$i]=~/^#_{50,}|#\*{50,}|#\-{50,}$/)&&
	   ($whole_file[$i+1]=~/ *\# {0,3}([Titl]+e) {0,8}: {0,10}([\-\w\.:]*) *(.*)/i) ){
	   $end_found = 0;
	   $TITLE = $1;
	   $title = "$2\n";
	   $entry_match=$TITLE;
	   if($TITLE =~ /^Title$/i){   # title name is given ?
	       if( ($title=~/^\s+$/)||( $title eq "\n") ){
		  $title_entry_null =1;
		  $title = '';
	       }else{
		  ${"Final_out$title"}{$TITLE}=$title;
		  push(@arr_of_hash, \%{"Final_out$title"} );
		  $title_found =1 ;
		  $i++;
	       }
	   }
	}elsif( ($end_found != 1)&&($title_found==1)&&  ## for eg) line
	   ($whole_file[$i]=~ /^# {1,12}(eg ?\)) {0,8}(.*)/i)){
	   $entry_match='Example';
	   ${"Final_out$title"}{$entry_match}.= "$2\n";
	}elsif( ($end_found != 1)&&($title_found==1)&& ## matching the most
	   ($whole_file[$i]=~ /^# {0,2}(\w{1,5}\s{0,2}\w{1,7}) {0,8}[:\)] {0,5}(.*) */i)){
	   $entry_match=$1;
	   $entry_value=$2;
	   $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
	   ${"Final_out$title"}{$entry_match}.= ": $entry_value\n";
		  }elsif( ($end_found != 1) && ($title_found==1) &&
	   ($whole_file[$i]=~ /^# {0,15}([\$\@]\w+ +[\w=\>]+ +\S+ \w+ \S+ *.*)/ )){
	   ${"Final_out$title"}{$entry_match} .= "$1\n";
	}elsif( ($end_found != 1)&&    ## Blank match
	   ($title_found==1)&&($whole_file[$i]=~/^# {0,}$/) ){
	   $blank_counter++;
	   if($blank_counter > 2){ $blank_counter--; }
	   else{ ${"Final_out$title"}{$entry_match}.= "\n";  }
	}elsif( ($end_found != 1)&& ## matching lines without entry.
	   ($title_found==1)&&($whole_file[$i]=~/^#( {1,12})(.+)/) ){
	   ${"Final_out$title"}{$entry_match}.= "$1$2\n";
			  $blank_counter=0;
	}elsif( ($end_found != 1)&&
	   ($title_found==1)&&($whole_file[$i]=~/^# {1,12}([^:.]+)/) ){
	   ${"Final_out$title"}{$entry_match}.= "$1\n";
			  $blank_counter=0;
	}elsif( ($title_found==1)&&   ## to match '#-----..' or '#*******..'(Astrid's)
	   ($whole_file[$i]=~ /^#[\*\-]{20,}/)){
	   $End_line_num = $i;
	   $end_found=1;
	   $title_found = 0;
	}
		}
	 }
  }
  \@arr_of_hash;
}

#________________________________________________________________________
# Title     : read_head_box2
# Usage     : %entries = %{&read_head_box(\$file_to_read )};
# Function  : Reads the header box(the one you see on top of sub routines of
#             Jong's programs.). This is similar to read_head_box, but
#             This has one long straight string as value(no \n inside)
#             There are two types of ending line one is Jong's #---------- ...
#             the other is Astrid's  #*************** ...
# Example   : Output is something like
#             ('Title', 'read_head_box', 'Tips', 'Use to parse doc', ...)
# Warning   :
# Class     :
# Keywords  :
# Options   : 'b' for remove blank lines. This will remove all the entries
#             with no descriptions
# Package   : File_Util
# Reference :
# Returns   : A hash ref.
# Tips      :
# Argument  : One or None. If you give an argu. it should be a ref. of an ARRAY
#              or a filename, or ref. of a filename.
#             If no arg is given, it reads SELF, ie. the program itself.
# Todo      :
# Author    : A Biomatic
# Version   : 1.5
# Used in   : default_help
# Enclosed  :
#--------------------------------------------------------------------
sub read_head_box2{
  my($i, @whole_file, $title_found, %Final_out, $variable_string,
	  $end_found, $line, $entry, $entry_match, $remove_blank, $j );

  if(ref($_[0]) eq 'ARRAY'){ ## When array is given
	  @whole_file = @{$_[0]};
  }elsif(-e ${$_[0]}){       ## When filename is given in a ref
	  open(FILE, "${$_[0]}");
	  @whole_file=(<FILE>);
  }elsif(-e $_[0]){          ## When filename is given
	  open(FILE, "$_[0]");
	  @whole_file=(<FILE>);
  }elsif( $_[0] eq 'b'){          ## When filename is given
	  $remove_blank = 1;
  }elsif( ${$_[0]} eq 'b'){          ## When filename is given
	  $remove_blank = 1;
  }else{
	  open(SELF, "$0");
	  @whole_file=(<SELF>);
  }

  ########################################################################
  for($i=0; $i<@whole_file; $i++){
	 if( ($whole_file[$i]=~/^#________+$/)&&
		 ($whole_file[$i+1]=~/ *\# *(\w+\s{0,2}\w+) *\: *([\w\.\w]+) */) ){
		 my($entry)=$1;
		 my($title) = "$2\n";
		 $Final_out{$entry}=$title;
		 $title_found ++ ;
		 $i++;  ## << this is essential to prevent reading the same line again.
		 last if $title_found > 1;    }


	 elsif( ($end_found != 1)&&($title_found==1)&&
			  ($whole_file[$i]=~ /^# +(\w\w+\s{0,2}\w+) +:(.*)/)){
		 $entry_match=$1;
		 my($value) = "$2\n";
		 ${"count$1"}++;     ### If there were more than 2 identical entries
		 if( ${"count$1"} > 1){
			 $Final_out{$entry_match}.="$value\n"; ### When there are two or more idential entry
		 }
		 else{
			 if(($value eq '')||($value eq ' ')){
				 unless( $remove_blank == 1){
					 $value= " \n";
				 }
			 }
			 unless( $Final_out{$entry_match} eq $value ){    ## when the entry is not described,
				 $Final_out{$entry_match}.= "$value\n";
			 }
		 }  }

	 elsif( ($end_found != 1)&&
		 ($title_found==1)&&($whole_file[$i]=~/^# (.+)$/) ){
		 $Final_out{$entry_match}.= "$1\n"; ## To make a long string line.
	 } # attaches to the last @entry_list element(ref)

	 elsif( ($end_found != 1)&&  ##<--------- If blank line is matched. Take the line
		 ($title_found==1)&&($whole_file[$i]=~/^# *$/) ){
		 $Final_out{$entry_match}.= " \n"; ## To make a long string line.
	 }  # attaches to the last @entry_list element(ref)

	 elsif( ($end_found != 1) && ($title_found==1) &&
		 ($whole_file[$i]=~ /^# +([\$\@\%]+.+)/ )){
		 $Final_out{$entry_match} .= "$1\n";

	 }elsif( ($title_found==1)&&
		 ($whole_file[$i]=~ / *\#[\*\-]{14,}/)){  ## to match '#-----..' or '#*******..'(Astrid's)
		 $end_found++;
		 last;
	 }elsif( (/^#{10,} option table of this program   #{10,}/)&&($end_found >=1) &&($title_found==1)){
		 $option_tb_found++; ### This is a global var.
	 }
  }
  if($title_found < 1){
	  print "\nFatal:  No headbox found by read_head_box2 sub.\n";  }
  \%Final_out;
}                  ##<<--- ENd of the sub read_head_box

#________________________________________________________________________
# Title     : read_all_head_boxes
# Usage     : %entries = %{&read_all_head_box(\$file_to_read )};
# Function  : Reads the header boxes(the one you see on top of sub routines of
#             Jong's programs.)
#             There are two types of ending line one is Jong's #---------- ...
#             the other is Astrid's  #*************** ...
# Example   :
# Warning   :
# Class     : Util
# Keywords  :
# Options   :
# Package   : Bio
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_all_head_boxes{
	##########################################################
	my(
	  $average1, $dir, $file, $in_dir, $end_found, $entry,$entry_match,
	  $error_rate, $gap_chr, $half_win, $id_compos, $jp_file, $length, $line,
	  $name, $name_found, $name_found, $type_seq, $offset, $option_string,
	  $original_dir, $output, $out_string, $pre, $pwd, $string, $string1,
	  $sum, $sum1, $type_secon, $type_sol, $title_found, $type_DSSP,
	  $type_acc, $variable_string, $win_size,
	  @boxes, @string, @k, @keys, @names, @out_hash,
	  @out_hash_final, @outref, @read_files, @str1, @str2,  @string1,
	  %correct_head_box_entry, %dummy, %Final_out, %hash, %input, %out_hash_final
	 );
  #""""""""""""""""""""""< handle_arguments head Ver 1.0 >""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	my($i, $j, $c, $d, $e, $f, $g, $h, $k, $l, $p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z,
	  $dir, $file, $line, $name, @keys, @names,  @temp, %hash, %input );
  #"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  if( -e $file[0] ){  ### If file is given it opens the file to find correct_head_box
	  open(OPEN_FILE, "$file[0]");  ## If not given, it uses running script to find it.
  }else{   open(OPEN_FILE, "$0"); }

  my(@whole_file)=(<OPEN_FILE>);

  for(@whole_file){
	 if( / *\# *([Tt][IiTtLlEe]+) *\: *([\w+\.\w+]*)/){
		 $Title = $1;
		 $TITLE = $2;
		 ${"$TITLE"}{$Title}=$TITLE;
		 $title_found = 1;
		 $end_found   = 0;
	 }elsif( ($end_found == 0)&&($title_found==1)&&(/^\#(         +[:]* +)(.+)$/) ){
		 ${"$TITLE"}{$entry_match}.= "\n $1$2";
		# attaches to the last @entry_list element(ref)
	 }elsif( ($end_found == 0 )&&($title_found==1)&&(/ *\# *(\w{3,11}) *\: *(.*)/)){
		 $entry_match=$1;
		 $count{"$TITLE$1"} ++;
		 if( $count{"$TITLE$1"} > 1){
			 ${"$TITLE"}{$1}.="\n             $2";
		 }else{
			 ${"$TITLE"}{$entry_match}.= $2; }

	 ### Following is when entry line '# $certain_var = 1 by t'
	 }elsif( ($end_found != 1) && ($title_found==1) && (/^\# *([\$\@\%]+.+)/) ){
		 $line = $1;
		 if($entry_match =~ /[Oo]ption/){  ## if last entry was '# Option :', attach the variable directly.
			 ${"$TITLE"}{$entry_match} .= "\n             $line";
		 }else{                            ## if last entry wasn't '# Option :', find Option
			 for $entry (keys %{"$TITLE"}){  ##  and attach the variable to it
				 if ($entry =~ /[Oo]ption/){
					 ${"$TITLE"}{$entry} .= "\n             $line";
				 }
			 }
		 }
	 }elsif( ($title_found==1)&&(/ *\#[\*\-]{12,}/)){  ## to match '#-----..' or '#*******..'(Astrid's)
		 $end_found = 1; $title_found=0;
		 push(@boxes, \%{"$TITLE"});

	 }elsif( (/^#{10,} option table of this program   #{10,}/)&&($end_found >=1) &&($title_found==1)){
		 $option_tb_found++; ### This is a global var.
	 }
  }
  if(@boxes > 1){ \@boxes; }
  elsif( @boxes==1){ $boxes[0]; }
}                  ##<<--- ENd of the sub read_head_box

#____________________________________________________________________
# Title    : correct_head_box
# Function : Makes headbox in right and updated format. The most
#            updated headbox format is very this headbox. So, to
#            change all other headbox format, change this first.
# Usage    : just type correct_head_box.pl with a file name.
# Example  : correct_head_box.pl Bio.pl
# Argument : a filename
# Returns  :
# Options  :
# Tips     :
# Author   : A Biomatic , CopyLefted
# Version  : 1.1
# Package  :
# Used in  :
# Class    : Utility
# Keywords :
# Todo     :
# Reference: http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Warning  :
# Enclosed :
#---------------------------------------------------------------
sub correct_head_box{
	##############################################################################
	my($c, $d, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r, $s, $t, $x, $y, $z,
	  $dir, $file, $in_dir, $error_rate, $gap_chr, $half_win, $id_compos, $jp_file, $length, $line,
	  $name, $name_found, $name_found, $num_option_string, $type_seq,
	  $offset, $option_string, $original_dir, $output, $out_string,
	  $string, $string1, $sub_name, $sum, $sum1, $type_secon,
	  @arg_output, @array, @dir_input,
	  @file, @string_input, @file_dir_input, @hash, @k,
	  @keys, @names, @num_option_string, @out_hash, @out_hash_final, @outref,
	  @read_files, @str1, @str2,  @string1, @string_input, @whole_file, %correct,
	  %correct_head_box_entry, %Final_out, %hash, %input, %out_hash_final
	 );
  #""""""""""""""""""""( handle_arguments head v1.0 )""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  ## Reading self and the template headbox in this subroutine.
  %correct_head_box_entry = %{&read_correct_head_box()};
  for($p=0; $p < @file; $p++){
	  $in_file = $file[$p];

	  ##""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  ##  Make backup of the input file
	  ##""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  &cp( "$in_file", "$in_file\.bak$$");
	  print "\n $in_file\.bak$$ is created as a backup \n\n";
	  print chr(7);

	  ##""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  ##  Open files
	  ##""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	  open(TARGET, "$in_file\.bak$$");
	  open(RESULT, ">$in_file");

	  my(@whole_file) = <TARGET>;
	  my(@keys) = keys %correct_head_box_entry;

	  for($i=0; $i < @whole_file; $i++){   ## <= going through the whole lines
		  my(@BOX);
		  if(($whole_file[$i] =~ /^#___________+/)&&
			  ($whole_file[$i+1] =~ /^# {0,4}([\w+\s*\w+]+) {0,4}: {0,9}([\w+\.\w+]*)/ ) ){
			  my($sub_name)=$2;
			  until( ($whole_file[$i] =~ /^sub +([\w\.]+) *\{/)||($whole_file[$i] =~ /^#\-{15,}/)
			  || ($whole_file[$i] =~ /^#\*{15,}/) ){
				  push(@BOX, $whole_file[$i]);
				  $i++;
			  }

			  ### To get the sub name by reading  'sub xxxxxxx{ ' line after #---------
			  for($z=$i; $z < $i+5; $z++){
				  if($whole_file[$z]=~/^sub +([\w\.]+) *\{/){
					  $sub_name=$1;
					  last;
				  }
			  }

			  my(%Final_out)=%{&read_head_box(\@BOX)};  ## Putting into a hash
			  ### Now I have %Final_out and %correct_head_box_entry
			  my(%correct) =%{&superpose_hash(\%correct_head_box_entry, \%Final_out)};
			  print RESULT @{&write_head_box(\%correct)};

			  until($whole_file[$i]=~/^sub +([\w\.]+) *\{/){  $i++ }
			  if($whole_file[$i]=~/^sub +([\w\.]+) *\{/){
				  until( $whole_file[$i] =~ /^}/){
					  print RESULT $whole_file[$i];
					  $i++;
				  }
				  print RESULT $whole_file[$i];
			  }
		  }elsif($whole_file[$i]=~/^sub +([\w\.]+) *\{/){  ### When there is no headbox at all.
			  $correct_head_box_entry{'Title'}=$1;
			  $correct_head_box_entry{'Version'}='1.0';
			  $correct_head_box_entry{'Author'}=getlogin;
			  print RESULT @{&write_head_box(\%correct_head_box_entry)};
			  print RESULT $whole_file[$i++];
			  until( $whole_file[$i] =~ /^}/){
				  print RESULT $whole_file[$i];
				  $i++;
			  }
			  print RESULT $whole_file[$i];

		  }else{  print RESULT $whole_file[$i]; }
	  }
	}
}

#________________________________________________________________________
# Title     : read_correct_head_box
# Usage     :
# Function  : This reads correct_head_box only.
# Example   :
# Warning   :
# Class     : Utility
# Keywords  : read_update_head_box, read update headbox
# Options   : v  for verbose message printing.
# Package   :
# Reference : http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_correct_head_box{
	##########################################################
	my($c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r,
	  $s, $t, $u, $v, $w, $x, $y, $z,
	  $average1, $char_opt, $dir, $file, $in_dir,
	  $error_rate, $gap_chr, $half_win, $id_compos, $jp_file, $length, $line,
	  $name, $name_found, $name_found, $num_opt, $type_seq,
	  $offset, $option_string, $original_dir, $output, $out_string,
	  $pre, $pwd, $string, $string1, $sum, $sum1, $tmp, $type_secon, $type_sol,
	  $type_DSSP, $type_acc, $win_size,
	  @arg_output, @array, @char_opt, @dir,
	  @file, @string, @file_dir, @hash, @k,
	  @keys, @names, @num_opt, @out_hash, @out_hash_final, @outref,
	  @read_files, @str1, @str2,  @string1, @string, @whole_file,
	  %correct_head_box_entry, %dummy, %Final_out, %hash, %input, %out_hash_final
	 );
	#=~~~~~~~~~( handle_arguments head 1.0 )~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#
	 my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	 my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	 my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	#=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=#

  $UID = getlogin;

  if( -e $file[0] ){  ### If file is given it opens the file to find correct_head_box
	  open(OPEN_FILE, "$file[0]");  ## If not given, it uses running script to find it.
  }else{   open(OPEN_FILE, "$0"); }

  my(@whole_file)=(<OPEN_FILE>);
  my($correct_head_box_name)  = 'correct_head_box';

  DO_IT_AGAIN_WITH_DIFF_NAME:
  for($i=0; $i < @whole_file; $i ++){

	 $whole_file[$i] =~ tr/\t/ {7}/;  ## This is quite important to some parsing!!!

	 #######################################
	 ##  The first and second line of box ##
	 #######################################
	 if( ($whole_file[$i]=~/^#____________+$/)&&    ##  '#______' is discarded
		 ($whole_file[$i+1]=~/ *\# {0,3}([TitlNam]+e) {0,8}: ([read_]*correct_head_box[\.pl]*)/i) ){
		 $TITLE = $1;
		 $title = "$2\n";
		 if($TITLE =~ /^Title|Name$/i){   #
			  if( ($title=~/^\s+$/)||( $title eq "\n") ){
				  $title_entry_null =1;
				  $title = '';
			  }
		 }
		 $Final_out{$TITLE}=$title;
		 $title_found ++ ;
		 $i++;  ## << this is essential to prevent reading the same line again.
		 last if $title_found > 1;    }

	 ############################################################################
	 ## The first and second line of box 2
	 ############################################################################
	 elsif( ($end_found != 1)&&($whole_file[$i]=~/^#____________+$/)&&
		 ($whole_file[$i+1]=~/^# {1,3}(\w{1,6}\s{0,2}\w+) {0,7}: {1,5}(.*) */) ){
		 $title_found ++ ;
		 $i++;
		 $entry_match=$1;
		 $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
		 $Final_out{$entry_match}.= "$2\n";
		 last if $title_found > 1;  next;   }

	 ##################################################################################
	 ##  'Enclosed' : section. After this, everything is read without discrimination ##
	 ##################################################################################
	 elsif( ($Enclosed_entry == 1)&&($whole_file[$i] =~/^#{1,} {1,}(.+)$/) ){
		 $Final_out{$Enclosed_var}.= "$1\n";    }

	 ############################################################################
	 ##  With proper entry 1 : descriptins like. 'Ussage : ssssssxxjkk  kj'      ##
	 ############################################################################
	 elsif( ($end_found != 1)&&($title_found==1)&&
		 ($whole_file[$i]=~ /^# {1,2}(\w{1,4}\s{0,2}\w{1,7}) {0,8}: {1,5}(.*) */)){
		 $entry_match=$1;
		 $entry_match =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e;
		 $Final_out{$entry_match}.= "$2\n";
		 if($entry_match=~/^(Enclosed*)$/i){
			 $Enclosed_entry = 1;  $Enclosed_var=$1;
		 }
	 }

	 ##############################################################################
	 ##  With proper entry 2 : descriptins like. 'Usage :', But blank description ##
	 ##############################################################################
	 elsif( ($end_found != 1)&&($title_found==1)&&
		 ($whole_file[$i]=~ /^# {1,2}(\w{1,4}\s{0,2}\w{1,7}) {0,9}: {0,}$/)){
		 $entry_match=$1;
		 $Final_out{$entry_match}.= "\n";
		 if($entry_match=~/^(Enclosed*)$/i){
			 $Enclosed_entry = 1;  $Enclosed_var=$1;
		 }
	 }

	 ###############################################
	 ### $option variable matching                ##
	 ###############################################
	 elsif( ($end_found != 1) && ($title_found==1) &&
		 ($whole_file[$i]=~ /^# {1,15}([\$\@]\w+ +[\w=\>]+ +\S+ \w+ \S+ *.*)/ )){
		 $Final_out{$entry_match} .= "$1\n";  }

	 ###############################################
	 ###  all space line matching                 ##
	 ###############################################
	 elsif( ($end_found != 1)&&  ##<----- If blank line is matched. Take the line
		 ($title_found==1)&&($whole_file[$i]=~/^# {0,}$/) ){
		 $blank_counter++;
		 if($blank_counter > 2){ $blank_counter--; }
		 else{ $Final_out{$entry_match}.= " \n";  }
	 }

	 ###############################################
	 ###  Anything after 3 space to 12 positions  ##
	 ###  To match 'examples' etc. INC. ':'       ##
	 ###############################################
	 elsif( ($end_found != 1)&&
		 ($title_found==1)&&($whole_file[$i]=~/^# {2,12}(.+)/) ){
		 $Final_out{$entry_match}.= "$1\n"; $blank_counter=0; }

	 ###############################################
	 ###  Anything after 1 space to 11 positions  ##
	 ###  To match 'examples' etc. EXC. ':'       ##
	 ###############################################
	 elsif( ($end_found != 1)&&
		 ($title_found==1)&&($whole_file[$i]=~/^# {1,12}([^:.]+)/) ){
		 $Final_out{$entry_match}.= "$1\n"; $blank_counter=0;}

	 ###############################################
	 ###-------End of the read_box reading--------##
	 ###############################################
	 elsif( ($title_found==1)&&
		 ($whole_file[$i]=~ /^#[\*\-]{15,}/)){  ## to match '#-----..' or '#*******..'(Astrid's)
		 $End_line_num = $i;
		 $end_found++;
		 last;      }

	 ###############################################
	 #  <<<<  Check if there is option table >>>>  #
	 ###############################################
	 elsif( (/^#{10,} option table of this program   #{10,}/)&&($end_found >=1) &&($title_found==1)){
		 $option_tb_found++; ### This is a global var.
	 }
  }
  @keys=keys %Final_out;
  for($i=0; $i < @keys; $i++){
	  if(   $keys[$i] =~/^Example/i){    $Final_out{$keys[$i]}=''; }
	  elsif($keys[$i] =~/^Version/i){    $Final_out{$keys[$i]}=''; }
	  elsif($keys[$i] =~/^Function/i){   $Final_out{$keys[$i]}=''; }
	  elsif($keys[$i] =~/^Options/i){    $Final_out{$keys[$i]}=''; }
	  elsif($keys[$i] =~/^Keywords/i){   $Final_out{$keys[$i]}=''; }
	  elsif($keys[$i] =~/^Class/i){      $Final_out{$keys[$i]}=''; }
	  elsif($keys[$i] =~/^Author/i){     $Final_out{$keys[$i]}=$UID; }
  }
  \%Final_out;
}

#____________________________________________________________________
# Title    : write_head_box
# Function : gets a hash ref. and writes the head box for a subroutine
# Usage    :
# Example  :
# Argument :
# Returns  :
# Options  : v  for verbose representation. This will print boxes on STDOUT
#            n  for no '#' leader.
# Tips     :
# Author   : A Biomatic
# Version  : 2.2
# Package  :
# Used in  :
# Class    : Utility
# Keywords : write_headbox
# Todo     :
# Reference: http://sonja.acad.cai.cam.ac.uk/perl_for_bio.html
# Warning  : if version no. is null, it automatically puts '1.0'
#---------------------------------------------------------------
sub write_head_box{
  #""""""""""""""""""( handle_arguments head v1.0 )""""""""""""""""""""""""""""""""""""""
	my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	my($CS, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $s, $t, $x,  $z,
	  $delimiter, $Enclosed_came, $end_found, $end_line, $entry,
	  $length, $line,  $name, $name_found, $name_found, $num,
	  $original_dir, $output, $out_string, $pre, $pwd, $start_line, $string, $string1,
	  $temp, $title_found, $type_DSSP, @arg_output, @Final_out, @k, @keys, @names, @out, @out_hash,
	  @out_hash_final, @output_box, @outref, @read_files, @str1, @str2,  @string1,
	  %correct_head_box_entry, %Final_out, %hash, %input, %out_hash_final
	 );
  #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  my($KL)=9;  my($VL)=60; ## key length( like in  # Title )  ## value length
  $num = 80;
  if($char_opt =~ /n/i){
	  $CS=' '; ## Comment symbol. For help display, you can change into ' '
  }else{
	  $CS='#'; ## Comment symbol. Default head_box display.
  }
  for($x=0; $x < @hash; $x++){
		my(%input) = %{$hash[$x]};  my(@keys)= sort (keys %input);
		my(@out);
		###########################################################################
		##  PUTTING an order in the printout entries. To make 'Title' come first
		###########################################################################
		for($i=0; $i < @keys; $i++){
		  if($keys[$i]=~/^Title/i){
			  $temp=$keys[0];	   $keys[0]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Enclosed?/i){
			  $temp=$keys[$#keys];	   $keys[$#keys]=$keys[$i];   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Usage$/i){
			  $temp=$keys[1];	   $keys[1]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Function/i){
			  $temp=$keys[2];	   $keys[2]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Example/i){
			  $temp=$keys[3];	   $keys[3]=$keys[$i];	   $keys[$i]=$temp;
		  }elsif($keys[$i]=~/^Version/i){
			  $temp=$keys[$#keys-2];  $keys[$#keys-2]=$keys[$i];   $keys[$i]=$temp;
			  #### To make null version value to '1.0'
			  if($input{$keys[$#keys-2]}=~/^ *$/){ $input{$keys[$#keys-2]}='1.0'; }
		  }elsif($keys[$i]=~/^Warning/i){
			  $temp2=$keys[$#keys-1]; $keys[$#keys-1]=$keys[$i];   $keys[$i]=$temp2;
		  }
		}
		############################################################
		##       Writing starting line                            ##
		############################################################
		my($start_line) = "$CS".'_'x"$num"."\n";
		if( $char_opt =~ /v/i){
			print $start_line;      }

		my($Enclosed_came);  ## <<-- This should be HERE !
		for( $i =0; $i < @keys; $i++){  #### @keys has been sorted before.
		  my($Len) = length($input{$keys[$i]});  $delimiter = ':';
		  my($entry) = $keys[$i];
		  $entry =~ s#^\S#(($tmp = $&) =~ tr/[a-z]/[A-Z]/,$tmp)#e; ## capitalizing word
		  if($entry=~/^Enclosed?$/i){ $Enclosed_came = 1; }
		  my(@input) = split(/\n+/, $input{$keys[$i]});
		  if(@input > 0){
			  for($j =0; $j < @input; $j++){
				 ## If NO entry name(blank) is given    ##
				 if($j > 0){  ## If the value is a multi line.
					  $entry = '';   $delimiter=' ';    }
				 if( $char_opt =~ /v/i){
					  ######################################################################
					  ###  This is to reduce the entry length of Enclosed content lines   ##
					  ######################################################################
					  if( ($Enclosed_came==1)&&($entry eq '') ){ $KL=2; $VL=80; }
					  printf("$CS %-${KL}s $delimiter %-${VL}s\n", $entry , $input[$j]);    }
				 if( ($Enclosed_came==1)&&($entry eq '') ){ $KL=2; $VL=80; }
				 $out[$k++]=sprintf("$CS %-${KL}s $delimiter %-${VL}s\n", $entry , $input[$j]);
				 if($entry=~/^Enclosed?/){ $Enclosed_came = 1; }   }}
		  ######################################################################
		  ##   If the entries have null descriptions, just print entries  ######
		  ######################################################################
		  elsif(@input ==0){
				 if( $char_opt =~ /v/i){
					  printf("$CS %-${KL}s $delimiter %-${VL}s\n", $entry , ' ');   }
				 $out[$k++]=sprintf("$CS %-${KL}s $delimiter %-${VL}s\n", $entry , ' ');
		  }
		}
		############################################################
		##       Writing  Ending  line                            ##
		############################################################
		$end_line = "$CS".'-'x"$num"."\n";
		if( $char_opt =~ /v/i){   print $end_line;   }
		unshift(@out, $start_line);   push(@out, $end_line);   push(@Final_out, \@out);
  }
  if(@Final_out > 1){ @Final_out; }
  elsif( @Final_out==1){ $Final_out[0] }
} #<--- END of write_head_box



#________________________________________________________________________
# Title     : read_option_table
# Usage     :
# Function  : Reads the option table made by Jong in any perl script. The
#             option table is a box with separators.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub read_option_table{
	my($table_found, @option_tb, $head);
	 open(SELF, "${$_[0]}");
	 while(<SELF>){
		if( (/^ *#+/) && ( $table_found== 1) ){
		  push (@option_tb, "$_");
		}elsif( ($table_found != 1)&&(/^ *\#+ *[Oo]ption *[Tt]able */) ){
			$table_found=1; $head="############## Option Table for $logname\'s \"$0\"\n"; ##
			push(@option_tb, $head);
		}
		if( ($table_found==1)&&(/^ *###################+ *$/)){  ### to find the end point of reading
			$table_found =0; last; }
	 }
	 \@option_tb;
}


#________________________________________________________________________
# Title     : default_help
# Usage     : &default_help2;  usually with 'parse_arguments' sub.
# Function  : Prints usage information and others when invoked. You need to have
#             sections like this explanation box in your perl code. When invoked,
#             default_help routine reads the running perl code (SELF READING) and
#             displays what you have typed in this box.
#             After one entry names like # Function :, the following lines without
#             entry name (like this very line) are attached to the previous entry.
#             In this example, to # Function : entry.
# Example   : &default_help2; &default_help2(\$arg_num_limit);   &default_help2( '3' );
#             1 scalar digit for the minimum number of arg (optional),
#             or its ref. If this defined, it will produce exit the program
#             telling the minimum arguments.
# Warning   : this uses format and references
# Class     :
# Keywords  :
# Options   :
# Package   : File_Util
# Reference :
# Returns   : formated information
# Tips      : This usually goes with  parse_arguments.pl (= easy_opt.pl)
# Argument  :
# Todo      :
# Author    :
# Version   : 3.1
# Used in   : parse_arguments,
# Enclosed  :
#--------------------------------------------------------------------
sub default_help{
  my($i, $perl_dir, $arg_num_limit, $pwd, $head ,$arg_num_limit );
  my($logname)=getlogin(); my($pwd)=`pwd`; my($date)=`date`; chomp($date,$pwd);
  my($not_provided)="--- not provided ---\n";
  my($file_to_read) = $0;

  for($i=0; $i < @_; $i ++){
	  if((ref($_[$i]) eq 'SCALAR')&&(${$_[$i]} =~ /^\d$/)){
		  $arg_num_limit = ${$_[$i]};  }
	  elsif( (!(ref($_[$i]))) && ($_[$i] =~ /^\d$/)){
		  $arg_num_limit = $_[$i];     }
  }
  my %entries = %{&read_head_box(\$file_to_read )};
  if($option_tb_found ==1){
	 @option_tb=@{&read_option_table(\$file_to_read)};
  }
  foreach $help_item (keys %entries){
	  ${$help_item}= $not_provided if( (${$help_item}=~/^[\W]*$/)||( !defined(${$help_item})) );
  }
  #""""""""""""""""""""""""""""""""""""""""
  #########  Writing the format <<<<<<<<<<<
  #""""""""""""""""""""""""""""""""""""""""
  $~ =HEADER_HELP;
  write;   ## <<--  $~ is the selection operator
  $~ =DEFAULT_HELP_FORM;
  for(sort keys %entries){  write  }
  print chr(7);  print "_"x72,"\n\n";

  if(@ARGV < $arg_num_limit){ print "\* $0 fataly needs $arg_num_limit arguments\n\n" }

  if(  $option_tb_found == 1){
	 #########  Printing the OPTION table contents <<<<<<<<<<<<
	 print "  Press \"Return\" key to see what options $logname\'s \n\n    \"$0\" take... \n";
		 $key_press=getc();
	 print @option_tb, "\n"x2 if(@option_tb > 0);
  }
format HEADER_HELP  =
_____________________________________________________________________
		  __  __      ______     __          _____
		 /\ \/\ \    /\  ___\   /\ \        /\  _ `\
		 \ \ \_\ \   \ \ \__/   \ \ \       \ \ \L\ \
		  \ \  _  \   \ \  _\    \ \ \       \ \ ,__/
			\ \ \ \ \   \ \ \/___  \ \ \_____  \ \ \/
			 \ \_\ \_\   \ \_____\  \ \______\  \ \_\
			  \/_/\/_/    \/_____/   \/______/   \/_/ V 3.1`
_____________________________________________________________________
.
format DEFAULT_HELP_FORM =
 @<<<<<<<<<: @*
 $_        $entries{$_}
.
}


#________________________________________________________________________
# Title     : default_help_old
# Usage     : &default_help;  usually with 'parse_arguments' sub.
# Function  : prints usage information and others when invoked. You need to have
#             sections like this explanation box in your perl code. When invoked,
#             default_help routine reads the running perl code (self reading) and
#             displays what you have typed in this box.
#             After one entry names like # Function :, the following lines without
#             entry name (like this very line) are attached to the previous entry.
#             In this example, to # Function : entry.
# Example   : &default_help; &default_help(\$arg_num_limit);   &default_help( '3' );
# Warning   : this uses format and references
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : formated information
# Tips      : This usually goes with  parse_arguments.pl (= easy_opt.pl)
# Argument  : 1 scalar digit for the minimum number of arg (optional),
#             or its ref. If this defined, it will produce exit the program
#             telling the minimum arguments.
# Todo      :
# Author    :
# Version   : 2.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub default_help_old{
  my($i, $perl_dir, $title_found,$usage, $prog_title);
  my($version, $author, $package, $warning, $tips, @option_tb);
  my($arg_num_limit, $option, $pwd,$function,$argument );
  my($file_to_read, $returns, $end_found,$example, $head);
  my($logname)=getlogin(); my($pwd)=`pwd`; my($date)=`date`; chomp($date,$pwd);
  my($not_provided)="--- not provided ---\n";

  for($i=0; $i < @_; $i ++){
	  if((ref($_[$i]) eq 'SCALAR')&&(${$_[$i]} =~ /^\d$/)){
		  $arg_num_limit = ${$_[$i]};  }
	  elsif( (!(ref($_[$i]))) && ($_[$i] =~ /^\d$/)){
		  $arg_num_limit = $_[$i];     }
  }

  #################################################################
  ##########       SElf reading part       ########################
  #################################################################

  $file_to_read = $0;
  &read_head_box_old(\$file_to_read);
  sub read_head_box_old{
	 my(@entry_list, $help_item, $temp, $usa, $exa, $war,
		 $opt, $arg, $ret, $fun, $tip, $aut, $ver, $pac);
	 open(SELF, "${$_[0]}");
	 while(<SELF>){
		if(/\#\![\/]*([\w\/]+) *([-\w]*) *([-\w]*) *([-\w]*) *([-\w]*)/){ ## matching #!/nfs/ind5/usr/bin/perl
			$perl_dir = $1;  $perl_options=join(" ", ($2,$3,$4,$5) );
			push(@entry_list, \$perl_options); next; }
		elsif( ($title_found != 1)&&(/ *\# *[Tt]*itle *\: *(.*)$/) ){
			$prog_title=$1; $title_found=1  }
																		 #          :
		elsif( ($end_found != 1)&&($title_found==1)&&(/^\#         +[:]* +(.+)$/) ){
			$temp ="\n                $1";         # this is to handle explanation without names.
			${$entry_list[$#entry_list]} .=$temp; }# attaches to the last @entry_list element(ref)

		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Ff]unction *\: *(.*)/)){
			$fun++; if($fun > 1){ $function.="\n                $1";}else{ $function.=$1  }
			push (@entry_list, \$function)  }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Uu]sage *\: *(.*)/)){
			$usa++; if($usa > 1){ $usage.="\n                $1";}else{ $usage.=$1  }
			push (@entry_list, \$usage)     }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Ee]xample *\: *(.*)/)){
			$exa++; if($exa > 1){ $example.="\n                $1";}else{ $example.=$1  }
			push (@entry_list, \$example )  }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Aa]rgument[s]* *\: *(.*)/)){
			$arg++; if($arg > 1){ $argument.="\n                $1";}else{ $argument.=$1 }
			push (@entry_list, \$argument)  }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Oo]ption[s]* *\: *(.*)/)){
			$opt++; if($opt > 1){ $option.="\n                $1";}else{ $option.=$1 }
			push (@entry_list, \$option)  }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Rr]eturn[s]* *\: *(.*)/)){
			$ret++; if($ret > 1){ $returns.="\n                $1";}else{ $returns.=$1  }
			push (@entry_list, \$returns)   }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Tt]ips *\: *(.*)/)){
			$tip++; if($tip > 1){ $tips.="\n                $1";}else{ $tips.=$1 }
			push (@entry_list, \$tips)      }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Aa]uthor *\: *(.*)/)){
			$aut++; if($aut > 1){ $author.="\n                $1";}else{ $author.=$1 }
			push (@entry_list, \$author)      }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Vv]ersion *\: *(.*)/)){
			$ver++; if($ver > 1){ $version.="\n                $1";}else{ $version.=$1 }
			push (@entry_list, \$version)      }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Pp]ackage *\: *(.*)/)){
			$pac++; if($pac > 1){ $package.="\n                $1";}else{ $package.=$1 }
			push (@entry_list, \$package)      }
		elsif( ($end_found != 1)&&($title_found==1)&&(/ *\# *[Ww]arning *\: *(.*)/)){
			$war++; if($war > 1){ $warning.="\n                $1";}else{ $warning.=$1  }
			push (@entry_list, \$warning)   }
		elsif( ($end_found != 1)&&($title_found==1)&&(/^ *[\#]+------------------------*/)){
			$end_found = 1;    }

		if( (/^ *#+/) && ( $table_found== 1) ){ push (@option_tb, "$_"); }
		elsif( ($table_found !=1)&&(/^ *\#+ *[Oo]ption *[Tt]able/) ){
			$table_found=1; $head="############## Option Table for $logname\'s \"$0\"\n"; ##
			push(@option_tb, $head); }

		if( ($table_found==1)&&(/^ *###################+ *$/)){  ### to find the end point of reading
			$table_found =0; last;}
	 }
  } ##<<--- ENd of the sub read_head_box


  foreach $help_item (@entry_list)  ## substituing with 'Not provided' message when there is no info
  {
	  ${$help_item}= $not_provided if( (${$help_item}=~/^[\W]*$/)||( !defined(${$help_item})) );
  }
  @argus = @ARGV;
  shift(@argus) if (-f $argus[0]);
  $options = join(" ", @argus); #### to show what option you put, later.

  #########################################
  #########  Writing the format <<<<<<<<<<<
  #########################################
  $~ =HEADER_HELP; write;   ## <<--  $~ is the selection operator
  $~ =DEFAULT_HELP; write;
  print chr(7); print "\n\n";

  if(@ARGV < $arg_num_limit){ print "\* $0 fataly needs $arg_num_limit arguments\n\n" }

  #########  Printing the OPTION table contents <<<<<<<<<<<<
  print "  Press \"Return\" key to see what options $logname\'s \n\n    \"$0\" take... \n";
	  $key_press=getc();
  print @option_tb, "\n"x2 if(@option_tb > 0);

format HEADER_HELP  =
_____________________________________________________________________________
				  __  __      ______      __           _____
				 /\ \/\ \    /\  ___\    /\ \         /\  _ `\
				 \ \ \_\ \   \ \ \__/    \ \ \        \ \ \L\ \
				  \ \  _  \   \ \  _\     \ \ \        \ \ ,__/
					\ \ \ \ \   \ \ \/___   \ \ \_____   \ \ \/
					 \ \_\ \_\   \ \_____\   \ \______\   \ \_\
					  \/_/\/_/    \/_____/    \/______/    \/_/ V 1`
_______________________________________________________________________________

.

format DEFAULT_HELP =
 Program name : @*
					sprintf("%s %s %s \"$0\" \t\t\tversion: $version");
 Perl program : @*
					sprintf("%s  %s \"$perl_dir\" \t\tversion: $]");
 Package from : @*
					 $package
 Present dir  : @*
					 $pwd

 Function     : @*
					 $function

 Usage        : @*
					 $usage
 Examples     : @*
					 $example
 Arguments    : @*
					 $argument
 Options      : @*
					 $option
 Argus given  : @*
					 sprintf("%s  %s %s %s %s %s %s %s %s %s %s %s %s %s %s", @ARGV);
 Returns      : @*
					$returns
 Tips         : @*
					$tips
 Author       : @*
					$author
 Version      : @*
					$version
 Warning      : @*
					$warning
_________________________________________________________________________________
.
}

#________________________________________________________________________
# Title     : print_seq_in_block
# Usage     : &print_seq_in_block (\$block_leng, 'i',\%h1, 'sort', \%h2, \%hash3,,,);
# Function  : gets many refs  for one scalar  or hashes and prints
#               the contents in lines of \$block_leng(the only scalar ref. given) char.
# Options   : 'o' or 'O' => ordered hash print,
#             'n' or'N' => no space between blocks.
#             's' or 'S' => printout sorted by seq names.
#             'i' or 'I' => interlaced print.(this requires identical names in hashes)
#             'v' or 'V' => show sequence start number at each line
#             (all options can be like \$sort
#             while $sort has 's' as value. naked number like 100 will be the
#             block_length. 'i' or 'I' => interlaced print.(this requires
#             identical names in hashes)
# Warning   :
# Class     :
# Keywords  :
# Example   : If there are 3 hashes output will be; (in the order of \%hash3, \%hash2, \%hash1)
#             >> 1st Hash        >> 2nd Hash         >> 3rd Hash
#             Name1  THIS-IS-    Name123  eHHHHHHH   Name123  12222223
#
#             You will get;
#                            Name1    THIS-IS-
#                            Name123  eHHHHHHH
#                            Name123  12222223
#
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : many refs  for hash (one for bottm, one for top, etc,top hash is usually
#               to denote certain caculations or results of the bottom one
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :   -- Following are examples.
#             Example of ( no option, DEFAULT )  # Example of ('i' or 'I' option,
#                                                                INTERLACE )
#             6taa           ----ATPADWRSQSIY    #   6taa       ------ATPADWRSQSIY
#             2aaa           ------LSAASWRTQS    #   6taa       ------CCHHHHCCCCEE
#             1cdg           APDTSVSNKQNFSTDV    #   6taa       ------563640130000
#
#             6taa           ------CCHHHHCCCC    #   2aaa       ------LSAASWRTQSIY
#             2aaa           ------CCHHHHCCCC    #   2aaa       ------CCHHHHCCCCEE
#             1cdg           CCCCCCCCCCCCCCCC    #   2aaa       ------271760131000
#
#             6taa           ------5636401300    #   1cdg       APDTSVSNKQNFSTDVIY
#             2aaa           ------2717601310    #   1cdg       CCCCCCCCCCCCCCCCEE
#             1cdg           6752327236000000    #   1cdg       675232723600000000
#
#             Example of('s' or 'S' option,SORT) # Example of ('o' or 'O' option,
#                                                        ORDERED by input hashes )
#
#             1cdg           APDTSVSNKQNFSTDV    #   6taa       ------ATPADWRSQSIY
#             2aaa           ------LSAASWRTQS    #   2aaa       ------LSAASWRTQSIY
#             6taa           ------ATPADWRSQS    #   1cdg       APDTSVSNKQNFSTDVIY
#
#             1cdg           CCCCCCCCCCCCCCCC    #   6taa       ------CCHHHHCCCCEE
#             2aaa           ------CCHHHHCCCC    #   2aaa       ------CCHHHHCCCCEE
#             6taa           ------CCHHHHCCCC    #   1cdg       CCCCCCCCCCCCCCCCEE
#
#             1cdg           6752327236000000    #   6taa       ------563640130000
#             2aaa           ------2717601310    #   2aaa       ------271760131000
#             6taa           ------5636401300    #   1cdg       675232723600000000
#--------------------------------------------------------------------
sub print_seq_in_block{
  my($c, $d, $e, $f, $k, $i, $s, $t,@in,$gapped,
	  %input0,%input1,%input2,%input3,%input4, @names0, @names1, @names2, @names3,
	  $intl,$z,$diff,$offset);
  my($bl)=60;
  my($sort) =0; my($n_space)=0; my($ordered) =0; my($gap_char) ='-';
  my($na,$larg,$names,$seq, $visual_num); my($n)=13;
  sub num{ $a <=> $b; } my(@in_ar, $bl_passed);

  ###############  ARGV handling ######################
  for($k=0; $k< @_ ;$k++){
	  if( !ref($_[$k]) ){    # when inputs are not ref.
		  if($_[$k]=~ /^[\-]*([\d]{1,4})$/){ $bl=$1 if $1>0; $bl_passed=1 if $1>0; next;}  #<--   option handling
		  if($_[$k]=~ /^[\-sS]$/)   { $sort =    1; next;}
		  if($_[$k]=~ /^[\-nN]$/)   { $n_space = 1; next;}
		  if($_[$k]=~ /^[\-iI]$/)   { $intl =    1; next;}
		  if($_[$k]=~ /^[\-]*[gG]+/){ $gapped   =  1; next;}
		  if($_[$k]=~ /^[\-]*[vV]+/){ $visual_num =  1; next;}
		  elsif($_[$k]=~ /^[\-oO]$/){ $ordered = 1;      }
	  }
	  elsif( ref($_[$k]) eq "SCALAR" ){     #<--   option handling
		  if(${$_[$k]}=~ /^[\-]*([\d]{1,4})$/){$bl=$1 if $1>0; $bl_passed=1 if $1>0; next;}      # the scalar input
		  if(${$_[$k]}=~ /^[\-sS]$/){$sort = 1;next;}                 # should shorter than 5
		  if(${$_[$k]}=~ /^[\-nN]$/){$n_space = 1;next;}              # to be recognized as
		  if(${$_[$k]}=~ /^[\-iI]$/){$intl = 1;next;}                 # options, be it number or
		  if(${$_[$k]}=~ /^[\-]*[g]/i){ $gapped =   1; next;}                 # options, be it number or
		  if(${$_[$k]}=~ /^[\-]*[v]/i){ $visual_num = 1; next;}                 # options, be it number or
		  elsif(${$_[$k]}=~ /^[o]$/i){$ordered = 1;}                  # or chars.
	  }
	  elsif(ref($_[$k]) eq "HASH") {  push(@in,  $_[$k]); } #<-- seqn handling hash
	  elsif(ref($_[$k]) eq "ARRAY"){  push(@in, &convert_arr_and_str_2_hash($_[$k], $k));} #<-- conv array to hash.
	  elsif(ref($_[$k]) eq "SCALAR"){ push(@in,&convert_arr_and_str_2_hash($_[$k], $k));} #<-- conv array to hash.
  }

  #########  HASH input handling ############
  for($k=0; $k< @in; $k++){
		 if(ref($in[$k]) eq "HASH"){
			  %{"input$k"}=%{$in[$k]};
			  print %input0;
			  if($sort == 1){   ## When the keys should be sorted.
				  $keys_long= join("", keys(%{"input$k"}) );   ## makes a string of keys to do the next
				  if ($keys_long =~ /[\d\.]+/){                ## see if there is digit.
					  @{"names$k"}= sort num keys(%{"input$k"}); # numerical sort of keys(seq names)
				  }
				  elsif($keys_long =~ /[\w\.\,]+/){          ## if there is no digits,
					  @{"names$k"}= sort keys(%{"input$k"});  ## do the normal string sort
				  }
			  }elsif($sort != 1){                           ## no sorting at all
					  @{"names$k"}= keys(%{"input$k"});
			  }

			  if($gapped != 1){
				  for($i=0; $i< @{"names$k"}; $i++){
					 if(${"input$k"}{${"names$k"}[$i]} =~ /\,/){               # remove ','
						${"input$k"}{${"names$k"}[$i]}=~ s/\,//g;
					 }
				  }
			  }
		 }
  }

  ########################################################################
  ##     Following is to make ends of sequences neat                   ##
  ########################################################################
  for($z=0; $z < @in; $z++){
	 for($t=0;$t < @{"names$z"}; $t ++ ){
		 $na=${"names$z"}[$t];
		 $s=${"input$z"}{$na};
		 $larg=length($s) if length($s)> $larg;
		 $n=length($na) if length($na) > $n;
		 if($s =~ /\-/){ $gap_char='-'; }elsif( $s =~ /\./){  $gap_char='.';  }
		 if (length($s)<$larg){
			$offset=length($s);
			$diff=$larg-$offset;
			substr($s,$offset,$larg)="$gap_char"x$diff;
		 }
	 }
  }

  ########################################################################
  ##     Following is the core code for making block printing          ##
  ########################################################################
  if($ordered== 1){
		$bl=$larg if (($larg < 60)&&($bl_passed != 1));
		for($c=0; $c < @in; $c++){
			for($k=0; $k < $larg; $k += $bl){
				for($i=0; $i < @{"names$c"}; $i++){
					 $names= ${"names$c"}[$i];
					 $seq= substr( ${"input$c"}{$names},  $k,  $bl);
					 $seq=join(" ", split(/\,/, $seq)) if $gapped == 1;
					 if($visual_num==1){
						 printf ("%-${n}s %4d %-$bl s\n", $names, ($k+1), $seq);
					 }else{ printf ("%-${n}s %-$bl s\n", $names, $seq); }
				}print "\n" unless($n_space == 1);
			}print "\n";
		}
  }elsif($intl==1){   ## When Interlace option is set
		  $bl=$larg  if (($larg < 50)&&($bl_passed != 1));
		  for($k=0; $k < $larg; $k+=$bl){
			 for($i=0; $i < @{"names0"}; $i++){
				for($c=0; $c <= $#in; $c++){
					 $names=${"names$c"}[$i];
					 $seq=substr(${"input$c"}{$names}, $k, $bl);
					 $seq=join(" ", split(/\,/, $seq)) if $gapped == 1;
					 if($visual_num==1){
						 printf ("%-${n}s %4d %-$bl s\n", $names, ($k+1), $seq);
					 }else{ printf ("%-${n}s %-$bl s\n", $names, $seq); }
				}print "\n" unless($n_space ==1);
			 }print "\n";
		  }print "\n" unless($n_space ==1);
  }else{
		############################################################
		##           This is the default                          ##
		############################################################
		for($k=0; $k < $larg; $k+=$bl){
			$bl=$larg if (($larg < 50)&&($bl_passed != 1));
			for($c=0; $c < @in; $c++){  # $n is the name space size
				my(@seq_names) = @{"names$c"};
				for($i=0; $i < @seq_names; $i++){
					 my($names)=$seq_names[$i];
					 my($long_seq)=${"input$c"}{$names};
					 my($seq)=substr($long_seq, $k, $bl);
					 $seq=join(" ", split(/\,/, $seq)) if $gapped == 1;
					 if($visual_num==1){
						 printf ("%-${n}s %4d %-$bl s\n", $names, ($k+1), $seq);
					 }else{ printf ("%-${n}s %-$bl s\n", $names, $seq); }
				}print "\n" unless($n_space ==1);
			}print "\n";
		}
	}
}

#________________________________________________________________________
# Title     : print_seq_in_columns
# Usage     : &print_seq_in_block (\$block_leng, 'i',\%h1, 'sort', \%h2, \%hash3,,,);
# Function  : gets many refs  for one scalar  or hashes and prints
#               the contents in lines of \$block_leng(the only scalar ref. given) char.
# Example   :  With command 'print_seq_in_columns.pl c2 s2', you get:
#
#		    name1 11111111  name1 22222
#		    name2 11        name2 2222222
#		    name3 1111111   name3 22222
#		    name4 11111     name4 2222
#		    name5 11111     name5 222
#
#		    name1 3333      name1 4444
#		    name2 3333      name2 444
#		    name3 333       name3 4
#		    name4 333       name4 4444
#		    name5 3333      name5 4444444
#
# Warning   :
# Class     :
# Keywords  :
# Options   : c, i, s
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  : many refs  for hash (one for bottm, one for top, etc,top hash is usually
#               to denote certain caculations or results of the bottom one
# Todo      :
# Author    : A Biomatic
# Version   : 1.1
# Used in   :
# Enclosed  :
#---------------------------------------------------------------------------
sub print_seq_in_columns{
	#~~~~~~~~~~~~~~~~~~~~~~( handle_arguments head 1.0 )~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 my(@A ) = &handle_arguments( @_ ); my( $num_opt )=${$A[7]}; my( $char_opt )=${$A[8]};
	 my(@hash)  =@{$A[0]}; my(@file)   =@{$A[4]}; my(@dir   )  =@{$A[3]}; my(@array)=@{$A[1]};
	 my(@string)=@{$A[2]}; my(@num_opt)=@{$A[5]}; my(@char_opt)=@{$A[6]};
	 my($column_num, $bl_passed, @in_ar, $c, $d,$e,$f,$g,$h,$i,$j,$k,$l, $s,$t, $x,$z,
	  $packed, $diff,$offset, $dir, $file, $in_dir, $end_found, $entry, $entry_match,
	  $gap_chr, $intl, $line, $na, $name, $larg,$names,$seq, $n_space, $offset,
	  $ordered, $output, $out_string, $pre, $pwd, $sort, $string, $tmp, $temp,
	  $title_found, $win_size, @arg_output, @in, @string, @k, @keys, @names,
	  @out_hash, @out_hash_final, @output_box, @outref, @read_files, @temp,
	  %hash, %input, %out_hash_final, $single_column, $largest_elem_count   );
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  $gap_char='-';

	sub numerically{ $a <=> $b; }

  ######################################
  ####    Sub argument handling     ####
  ######################################
  if($char_opt =~/n/i){      $n_space    = 1; }
  if($char_opt =~/i/i){      $intl       = 1; }
  if($char_opt =~/s(\d+)/i){ $sp         = $1  }
  if($char_opt =~/c(\d+)/i){ $column_num = $1  }
  if($char_opt =~/c[^\d]/i){ $column_num = 1 ; } ## If just -c is given, you print single column
  if($num_opt  =~/(\d+)/i){ $bl  = $1; $bl_passed=1 if $1>0;}
  $column_num = @hash unless( defined ($column_num)  );
  $column_num = @hash if( $column_num > @hash);
  $column_num = 1 if $column_num < 1;  ## To make  '-c0' as -c1.
  if(defined($sp)){  $sp =" "x$sp }else{ $sp='  '; }


  #########  HASH input handling ############
  ## This part assigns hash keys into @names1, @names2, etc, according to the no. hash input.
  for($k=0; $k<@hash; $k++){
		 %hash=%{$hash[$k]};
		 if($sort == 1){      ## <<< this does automatic numerical handling >>>>
			 $keys_long=join("", keys %hash );
			 if ($keys_long =~ /[\d\.]+/){
				 @{"names$k"}= sort numerically keys %hash; }   # numerical sort
			 elsif($keys_long =~ /[\w\.\,]+/){
				 @{"names$k"}= sort keys(%hash);  # normal sort
			 }
		 }
		 else{
			  @{"names$k"}= keys(%hash);
			  $largest_elem_count=@{"names$k"} if (@{"names$k"} > $largest_elem_count);
		 }
		 #### IF sequence is like   'A,B,C,D,E,..' delimited by ',',  remove ','
		 for($i=0; $i< @{"names$k"}; $i++){
				  $string = $hash{${"names$k"}[$i]};
				  $larg=length($string) if $larg < length($string);
				  if($string =~ /\,/){
					  $string=~ s/\,//g;
				  }
		}

  }
  ## The output of above part is nothing more than  @names1, @names2, ...


  ######################################
  ####### Sub argument handling ########
  ######################################

  for($z=0; $c < @hash ; $c++){
	 %hash = %{$hash[$c]};
	 for($t=0;$t< @{"names$c"};$t++){
		 $s=$hash{${"names$c"}[$t]};
		 $bl = $larg if($bl_passed != 1);
		 $n = length($na)+1 if length($na) > $n;
		 if($s =~ /\-/){ $gap_char='-'; }elsif( $s =~ /\./){  $gap_char='.';  }
		 if (length($s)<$larg){
			 $offset=length($s);
			 $diff=$larg-$offset;
			 substr($s,$offset,$larg)="$gap_char"x$diff;
		 }
	 }
  }
  if($intl==1){
	  $bl=$larg if ($bl_passed != 1);
	  for($k=0; $k < $larg; $k+=$bl){
			 for($c=0; $c < @hash; $c++){  # $n is the name space size
				%hash = %{$hash[$c]};
				for($i=0; $i < @{"names$c"}; $i++){
					 $names=${"names$c"}[$i];
					 $seq  =substr($hash{$names},$k,$bl);
					 printf ("%-${n}s %-${bl}s  ", $names, $seq);
				}
				print "\n" unless($n_space ==1);
			 }
			 print "\n";
	  }
  }
  #######################################################
  ###   This is the default printing part.
  #######################################################
  else{     # bl is the column width. should be at least 1
	  $bl=$larg if ($bl_passed != 1);
	  for($k=0; $k < $larg; $k+=$bl){
		  # following is for various column number printing
		  for($m=0; $m < @hash; $m+=$column_num){
			  for($i=0; $i < $largest_elem_count ; $i++){
				  for($c=$m; $c < $column_num+$m; $c++){
					  %hash = %{$hash[$c]};
					  @keys = keys (%hash);
					  $names= $keys[$i];
					  #print "\n$names ====> \n";
					  $seq=substr($hash{$names}, $k, $bl);
					  printf ("%-${n}s %-${bl}s${sp}", $names, $seq);
				  }
				  print "\n";
			  }
			  print "\n" if @names0 > 1;
		  }
	  }
	  print "\n" unless($n_space ==1);
  }
}

#________________________________________________________________________
# Title     : convert_arr_and_str_2_hash
# Usage     : ($hash1, $hash2)=&convert_arr_and_str_2_hash(\$input, \$input2, '1', '2'.. );
#             * This is the combination of convert_string_to_hash & convert_array_to_hash
# Function  : makes hash(es) out of array(s)
#             if ordering digit(s) is put, it orders the keys according to it.
#             if ordering digit is not increased by one, the difference is used
#             as the increasing factor. No option results in
#             array_1, array_2, array_3...
#
# Example   : &print_seq_in_block(&convert_arr_and_str_2_hash(\@input,\@input2,\@input3 ));
#             &convert_arr_and_str_2_hash(\$input1,\$input2, '2' );
#             results in; (ordering starts from the given '2')
#                          array_2       input1 arraystring
#                          array_3       input2 arraystring
#
#             one more exam
#                          string_6       This is st                  and 3 strings)
#                          string_10      This is st
#                          array_2        111233434242
#                          array_6        111233434242
#                          array_10       111243424224
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more ref. of hashes.
# Tips      :
# Argument  : one or more ref. of arrays
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_arr_and_str_2_hash{ my(@out_ref_hash_str,@s,$i,@w,@c,$diff,$c);
  undef(%temp); undef(%temp2);
  for($i=0; $i<@_; $i++){
	 if ( (ref($_[$i]) eq 'SCALAR')&&(${$_[$i]}=~/^([\d]{1,5})$/) ){
		 push(@c, $1);      }
	 elsif( (ref($_[$i]) eq 'SCALAR')){
		 push(@s, ${$_[$i]});     }
	 elsif( (ref($_[$i]) eq 'ARRAY')){
		 push(@w, join("", @{$_[$i]}));    }
	 elsif( (!ref($_[$i])) && ($_[$i]=~/^([\d]{1,5})$/)){
		 push(@c, $1);      }
	 else{ print "\n There is an odd arg. check convert_arr_and_str_2_hash in $0\n\n";
		print chr(007);   exit;  }  }
  for($i=0; $i<@s; $i++){ my($string)=$s[$i]; my(%temp); ###### array handling
	  if(defined($c[$i])){ $temp{"string_$c[$i]"}=$string;
		  push( @out_ref_hash_str, \%temp); $c=$c[$i]; $diff =$c[$i]-$c[$i-1];      }
	  elsif( !(defined($c[$i])) ){
		  if($diff ==0){	$c=$c+$diff+1; }else{ ($c=$c+$diff) };
		  $temp{"string_$c"}=$string; push( @out_ref_hash_str, \%temp);   } }
  for($i=0; $i<@w; $i++){ my($string)=$w[$i]; my(%temp2);###### string handling
	  if(defined($c[$i])){ $temp2{"array_$c[$i]"}=$string; push( @out_ref_hash_str, \%temp2);
		  $c=$c[$i]; $diff =$c[$i]-$c[$i-1];      }
	  elsif( !(defined($c[$i])) ){
		  if($diff ==0){	$c=$c+$diff+1; }else{ ($c=$c+$diff) };
		  $temp2{"array_$c"}=$string;  push( @out_ref_hash_str, \%temp2); } }
  if( @out_ref_hash_str == 1 ){ return($out_ref_hash_str[0] ); }
  elsif(@out_ref_hash_str > 1){ return(@out_ref_hash_str);}
}

#________________________________________________________________________
# Title     : convert_string_to_hash
# Usage     : ($hash1, $hash2)=&convert_string_to_hash(\$input, \$input2, '1', '2'.. );
# Function  : makes hash(es) out of string(s)
#             if ordering digit(s) is put, it orders the keys according to it.
#             if ordering digit is not increased by one, the difference is used
#             as the increasing factor. No option results in
#             string_1, string_2, string_3...
#
# Example   : &print_seq_in_block(&convert_string_to_hash(\$input,\$input2,\$input3 ));
#             &convert_string_to_hash(\$input1,\$input2, '2' );
#             results in; (ordering starts from the given '2')
#                          string_2       input1 string
#                          string_3       input2 string
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more ref. of hashes.
# Tips      :
# Argument  : one or more ref. of arrays
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_string_to_hash{ my(@out_ref_hash_str)=(); my($i, @w, @c);
  my($diff, $c);
  for($i=0; $i<@_; $i++){
	 if ( (ref($_[$i]) eq 'SCALAR')&&(${$_[$i]}=~/^([\d]{1,5})$/) ){
		 push(@c, $1);
	 }
	 elsif( (ref($_[$i]) eq 'SCALAR')){
		 push(@w, ${$_[$i]});
	 }
	 elsif( (!ref($_[$i])) && ($_[$i]=~/^([\d]{1,5})$/)){
		 push(@c, $1);
	 }
  }
  for($i=0; $i<@w; $i++){   my($string)=$w[$i];
	  if(defined($c[$i])){
		  ${"hash_str$i"}{"string_$c[$i]"}=$string;  my(%temp)=%{"hash_str$i"};
		  push( @out_ref_hash_str, \%temp);
		  $c=$c[$i]; $diff =$c[$i]-$c[$i-1];
	  }
	  elsif( !(defined($c[$i])) ){
		  if($diff ==0){	$c=$c+$diff+1; }else{ ($c=$c+$diff) };
		  ${"hash_str$i"}{"string_$c"}=$string;  my(%temp)=%{"hash_str$i"};
		  push( @out_ref_hash_str, \%temp);
	  }
  }
  if( @out_ref_hash_str == 1 ){ return($out_ref_hash_str[0] ); }
  elsif(@out_ref_hash_str > 1){ return(@out_ref_hash_str);}
}

#________________________________________________________________________
# Title     : convert_array_to_hash
# Usage     : ($hash1, $hash2)=&convert_array_to_hash(\$input, \$input2, '1', '2'.. );
# Function  : makes hash(es) out of array(s)
#             if ordering digit(s) is put, it orders the keys according to it.
#             if ordering digit is not increased by one, the difference is used
#             as the increasing factor. No option results in
#             array_1, array_2, array_3...
#
# Example   : &print_seq_in_block(&convert_array_to_hash(\@input,\@input2,\@input3 ));
#             &convert_array_to_hash(\$input1,\$input2, '2' );
#             results in; (ordering starts from the given '2')
#                          array_2       input1 arraystring
#                          array_3       input2 arraystring
#
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one or more ref. of hashes.
# Tips      :
# Argument  : one or more ref. of arrays
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub convert_array_to_hash{ my(@out_ref_hash_str)=(); my($i, @w, @c);
  my($diff, $c);
  for($i=0; $i<@_; $i++){
	 if ( (ref($_[$i]) eq 'SCALAR')&&(${$_[$i]}=~/^([\d]{1,5})$/) ){
		 push(@c, $1);
	 }
	 elsif( (ref($_[$i]) eq 'ARRAY')){
		 push(@w, $_[$i]);
	 }
	 elsif( (!ref($_[$i])) && ($_[$i]=~/^([\d]{1,5})$/)){
		 push(@c, $1);
	 }
  }
  for($i=0; $i<@w; $i++){   my($string)=join("", @{$w[$i]});
	  if(defined($c[$i])){
		  ${"hash_str$i"}{"array_$c[$i]"}=$string;  my(%temp)=%{"hash_str$i"};
		  push( @out_ref_hash_str, \%temp);
		  $c=$c[$i]; $diff =$c[$i]-$c[$i-1];
	  }
	  elsif( !(defined($c[$i])) ){
		  if($diff ==0){	$c=$c+$diff+1; }else{ ($c=$c+$diff) };
		  ${"hash_str$i"}{"array_$c"}=$string;  my(%temp)=%{"hash_str$i"};
		  push( @out_ref_hash_str, \%temp);
	  }
  }
  if( @out_ref_hash_str == 1 ){ return($out_ref_hash_str[0] ); }
  elsif(@out_ref_hash_str > 1){ return(@out_ref_hash_str);}
}

#________________________________________________________________________
# Title     : remove_dup_in_array
# Usage     : @out2 = @{&remove_dup_in_array(\@input1, \@input2,,,,)};
#             @out1 = @{&remove_dup_in_array(\@input1 )};
# Function  : removes duplicate entries in an array.
# Example   : (1,1,1,1,3,3,3,3,4,4,4,3,3,4,4);  --> (1,3,4);
# Warning   :
# Class     :
# Keywords  : merge array elements, remove_repeting_elements,
#             remove_same_array_elements
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      :
# Argument  : one or more refs for arrays or one array.
# Todo      :
# Author    :
# Version   : 1.2
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub remove_dup_in_array{
  my($i, @out_ref, @nondup,%duplicate, @orig, @out_ref);
  for($i=0; $i<@_; $i++){
	  undef(%duplicate);
	  if(ref($_[$i]) eq 'ARRAY'){    @orig = @{$_[$i]};    }
	  else{ @orig=@_ }
	  @nondup = grep { ! $duplicate{$_}++ } @orig;
	  push(@out_ref, \@nondup);  }
  if(@out_ref ==1){ return($out_ref[0]);}
  elsif(@out_ref >1){  return(@out_ref);}
}

#____________________________________________________________________
# Title     : remove_elements_by_pattern
# Usage     : @out2 = @{&remove_elements_by_pattern(\@input1, \@input2,,,,)};
#             @out1 = @{&remove_elements_by_pattern(\@input1 )};
# Function  : removes elements by pattern in the array
# Example   :  @TARGET=qw(1 % $ ^ # A B 4444 44 4 4 3 33 3 11 A 3 4 4 7 AB);
#              @remove=qw(\W);  # removes all the non word stuff
#              @remove2=qw(\d );
#              @out=@{&remove_elements_by_pattern(\@TARGET, \@remove,\@remove2)};
# Warning   :
# Class     :
# Keywords  : remove_this_elements, remove_these_elements, remove_elements
#             remove_elements_by_position, kill_array_elements, kill_elements
#             take_away_elements
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      :
# Argument  : one or more refs for arrays. The first array is always the
#             only target.
# Todo      :
# Author    :
# Version   : 1.1
# Used in   :
# Enclosed  :
#-----------------------------------------------------------------
sub remove_elements_by_pattern{
  my $i, $j, $k, @elem;
  my @TARGET=@{$_[0]};
  if(@_ < 2){
	 print __LINE__, "\n remove_elements_by_pattern in $0 needs 2 array refs \n\n"
  }
  for($i=1; $i< @_; $i++){
	 if(ref($_[$i]) eq 'ARRAY'){
		push(@elem, @{$_[$i]});
	 }elsif(ref($_[$i]) eq 'SCALAR'){
		push(@elem, ${$_[$i]});
	 }else{
		push(@elem, $_[$i]);
	 }
  }
  for($j=0; $j<@TARGET; $j++){
	 for($k=0; $k<@elem; $k++){
		if($TARGET[$j] =~ /$elem[$k]/){
			splice(@TARGET, $j, 1);
			$j--;
		}
	 }
  }
  return(\@TARGET);
}




#____________________________________________________________________
# Title     : remove_elements_by_name
# Usage     : @out2 = @{&remove_elements_by_name(\@input1, \@input2,,,,)};
#             @out1 = @{&remove_elements_by_name(\@input1 )};
# Function  : removes elements by name in the array
# Example   : ( two input:  (1,2,3,4,4,4,5,5,6,7), (1,3,4)  --> (2,5,5,6,7);
# Warning   :
# Class     :
# Keywords  : remove_this_elements, remove_these_elements, remove_elements
#             remove_elements_by_position, kill_array_elements, kill_elements
#             take_away_elements
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      :
# Argument  : one or more refs for arrays. The first array is always the
#             only target. The removing elements can be scalar ref or
#             just scalar.
# Todo      :
# Author    :
# Version   : 1.1
# Used in   :
# Enclosed  :
#-----------------------------------------------------------------
sub remove_elements_by_name{
  my $i, $j, $k, @elem;
  my @TARGET=@{$_[0]};
  if(@_ < 2){
	 print __LINE__, "\n remove_elements_by_name in $0 needs 2 array refs \n\n"
  }
  for($i=1; $i< @_; $i++){
	 if(ref($_[$i]) eq 'ARRAY'){
		push(@elem, @{$_[$i]});
	 }elsif(ref($_[$i]) eq 'SCALAR'){
		push(@elem, ${$_[$i]});
	 }else{
		push(@elem, $_[$i]);
	 }
  }
  for($j=0; $j<@TARGET; $j++){
	 for($k=0; $k<@elem; $k++){
		if($TARGET[$j] eq $elem[$k]){
			splice(@TARGET, $j, 1);
			$j--;
		}
	 }
  }
  return(\@TARGET);
}

#____________________________________________________________________
# Title     : remove_elements_by_position
# Usage     : @out2 = @{&remove_elements_by_position(\@input1, \@input2,,,,)};
#             @out1 = @{&remove_elements_by_position(\@input1 )};
# Function  : removes elements by name in the array
# Example   : ( two input:  (1,2,3,4,5,6,7), (1,3,4)  --> (2 5 6 7);
# Warning   : Position 1 means $array[0]
# Class     :
# Keywords  : remove_this_elements, remove_these_elements, remove_elements
#             remove_elements_by_position, kill_array_elements, kill_elements
#             take_away_elements
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      :
# Argument  : one or more refs for arrays. The first array is always the
#             only target.
# Todo      :
# Author    :
# Version   : 1.1
# Used in   :
# Enclosed  :
#-----------------------------------------------------------------
sub remove_elements_by_position{
  my $i, $j, $k, @position;
  my @TARGET=@{$_[0]};
  if(@_ < 2){
	 print __LINE__, "\n remove_elements_by_position in $0 needs 2 array refs \n\n"
  }
  for($i=1; $i< @_; $i++){
	 if(ref($_[$i]) eq 'ARRAY'){
		push(@position, @{$_[$i]});
	 }elsif(ref($_[$i]) eq 'SCALAR'){
		push(@position, ${$_[$i]});
	 }else{
		push(@position, $_[$i]);
	 }
  }
  for($j=0; $j<@position; $j++){
	 splice(@TARGET, $position[$j], 1);
  }
  return(\@TARGET);
}



#________________________________________________________________________
# Title     : merge_array
# Usage     : @out2 = @{&merge_array(\@input1, \@input2,,,,)};
#             @out1 = @{&merge_array(\@input1 )};
# Function  : removes duplicate entries in an array. If you put
#             more than one array as inputs, it will produce references of
#             arrays merged singly. Each resulting array is independant.
#             CF. merge_many_arrays
# Example   : (1,1,1,1,3,3,3,3,4,4,4,3,3,4,4);  --> (1,3,4);
# Warning   :
# Class     :
# Keywords  : merge array elements
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      :
# Argument  : one or more refs for arrays.
# Todo      :
# Author    :  A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub merge_array{
  my(@out_ref, %duplicate, $i, @nondup, @orig, @out_ref);
  for($i=0; $i< @_; $i++){
	  undef(%duplicate);
	  if(ref($_[$i]) eq 'ARRAY'){    @orig = @{$_[$i]};    }
	  @nondup = grep { ! $duplicate{$_}++ } @orig;
	  push(@out_ref, \@nondup);  }
  if(@out_ref == 1){ return($out_ref[0]);
  }elsif(@out_ref > 1){  return(@out_ref);}
}

#________________________________________________________________________
# Title     : get_multiple_array_entry
# Usage     : @out2 = @{&merge_array(\@input1, \@input2,,,,)};
#             @out1 = @{&merge_array(\@input1 )};
# Function  : Gets any multiple array entry in a given array. If more than
#             one array is given, each array will have a reference return.
# Example   : (1,1,1,1,3,3,3,3,4,4,4,3,3,4,4);  --> (1,3,4);
#             if you put two arrays(1,1,1,3,3, 100) and (2,2, 4,4, 100), you will get
#             references of arrays( 1,3) and (2,4) ignoring single array entries.
# Warning   :
# Class     :
# Keywords  : multiple entry array, get_common_entry_array
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      : compare with get_common_entry_array
# Argument  : one or more refs for arrays.
# Todo      :
# Author    :
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_multiple_array_entry{
  my(@out_ref, %duplicate, $i, @orig, @common, @out_ref);
  for($i=0; $i< @_; $i++){
	  undef(%duplicate);
	  if(ref($_[$i]) eq 'ARRAY'){    @orig = @{$_[$i]};    }
	  @common = grep { $duplicate{$_}++ } @orig;
	  push(@out_ref, \@common);  }
  if(@out_ref == 1){ return($out_ref[0]);
  }elsif(@out_ref > 1){  return(@out_ref);}
}
#________________________________________________________________________
# Title     : get_common_array_entry
# Usage     : @out2 = @{&merge_array(\@input1, \@input2,,,,)};
#             @out1 = @{&merge_array(\@input1 )};
# Function  : Gets any common array entry in given arrays. If one single array
#             is given, mutiply occurring entries in the array will be returned.
# Example   : (1,1,1,2,3,3,3,4)                 --> (1,3);
#             (1,2,3) (1,2,3,4,5)               --> (1,2,3);
#             (1,2,3,4,5) (1,2,3,4,5) (3,4,5,6) --> (4,5);
# Warning   : accepts only references of arrays(others are ignored).
# Class     :
# Keywords  : multiple entry array, get_common_entry_array, multiply array,
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      : compare with get_common_entry_array
# Argument  : one or more refs for arrays.
# Todo      :
# Author    :
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub get_common_array_entry{
  my(@out_ref, %duplicate, $i, @pooled_big_array, @common, @out_ref);
  for($i=0; $i< @_; $i++){
	  undef(%duplicate);
	  if(ref($_[$i]) eq 'ARRAY'){
		  $array_no ++;
		  push(@pooled_big_array, @{$_[$i]});
	  }
	  @common = grep { $duplicate{$_}++ } @orig;
	  push(@out_ref, \@common);  }
  if(@out_ref == 1){ return($out_ref[0]);
  }elsif(@out_ref > 1){  return(@out_ref);}
}

#________________________________________________________________________
# Title     : merge_many_arrays
# Usage     : @out2 = @{&merge_many_arrays(\@input1, @inputX, \@input2,,,,)};
#             @out1 = @{&merge_many_arrays(\@input1 )};
# Function  : removes duplicate entries in multiple array inputs.
# Example   : (1,1,1,1,3,3), (1,3,3,4,4,4,3,3,4,4);  --> (1,3,4);
# Warning   : synonym of  remove_dup_in_array
# Class     :
# Keywords  : merge array elements from multiple arrays.
# Options   :
# Package   : Bio::Seq
# Reference :
# Returns   : one reference.
# Tips      :
# Argument  : one or more refs for arrays. or just arrays.
# Todo      :
# Author    :
# Version   : 1
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub merge_many_arrays{ my(@out_ref, %duplicate,$i, @orig, @out_ref);
  for($i=0; $i<@_; $i++){   undef(%duplicate);
	  if(ref($_[$i]) eq 'ARRAY'){    @orig = (@orig, @{$_[$i]});
	  }else{ push(@orig, $_[$i]); }
  }
  @nondup = grep { ! $duplicate{$_}++ } @orig;
  return(\@nondup)
}


#________________________________________________________________________
# Title     : remove_repetitives_in_array
# Usage     : @out2 = @{&remove_repetitives_in_array(\@input1, \@input2,,,,)};
#             @out1 = @{&remove_repetitives_in_array(\@input1 )};
# Function  : removes duplicate entries in an array. If you put
#             more than one array as inputs, it will produce references of
#             arrays merged singly. Each resulting array is independant.
#             CF. merge_many_arrays
# Example   : (1,1,1,1,3,3,3,3,4,4,4,3,3,4,4);  --> (1,3,4);
# Warning   : synonym of  remove_dup_in_array
# Class     :
# Keywords  : remove_dup_in_array, merge array elements, remove_duplicates,
# Options   :
# Package   :
# Reference :
# Returns   : one or more references.
# Tips      :
# Argument  : one or more refs for arrays.
# Todo      :
# Author    :
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub remove_repetitives_in_array{
  my(@out_ref, %duplicate,$i, @orig, @out_ref);
  for($i=0; $i<@_; $i++){   undef(%duplicate);
	  if(ref($_[$i]) eq 'ARRAY'){    @orig = @{$_[$i]};    }
	  @nondup = grep { ! $duplicate{$_}++ } @orig;
	  push(@out_ref, \@nondup);  }
  if(@out_ref ==1){ return($out_ref[0]);}
  elsif(@out_ref >1){  return(@out_ref);}
}



#________________________________________________________________________
# Title     : filter_hash_by_num_value
# Usage     : ($ref1, $ref2, $ref3)=&filter_hash_by_num_value(\%h1, \$thres,...);
# Function  : returns hash refs. after filtering with threshold value.
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   :
# Tips      :
# Argument  :
# Todo      :
# Author    : A Biomatic
# Version   : 1.0
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub filter_hash_by_num_value{
  my(%output, $i, $input,$j);
  for($i=0; $i < @_; $i++){
	 if   ( ref($_[$i]) eq 'HASH'  ){  %{"input$j"}=%{$_[$i]}; $j++; }
	 elsif( ref($_[$i]) eq 'SCALAR'){  $input      =${$_[$i]}; }
	 elsif( ref($_[$i]) eq 'ARRAY' ){  @{"input$i"}=@{$_[$i]}; }
	 elsif( !( ref($_[$i]) ) )      {
		 if( $_[$i] =~ /^([\.\d]+)$/){  $input  = $1;} }
	 else {   print "\n The input to handle_args has problem \n"; exit;  }  }
  for($i=0; $i < $j; $i++){
	  my(@keys)= keys %{"input$i"}; my($threshold)=$input;
	  for $key (@keys){
		 if(${"input$i"}{$key} > $threshold){ ${"output$i"}{$key}=${"input$i"}{$key};} }
	  push(@out_hash_ref, \%{"output$i"});  }
  if(@out_hash_ref == 1){ return($out_hash_ref[0]); }
  elsif(@out_hash_ref > 1){ return(@out_hash_ref); } package main;
}

#________________________________________________________________________
# Title     : dir_search_single  (refer dir_search for a list of possible dirs)
# Usage     : $output_best_possible_dir = ${&dir_search_single(\$input_name)};
# Function  : With given full path or single name for a dir. it returns
#             the full path dir name. If it fails to find in pwd or given
#             specified path, it tries to search PATH, HOME etc..
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one Ref. for an array.
# Tips      :
# Argument  : One Ref. for a scalar.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub dir_search_single{    my($in_dir)=${$_[0]};
  my(@ENV_dir,$pwd,@temp,@probable_dir_list, @dirs,@possible_dirs,$final_dir_found);
  if (!(-d $in_dir)){
		if ($in_dir =~/^[\w\.\-]+$/){ $pwd=`pwd`; chomp($pwd);
			 if(-d "$pwd\/$in_dir" ){
				 $final_dir_found = "$pwd\/$in_dir";
			 }
			 elsif( !(-d "$pwd/$in_dir" ) ){
				 @temp=split('/', $pwd); # goes up one level.
				 pop(@temp);
				 $up_pwd=join("/", @temp);
				 if (-d "$up_pwd\/$in_dir"){
					$final_dir_found=$in_dir ;
				 }elsif( !(-d "$up_pwd/$in_dir" ) ){
					 @probable_dir_list=('JPO','ALIGN','PDB','PATH','HOME','PIRDIR',
						  'PDBSST','PDBENT', 'BLASTDB', 'PIRDIR', 'SWDIR');
					 for $elem (@probable_dir_list){
						 @dirs=split(/:/, $ENV{$elem});
						 for (@dirs){
							if (/$in_dir$/){  # if $in_dir matches with a set dir.
								$final_dir_found=$_;
							}elsif( -d "$_\/$in_dir"){
								$final_dir_found="$_\/$in_dir";
							}
						 }
					 }
				 }#<---}elsif( !(-d "$up_pwd/$in_dir" ) ){
			 }
		}elsif($in_dir =~ /\/([\w\.\-]+)$/){ # if it is a full path.
			  $in_dir = $1;
			  if(-d "$pwd\/$in_dir" ){
				  $final_dir_found = "$pwd\/$in_dir"; last;
			  }elsif( !(-d "$pwd\/$in_dir" ) ){
				  $in_dir="$up_pwd\/$in_dir";
				  $final_dir_found=$in_dir if (-d $in_dir); last;
			  }else{
				  for (@probable_dir_list){
					  @dirs=split(':', $ENV{$_});
					  for (@dirs){
						 if (/$in_dir$/){
							$final_dir_found=$_; last;
						 }
					  }
				  }
			  }
		 }
	}else{  # If the input dir is there as it is!! (no need to process)
		$final_dir_found = $in_dir;
	}
	return(\$final_dir_found);
}
#________________________________________________________________________
# Title     : dir_search  (look at dir_search_single for one dir lookup)
# Usage     : @output_possible_dirs = @{&dir_search(\$input_name)};
# Function  : With given full path or single name for a dir. it returns
#             the full path dir name. If it fails to find in pwd or given
#             specified path, it tries to search PATH, HOME etc..
# Example   :
# Warning   :
# Class     :
# Keywords  :
# Options   :
# Package   :
# Reference :
# Returns   : one Ref. for an array.
# Tips      :
# Argument  : One Ref. for a scalar.
# Todo      :
# Author    : A Biomatic
# Version   :
# Used in   :
# Enclosed  :
#--------------------------------------------------------------------
sub dir_search{
		my($in_dir)=${$_[0]};
		my(@ENV_dir, @probable_dir_list, @dirs,@possible_dirs);
		if($in_dir =~ /\/([\w\.\-]+)$/){
		  $in_dir = $1;
		}
		@probable_dir_list=('PDB', 'PATH', 'HOME', 'JPO', 'PIRDIR', 'PDBSST','PDBENT',
								  'BLASTDB', 'PIRDIR', 'SWDIR');
		for (@probable_dir_list){
		  @dirs=split(':', $ENV{$_});
		  for (@dirs){
			 if (/$in_dir$/){
				push(@possible_dirs, $_);
			 }
		  }
		}
		if(@possible_dirs <1){  # goes up one level and tries to find dir.
		  my($pwd)=`pwd`; chomp($pwd);
		  my(@temp)=split('/', $pwd);
		  pop(@temp);
		  my($up_pwd)=join("/", @temp);
		  $in_dir="$up_pwd\/$in_dir";
		  push(@possible_dirs, $in_dir) if (-d $in_dir);
		}
		\@possible_dirs;
}


1;	# can be any non zero digit
__END__


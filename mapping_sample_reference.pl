#!/usr/bin/perl -w

my ($series_matrix) = @ARGV;

open (IN,"<", "$series_matrix") or die "Cannot find the required file!\n";
open (SAMPLE_TITLE,'>s_title.txt') or die "Cannot write into file s_title.txt!\n";
open (SAMPLE,'>s_id.txt') or die "Cannot write into s_id.txt!\n";
open (S_DESC,'>s_desc.txt') or die "Cannot write into file s_desc.txt!\n";

@file= <IN>;
chomp @file;

foreach $_(@file)
{
	$_=~s/\r//g;
	$_=~s/"//g;
	$_=~s/#//g;
	#print "hello\n";
	if ($_=~/\!Sample_title/)
	{
		print "match1\n";
		@sample_t= split (/\t/,$_);
		$sample_t_len=@sample_t;
		print "$sample_t_len elements!\n";
		for ($i=1;$i<=@sample_t;$i++)
		{
			print SAMPLE_TITLE "$sample_t[$i]\n";
		}
		
	}
	else
	{
		
	} 
	if ($_=~/\!Sample_geo_accession/) 
	{
		print "match2\n";
		@sample= split (/\t/,$_);
		$samplelen=@sample;
		print "$samplelen elements!\n";
		for ($j=1;$j<=@sample;$j++)
		{
			print SAMPLE "$sample[$j]\n";
		}

	}
	else
	{
		
	}
	if ($_=~/\!Sample_description/)
	{
		print "match3\n";
		@sample_desc= split (/\t/,$_);
		$sample_desc_len=@sample;
		print "$sample_desc_len elements!\n";
		for ($k=1;$k<=@sample_desc;$k++)
		{
			print S_DESC "$sample_desc[$k]\n";
		}
	}
	else
	{
		
	}
}
system "paste s_title.txt s_id.txt s_desc.txt>mapping_reference_out.txt";
close IN,SAMPLE,S_DESC; 
	

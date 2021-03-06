#!/usr/bin/perl -w
use POSIX qw/floor/;

my ($bim, $snploc) = @ARGV;

open (IN1,"<", "$bim") or die "Cannot open $bim!\n";
open (IN2,"<", "$snploc") or die "Cannot open $snploc!\n";
open (OUT1,">", "snploc_matched.txt") or die "Cannot write into snploc_4.txt!\n";

@gsesnp=<IN1>;
chomp @gsesnp;
@snp3=<IN2>;
chomp @snp3;


for ($j=0;$j<@snp3;$j++)
{
	$snp3[$j]=~s/\r//g;
	if ($snp3[$j] eq "")
	{
	}
	else
	{
		@splitsnp3=split('\t',$snp3[$j]);
		@temparray= [$splitsnp3[0], $j];
		push @lines, @temparray;
	}
}

#print "@lines";

@sorted = sort {$a->[0] cmp $b->[0]}  @lines; 

my @col = map $_->[0],@sorted;


for ($i=0;$i<@gsesnp;$i++)
{
	$gsesnp[$i]=~s/\r//g;
	@a=split('\t',$gsesnp[$i]);
	$low_idx = 0;
	$high_idx = @col;
	$c="";
	while ($low_idx <= $high_idx)
	{
		$mid_idx = floor(($low_idx+$high_idx)/2);
#		print "$col[$mid_idx] \t $a[1] \t $high_idx \n";
		if ($col[$mid_idx] gt $a[1])
		{
			$high_idx = $mid_idx;
		}
		elsif ($col[$mid_idx] lt $a[1])
		{
			$low_idx = $mid_idx;
		}
		else
		{
			$correct_idx=$sorted[$mid_idx][1];
			#print "$sorted[$mid_idx][1]\n";
			$c="$snp3[$correct_idx]\n";
			$low_idx=$high_idx+1;
		}
#		$low_idx=$high_idx+1;

	}
	print OUT1 "$c";
}

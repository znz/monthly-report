#!/usr/bin/perl

#$t=1;
#while( $t < 256 ){
#  printf( "\\ja\\char%d",$t );
#  ++$t;
#}
  $t=33;
  while( $t < 114 ){
    printf( "\'\x1b\x24\x42\x27%c\x1b\x28\x42\' \'\' %2d\n",$t,$t-32);
    ++$t;
  }


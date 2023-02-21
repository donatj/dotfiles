#!/usr/bin/env php
<?php

$string = "";

$opt = getopt('r');

while( $line = fgets(STDIN) ) {
	$string .= $line;
}

$string = str_replace([ "\r", "\n" ], ' ', $string);

$joinParts = preg_split('/\s(inner |outer |left | right)?join\s.*?\son\s/i', $string);

$ins  = [];
$outs = [];
array_shift($joinParts);
foreach( $joinParts as $joinPart ) {
	$j = preg_split('/\sand\s/i', $joinPart, -1, PREG_SPLIT_NO_EMPTY);

	foreach( $j as $k ) {
		$equalParts = explode("=", $k, 2);

		$ins[]  = trim($equalParts[0]);
		$outs[] = trim($equalParts[1]);
	}
}

if( isset($opt['r']) ) {
	[ $ins, $outs ] = [ $outs, $ins ];
}

$ins_tbl_parts  = explode(".", $ins[0], 2);
$outs_tbl_parts = explode(".", $outs[0], 2);

$table1 = $ins_tbl_parts[0];
$table2 = $outs_tbl_parts[0];

$in  = implode(", \n\t", $ins);
$out = implode(", \n\t", $outs);

echo "INSERT INTO `{$table1}` \n(\n\t{$in}\n) \n\n(SELECT\n\t{$out}\nFROM `{$table2}`)";

echo PHP_EOL;

function see( $data ) {
	echo "\n\n---V---\n";
	var_export($data);
	echo "\n---X---\n\n";
}
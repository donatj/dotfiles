#!/usr/bin/env php
<?php

$string = "";

$opt = getopt('r');

while( $line = fgets(STDIN) ) {
	$string .= $line;
}

$string = strtolower($string);
$string = str_replace(array( "\r", "\n" ), ' ', $string);

$joinparts = preg_split('/\s(inner |outer |left | right)?join\s.*?\son\s/', $string);

$ins  = array();
$outs = array();
array_shift($joinparts);
foreach( $joinparts as $joinpart ) {
	$j = explode(" and ", $joinpart);

	foreach( $j as $k ) {
		// print_r($k);
		$equalparts = explode("=", $k, 2);
		// print_r($equalparts);
		$ins[]  = trim($equalparts[0]);
		$outs[] = trim($equalparts[1]);
	}
}

if( isset($opt['r']) ) {
	list($ins, $outs) = [ $outs, $ins ];
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
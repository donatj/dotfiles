#!/usr/bin/env php
<?php

$string = $argv[1];
$string = strtolower($string);
$string = str_replace(array("\r", "\n"), ' ', $string);

$onparts = explode(" on ", $string, 2);
$j = explode(" and ", $onparts[1]);

$ins = array();
$outs = array();
foreach($j as $k) {
	// print_r($k);
	$equalparts = explode("=", $k, 2);
	// print_r($equalparts);
	$ins[] = trim($equalparts[0]);
	$outs[] = trim($equalparts[1]);
}

$ins_tbl_parts = explode(".", $ins[0], 2);
$table1 = $ins_tbl_parts[0];

$outs_tbl_parts = explode(".", $outs[0], 2);
$table2 = $outs_tbl_parts[0];

$in  = implode(", \n\t", $ins);
$out = implode(", \n\t", $outs);

echo "INSERT INTO `{$table1}` \n(\n\t{$in}\n) \n\n(SELECT\n\t{$out}\nFROM `{$table2}`)"; 

echo PHP_EOL;
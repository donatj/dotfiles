#!/usr/bin/env php
<?php

// On Error GoTo 10
// Dim ins As New List(Of String)
// Dim outs As New List(Of String)
// Dim i As String = TextBoxIn.Text


// Dim j As String() = Split(i, " and ", -1, CompareMethod.Text)

// For Each k As String In j
// 	Dim a As String = k.Substring(k.LastIndexOf("=") + 1)
// 	Dim b As String = k.Substring(0, k.LastIndexOf("="))
// 	ins.Add(a.Trim)
// 	outs.Add(b.Trim)
// Next
// Dim table1 As String = ins.First.Substring(0, ins.First.LastIndexOf("."))
// Dim table2 As String = outs.First.Substring(0, outs.First.LastIndexOf("."))
// TextBoxOut.Text = "Insert Into " & table1 & vbCrLf & "( " & Join(ins.ToArray, ", " & vbCrLf) & " ) " & vbCrLf & "( Select " & vbCrLf & Join(outs.ToArray, ", " & vbCrLf) & " From " & table2 & " )"
// Return
// 10:
// TextBoxOut.Text = ""

// print_r($argv[1]);

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
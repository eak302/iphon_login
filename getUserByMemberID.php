<?php
  $objConnect = mysql_connect("localhost","root","root");
	$objDB = mysql_select_db("mydatabase");
	
	//$_POST["sMemberID"] = "1"; // for Sample

	$strMemberID = $_POST["sMemberID"];
	$strSQL = "SELECT * FROM member WHERE 1 AND MemberID = '".$strMemberID."'  ";

	$objQuery = mysql_query($strSQL);
	$obResult = mysql_fetch_array($objQuery);
	if($obResult)
	{
		$arr["MemberID"] = $obResult["MemberID"];
		$arr["Username"] = $obResult["Username"];
		$arr["Password"] = $obResult["Password"];
		$arr["Name"] = $obResult["Name"];
		$arr["Email"] = $obResult["Email"];
		$arr["Tel"] = $obResult["Tel"];
	}

	
	mysql_close($objConnect);

	/*** return JSON by MemberID ***/
	/* Eg :
	{"MemberID":"2",
	"Username":"adisorn",
	"Password":"adisorn@2",
	"Name":"Adisorn Bunsong",
	"Tel":"021978032",
	"Email":"adisorn@thaicreate.com"}
	*/
	
	echo json_encode($arr);
?>

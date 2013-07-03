<?php
  $objConnect = mysql_connect("localhost","root","root");
	$objDB = mysql_select_db("mydatabase");

	//$_POST["sUsername"] = "weerachai"; // for Sample
	//$_POST["sPassword"] = "weerachai@1";  // for Sample

	$strUsername = $_POST["sUsername"];
	$strPassword = $_POST["sPassword"];
	$strSQL = "SELECT * FROM member WHERE 1 
		AND Username = '".$strUsername."'  
		AND Password = '".$strPassword."'  
		";

	$objQuery = mysql_query($strSQL);
	$objResult = mysql_fetch_array($objQuery);
	$intNumRows = mysql_num_rows($objQuery);
	if($intNumRows==0)
	{
		$arr["Status"] = "0";
		$arr["MemberID"] = "0";
		$arr["Message"] = "Incorrect Username and Password";
		
		echo json_encode($arr);
		exit();
	}
	else
	{
		$arr["Status"] = "1";
		$arr["MemberID"] = $objResult["MemberID"];
		$arr["Message"] = "Login Successfully";

		echo json_encode($arr);
		exit();
	}

	/**
	return 
		 // (0=Failed , 1=Complete)
		 // MemberID
		 // Error Message
	*/
	
	mysql_close($objConnect);
	
?>

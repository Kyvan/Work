<?php  
error_reporting(0);  

$request = "Keeper / HTTP/1.1\r\n  
User-Agent: Mozilla/4.0 (Compatible; whatever)\r\n  
Host: google.com\r\n  
Accept: */*\r\n";  

$urltarget = $_POST['url'];  

$socket = fsockopen($urltarget);  
fwrite($socket,$request);  
$received = fread($socket,1024*1024);  
echo $received;  

?>  
<?php 
$currentLanguage = $_POST["language"];
if (!isset($currentLanguage)) {
    $currentLanguage = $_GET["language"];
}
if (!isset($currentLanguage)) {
    $currentLanguage = 'en';
}
$languageXMLdoc = new DOMDocument();
$languageXMLdoc->load($currentLanguage.'.xml');
function getMyLocalizedMessage($doc, $messageName) {
	return $doc->getElementsByTagName($messageName)->item(0)->nodeValue;
};
?>
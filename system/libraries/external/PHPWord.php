<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once(SYSTEMPATH . 'libraries/external/PHPWord/vendor/autoload.php');

class PHPWord {
	function __construct() {
	}
}

if( !function_exists('PhpWord_PhpWord') ){
	function PhpWord_PhpWord($source = NULL) {
		if( $source == NULL )
			return new \PhpOffice\PhpWord\PhpWord();
		else
			return \PhpOffice\PhpWord\IOFactory::load($source);
	}
}

if( !function_exists('PhpWord_TemplateProcessor') ){
	function PhpWord_TemplateProcessor($filename) {
		return new \PhpOffice\PhpWord\TemplateProcessor($filename);
	}
}

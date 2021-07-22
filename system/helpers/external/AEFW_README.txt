CHANGE CONFIG
=====================================================
copy phpThumb.config.php to ../config/PHPTHUMB_CONFIG.php

$PHPTHUMB_CONFIG['disable_debug']               = true; // 
//$PHPTHUMB_CONFIG['high_security_enabled']       = true; // 
$PHPTHUMB_CONFIG['high_security_password']      = md5('1nd0n3t50ft'); // 
$PHPTHUMB_CONFIG['cache_directory'] = cache_path() . '/'; // 
$PHPTHUMB_CONFIG['cache_maxage'] = 86400 * 3; // 
$PHPTHUMB_CONFIG['cache_source_directory'] = cache_path('source') . '/'; // 
//$PHPTHUMB_CONFIG['cache_source_filemtime_ignore_local']  = false; // 
$PHPTHUMB_CONFIG['cache_source_filemtime_ignore_remote'] = false; // 
$PHPTHUMB_CONFIG['output_format']    = 'png'; // 
$PHPTHUMB_CONFIG['nohotlink_enabled']           = false; // 
$PHPTHUMB_CONFIG['nooffsitelink_enabled']       = false; // 
$PHPTHUMB_CONFIG['http_user_agent'] = (isset($_SERVER['HTTP_USER_AGENT'])) ? $_SERVER['HTTP_USER_AGENT'] : false ;
$PHPTHUMB_CONFIG['disable_pathinfo_parsing']        = false; // 
$PHPTHUMB_CONFIG['allow_local_http_src']         = true; // 

Remove function phpThumbURL to last

-----------------------------------------------------

phpThumb.config.php
After // END DEFAULT PARAMETERS SECTION
please append code bellow
$PHPTHUMB_CONFIG = get_config('PHPTHUMB_CONFIG');

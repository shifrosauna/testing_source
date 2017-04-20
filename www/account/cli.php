<?php
/**
 * Point of entry for all async tasks.
 */

chdir(dirname(__FILE__));

// Register The Auto Loader
$_SERVER['DOCUMENT_ROOT'] = dirname(__FILE__);

require_once __DIR__ . '/../../vendor/autoload.php';

// Run The Application
$engine = new \App\Engine('account', 'Cli');

// Environment adjustment
$engine->setDefaultTimezone();
$engine->setExceptionsHandler();

\App\Exceptions\Handlers\Control::$debug = true;

$engine->parseCliQuery($argv);
$engine->findControllerAndAction();

$engine->execute();
$engine->output();
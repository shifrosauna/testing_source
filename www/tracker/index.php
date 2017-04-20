<?php
/**
 * Point of entry for all requests.
 */

// Register The Auto Loader
require_once __DIR__ . '/../../vendor/autoload.php';

// Run The Application
$engine = new \App\Engine('tracker', 'Tracker');

// Environment adjustment
$engine->setDefaultTimezone();
$engine->setExceptionsHandler();

$engine->parseQuery();
$engine->findControllerAndAction('Index');

$engine->execute();
$engine->output();
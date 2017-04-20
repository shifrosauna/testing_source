<?php
/**
 * Point of entry for all requests.
 */

// Register The Auto Loader
require_once __DIR__ . '/../../vendor/autoload.php';

// Run The Application
$engine = new \App\Engine('account', 'Account');

// Environment adjustment
$engine->setLanguage();
$engine->setDefaultTimezone();
$engine->setExceptionsHandler();

$engine->parseQuery();
$engine->findControllerAndAction();

$engine->checkWorkAccess();
$engine->checkUser();
$engine->setHTMLViews();

$engine->execute();
$engine->output();
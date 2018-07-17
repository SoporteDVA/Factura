<?php
class Log
{
public function __construct($filename, $path)
{
$this->path     = ($path) ? $path : "/";
$this->filename = ($filename) ? $filename : "log";
$this->date     = date("Y-m-d H:i:s");
$this->ip       = ($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : 0;
}

?>
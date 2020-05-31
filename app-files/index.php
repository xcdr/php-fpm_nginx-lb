<?php
    header('Content-Type: text/plain');

    printf("Dynamic content!\n\nNode environment:\n");
    printf("- hostname: %s\n", $_ENV['HOSTNAME']);
    printf("- app mode: %s\n", $_ENV['APP_ENV']);
?>

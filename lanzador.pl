#!/usr/bin/perl
#**************************************************************
#         		Pontificia Universidad Javeriana
#     Autor: J. Corredor
#     Fecha: Febrero 2024
#     Materia: Sistemas Operativos
#     Tema: Taller de Evaluación de Rendimiento
#     Fichero: script automatización ejecución por lotes 
#****************************************************************/

$Path = `pwd`;
chomp($Path);

#Para las pruebas, fueron editadas las líneas que tienen copmentarioal frente
$Nombre_Ejecutable = "MM_ejecutable";
@Size_Matriz = ("3000");  #Matriz de X * X
@Num_Hilos = (1);        #Se pone el hilo acá
$Repeticiones = 3;       #Y acá se pone el número de repeticiones

#Se hace el foreach de la matriz y el número de hilos
foreach $size (@Size_Matriz){
	foreach $hilo (@Num_Hilos) {
    
        #Acá se guardan los resultados de cada archivo
		$file="$Path/$Nombre_Ejecutable-".$size."-Hilos-".$hilo.".dat";
        
        #Se ingresa una variable que indica el tiempo total
		my $total_time = 0;

		for ($i = 0; $i<$Repeticiones; $i++) {
			#Ejecuta y captura la salida del tiempo de ejecución
			my $output=`$Path/$Nombre_Ejecutable $size $hilo`;
			printf("$Path/$Nombre_Ejecutable $size $hilo \n");

			#Extrae el tiempo de ejecución desde la salida contando
            #desde 1 y el tiempo total en cada ejecución
			if ($output =~ /(\d+)\s*µs/) {
				my $time = $1;
				$total_time += $time;
				
				#Se guarda la salida completa en el archivo y se hace un manejo de errores
				open(my $fh, '>>', $file) or die "No se puede abrir el archivo '$file' $!";
				print $fh $output;
				close($fh);
			}
		}

		#Acá se calculó el promedio / sobre las repeticiones
		my $avg_time = $total_time / $Repeticiones;
		print "El tiempo promedio de ejecución para matriz $size x $size con $hilo hilo es: $avg_time µs\n";
	}
}
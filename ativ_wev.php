<?php
$usuario   = "bryantavares";		// um usuário criado no banco para este script
$senha     = "";	// a senha do usuário

$banco = mysqli_connect("localhost", $usuario, $senha, "WEB");
if (!$banco){
	echo "Erro ao tentar acessar o banco de dados<br>\n";
	exit (0);
}

$cria = "SELECT * from alunos;";
/* Banco aberto está no mysqli_connect: banco WEB. Opcionalmente pode ser
 * SELECT * from WEB.alunos mas cuidado com o ponto
 * */
$ret = mysqli_query($banco, $cria);

if (!$ret) {
	echo "Não pode executar a query.<br>\n";
	echo mysqli_error($banco)."<br>";
} else {
	$dados = mysqli_fetch_all($ret, MYSQLI_ASSOC);
	echo "<pre>\n";
	print_r($dados);
	echo "</pre>\n";
}

if (mysqli_close($banco)) {
	echo "Conexão com banco de dados FECHADA<br>\n";
}
?>

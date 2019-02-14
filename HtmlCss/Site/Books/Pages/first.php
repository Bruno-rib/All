<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="AllWebpages.css"/>
	
    <meta charset="utf-8">
    <title>Bruno</title>
	
	<style>
		form {font-size:1em;
			color:black;
			text-align:center;
			text-indent:initial;
		}
		
		a:hover {
		color:darkblue;
		text-decoration:none;
		font-weight:bold;
		}
		
		input[type="textarea"] {
			width: 400px;
		}
		input[placeholder] {
			color:grey;
		}
		
	</style>
	
	
</head>
<!--   --------------------------------------END HEAD---->
<body>
	<div id="head">
		<h1>PHP</h1>
	</div>
	<div id="menu">
		<ul>
		<li><a href="#dice">Dice</a> </li> 
		<li><a href="#time">Time</a></li> 
		<li><a href="#date">Date  </a></li> 
		<li><a href="#comment">Comment  </a></li> 
		</ul>
	</div>
	<div id="box11">
		<h2 id="dice"> 
		<form action="first.php" method="POST">
			<input type="submit" name="roll" value="Roll dice.">
		</form>
		 </h2>
		<p>
		<?php
		if (isset($_POST['roll'])) {
			$rand = rand(1, 6);
			$rand1 = rand(1,6);
			echo 'You rolled a '.$rand.', while the house
			rolled a '.$rand1.'.';
			
			if ($rand >= $rand1) {
				echo '<br>You WON!';
			} else {
				echo '<br>House wins, today is nacho your lucky day... ';
			}
		}
		?>
		</p>
	</div>
	<!---------------------------------------------->
	<div id="box12">
		<h2 id="time"> Time logged </h2>

		<p>
		<?php
		$time = time();
		$actual_time = date('D d M Y @ H:i:s', ($time - 60*60*9));

		echo 'The current date/time is <br>'.$actual_time;
		?> 
		</p>
	</div>
	<!--------------------------------------------->
	<div id="box21">
		<h3 id="date" > 
		<form action="first.php" method="GET">
			Birthday:<br><input type="text" name="day" placeholder="Day as a number"><br>
			Month:<br><input type="text" name="date" placeholder="Month as a number"><br>
			Year:<br><input type="text" name="year" placeholder="Year as a 4 digit number"><br><br>
			<input type="submit" value="Submit">
		</form>
		</h3>
		<p>
		<?php
		if (isset ($_GET['day'])
		&&isset($_GET['date']) &&isset($_GET['year'])) {
			$day = $_GET['day'];
			$date = $_GET['date'];
			$year = $_GET['year'];
			if(!empty($day)&&!empty($date)&&!empty($year)) {
				$x=($day*60*60*24)+($date*60*60*24*30.4375)
				+(($year-1970)*60*60*24*365.25);
				echo 'You have been alive for: '.(time()-$x).' seconds.';
			}	else {
				echo 'Fill in all fields.';
			}
		}
		?>
		</p>
	</div>
	<div id="box22">
			<h3 id="comment"> 
			<form action="first.php" method="POST">
			Comment:<br><br>
			<textarea name="comment" rows="4" cols="50"></textarea><br><br>
			<input type="submit" value="Submit">
			</form>
			</h3>
		<p>
			<?php

			if (isset($_POST['comment'])) { 
				$comment = $_POST['comment'];
				if (!empty($comment)) {
					
					$handle = fopen('comments.txt','a');
					fwrite($handle,$comment."\n\n\n");
					fclose($handle);
					
					echo 'Thanks for your comment.';
		
				} else {
					echo 'Please type a comment.';
				}
			}

			?>
		</p>
	</div>
</body>


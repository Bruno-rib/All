function setup() {
	createCanvas(600, 400);
	background(0);
	let button = createButton('press');
	button.mousePressed(changeBackground);

	function chageBackground() {
		background(random(255));
	}
}
/*  WELCOME TO PULSAR STAR GAME

/////       MOUSE CONTROLLED!!       //////
//////       CLICK TO SHOOT         ///////

1.Avoid the comets
2.Shoot the Pulsar Star
    (keep it in a not threatening size)
3.Do not let your gun over heat!
4.Save The world!
*/

/* Score:
when end screen shows up with your score, save it as a spin-off; your score will be saved for everyone to see
then comment it below.
*/

cursor("");

// global variables
{
//black hole
var blackSize = 5;
var n = 1;
var b = 0;

//STARS AND PLANETS OBJECT
var sizeX = sizeX;
var sizeY = sizeY;

// LOGO
var n1 = 0.01;
var angle1 = -45;
var t = 0;
var c = 0;

// END MESSAGE
var score = 0;
var lives = 3;
var days = 1;

//austronaut and death ray
var overHeat = 0;
var austX = mouseX;
var austY = mouseY;
var x1 = 320;
var y1 = 320;
var overHeat = 20;
var n = 1;
var sp = getImage("space/octopus");
var theta = 0;

// comets
var cxl = 45;
var cxr = -1;
var cyu = 45;
var cyd = -1;

//intro
{var tl = 0;
var pl = 0;
var x = 375;
var y = 25;
var cx1 = 80;
var cy1 = 360;
var x2 = 101;
var y2 = 101;
var sp = getImage("space/octopus");
var angle = 0;
var pos={
  x:35,
  y:390
};
 
var flames = [];
var r = 8;
var s = 15;
}

//reset counter
var co = co;
if (isNaN(co)) {
    co = 1;   
} else if (co > 2) {
t = 750;
}
co++;

}

// LOGO function
{
var logo = function() {
    if (t<746) {
        
    if (n1<3) {
        if (t>50) {
        n1+=0.1;
        }
    
        for (var j = -1; j<401; j++){
            stroke(255-j, 148-j, 255-j/2);
            line (0,j,400,j);
        }
    }
    
    pushMatrix();
    noStroke();
    translate(200 - 10 *n1,300 - 10 *n1);
    scale(n1);
    rotate(angle1);

    fill(0, 0 , 0 );
    textSize(36);
    text("G",-20, 0, 100, 100);
    text("B",20, 0, 100, 100);
    textSize(19);
    text("2",40, -20, 100, 100);
    ellipse (14, 14, 5, 5);
    
    fill(230 - c, 3 - c, 226 - c);
    textSize(32);    
    text("G",-20, 0, 100, 100);
    text("B",20, 0, 100, 100);
    textSize(16);
    text("2",40, -20, 100, 100);
    fill(230 + c, 3 + c/2, 226 + c);
    ellipse (13, 13, 3, 3);
    popMatrix();
    t++;
    if (t > 400) {
        angle1+= 2;
        n1+=0.04;
        c++;
    }
    } else {
        background(0, 0, 0);
    }
};

}

// static intro screen
{
var z= function (x, y){
    
    strokeWeight(1);
    noFill();
    for (var y=1; y<20;y+= y/10){
        for(var x=1; x<20; x += x/10){
            stroke(255, 255, 255,80);
            fill(143, 137, 137);
            line(x*x + 100,y * y +100,x2*x2 ,y2*y2 );
            x2 = x;
            y2 = y;
        }
    }
};

var header = function() {
    var theta = atan2(y - cy1, x - cx1);
    pushMatrix();
    translate(cx1, cy1);
    rotate(theta);
    image (sp, -60, -80, 80, 80);
    popMatrix();
};

var launch = function() {
    pushMatrix();
    translate (400, 0);
    rotate (90);
    background (0, 0, 0);
    fill(53, 53, 97);
    triangle (100,100,100,800,800,100);
    z(1, 1);
    popMatrix();
};

var buttons = function() {
    textSize(16);
    fill(255, 0, 0);
    rect(40, 290, 100, 40);
    fill(166, 255, 0);
    text ("click to play" , 50, 300, 400, 400);
    
    textSize(16);
    fill(255, 0, 0);
    rect(240, 40, 100, 40);
    fill(166, 255, 0);
    text ("instructions" , 250, 50, 400, 400);
    
    textSize (57);
    fill(255, 255, 255);
    text("PULSAR STAR", 148, 218, 200, 200);
    textSize(55);
    fill (255, 0, random (0, 255));
    text("PULSAR STAR", 150, 220, 200, 200);

    
};

var updateFlames = function(f){
    for (var i=f.length-1;i>=0;i--){
        f[i].r+=r;
        if(f[i].r>200){
            f.splice(i,1);
        }
    }
};
 
var drawFlames = function(f){
    var t,c;
    var fromColor = color(0, 0, 0);
    var toColor = color(255, 0, 0);
    noFill();
    strokeWeight(s);
    for (var i=f.length-1;i>=0;i--){
        c = lerpColor(fromColor,toColor,f[i].r*20/255);
        stroke(c);
        t = atan2(f[i].dy,f[i].dx);
        arc(f[i].x,f[i].y,f[i].r,f[i].r,t-15,t+15);
    }
};

var flamesMov = function() {
    pushMatrix();
    if (r< 350 && angle <= 180 && angle >= 90) {

    flames.push({
        x:pos.x,
        y:pos.y,
        dx:5 * cos(angle),
        dy:5 * sin(angle),
        r:0
    });
    }
    popMatrix();
    pos.x+=1;
    pos.y-=1;
    angle += 137.5;
    if (angle>360) {
        angle = angle%360;
    }
        updateFlames(flames);
    drawFlames(flames);
    cx1 += 1;
    cy1 -= 1;
    
};
 
mouseClicked = function() {
    if (pl === 0) {
  tl = 1;
  pl = 1;
    }
};

var instructions = function() {
  if (mouseX >200 && mouseY < 100) {
      fill (143, 68, 131);
      rect(25, 25, 200, 200);
      fill(255, 255, 255);
      textSize (12);
   text (" * Spaceship is mouse controlled", 30, 40, 200, 40); 
   text (" * Hold mouse button to shoot", 30, 60, 200, 40); 
   text (" * Shooting for too long will overheat your gun", 30, 80, 200, 40); 
   text (" * Dodge the comets", 30, 120, 200, 40); 
   text (" Special thanks to Bob Lyon!", 30, 200, 200, 40); 
  }
};

var intro = function() {
    launch();
    instructions();
    if (tl === 0) {
        buttons();
    }else if (tl !== 0) {
    if (cx1<330) {
    flamesMov();
    header ();
    }
    }

};  
}

//Main Game
{//black hole object
{
var Attractor = function() {
    this.position = new PVector(width - width/6, height - height/5);
    this.mass = blackSize / 10 + n -1;
    this.G = 1;
    this.x = this.position.x;
    this.y = this.position.y;
    this.w = blackSize;
    this.h = blackSize;
};

Attractor.prototype.contains = function(m) {
    var l = m.position;
    if (blackSize < 100){
        b = blackSize;
    }
    return l.x > this.x - b/2 && l.x < this.x + b/2 &&
           l.y > this.y && l.y < this.y + b/2;
};

Attractor.prototype.calculateAttraction = function(mover) {
    // Calculate direction of force
    var force = PVector.sub(this.position, mover.position);
    // Distance between objects       
    var distance = force.mag();
    // Limiting the distance to eliminate "extreme"
    // results for very close or very far objects                            
    distance = constrain(distance, 0.1, 75 - n *4);
    // Normalize vector                   
    force.normalize();
    // Calculate gravitional force magnitude  
    var strength = (this.G * this.mass * mover.mass) / (distance * distance);
    // Get force vector --> magnitude * direction
    force.mult(strength);
    return force;
};

// Method to display
Attractor.prototype.display = function() {
    ellipseMode(CENTER);
    noStroke();
    for (var i = 0; i <3; i++){
        fill(random (43, 163), random (255), 150, random (10,150));
        ellipse (random (this.x - blackSize / 4,this.x + blackSize / 4), (this.y - blackSize / 4,this.y + blackSize / 4), random (-blackSize, blackSize), random(-blackSize, blackSize));
    }
};
}

//STARS AND PLANETS OBJECT
{
var Mover = function(mass, x, y, v, sizeX, sizeY) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(0, v);
    this.acceleration = new PVector(0, 0);
    this.mass = mass;
};
  
Mover.prototype.applyForce = function(force) {
    var f = PVector.div(force,this.mass);
    this.acceleration.add(f);
};
  
Mover.prototype.update = function() {
    this.velocity.add(this.acceleration);
    this.position.add(this.velocity);
    this.acceleration.mult(0);
    this.velocity.limit = 4;
};

Mover.prototype.display = function(sizeX, sizeY) {
    noFill();
    stroke(random(60,255), random(60,255), random(60,255));
    strokeWeight(2);
    ellipse(this.position.x, this.position.y, sizeX, sizeY);
};

Mover.prototype.checkEdges = function(v) {
    if (this.position.y > height) {
        this.position.y = random (0, -100);
        this.position.x = random (-100, 500);
        this.velocity.x = 0;
        this.velocity.y = v;
    }
};
}

//end message function
{
var endMessage = function(){

var generator = new Random(1);
 background (0, 0, 0);
 
draw = function() {
    var numX = generator.nextGaussian();
    var numY = generator.nextGaussian();
    var standardDeviation = 60;
    var mean = 200;
    var x = standardDeviation * numX + mean;
    var y = standardDeviation * numY + mean;

    stroke (y/400*255, x/400*255, y/400*255, random (10,50));
    
    strokeWeight(random (2,10));
    point(x, y);
    
    stroke (25, 92, 12, 1);
    fill(0,0,0);
    ellipse (250,150,20,20);
    stroke (105, 18, 110,1);
    ellipse (150,250,20,20);
    fill(5, 4, 4);
    ellipse (260,280,10,10);
    ellipse (280,260,10,10);
};

        fill(227, 85, 3);
        textSize (23);
        text ("You have failed, and the solar system has been destroyed.", 20, 20, 380, 200);   
        var final = days * score/10000;
        final = round(final);
        text ("final score: " + floor(score), 50, 320, 200, 200);
        text ("level reached: " + n, 50, 360, 300, 100);
};
}

//day Counter function
{var dayCounter = function(){
            fill(255, 255, 255);
            textSize(12);
            text (days+" days",20,20,100,60);
            days += 1;
};
}

//austronaut and death ray
{
var attractor = new Attractor();
var deathRay = function (){
        if (blackSize >(10 + n*2) && mouseIsPressed){
            if (overHeat<400){
                x1 = random(315, 335);
                y1 = random(315, 335);
                blackSize -=0.6 + n/10; 
                ellipse(x1, y1, 15, 15);
                ellipse (mouseX, mouseY,overHeat/10,overHeat/10);
                strokeWeight(random (1,10));
                stroke(0, 0, random (0,255),40);
                line ( mouseX,  mouseY + 2, x1, y1);
                stroke(random (0,255), random (0,255), 0,40);
                line ( mouseX,  mouseY - 2,x1, y1);
                stroke(random (0,255), 265 - n*20, 0 + n* 20);
                line ( mouseX,  mouseY, x1, y1);
                overHeat ++;
                score += n/2;
            }
        } else if (overHeat >-1){
                overHeat -= 40 - n ;
        }
        fill (random(0,255), random(0,150), 0);
       
        theta = atan2(325 - mouseY, 325 - mouseX);
        pushMatrix();
        translate(mouseX, mouseY);
        rotate(theta);
        image (sp, -80, -70, 100, 100);
        popMatrix();
        fill (89, 255, 0);
        text (floor(score) +" points",20,40,100,60);
};
}

//stars being attracted to the black hole
{
var movers = [];
for (var i = 0; i < 100; i++) {
    movers[i] = new Mover(10, random(width), random(height), 1/4);
}

var starsAttracted = function(){
    background(50, 50, 50);
        for (var i = 0; i < 100; i++) {
            var force = attractor.calculateAttraction(movers[i]);
            movers[i].applyForce(force);
            movers[i].update();
            movers[i].checkEdges(1/4);
            movers[i].display(1,1);
            attractor.display();
            if (attractor.contains(movers[i])){
                movers[i].position.y = height +1;
                noStroke();
                fill(121, 26, 140);
                ellipse (335,315,random(25,150),random(25,150));
                blackSize = blackSize + movers[i].mass;
            }
            
        }
    fill(255, 255, 255);
    text (lives +" lives", 360,20,100,100);
};
}

//comets (can hurt player)
{
    
//check spin of player
var contain = function() {
    if (theta <= 20 && -20 <= theta) {
        cxl = 50;
        cxr = -1;
        cyu = 45;
        cyd = 10;
    } else if (theta <= 110 && 70 <= theta) {
        cxl = 20;
        cxr = 20;
        cyu = 55;
        cyd = -1;
    } else if (theta <= 180 && 160 <= theta || theta <= -160 && -180 <= theta) {
        cxl = -1;
        cxr = 50;
        cyu = 10;
        cyd = 45;
    } else if (theta <= -70 && -110 <= theta) {
        cxl = 20;
        cxr = 20;
        cyu = -1;
        cyd = 55;
    } else if (theta <= 70 && 20 <= theta) {
        cxl = 50;
        cxr = -1;
        cyu = 50;
        cyd = -1;
    } else if (theta <= 160 && 110 <= theta) {
        cxl = -1;
        cxr = 50;
        cyu = 50;
        cyd = -1;
    } else if (theta <= -110 && -160 <= theta) {
        cxl = -1;
        cxr = 50;
        cyu = -1;
        cyd = 50;
    } else if (theta <= -20 && -70 <= theta) {
        cxl = 50;
        cxr = -1;
        cyu = -1;
        cyd = 50;
    }
};

for (var i = 100; i < 105; i++) {
    movers[i] = new Mover(25, random(width), random(height), n);
}

var comet = function(){
 for (var i = 100; i < 105; i++) {
            var force = attractor.calculateAttraction(movers[i]);
            movers[i].applyForce(force);
            movers[i].update();
            movers[i].checkEdges(n);
            noFill();
            stroke (movers[i].position.x, 38, 255);
            strokeWeight(4);
            ellipse (movers[i].position.x, movers[i].position.y, 4, 4);
            if (attractor.contains(movers[i])){
                movers[i].position.y = height +1;
                noStroke();
                fill(121, 26, 140);
                ellipse (335,315,random(25,150),random(25,150));
                blackSize = blackSize + movers[i].mass;
            }
            if (movers[i].position.x <= mouseX + cxr && movers[i].position.x  >= mouseX - cxl && movers[i].position.y  <= mouseY + cyd && movers[i].position.y  >= mouseY - cyu){
                movers[i].position.x = height +1;
                lives --;
                background(255, 0, 0);
            }
        }
};
}

//comets2 (can hurt player)
{
for (var i = 105; i < 110; i++) {
    movers[i] = new Mover(15, random(width), random(height), 2);
}
var comet1 = function(){
 for (var i = 105; i < 110; i++) {
            var force = attractor.calculateAttraction(movers[i]);
            movers[i].applyForce(force);
            movers[i].update();
            movers[i].checkEdges(2);
            noFill();
            stroke (movers[i].position.x, 150, movers[i].position.x/2);
            strokeWeight(6);
            triangle (movers[i].position.x - 1, movers[i].position.y + 1, movers[i].position.x, movers[i].position.y + 1, movers[i].position.x + 1, movers[i].position.y -1);
            if (attractor.contains(movers[i])){
                movers[i].position.y = height +1;
                noStroke();
                fill(121, 26, 140);
                ellipse (335,315,random(25,150),random(25,150));
                blackSize = blackSize + movers[i].mass;
            }
            if (movers[i].position.x <= mouseX + cxr && movers[i].position.x  >= mouseX - cxl && movers[i].position.y  <= mouseY + cyd && movers[i].position.y  >= mouseY - cyu){
                movers[i].position.x = height +1;
                lives --;
                background(255, 0, 0);
            }
        }
};
}

//comets3 (can hurt player)
{
for (var i = 110; i < 130; i++) {
    movers[i] = new Mover(5, random(width), random(height), 4);
}
var comet2 = function(){
 for (var i = 110; i < (114+n); i++) {
            var force = attractor.calculateAttraction(movers[i]);
            movers[i].applyForce(force);
            movers[i].update();
            movers[i].checkEdges(4);
            noFill();
            stroke (movers[i].position.x + 50, movers[i].position.x/2 , 0);
            strokeWeight(8);
            triangle (movers[i].position.x + 1, movers[i].position.y + 1, movers[i].position.x, movers[i].position.y + 1, movers[i].position.x - 1, movers[i].position.y -1);
            if (attractor.contains(movers[i])){
                movers[i].position.y = height +1;
                noStroke();
                fill(121, 26, 140);
                ellipse (335,315,random(25,150),random(25,150));
                blackSize = blackSize + movers[i].mass;
            }
            if (movers[i].position.x <= mouseX + cxr && movers[i].position.x  >= mouseX - cxl && movers[i].position.y  <= mouseY + cyd && movers[i].position.y  >= mouseY - cyu){
                movers[i].position.x = height +1;
                lives --;
                background(255, 0, 0);
            }
        }
    fill(255, 255, 255);
    text (lives +" lives", 360,20,100,100);
};

var difficult = function(){
    if (days%2999 === 0 && n<16){
        n = n +1;
    }
    text ("level " + n, 20, 60, 100, 100);
};
}
}

// main function
{
draw = function() {
    //Fading explanation of the program
    contain();
    if (t<746){
        logo ();
    } else if (cx1 < 330) {
        intro();
    } else if (blackSize<(499 + n*10) && lives>0){
        cursor("NONE");
        starsAttracted();
        comet();
        comet1();
        comet2();
        dayCounter();
        deathRay();
        difficult();
    } else {
        endMessage();
        //mouseClicked = function() {
            //Program.restart();
        //};
    }

};
}





// https://discourse.processing.org/t/flood-fill-very-slow/5110

//select target colour
int targetRed = 0;
int targetGreen = 0;
int targetBlue = 0;

//set global variables
color c;
int currentpixel;
int pixeltocheck;
ArrayList<Integer> pixelstochange= new ArrayList();

//set arraylist counter to 0
int arraylistindex = 0;

void setup() {
  size(600, 600);
  noFill();
  stroke(0);
  background(255);
  strokeWeight(2.5);

  //create random shapes
  for (int i=0; i<35; i++) {
    rect(random(600), random(600), 50, 50);
    ellipse(random(600), random(600), 200, 100);
  }
  loadPixels();
}

void draw() {

  //go to next pixel on arraylist, repeat check 4 surrounding pixels
  while (arraylistindex<pixelstochange.size()&&pixelstochange.size()>0) {
    checkSurrounding();
  }
}

//click on area, get pixel number and colour
void mouseClicked() {

  currentpixel=mouseY*width+mouseX;
  c =pixels[currentpixel];
  pixels[currentpixel]=color(targetRed, targetGreen, targetBlue);
  testColour();
}

//check not target colour
void testColour() {

  if (red(c)!=targetRed||green(c)!=targetGreen||blue(c)!=targetBlue) { 
    addToArrayList();
  }
}

//if different add pixel to arraylist
void addToArrayList() {

  pixelstochange.add(currentpixel);
  checkSurrounding();
}

//check 4 surrounding pixels
void checkSurrounding() {

  int checkingpixel = pixelstochange.get(arraylistindex);

  pixeltocheck = checkingpixel-width;
  if (pixeltocheck>0) {
    color top =pixels[pixeltocheck];
    if (red(top)!=targetRed||green(top)!=targetGreen||blue(top)!=targetBlue) {    
      checkOnArrayList();
    }
  }


  pixeltocheck =checkingpixel+width; 
  if (pixeltocheck<width*height) {
    color bottom =pixels[pixeltocheck];
    if (red(bottom)!=targetRed||green(bottom)!=targetGreen||blue(bottom)!=targetBlue&&pixeltocheck<width*height) {     
      checkOnArrayList();
    }
  }

  pixeltocheck =checkingpixel-1;
  if (pixeltocheck>0&&pixeltocheck%width!=0) {
    color left =pixels[pixeltocheck];
    if (red(left)!=targetRed||green(left)!=targetGreen||blue(left)!=targetBlue) {     
      checkOnArrayList();
    }
  }

  pixeltocheck =checkingpixel+1;
  if (pixeltocheck<width*height&&pixeltocheck%width!=width-1) {
    color right =pixels[pixeltocheck];
    if (red(right)!=targetRed||green(right)!=targetGreen||blue(right)!=targetBlue) {    
      checkOnArrayList();
    }
  }

  //increment arraylist counter
  arraylistindex++;
}

//for each, if different check not on arraylist
//if not on arraylist, add to array list
void checkOnArrayList() {

  if (pixelstochange.contains(pixeltocheck)) {
    return;
  } else {
    pixelstochange.add(pixeltocheck);
    pixels[pixeltocheck]=color(targetRed, targetGreen, targetBlue);
    updatePixels();
    println(pixelstochange.size());
  }
}

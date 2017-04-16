PImage source;
PImage destination;
int i;
float tRed;
float tGreen;
float tBlue;
int loc = 0;
float leastLikeLoc;
boolean[] used;
int bap = 0;

void setup() {
  size(600, 600);
  source = loadImage("toende.jpg");
  destination = createImage(source.width, source.height, RGB);
  i = 0;
  image(source, 0, 0, source.width, source.height);
  source.loadPixels();
  destination.loadPixels();
  used = new boolean[source.width * source.height];
}

void draw() {
  if (loc > source.width * source.height) {
    loc = 0;
    for (int i = 0; i < source.pixels.length; i++) {
      source.pixels[i] = destination.pixels[i];
    }
    source.updatePixels();
    source.loadPixels();
    destination.loadPixels();
  }
  bap++;

  
  for (int y = 0; y < source.width*source.height; y++) {

    int comparedPixel = y - source.width - 1;
    int negLoc = loc;

    try {
      leastLikeLoc = source.pixels[y];
      tRed = red(source.pixels[y]);
      tGreen = green(source.pixels[y]);
      tBlue = blue(source.pixels[y]);
    } 
    catch (Exception e1) {
    }
    
      int[] directionsPre = { 0, 1, 2, source.width, source.width+2, source.width*2, source.width*2+1, source.width*2+2};
    boolean[] randTaken = new boolean[7];
    int tosset = 0;
    int tosset2;
    int[] directions = { 0, 0, 0, 0, 0, 0, 0, 0};
    while(tosset < 8){
      tosset2 = int(random(randTaken.length));
      if(!randTaken[tosset2]){
        randTaken[tosset2] = true;     
        directions[tosset] = directionsPre[tosset2]; 
        tosset++;
      }
    }
    System.out.println("randTaken.length");
    for (int k = 0; k < 8; k++) {
      
      int direction = directions[k];
      
      float totalValue = 0;
      try {
        totalValue = abs(red(source.pixels[y]) - red(source.pixels[comparedPixel] + direction)) + abs(green(source.pixels[y]) - green(source.pixels[comparedPixel]+ direction)) + abs(blue(source.pixels[y]) - blue(source.pixels[comparedPixel]+ direction));       
        if (totalValue >= leastLikeLoc && !used[comparedPixel] && !used[y] ) {
          leastLikeLoc = totalValue;
          negLoc = comparedPixel;
          tRed = red(source.pixels[comparedPixel]);
          tGreen = green(source.pixels[comparedPixel]);
          tBlue = blue(source.pixels[comparedPixel]);
        }
      } 
      catch(Exception e) {
      }
      finally {
      }
      comparedPixel++;
    }
    try {
      if (negLoc != loc) {
        destination.pixels[y] = color(tRed, tGreen, tBlue);
        used[y] = true;
        used[negLoc] = true;
      } else {
        destination.pixels[y] = source.pixels[y];
      }
    } 
    catch (Exception e1) {
    }
  }
  loc = 999999999;
  image(destination, 0, 0, source.width, source.height);
  destination.updatePixels();
  used = new boolean[source.width * source.height];
}
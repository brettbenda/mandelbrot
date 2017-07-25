/*
Made by Brett Benda in 2017
*/
int imageNum = 1;
double zoom = 4;
double xDisplacement = 0;
double yDisplacement = 0;
boolean isMoving = false;
double savedXDis;//xDisplacement at start of movement
double savedYDis;//yDisplacement at start of movement
double tempDX;//temp change in x, based on zoom
double tempDY;//temp change in y, based on zoom
double initX;//x pos when you first click
double initY;//y pos when you first click
double currX;//x pos after you click, but still have mouse pressed
double currY;//y pos after you click, but still have mouse pressed

DataInput iterations;
DataInput realP;
DataInput imagP;
void setup() {
  size(1200, 675);
  background(255);
  iterations = new DataInput("Max Iterations",50,1100,100,1000,0,5);
  realP = new DataInput("Real Part",1,1100,200,2,-2,0.1);
  imagP = new DataInput("Imaginary Part",1,1100,300,2,-2,0.1);
}

void draw() {
  background(255);
  updateZoomAndTranslation();
  drawJulia(zoom, xDisplacement, yDisplacement, (int)iterations.getData());
  iterations.show();
  realP.show();
  imagP.show();
}

void mouseWheel(MouseEvent event){
  if(event.getCount()<0){
    zoom*=0.9;
  }
  if(event.getCount()>0){
    zoom*=1.1;
  }
}

void updateZoomAndTranslation() {
  if (mousePressed) {
    if (!isMoving) {
      isMoving = true;
      initX = mouseX;
      initY = mouseY;
      savedXDis = xDisplacement;
      savedYDis = yDisplacement;
    }
    if (isMoving) {
      currX = mouseX;
      currY = mouseY;
      tempDX = (double)(initX-currX)/width*zoom; 
      tempDY = (double)(initY-currY)/height*zoom;
      xDisplacement = savedXDis + tempDX;
      yDisplacement = savedYDis + tempDY;
    }
  } else {
    isMoving = false;
  }
}

void drawJulia(double xAxisLength, double xDisplacement, double yDisplacement, int iterations) {
  //load pixels so we can modify them
  loadPixels();

  //using HSB for coloring
  colorMode(HSB);

  //constants
  double realPart = realP.getData();
  double imaginaryPart = imagP.getData();

  //we want the y-axis to be proportional to the x-axis
  double yAxisHeight = (xAxisLength * height)/(width);

  //minimun (starting) values
  //and how much we need to increase them by each iterations
  double xMinimum = -xAxisLength/2 + xDisplacement;
  double dX = (double)xAxisLength/width;
  double yMinimum = -yAxisHeight/2 + yDisplacement;
  double dY = (double)yAxisHeight/height;

  double y = yMinimum;//start at minumum x-value

  //increment down to the next row
  for (int i = 0; i<height; i++) {

    double x = xMinimum;//start at minimum y-value;

    //increment across the row;
    for (int j = 0; j<width; j++) {

      double a = x;//real part is x

      double b = y;//imaginary part is y

      int n = 0; //start at iteration 0

      while (n<iterations) {
        double aSquared = a*a;
        double bSquared = b*b;
        double twoAB = 2*a*b;

        //new parts are determined by expansion 
        //(a+bi)^2 == a^2 - b^2 + 2ab
        //we add the predefined constants, rather than the place we are
        a = aSquared - bSquared + realPart;
        b = twoAB + imaginaryPart;

        //if value of new
        if (Math.sqrt(a*a+b*b)>4) {
          break;
        }
        n++;
      }

      if (n == iterations) {
        pixels[j+i*width] = #000000;
      } else {
        float hue = 5*n;
        if (hue > 255) {
          hue = hue%255;
        }
        pixels[j+i*width] = color(hue, 255, 255);
      }

      x+=dX;
    }
    y+=dY;
  }

  updatePixels();
}
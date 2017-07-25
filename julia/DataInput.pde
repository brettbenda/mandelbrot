class DataInput {
  float data = 0; //current value that can be retrieved
  float x, y, upperBound, lowerBound, increment; //x coord of center, y coord of center, max value, min value, value used as increment
  String name; //name of the field
  Button upper, lower; //buttons to modify the current data
  boolean hasBeenClicked = false; //by default, neither button is clicked

  DataInput(String name, float defaultVal, float x, float y, float upperBound, float lowerBound, float increment) {
    this.name = name;
    this.data = defaultVal;
    this.x = x;
    this.y = y;
    this.upperBound = upperBound;
    this.lowerBound = lowerBound;
    this.lower = new Button(x-50,y,25,25,"-");
    this.upper = new Button(x+50,y,25,25,"+");
    this.increment = increment;
  }
  
  void show(){
   //increment data by the given increment value if the right arrow is selected
   if(upper.isClicked() && data < upperBound && !hasBeenClicked){
    data+=increment; 
    hasBeenClicked = true;
   }
   //decrement data by the given increment value if the left arrow is selected
   if(lower.isClicked() && data > lowerBound && !hasBeenClicked){
    data-= increment; 
    hasBeenClicked = true;
   }
   
   //if neither button is clicked, neither has been clicked
   if(!upper.isClicked() && !lower.isClicked()){
    hasBeenClicked = false; 
   }
   
   //display data
   lower.show();
   upper.show();
   fill(255);
   textFont(createFont("Tahoma", width/50));
   textAlign(CENTER,CENTER);
   if(data%1==0){
     text((int)data,x,y);
   }else{
     text(data,x,y);
   }
   text(name,x,y-height/20);
  }
  
  
  //return the data currently being stored
  float getData(){
   return this.data; 
  }
}
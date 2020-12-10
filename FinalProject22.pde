  PImage myPic ;
void setup()
{
  size(1600, 920);
  //can I load a photo from a website? 
   myPic = loadImage("test.png", "png");
   
}

void draw()
{

  image(OrderedDither(findMyNearbyPic(desaturate(myPic), 1), 1,5), 0, 0);
  saveFrame("myPic.png");
  println("IMAGE SAVED");

}

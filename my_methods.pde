

color ClosestPaletteColor( color myPic, int MaxSize)
{ 
  return color(round(MaxSize*(red(myPic)/256.f))*(256.f/MaxSize), 
                  round(MaxSize*(green(myPic)/256.f))*(256.f/MaxSize),
                  round(MaxSize*(blue(myPic)/256.f))*(256.f/MaxSize));
}

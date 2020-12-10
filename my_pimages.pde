
PImage findMyNearbyPic( PImage myPic,  float scaleFactor)
{
 PImage finalImage = createImage(round(myPic.width * scaleFactor), round(myPic.height * scaleFactor),  RGB);

 for(int i=0; i<finalImage.height; i++)
 {
   for(int j=0; j<finalImage.width; j++)
   {
     //println("W:" + j + " H:" + i);
     finalImage.pixels[i*finalImage.width + j]
       = myPic.pixels[floor(i/scaleFactor)*myPic.width + floor(j/scaleFactor)];
   }
 }
 
 finalImage.updatePixels();
 return finalImage;
}

PImage OrderedDither( PImage myPic, int MaxSize, int myFac)
{
  PImage finalImage = createImage(myPic.width, myPic.height, RGB);
  float DeltaArray[][] ={ {0.f/16.f, (myFac)*1.f/16.f, (myFac)*3.f/16.f, (myFac)*4.f/16.f},
                       {5.f/16.f, 4.f/16.f, 3.f/16.f, 6.f/16.f},
                       {1.f/16.f, 8.f/16.f, 1.f/16.f, 7.f/16.f},
                       {10.f/16.f, 4.f/16.f, 15.f/16.f, 2.f/16.f} };
   
  for(int i=0; i<finalImage.height; i++)
 {
   for(int j=0; j<finalImage.width; j++)
   {
     color colorForHue = myPic.pixels[i*finalImage.width + j];
     float addedValue = (256.f/MaxSize)*(DeltaArray[i%4][j%4]-0.5f);
     colorForHue = color(red(colorForHue)+addedValue, green(colorForHue)+addedValue, blue(colorForHue)+addedValue);
     colorForHue = ClosestPaletteColor(colorForHue, MaxSize);
     finalImage.pixels[i*finalImage.width+j] = colorForHue;
   }
 }
  finalImage.updatePixels();
  return finalImage; 
}

PImage ErrorDiffusionDither( PImage myPic, int MaxSize,  float[][] ditMat)
{
  PImage result = myPic.copy();
  for(int i=0; i<myPic.height; i++)
  {
    for(int j=0; j<myPic.width; j++)
    {
      selectHue oldPixel = new selectHue(result.pixels[i*result.width + j]);
      selectHue newPixel = new selectHue(ClosestPaletteColor(oldPixel.toInt(), MaxSize));
      selectHue quantError = oldPixel.copy().add(newPixel.copy().multiply(-1.f));
      result.pixels[i*result.width + j] = newPixel.toInt();
      
      int pixelOffset = ditMat[0].length/2;
      
      for(int mHeight=0; mHeight<ditMat.length; mHeight++)
      {
        for(int mWidth=0; mWidth<ditMat[0].length; mWidth++)
        {
          if(ditMat[mHeight][mWidth] == 0){ continue; }
          if(ditMat[mHeight][mWidth] == 1){ continue; }
          
          if(i+mHeight<result.height)
          {
            if(j-pixelOffset+mWidth>0 && j+mWidth-pixelOffset<result.width)
            {
              result.pixels[(i+mHeight)*result.width + j - pixelOffset + mWidth] =
              new selectHue(result.pixels[(i+mHeight)*result.width + j - pixelOffset + mWidth])
                  .add(quantError.copy()
                       .multiply(ditMat[mHeight][mWidth]))
                  .toInt();
            }
          } else { continue; }
        } 
      }
    }
  }
  result.updatePixels();
  return result;
}


PImage desaturate( PImage myPic)
{
  PImage result = createImage(myPic.width, myPic.height, RGB);
  
 for(int i=0; i<myPic.height; i++)
 {
   for(int j=0; j<myPic.width; j++)
   {
     color colorForHue = myPic.pixels[i*myPic.width+j];
     int gray = int(red(colorForHue)+green(colorForHue)+blue(colorForHue))/3;
     colorForHue = color(gray, gray, gray);
     result.pixels[i*myPic.width+j] = colorForHue;
   }
 }
  
  return result;
}

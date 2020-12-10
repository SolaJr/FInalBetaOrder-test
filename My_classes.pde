

class selectHue
{
  public selectHue(float red, float green, float blue)
  {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
  public selectHue(float gray)
  {
    this.red = this.green = this.blue = gray;
  }
  public selectHue(int value)
  {
    this.red = red(value);
    this.green = green(value);
    this.blue = blue(value);
  }
  
  public float red = 0, green = 0, blue = 0;
  
  public float[] toMatrix()
  {
    return new float[]{this.red, this.green, this.blue};
  }
  public color toInt()
  {
    return color(red, green, blue);
  }

  public selectHue add( selectHue myPic)
  {
    red += myPic.red;
    green += myPic.green;
    blue += myPic.blue;
    return this;
  }
  public selectHue add( color myPic)
  {
    red += red(myPic);
    green += green(myPic);
    blue += blue(myPic);
    return this;
  }  public selectHue add( float value)
  {
    red += value;
    green += value;
    blue += value;
    return this;
  }
  public selectHue multiply( float value)
  {
    red *= value;
    green *= value;
    blue *= value;
    return this;
  }
  public selectHue copy()
  {
    return new selectHue(red, green, blue);
  }
  
}
static class ErrorDiffusionDitherMatrices
{
  static float Basic2DMatrix [][] =               { {1,      2f/4f},
                                                    {1f/4f,  1f/4f} };
}

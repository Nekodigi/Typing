float EaseInCubic(float start, float end, float t){
  end -= start;//calculate difference
  return start+t*t*t*end;
}

class Flower < Processing::App
  def setup
    size 900, 630
    @cols=30
    @rows=21 
    @cell_size=30
    @flower=load_image "flower.png"
    @lt=color 228,109,47
    @md=color 204,52,2
    @dk=color 183,28,19
    @white=color 255
    background 240,240,240
    @colors=[@white,@lt,@md,@dk]
    @color_count_map = {}
    @font = text_font(load_font("HelveticaNeue-10.vlw"))
    smooth
    no_loop
  end
  
  def nearest color
    closest_color = @white
    distance = 1000
    @colors.each do |c|
      t=dist(red(color), green(color), blue(color), red(c), green(c), blue(c)).abs
      if t < distance 
        closest_color = c
        distance = t
      end
    end
    @color_count_map[closest_color] ||= 0
    @color_count_map[closest_color] += 1
    closest_color
  end
  
  def display_color_counts
    return if @done
    rect_mode(CORNER)
    stroke 0
    fill 255
    rect(width-70,height-55,70,55)
    i=0
    @color_count_map.each do |p|
      c = p[0]
      count = p[1]
      fill(p[0])
      stroke(0)
      ycoord = height-50+i*12
      ellipse(width-65,ycoord, 10,10) 
      fill 0
      text("#{count} caps", width-50, ycoord + 10)
      i+=1
    end
    save("bottlecap_flower.png")
    @done = true
  end
  
  def draw
    image_mode CENTER
    pixels=@flower.load_pixels

    @cols.times do |x|
      @rows.times do |y|
       #loc = x + y*width
       c=@flower.pixels[x+y*@cols]
       fill(nearest(c))
       no_stroke
       ellipse_mode CORNER
       ellipse x*@cell_size,y*@cell_size,@cell_size,@cell_size
      end 
    end
    display_color_counts    
  end
end
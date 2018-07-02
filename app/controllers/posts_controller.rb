class PostsController < ApplicationController
    require 'xmlsimple'
    require 'uri'
    require 'net/http'
  def index
    @line = Line.find(params[:line_id])
    
    @posts = @line.posts.all
  end

  def new
    @line = Line.find(params[:line_id])
    @user = current_user
    @post = @line.posts.build
    @stations = get_stations(@line.line_cd)
  
  end

  def create
    @line = Line.find(params[:line_id])
    @user = current_user
    @post = @line.posts.build(post_params)
    @post.user_id = @user.id
    get_station_name(@line.line_cd, @post.near_station_id)
    @post.near_station_name = @station_name
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to line_posts_path
    else 
      flash[:destroy] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content,:cloud_level, :near_station_id)
  end
  
  def get_stations(line_cd)
   
    num = line_cd
    uri = URI.parse("http://www.ekidata.jp/api/l/#{num}.xml")
    xml = Net::HTTP.get(uri)
    result = XmlSimple.xml_in(xml)
    stations = []
    
    data = result["station"]
    data.each do |station|
      stations.push([station["station_name"][0], station["station_cd"][0]])
    end
    
    return stations
      
    
    
    
  end
  
  def get_station_name(line_cd,near_station_id)
    
    num = line_cd
    uri = URI.parse("http://www.ekidata.jp/api/l/#{num}.xml")
    xml = Net::HTTP.get(uri)
    result = XmlSimple.xml_in(xml)
    data = result["station"]
    
    data.each do |station|
      if station["station_cd"][0] == near_station_id.to_s
        @station_name = station["station_name"][0]
        break
    
        
      end
      
    end
  end
  
    
  
end

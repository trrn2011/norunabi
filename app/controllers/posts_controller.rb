class PostsController < ApplicationController
    require 'xmlsimple'
    require 'uri'
    require 'net/http'
    require 'csv'
  def index
    @line = Line.find(params[:line_id])
    
    @posts = @line.posts.all.page(params[:page]).per(20)
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
    p num
    # uri = URI.parse("http://www.ekidata.jp/api/l/#{num}.xml")
    # xml = Net::HTTP.get(uri)
    # result = XmlSimple.xml_in(xml)
    csv_data = CSV.read('station.csv', headers: true)
    stations = []
    
    # data = result["station"]
    csv_data.each do |station|
      stations.push([station["station_name"], station["station_cd"].to_i]) if station["line_cd"].to_i == num
    end
    
    return stations
      
    
    
    
  end
  
  def get_station_name(line_cd,near_station_id)
    
    num = line_cd
    # uri = URI.parse("http://www.ekidata.jp/api/l/#{num}.xml")
    # xml = Net::HTTP.get(uri)
    # result = XmlSimple.xml_in(xml)
    # data = result["station"]
    data = CSV.read('station.csv', headers: true)
    data.each do |station|
      if station["station_cd"] == near_station_id.to_s
        @station_name = station["station_name"]
        break
    
        
      end
      
    end
  end
  
    
  
end

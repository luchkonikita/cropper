require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'RMagick'
include Magick

configure do
  SITECONFIG = OpenStruct.new(
                   :title => 'CROPPER',
                   :author => 'Your Name',
                   :url_base => 'http://localhost:4567/'
                 )
  ALLOWEDFILETYPES = [ '.jpg','.jpeg', '.png', '.gif' ]
end

get '/' do
  haml :home
end

post '/upload' do
  if params['image']

    # File.open('uploads/' + params['image'][:filename], 'w') do |f|
    #   f.write(params['image'][:tempfile].read)
    # end

    # f = ImageList.new("uploads/#{params['image'][:filename]}")
    # thumb = f.resize_to_fit(300)
    # thumb.write("public/images/#{params['image'][:filename]}")

    # @image_url  = "images/#{params['image'][:filename]}"
    # @image_name = params['image'][:filename]

    extension = File.extname(params['image'][:filename])
    if ALLOWEDFILETYPES.include?(extension)

      File.open('public/images/' + params['image'][:filename], 'w') do |f|
        f.write(params['image'][:tempfile].read)
      end

      json result: true, filepath: ('images/' + params['image'][:filename])
    else
      json result: false, notice: 'unsupported format'
    end
  else
    json result: false, notice: 'something went wrong'
  end
end

post '/crop' do
  'successs'
end


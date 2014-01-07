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
  enable :sessions
end

get '/' do
  haml :home
end

post '/upload' do
  if params['image']
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


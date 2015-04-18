before do
  content_type :json
  headers['Access-Control-Allow-Origin'] = "http://kjb085.github.io"
  headers['Access-Control-Request-Method'] = ["POST"]
end

set :protection, false
set :public_dir, Proc.new { File.join(root, "_site") }

post '/send_email' do

  Rack::Recaptcha.test_mode!

  if recaptcha_valid?

    client = SendGrid::Client.new(api_user: 'app35909075@heroku.com', api_key: 'kjb141414')

    email = SendGrid::Mail.new do |m|
      m.to = 'kjb085@gmail.com'
      m.from = params[:name] + "<" + params[:email] + ">"
      m.subject = "[kjb085.github.io] Tel:" + params[:tel]
      m.html = params[:message]
    end

    output = client.send(email)

    if !(output.nil?)
      { :message => 'success' }.to_json
    else
      { :message => 'failure_email' }.to_json
    end
  else
    { :message => 'failure_captcha' }.to_json
  end
end

not_found do
  File.read('_site/404.html')
end

get '/*' do
  file_name = "_site#{request.path_info}/index.html".gsub(%r{\/+},'/')
  if File.exists?(file_name)
    File.read(file_name)
  else
    raise Sinatra::NotFound
  end
end
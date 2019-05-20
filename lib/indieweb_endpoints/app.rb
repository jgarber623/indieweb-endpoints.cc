module IndiewebEndpoints
  class App < Sinatra::Base
    configure do
      use Rack::Protection, except: [:remote_token, :session_hijacking, :xss_header]
      use Rack::Protection::ContentSecurityPolicy, default_src: "'self'", frame_ancestors: "'none'"
      use Rack::Protection::StrictTransport, max_age: 31536000, include_subdomains: true, preload: true

      set :root, File.dirname(File.expand_path('..', __dir__))

      set :raise_errors, true
      set :show_exceptions, :after_handler
    end

    configure :production do
      use Rack::SslEnforcer, redirect_html: false
      use Rack::HostRedirect, %w[www.indieweb-endpoints.cc] => 'indieweb-endpoints.cc'
      use Rack::Deflater
    end

    register Sinatra::Param
    register Sinatra::RespondWith

    respond_to :html, :json

    get '/', provides: :html do
      cache_control :public

      respond_with :index
    end

    get '/search' do
      url = param :url, required: true, format: uri_regexp, raise: true

      endpoints = IndieWeb::Endpoints.get(url).to_h

      respond_with :search, endpoints: endpoints do |format|
        format.json { json endpoints }
      end
    rescue Sinatra::Param::InvalidParameterError
      halt 400
    end

    error 400 do
      response = { code: 400, message: 'Parameter url is required and must be a valid URL (e.g. https://example.com)' }

      respond_with :'400', error: response
    end

    error 404 do
      cache_control :public

      response = { code: 404, message: 'The requested URL could not be found' }

      respond_with :'404', error: response
    end

    private

    def uri_regexp
      @uri_regexp ||= URI.regexp(%w[http https])
    end
  end
end

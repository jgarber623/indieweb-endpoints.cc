module IndiewebEndpoints
  class App < Sinatra::Base
    configure do
      use Rack::Protection, except: [:remote_token, :session_hijacking, :xss_header]
      use Rack::Protection::ContentSecurityPolicy, default_src: "'self'", style_src: "'self' https://fonts.googleapis.com", font_src: "'self' https://fonts.gstatic.com", frame_ancestors: "'none'"
      use Rack::Protection::StrictTransport, max_age: 31536000, include_subdomains: true, preload: true

      set :root, File.dirname(File.expand_path('..', __dir__))

      set :raise_errors, true
      set :show_exceptions, :after_handler

      set :assets_css_compressor, :sass
      set :assets_paths, %w[assets/images assets/stylesheets]
      set :assets_precompile, %w[*.png application.css]
    end

    configure :production do
      use Rack::SslEnforcer, redirect_html: false
      use Rack::HostRedirect, %w[indieweb-endpoints-cc-web-f6guikqi7q-uc.a.run.app www.indieweb-endpoints.cc] => 'indieweb-endpoints.cc'
      use Rack::Deflater
    end

    register Sinatra::AssetPipeline
    register Sinatra::Param
    register Sinatra::RespondWith

    before do
      message = 'The requested method is not allowed'

      halt(405, message) unless request.get?
    end

    after do
      message = 'The requested format is not supported'

      halt(406, message) if status == 500 && body.include?('Unknown template engine')
    end

    get '/', provides: :html do
      respond_with :index
    end

    get '/search', provides: [:html, :json] do
      url = param :url, required: true, transform: :strip, format: uri_regexp, raise: true

      endpoints = IndieWeb::Endpoints.get(url).to_h

      respond_with :search, endpoints: endpoints, url: url do |format|
        format.json { json endpoints }
      end
    rescue IndieWeb::Endpoints::InvalidURIError, Sinatra::Param::InvalidParameterError
      halt 400
    rescue IndieWeb::Endpoints::IndieWebEndpointsError
      halt 408
    end

    error 400 do
      message = 'Parameter url is required and must be a valid URL (e.g. https://example.com)'

      respond_with :'400', error: { code: 400, message: message }
    end

    error 404 do
      message = 'The requested URL could not be found'

      respond_with :'404', error: { code: 404, message: message }
    end

    error 408 do
      message = 'The request timed out and could not be completed'

      respond_with :'408', error: { code: 408, message: message }
    end

    private

    def uri_regexp
      @uri_regexp ||= URI.regexp(%w[http https])
    end
  end
end

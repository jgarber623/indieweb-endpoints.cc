module IndiewebEndpoints
  class App < Sinatra::Base
    configure do
      use Rack::Protection, except: [:remote_token, :session_hijacking, :xss_header]
      use Rack::Protection::ContentSecurityPolicy, default_src: "'self'", style_src: "'self' https://fonts.googleapis.com", font_src: "'self' https://fonts.gstatic.com", frame_ancestors: "'none'"
      use Rack::Protection::StrictTransport, max_age: 31_536_000, include_subdomains: true, preload: true

      set :root, File.dirname(File.expand_path('..', __dir__))

      set :raise_errors, true
      set :raise_sinatra_param_exceptions, true
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
      raise MethodNotAllowed unless request.head? || request.get?
    end

    after do
      halt(406, { 'Content-Type' => 'text/plain' }, 'The requested format is not supported') if status == 500 && body.include?('Unknown template engine')
    end

    get '/', provides: :html do
      cache_control :public

      respond_with :index
    end

    get '/search', provides: [:html, :json] do
      param :url, required: true, transform: :strip, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

      client = IndieWeb::Endpoints::Client.new(params[:url])
      endpoints = client.endpoints

      respond_with :search, endpoints: endpoints, canonical_url: client.response.uri do |format|
        format.json { json endpoints }
      end
    rescue IndieWeb::Endpoints::InvalidURIError, Sinatra::Param::InvalidParameterError
      raise BadRequest, 'Parameter url is required and must be a valid URL (e.g. https://example.com)'
    rescue IndieWeb::Endpoints::IndieWebEndpointsError
      raise RequestTimeout, 'The request timed out and could not be completed'
    end

    error 400 do
      respond_with :'400', error: { code: 400, message: env['sinatra.error'].message }
    end

    error 404 do
      cache_control :public

      respond_with :'404', error: { code: 404, message: 'The requested URL could not be found' }
    end

    error 405 do
      halt 405, { 'Content-Type' => 'text/plain' }, 'The requested method is not allowed'
    end

    error 408 do
      respond_with :'408', error: { code: 408, message: env['sinatra.error'].message }
    end
  end
end

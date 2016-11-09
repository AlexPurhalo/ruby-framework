class Router
  def call(env)
    # if request's path doesn't match with paths routes - shows 404 not found
    # if path was found between other routers paths - shows it path with acording status
    request = @routes[env['REQUEST_METHOD']][env['REQUEST_PATH']]
    request ? request.call(env) : [404, {}, ["Not found :("]]
  end

  private
  def initialize(&block)
    @routes = {}
    instance_exec(&block)
  end

  def get(path, rack_app)
    match('GET', path, rack_app)
  end

  def post(path, rack_app)
    match('POST', path, rack_app)
  end

  def match(http_method, path, rack_app)
    @routes[http_method] ||= {}
    @routes[http_method][path] = rack_app
  end
end
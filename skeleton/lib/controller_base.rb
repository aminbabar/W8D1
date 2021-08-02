require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require "byebug"

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res

  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
    # return false unless @already_built_response = false
  end

  # Set the response status code and header
  def redirect_to(url)
    # @res.instance_variable_set(:@headers, {"location" => url})
    res.add_header("location", url)
    @res.instance_variable_set(:@status, 302)
    if already_built_response?
      raise "Double render error"
    end
    @already_built_response = true
    # debugger
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    @res.content_type = content_type
    @res.instance_variable_set(:@body, [content])
    if already_built_response?
      raise "Double render error"
    end
    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    directory = self.class.to_s.split("Controller")[0].downcase + "_controller/"
    file_name = template_name.to_s + ".html.erb"
    file = File.read("views/" + directory + file_name)
    template = ERB.new(file)
    # debugger
    render_content(template.result(binding), 'text/html')
    # @res.instance_variable_set(:@body, [template.result(binding)])
    # debugger
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end


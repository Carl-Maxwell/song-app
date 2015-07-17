module MyFormHelper
  def my_form(obj, action, *control_args)
    controls_str = control_args.map do |(field, type)|
      control(obj, field, type)
    end.join("<br />")

    if action == :create
      url    = send(obj.class.table_name + "_url")
      submit = "create"
    else
      url    = send(obj.class.table_name.singularize + "_url", obj)
      submit = "save"
    end

    if action == :update
      hidden_method = '<input type="hidden" name="_method" value="PATCH" />'
    else
      hidden_method = ''
    end

    output = <<-HTML
      <form action="#{url}" method="POST">
        <input
          type="hidden"
          name="authenticity_token"
          value="#{form_authenticity_token}"
        >

        #{hidden_method}

        #{controls_str}
        <br />
        <input type="submit" value="#{submit}">
      </form>
    HTML

    output.html_safe
  end

  def control(obj, field, type)
    model_name = obj.class.to_s.downcase

    case type
    when :text, :password
      control_textlike(type, model_name, field, obj[field])
    when :radio
      control_radio(model_name, field, obj[field])
    when :dropdown
      control_dropdown(model_name, field, obj[field])
    when :textarea
      control_textarea(model_name, field, obj[field])
    when :hidden
      control_hidden(model_name, field, obj[field])
    end
  end

  def control_textlike(type, model_name, field, value = "")
    <<-HTML.html_safe
    <label>
      #{field.to_s.titleize}
      <input
        type="#{type}"
        name="#{model_name}[#{field}]"
        value="#{h(value)}"
      / >
    </label>
    HTML
  end

  def control_hidden(model_name, field, value = "")
    <<-HTML.html_safe
    <label>
      <input
        type="hidden"
        name="#{model_name}[#{field}]"
        value="#{h(value)}"
      / >
    </label>
    HTML
  end

  def control_textarea(model_name, field, value = "")
    <<-HTML.html_safe
    <label>
      <textarea
        name="#{model_name}[#{field}]"
      >#{h(value)}</textarea>
    </label>
    HTML
  end

  def control_radio(model_name, field, value)
    m = model_name.camelcase.constantize
    options = m.const_get(field.upcase)

    output = options.map do |option|
      <<-HTML
      <label>
        <input
          type="radio"
          name="#{model_name}[#{field}]"
          value="#{option}"
          #{value == option ? "checked" : ""}
        >
        #{option}
      </label>
      HTML
    end.join("<br />")

    field.to_s.titleize + "<br />" + output
  end

  def control_dropdown(model_name, field, value)
    model_class = model_name.camelcase.constantize

    # field must be like "#{modelname}_id"
    # TODO go into model_class & grab model_class's field assocation class_name

    options_class = field[0..-4].to_s.camelcase.constantize

    output = options_class.all.map do |option|
      <<-HTML
        <option
          type="radio"
          value="#{option.id}"
          #{value == option.id ? "selected" : ""}
        >
        #{option.name}
        </option>
      HTML
    end.join("")

    field.to_s.titleize +
      "<br />" +
      "<select name=\"#{model_name}[#{field}]\">" +
      output +
      "</select>"
  end
end

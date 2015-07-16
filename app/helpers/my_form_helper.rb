module MyFormHelper
  def my_form(name, model, method, controls = {})
    action = send(model.table_name + "_url")

    output = <<-HTML
      <h1>#{name.titleize} a #{model.table_name.singularize.titleize}</h1>

      <form action="#{action}" method="POST">
        <input
          type="hidden"
          name="authenticity_token"
          value="<%= form_authenticity_token %>"
        >

        <label>
          Email
          <input type="text" name="user[email]">
        </label>

        <label>
          Password
          <input type="password" name="user[password]">
        </label>

        <input type="submit" value="#{name}">
      </form>
    HTML

    output.html_safe
  end
end

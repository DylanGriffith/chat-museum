module ApplicationHelper
  def messages_before(message, count)
    Message.where("id < ?", message.id).order(:id).reverse.first(count)
  end

  def messages_after(message, count)
    Message.where("id > ?", message.id).order(:id).first(count)
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.map do |msg_type, message|
      content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        message.html_safe + content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
      end
    end.join("").html_safe
  end
end

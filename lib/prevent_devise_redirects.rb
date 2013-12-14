class PreventDeviseRedirects < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'application/json'
  end
end
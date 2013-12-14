# JWLL: We don't want devise to render the form with the default application template because stuff
# is getting AJAXed in. Thus, we use the angular layout which only renders the inner content.
class SessionsController < Devise::SessionsController
  layout "angular"
end
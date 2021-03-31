require_relative "base_api"

class Sessions < BaseApi
  def login(payload)
    logger.debug("Iniciando post login sessions body: #{payload.to_json}")
    return self.class.post(
             "http://rocklov-api:3333/sessions",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end

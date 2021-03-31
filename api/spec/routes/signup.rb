require_relative "base_api"

class Singup < BaseApi
  def create(payload)
    logger.debug("Iniciando post create Singup body: #{payload.to_json}")
    return self.class.post(
             "http://rocklov-api:3333/signup",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end

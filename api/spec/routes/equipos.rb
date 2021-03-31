require_relative "base_api"

class Equipos < BaseApi
  def create(payload, user_id)
    logger.debug("Iniciando post create equipos body: #{payload.to_s.to_json} e user_id: #{user_id}")
    return self.class.post(
             "http://rocklov-api:3333/equipos",
             body: payload,
             headers: {
               "user_id": user_id,
             },
           )
  end

  def find_by_id(equipo_id, user_id)
    logger.debug("Iniciando get equipos com id: #{equipo_id} e user_id: #{user_id}")
    return self.class.get("/equipos/#{equipo_id}",
                          headers: {
                            "user_id": user_id,
                          })
  end

  def delete_by_id(equipo_id, user_id)
    logger.debug("Iniciando delete no id: #{equipo_id} e user_id: #{user_id}")
    return self.class.delete("/equipos/#{equipo_id}",
                             headers: {
                               "user_id": user_id,
                             })
  end

  def list(user_id)
    logger.debug("Iniciando get equipos para user_id: #{user_id}")
    return self.class.get("/equipos",
                          headers: {
                            "user_id": user_id,
                          })
  end

  def booking(equipo_id, user_locator_id)
    logger.debug("Iniciando post equipos para id: #{equipo_id} e usario locator: #{user_locator_id}")
    return self.class.post("/equipos/#{equipo_id}/bookings",
                           body: { date: Time.now.strftime("%d/%m/%Y") }.to_json,
                           headers: {
                             "user_id": user_locator_id,
                           })
  end
end

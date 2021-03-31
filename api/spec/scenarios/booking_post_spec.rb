describe "POST /equipos/{equipo_id}/bookings" do
  before(:all) do
    payload = { email: "andso4@teste.com.br", password: "1234" }
    result = Sessions.new.login(payload)

    @comprador_id = result.parsed_response["_id"]
  end

  context "solicitar locacao" do
    before(:all) do
      result = Sessions.new.login({ email: "andso3@teste.com.br", password: "1234" })
      joe_id = result.parsed_response["_id"]

      fender = {
        thumbnail: Helpers::get_thumb("Capturar.JPG"),
        name: "teste2",
        category: "Cordas",
        price: 100,
      }
      MongoDB.new.remove_equipo(fender[:name], joe_id)
      result = Equipos.new.create(fender, joe_id)
      fender_id = result.parsed_response["_id"]

      @result = Equipos.new.booking(fender_id, @comprador_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 201
    end
  end
end

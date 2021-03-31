describe "GET /equipos{equipo_id}" do
  before(:all) do
    payload = { email: "andso1@teste.com.br", password: "1234" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter unico equipo" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("Capturar.JPG"),
        name: "teste2",
        category: "Cordas",
        price: 299,
      }
      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar o nome" do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "equipo não existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it("deve retornar 404") do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "andso3@teste.com.br", password: "1234" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter uma lista" do
    before(:all) do
      payloads = [
        {
          thumbnail: Helpers::get_thumb("Capturar.JPG"),
          name: "teste3",
          category: "Áudio e tecnlogia".force_encoding("ASCII-8BIT"),
          price: 12,
        },
        {
          thumbnail: Helpers::get_thumb("Capturar.JPG"),
          name: "teste4",
          category: "Áudio e tecnlogia".force_encoding("ASCII-8BIT"),
          price: 13,
        },
        {
          thumbnail: Helpers::get_thumb("Capturar.JPG"),
          name: "teste5",
          category: "Áudio e tecnlogia".force_encoding("ASCII-8BIT"),
          price: 14,
        },
      ]
      payloads.each do |payload|
        MongoDB.new.remove_equipo(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      @result = Equipos.new.list(@user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar uma lista" do
      expect(@result.parsed_response).not_to be_empty
    end
  end
end

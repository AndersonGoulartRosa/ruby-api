require "faker"

describe "POST/ singup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Name do cara", email: Faker::Internet.email, password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      @result = Singup.new.create(payload)
    end

    it "validade status code" do
      expect(@result.code).to eql 200
    end

    it "validade tamanho id" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      payload = { name: "Name do cara", email: "joao@gmail.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      Singup.new.create(payload)
      @result = Singup.new.create(payload)
    end

    it "validade status code 409" do
      expect(@result.code).to eql 409
    end

    it "validade tamanho id" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end
end

require "json_matchers/rspec"

JsonMatchers.schema_root = "./spec/fixtures/schemas"

describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "teste@teste.com.br", password: "1234" }
      @result = Sessions.new.login(payload)
    end

    it "verifico schema reponse login" do
      expect(@result).to match_json_schema("login_schema")
    end
  end
end

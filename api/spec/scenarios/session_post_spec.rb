describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "teste@teste.com.br", password: "1234" }
      @result = Sessions.new.login(payload)
    end

    it "validade status code" do
      expect(@result.code).to eql 200
    end

    it "validade tamanho id" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  # examples = [
  #     {
  #         title: "senha incorreta",
  #         payload: {email: "teste@teste.com.br", password: "12345"},
  #         code: 401,
  #         error:"Unauthorized"
  #     },
  #     {
  #         title: "usuario não existe",
  #         payload: {email: "404@teste.com.br", password: "12345"},
  #         code: 401,
  #         error:"Unauthorized"
  #     },
  #     {
  #         title: "email em branco",
  #         payload: {email: "", password: "12345"},
  #         code: 412,
  #         error:"required email"
  #     },
  #     {
  #         title: "usuario em branco",
  #         payload: {password: "12345"},
  #         code: 412,
  #         error:"required email"
  #     },
  #     {
  #         title: "senha em branco",
  #         payload: {email: "teste@teste.com.br", password: ""},
  #         code: 412,
  #         error:"required password"
  #     },
  #     {
  #         title: "senha nulo",
  #         payload: {email: "teste@teste.com.br"},
  #         code: 412,
  #         error:"required password"
  #     }
  # ]

  examples = Helpers::get_fixture("login")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "validade status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "mensagem não autorizado" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end

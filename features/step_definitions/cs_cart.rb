
Dado(/^que eu esteja na tela principal da loja virtual$/) do
  SetUrl.new.load
  FuncionalidadesLoja.new.wait_element_visible('#minimize_block')
end

Dado(/^preencho o campo procurar produto com "([^"]*)"$/) do |produto|
  FuncionalidadesLoja.new.campo_pesquisa.send_keys(produto)
end

Dado(/^clico no botão Pesquisar$/) do
  FuncionalidadesLoja.new.btn_pesquisar.click
end

Dado(/^clico no produto "([^"]*)"$/) do |produto_selecionado|
  FuncionalidadesLoja.new.selecionar_produto(produto_selecionado)
end

Quando(/^clico no botão Adicionar ao carrinho$/) do
 expect(FuncionalidadesLoja.new.nome_produto_compra.text).to have_text "Batman: Arkham City (X360)"
 FuncionalidadesLoja.new.btn_add_carrinho.click

end

Então(/^o produto é adicionado ao carrinho de compra com sucesso$/) do
  FuncionalidadesLoja.new.wait_element_visible('.close')
  FuncionalidadesLoja.new.fechar_pop_ap.click
  FuncionalidadesLoja.new.btn_produto_no_carrinho.click
  FuncionalidadesLoja.new.wait_element_visible('.ty-cart-items__list-item-desc')
  expect(FuncionalidadesLoja.new.protudo_no_carrinho.text).to include("Batman: Arkham City (X360)")
end







#language: pt
#  encoding: utf-8
Funcionalidade: Comprar em loja virtual
Sendo usuário da loja virtual demo cs cart
Posso consultar e efetuar compras de protudos 
Para suprir as minhas necessidades

@validar_carrinho
Cenário: Valide que no carrinho de compras foi adicionado o produto
Dado que eu esteja na tela principal da loja virtual
E preencho o campo procurar produto com "Batman"
E clico no botão Pesquisar
E clico no produto "Batman: Arkham City (X360)"
Quando clico no botão Adicionar ao carrinho
Então o produto é adicionado ao carrinho de compra com sucesso



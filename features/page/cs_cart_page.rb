class SetUrl < SitePrism::Page

  set_url $base_url['base_url']

end

class FuncionalidadesLoja < SitePrism::Page

  element :btn_pesquisar, '.ty-search-magnifier'
  element :btn_add_carrinho, '#button_cart_94'
  element :campo_pesquisa, '#search_input'
  element :fechar_pop_ap, '.close'
  element :nome_produto_compra, '.ty-product-block-title'
  element :btn_produto_no_carrinho, '#sw_dropdown_8'
  element :protudo_no_carrinho, '.ty-cart-items__list-item-desc'


def wait_element_visible(element)
    find(element, :visible => true, wait: 3)
end

def selecionar_produto(produto)
    all(:css, '.product-title').each do |item|
    if item.text == produto
       item.click
      break
      end
    end
  end
end

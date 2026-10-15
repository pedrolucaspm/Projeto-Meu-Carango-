
let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

const carrinhoContainer = document.getElementById('carrinho');
const carrinhoVazioMsg = document.getElementById('carrinho-vazio');
const btnFinalizar = document.getElementById('finalizar');

function salvarCarrinho() {
  localStorage.setItem('carrinho', JSON.stringify(carrinho));
}

function atualizarCarrinho() {
  carrinhoContainer.innerHTML = '';

  if (carrinho.length === 0) {
    carrinhoVazioMsg.style.display = 'block';
    btnFinalizar.style.display = 'none';
    return;
  }

  carrinhoVazioMsg.style.display = 'none';
  btnFinalizar.style.display = 'inline-block';

  carrinho.forEach((item, index) => {
    const div = document.createElement('div');
    div.className = 'carrinho-item';

    div.innerHTML = `
      <img src="${item.imagem}" alt="${item.nome}" />
      <div class="carrinho-info">
        <h4>${item.nome}</h4>
        <p>R$ ${item.preco.toLocaleString('pt-BR')}</p>
      </div>
      <button onclick="removerItem(${index})">Remover</button>
    `;

    carrinhoContainer.appendChild(div);
  });

}


function removerItem(index) {
  carrinho.splice(index, 1);
  salvarCarrinho();
  atualizarCarrinho();
}


window.onload = atualizarCarrinho;

window.removerItem = removerItem;

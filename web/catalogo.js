const botoesAdd = document.querySelectorAll('.btn-add');

botoesAdd.forEach(botao => {
  botao.addEventListener('click', (e) => {
    const card = e.target.closest('.card-img');

    const nome = card.getAttribute('data-nome');
    const preco = parseFloat(card.getAttribute('data-preco'));
    const imagem = card.querySelector('img').src;

    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];


    carrinho.push({ nome, preco, imagem });

    localStorage.setItem('carrinho', JSON.stringify(carrinho));

    alert(`${nome} adicionado ao carrinho!`);
  });
});

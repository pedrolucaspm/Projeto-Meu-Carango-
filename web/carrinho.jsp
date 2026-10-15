<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Carrinho</title>
    <style>
        body { background: #111; color: #fff; font-family: sans-serif; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #555; padding: 10px; text-align: left; }
        th { background: #222; }
        button {
            padding: 10px 20px;
            background: #cc0000; 
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background: #990000; 
        }
    </style>
</head>
<body>

<h1>Seu Carrinho</h1>

<table id="carrinhoTable">
    <thead>
        <tr>
            <th>Imagem</th>
            <th>Nome</th>
            <th>Preço</th>
            <th>Marca</th>
            <th>Remover</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>

<button id="finalizarCompraBtn">Finalizar Compra</button>

<script>
    function carregarCarrinho() {
        let carrinho = JSON.parse(localStorage.getItem('carrinho') || '[]');
        let tbody = document.querySelector('#carrinhoTable tbody');
        tbody.innerHTML = '';

        if (carrinho.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;">Carrinho vazio</td></tr>';
            return;
        }

        carrinho.forEach((item, index) => {
            let tr = document.createElement('tr');

            let imgTd = document.createElement('td');
            let img = document.createElement('img');
            img.src = item.imagem || '';
            img.style.width = '100px';
            imgTd.appendChild(img);
            tr.appendChild(imgTd);

            let nomeTd = document.createElement('td');
            nomeTd.textContent = item.nome;
            tr.appendChild(nomeTd);

            let precoTd = document.createElement('td');
            precoTd.textContent = 'R$ ' + item.preco.toFixed(2);
            tr.appendChild(precoTd);

            let marcaTd = document.createElement('td');
            marcaTd.textContent = item.marca || 'Desconhecida';
            tr.appendChild(marcaTd);

            let removerTd = document.createElement('td');
            let btnRemover = document.createElement('button');
            btnRemover.textContent = 'X';
            btnRemover.onclick = () => {
                carrinho.splice(index, 1);
                localStorage.setItem('carrinho', JSON.stringify(carrinho));
                carregarCarrinho();
            };
            removerTd.appendChild(btnRemover);
            tr.appendChild(removerTd);

            tbody.appendChild(tr);
        });
    }

    document.getElementById('finalizarCompraBtn').addEventListener('click', () => {
        let carrinho = JSON.parse(localStorage.getItem('carrinho') || '[]');
        if (carrinho.length === 0) {
            alert('Seu carrinho está vazio!');
            return;
        }

        let form = document.createElement('form');
        form.method = 'POST';
        form.action = 'finalizarcompra.jsp';

        let input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'carrinho';
        input.value = JSON.stringify(carrinho);
        form.appendChild(input);

        document.body.appendChild(form);
        form.submit();
    });

    carregarCarrinho();
</script>
<img align="right" src="fundocarrinho.jpg" width="400" height="300">
</body>
</html>
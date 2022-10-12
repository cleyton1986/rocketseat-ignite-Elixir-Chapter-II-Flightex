<p align="center">
  <img  src="./assets/cover-elixir.png">
</p>

<h1 align="center">
  Ignite (Elixir) - Rocketseat
</h1>

<h3 align="center">
  Chapter II - Desafio 01: Reservas de voos
</h3>

</p>

<blockquote align="center">“Tudo deveria se tornar o mais simples possível, mas não simplificado - Albert Einstein”!</blockquote>

<p align="center">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/cleyton1986/rocketseat-ignite-desafio-01-elixir-reservas-de-voo?color=%2304D361">

  <a href="https://www.linkedin.com/in/cleytonalves">
    <img alt="Made by Cleyton" src="https://img.shields.io/badge/Made%20by-Cleyton_Alves-Alves%2304D361">
  </a>

  <img alt="License" src="https://img.shields.io/badge/license-MIT-%2304D361">

  <a href="https://github.com/cleyton1986/rocketseat-ignite-desafio-01-elixir-reservas-de-voo/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/cleyton1986/rocketseat-ignite-desafio-01-elixir-reservas-de-voo?style=social">
  </a>
</p>

<p align="center">
  <a href="#tecnologias-e-recursos">Tecnologias e Recursos</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#sobre-o-desafio">Sobre o desafio</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#específicação-dos-testes">Especificação de testes</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#instalação-e-execução">Instalação e execução</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#calendar-entrega">Entrega</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#memo-licença">Licença</a>
</p>


## Tecnologias e recursos

- [Elixir](https://elixir-lang.org/install.html)

</br>

## Sobre o desafio

Nesse desafio, você deverá criar uma aplicação de reserva de voos, onde haverá o cadastro de usuários e o cadastro de reservas para um usuário.

A struct do usuário deverá possuir os seguintes campos:

```js 
%User{
	id: id,
	name: name,
	email: email,
	cpf: cpf
}

```

**Obs:** O Id deve ser gerado automaticamente, pode ser um inteiro ou um UUID, mas não pode se repetir.

A struct da reserva deverá possuir os seguintes campos:

```js 
%Booking{
	id: id,
	complete_date: complete_date,
	local_origin: local_origin,
	local_destination: local_destination,
	user_id: user_id
}
```

O campo `data_completa` deverá ser uma `NaiveDateTime`, que é um formato de data sem fuso horário e com funções auxiliares. Mais detalhes sobre [NaiveDateTime aqui](https://hexdocs.pm/elixir/NaiveDateTime.html#content).

<aside>
⚠️ É importante que todos os dados sejam salvos em um **Agent**, de acordo com o que foi visto no módulo.

</aside>

Se quiser testar a sua implementação a partir do terminal, rode `iex -S mix` dentro do diretório raiz do projeto.

</br>

##  Download do arquivos

  - [part_1.csv](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/ef3f1650-5374-4430-bc33-e89b51ad949a/part_1.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20221009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20221009T171439Z&X-Amz-Expires=86400&X-Amz-Signature=3a6ca573d89e80c776360553e7ee101df7fecd6f13e514d81aae6e4386c67f74&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22part_1.csv%22&x-id=GetObject)
  - [part_2.csv](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/019635f0-d0ed-4b42-b69b-939d7492563c/part_2.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20221009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20221009T171454Z&X-Amz-Expires=86400&X-Amz-Signature=acbba6d6829dc3db1e469e5a667aed0b7b7bca060406f468fb2b9cf426f5150c&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22part_2.csv%22&x-id=GetObject)
  - [part_3.csv](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/4800edf6-8d81-4209-9841-b45a9d8fa951/part_3.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20221009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20221009T171507Z&X-Amz-Expires=86400&X-Amz-Signature=941ef4e47d2d52cf08409c9d909ac93fde2472bdfdb9605b9f9571153a8cf413&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22part_3.csv%22&x-id=GetObject)

</br>

## Específicação dos testes

Em cada teste, você encontrará uma breve descrição do que sua aplicação deve cumprir para que o teste passe.

Para esse desafio, temos os seguintes testes:

### Bookings:

<p>
  🧪 (
    <a href="https://www.notion.so/Testes-test-bookings-booking_agent_test-exs-f1aeba950bd244168d78120d802b14b5">test/bookings/booking_agent_test.exs</a>
  )
</p>

<p>
  🧪 (
    <a href="https://www.notion.so/Testes-test-bookings-booking_test-exs-f438dcbbb5ca4f369678e15049aa6bc0">test/bookings/booking_test.exs</a>
  )
</p>

<p>
  🧪 (
    <a href="https://www.notion.so/Testes-test-bookings-create_or_update_test-exs-3cffdfc8a85d42c1823373bce2497592">test/bookings/create_or_update_test.exs</a>
  )
</p>

<p>
  🧪 (
    <a href="https://www.notion.so/Teste-test-bookings-report_test-exs-6d37d678415f48f186d5779a2bcf20f4">test/bookings/report_test.exs</a>
  ) 👀 OBS.: Este teste não é obrigatório.
</p>

<p>
  🧪 (
    <a href="https://www.notion.so/Testes-test-bookings-create_or_update_test-exs-3cffdfc8a85d42c1823373bce2497592">test/bookings/create_or_update_test.exs</a>
  )
</p>
</br>

### Users:

<p>
  🧪 (
    <a href="https://www.notion.so/Teste-test-users-create_or_update_test-exs-e7c929008e7a491c9aeaa9ee36a12457">/test/users/create_or_update_test.exs</a>
  )
</p>

<p>
  🧪 (
    <a href="https://www.notion.so/Teste-test-users-user_agent_test-exs-e1b36b62855540bc9573ceebe4bbc6ad">/test/users/user_agent_test.exs</a>
  )
</p>

<p>
  🧪 (
    <a href="https://www.notion.so/Teste-test-users-users_test-exs-d1272b91269f4989ad4e919d302b140b">/test/users/users_test.exs</a>
  )
</p>

</br>

## :calendar: Entrega

Esse desafio foi entregue na plataforma Skylab - Rocketseat.
</br>

<p align="center">
  <img  src="./assets/test-result.png">
</p>

## Instalação e execução
</br>


### Configuração do ambiente:
<p>
  💿 (
    <a href="https://www.notion.so/Ambiente-de-desenvolvimento-Trilha-Elixir-aa2399b4ec17447582d04cbce8ffa12f">Guia de instalação e configuração do Ambiente - Elixir </a>
  )
</p>
</br>

```bash
# OBS.: ANTES DE PROCEDIMENTO, CERTIFIQUE-SE QUE O ELIXIR ESTEJA INSTALADO NO SEU COMPUTADOR CORRETAMENTE.

# Clone esse repositório
$ git clone https://github.com/cleyton1986/rocketseat-ignite-desafio-01-elixir-reservas-de-voo

# Entre no diretório
$ cd rocketseat-ignite-desafio-01-elixir-reservas-de-voo

# baixe as dependencias
$ mix deps.get

# para compilar o projeto, execute o comando
$ mix compile

# para rodar os testes, execute o comando
$ mix test

# para mais detalhes
$ mix test --cover

# acessando o iex
$ iex -S mix

# teste dos métodos usando usando o iex

```
## :memo: Licença

Esse projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

 implementado por 👨🏽‍💻 Cleyton Alves e desenvolvido 💜 by Rocketseat.


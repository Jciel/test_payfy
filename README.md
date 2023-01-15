# TestPayfy



## Pre requisitos
Para executar o projeto é necessário já ter instalado o Erlang/Elixir e banco de dados PostgreSQL, verificar na paǵina dos projetos como é a instalção de cada um
* [PostgreSQL](https://www.postgresql.org)
* [Elixir](https://elixir-lang.org)

 Devemos configurar um user ``postgres`` e senha ``postgres`` para utilizamos o banco de dados   

### Versões utilizadas
  * PostgreSQL 15.1
  * Elixir 1.14.2
  * Erlang/OTP 24

<br>
<br>

## Instalação

Primeiramente devemos fazer o clone do repositório do github  
```sh
git clone https://github.com/Jciel/test_payfy.git
```

<br>
<br>

Após o clone doprojeto, podemos entrar no diretório do projeto e instalar   
as dependências da aplicação   
```sh
cd diretorio

mix deps.get
```

<br>

Agora podemos executar a criação do banco de dados da aplicação, esse comando  
também irá executar a seed que irá inserir alguns dados no banco de dados  
```sh
mix ecto.setup
```
Caso necessário podemos executar a criação das tabelas no banco de dados utilizando o comando
```sh
mix ecto.migrations
```
Caso necessário podemos executar o seed com o comando
```sh
mix run priv/repo/seeds.exs
```

<br>

### Teste
Podemos executar os testes com o comando  
```sh
mix test
```
Também é possivel executar testes pelo Insomnia, importando a coleção de request existente na  
rais do projeto ``request_collection_test_payfy.json``

<br>
<br>

Após podemos iniciar o Phoenix em execução local com o seguinte comando
```sh
mix phx.server
```
Assim a API estará pronta para execução

<br>
<br>
<br>


## API Endpoints  


<details>
<summary> POST "/users"</summary>

<summary>Input</summary>

```json
{
  "name" : "nameuser",
  "email" : "test_email@gmail.com"
}
```
<summary>Response</summary>

```json
200 OK
{
  "data": {
    "id": "cd748ad4-a8cd-4a8d-9179-54ee793ecad8"
  }
}
```

<br>

<summary>Input</summary>

```json
{
  "name" : "nameuser",
  "email" : "error_email"
}
```
<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"email": [
			"has invalid format"
		]
	}
}
```

<br>

<summary>Input</summary>

```json
{
  "email" : "test_email@gmail.com"
}
```
<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"name": [
			"can't be blank"
		]
	}
}
```

<br>

<summary>Input</summary>

```json
{
  "name" : "nameuser"
}
```
<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"email": [
			"can't be blank"
		]
	}
}
```

</details>


<br>


<details>
<summary>POST "/sweepstakes"</summary>

<summary>Input</summary>
Post with all valid params

```json
{
  "name" : "namesweepstake",
  "draw_date" : 1701388800000,
	"user_id" : null
}
```
<summary>Response</summary>

```json
200 OK
{
	"data": {
		"id": "f4832449-332e-439e-a9a7-f9188d79f0e9"
	}
}
```

<br>

<summary>Input</summary>
Post with a invalid user_id

```json
{
  "name" : "namesweepstake",
  "draw_date" : 1701388800000,
	"user_id" : "8ae0f214-c307-41d3-8787-a2d2a7568ce8"
}
```
<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"user_id": [
			"does not exist"
		]
	}
}
```

<br>

<summary>Input</summary>
Post without a draw date

```json
{
  "name" : "namesweepstake",
	"user_id" : null
}
```
<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"draw_date": [
			"can't be blank"
		]
	}
}
```

<br>

<summary>Input</summary>
Post without a name

```json
{
  "draw_date" : 1701388800000,
	"user_id" : null
}
```
<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"name": [
			"can't be blank"
		]
	}
}
```
</details>

<br>

<details>

<summary> POST "/register-sweepstakes"</summary>

<summary>Input</summary>
Post with all valid params

```json
{
	"user_id" : "76e28268-e6fc-4a05-bdee-e540a1c0e187",
	"sweepstake_id" : "22559088-79cc-4fcd-a065-6d4064e2c819"
}

```
<summary>Response</summary>

```json
200 OK
{
	"data": "Ok"
}
```

<br>

<summary>Input</summary>
Try create a register with valid params sweepstake outside deadline  

```json
{
  "user_id" : "76e28268-e6fc-4a05-bdee-e540a1c0e187",
  "sweepstake_id" : "a7d76267-44b0-40a1-8e39-618a74a11d8b"
}
```

<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"sweepstake_id": [
			"Registration outside the draw deadline"
		]
	}
}
```

<br>

<summary>Input</summary>
Try create a register with valid params in same sweepstake  

```json
{
  "user_id" : "76e28268-e6fc-4a05-bdee-e540a1c0e187",
  "sweepstake_id" : "123ed3ae-2a5c-45b0-819d-4e4afde250b0"
}
```

<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"sweepstake_id": [
			"User already registered in this draw"
		]
	}
}
```

<br>

<summary>Input</summary>
Try create a register with invalid user_id  

```json
{
  "user_id" : "123ed3ae-2a5c-45b0-819d-4e4afde250b0",
  "sweepstake_id" : "123ed3ae-2a5c-45b0-819d-4e4afde250b0"
}
```

<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"user_id": [
			"does not exist"
		]
	}
}
```

<br>

<summary>Input</summary>
Try create a register with invalid sweepstake_id   

```json
{
  "user_id" : "76e28268-e6fc-4a05-bdee-e540a1c0e187",
  "sweepstake_id" : "0b13d449-6a89-435d-b26a-7c5364c65231"
}
```

<summary>Response</summary>

```json
422 Unprocessable Entity
{
	"errors": {
		"sweepstake_id": [
			"does not exist"
		]
	}
}
```
</details>

<br>

<details>
<summary> GET "/consult-draw"</summary>

<summary>Input</summary>
Get a User winner from Sweepstake   

id: ``/3bc57d10-c52b-425e-8c24-69934ba9d4dd``

<summary>Response</summary>

```json
200 OK
{
	"data": {
		"email": "joao@gmail.com",
		"id": "6a764634-35a1-4c23-b1a9-6f625281b942",
		"name": "João"
	}
}
```

<br>

<summary>Input</summary>
Try get a User winner from Sweepstake without winner  

id: ``/123ed3ae-2a5c-45b0-819d-4e4afde250b0``

<summary>Response</summary>

```json
404 Unprocessable Entity
{
	"errors": {
		"user_id": [
			"does not exist"
		]
	}
}
```

<br>

<summary>Input</summary>
Try get a User winner from Sweepstake with generic id

id: ``/e17f5ce2-e155-44c4-8996-f02f9e84c7e5``

<summary>Response</summary>

```json
404 Unprocessable Entity
{
	"errors": {
		"sweepstake_id": [
			"does not exist"
		]
	}
}
```
</details>
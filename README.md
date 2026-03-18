# README

# 🛒 E-commerce com Integração de Pagamento (Stripe)

Aplicação web desenvolvida com Ruby on Rails que simula um fluxo completo de compra online, incluindo criação de pedidos, integração com Stripe Checkout e confirmação de pagamento.

---
## 🚀 Demostraçao
https://www.loom.com/share/61769564bca24be0913a3a419058cf66


## 🧠 Sobre o Projeto

Este projeto foi desenvolvido com o objetivo de simular um fluxo real de pagamento em uma aplicação web, utilizando boas práticas de backend e integração com APIs externas.

O sistema permite que o usuário:

- Inicie um pagamento
- Seja redirecionado para o checkout do Stripe
- Finalize a compra com cartão de teste
- Retorne para a aplicação com o status do pagamento validado

---

## ⚙️ Funcionalidades

- 💳 Integração com Stripe Checkout
- 📦 Criação de pedidos no banco de dados
- ✅ Validação de pagamento via API
- 🔄 Atualização de status do pedido (pending → paid)
- 🌐 Redirecionamento pós-pagamento (success/cancel)
- 🔐 Uso de variáveis de ambiente para segurança

---

## 🏗️ Arquitetura

Fluxo da aplicação:

```text
Usuário clica em "Pagar"
↓
Rails cria um pedido (status: pending)
↓
Rails cria uma sessão no Stripe
↓
Usuário é redirecionado para o checkout
↓
Pagamento realizado
↓
Stripe redireciona para /success
↓
Rails valida pagamento via session_id
↓
Pedido atualizado para "paid"
````
## COMO RODAR LOCALMENTE

# Clonar repositório
git clone https://github.com/seu-usuario/seu-repo.git

# Entrar na pasta
cd seu-repo

# Instalar dependências
bundle install

# Criar banco
rails db:create db:migrate

# Rodar servidor
rails s

# Rodar o stripe
stripe listen --forward-to http://localhost:3000/webhook

##Cartão de teste

Número: 4242 4242 4242 4242
Validade: qualquer data futura
CVC: qualquer número

##Contas testes

-email:user@email.com
-password:123456

##ADMIN

-email:admin@site.com
-password:123456


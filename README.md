# Despesas App

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?logo=firebase&logoColor=black)
![GraphQL](https://img.shields.io/badge/GraphQL-Hasura-E10098?logo=graphql&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-Offline-003B57?logo=sqlite&logoColor=white)
![UEG](https://img.shields.io/badge/UEG-TCC-0A4DA2)
![Platform](https://img.shields.io/badge/Platform-Android-success)

Aplicativo mobile para gerenciamento de finanças pessoais desenvolvido em **Flutter**, utilizando **Firebase Authentication**, **Hasura GraphQL** e **SQLite** para oferecer sincronização de dados online e funcionamento offline.

---

# Sobre o projeto

O **Despesas App** foi desenvolvido com o objetivo de facilitar o gerenciamento financeiro pessoal por meio de uma interface simples, intuitiva e moderna.

O aplicativo permite registrar receitas e despesas, acompanhar o saldo disponível, visualizar estatísticas financeiras e sincronizar automaticamente os dados com o servidor quando houver conexão com a internet.

O projeto utiliza uma arquitetura em camadas, separando responsabilidades entre interface, serviços, persistência local e comunicação com o backend.

---

# Trabalho de Conclusão de Curso

Este projeto foi desenvolvido como **Trabalho de Conclusão de Curso (TCC)** do curso de **Bacharelado em Sistemas de Informação** da **Universidade Estadual de Goiás (UEG)**.

A pesquisa aborda o desenvolvimento de uma aplicação móvel para controle financeiro utilizando Flutter, Firebase, GraphQL, SQLite e sincronização offline, aplicando conceitos de arquitetura de software, desenvolvimento mobile e computação em nuvem.

**Monografia (acesso para leitura):**

https://docs.google.com/document/d/1HZg0tvlsHUJMARMAiV11wwSB8aB7bf7oTxGbm3moVpk/edit?usp=sharing

---

# Funcionalidades

- Cadastro de usuários
- Login e autenticação com Firebase
- Cadastro de receitas
- Cadastro de despesas
- Edição de transações
- Exclusão de transações
- Controle de saldo
- Dashboard financeiro
- Estatísticas por período
- Perfil do usuário
- Funcionamento offline
- Sincronização automática com Hasura GraphQL
- Cloud Functions para gerenciamento de usuários

---

# Tecnologias

## Mobile

- Flutter
- Dart

## Backend

- Firebase Authentication
- Firebase Core
- Firebase Cloud Functions
- Hasura GraphQL

## Banco de dados

- SQLite
- GraphQL

## Gerenciamento

- GetIt
- Flutter Secure Storage
- Intl
- FL Chart

---

# Arquitetura

```
lib/
├── common/
│   ├── constants/
│   ├── models/
│   ├── theme/
│   └── widgets/
│
├── features/
│   ├── cadastro/
│   ├── home/
│   ├── login/
│   ├── onboarding/
│   ├── profile/
│   ├── splash/
│   ├── stats/
│   ├── transactions/
│   └── wallet/
│
├── repositories/
├── services/
├── locator.dart
├── app.dart
└── main.dart
```

---

# Sincronização Offline

O aplicativo utiliza **SQLite** para armazenar os dados localmente.

Quando não existe conexão com a internet, todas as operações continuam funcionando normalmente.

Assim que a conexão é restabelecida, ocorre a sincronização automática com o backend GraphQL.

Cada registro possui um status de sincronização:

| Status | Descrição |
|---------|-----------|
| create | Registro criado localmente |
| update | Registro alterado localmente |
| delete | Registro removido localmente |
| synced | Registro sincronizado |

---

# Cloud Functions

O projeto utiliza Firebase Cloud Functions para:

- criação de usuários;
- atualização de usuários;
- exclusão de usuários;
- integração com o Hasura.

---

# Estrutura de Navegação

```
Splash
   │
   ▼
Onboarding
   │
   ▼
Login / Cadastro
   │
   ▼
Home
 ├── Carteira
 ├── Estatísticas
 ├── Perfil
 └── Nova Transação
```

---

# Pré-requisitos

- Flutter SDK
- Dart SDK
- Android Studio ou VS Code
- Firebase CLI
- Node.js
- Projeto Firebase
- Instância Hasura GraphQL

---

# Instalação

Clone o projeto:

```bash
git clone https://github.com/augusto-hog/despesas_app.git
```

Entre na pasta:

```bash
cd despesas_app
```

Instale as dependências:

```bash
flutter pub get
```

Configure o Firebase:

```bash
flutterfire configure
```

Execute o aplicativo:

```bash
flutter run
```

---

# Cloud Functions

Entre na pasta:

```bash
cd functions
```

Instale as dependências:

```bash
npm install
```

Configure as variáveis do Hasura:

```bash
firebase functions:config:set hasura.endpoint="URL_DO_HASURA"

firebase functions:config:set hasura.admin_secret="ADMIN_SECRET"
```

Faça o deploy:

```bash
firebase deploy --only functions
```

---

# Build

APK

```bash
flutter build apk --release
```

App Bundle

```bash
flutter build appbundle --release
```

Web

```bash
flutter build web
```

---

# Objetivos do projeto

- Demonstrar conhecimentos em Flutter
- Aplicar arquitetura em camadas
- Desenvolver sincronização offline
- Integrar Firebase e Hasura
- Aplicar GraphQL em aplicações móveis
- Desenvolver uma solução prática para controle financeiro pessoal

---

# Autor

**Augusto Henrique Oliveira Gomes**

Graduado em **Sistemas de Informação** pela **Universidade Estadual de Goiás (UEG)**.

GitHub: https://github.com/augusto-hog

LinkedIn: https://www.linkedin.com/in/augusto-henrique-oliveira-gomes1501

---

⭐ Se este projeto foi útil para você, considere deixar uma estrela no repositório.

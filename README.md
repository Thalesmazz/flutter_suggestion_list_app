# Suggestion List App (Flutter)

Este documento descreve a arquitetura, os componentes e o fluxo de funcionamento do aplicativo `suggestion_list_app`, desenvolvido em Flutter.

## 1. Visão Geral do Projeto

O `suggestion_list_app` é um aplicativo móvel que demonstra um fluxo de autenticação de usuário completo, consumo de uma API externa para exibição de uma lista de itens e navegação para uma tela de detalhes.

O projeto foi desenvolvido com foco em boas práticas, incluindo a separação de responsabilidades, modelagem de dados e um fluxo de usuário intuitivo.

## 2. Funcionalidades Implementadas

- **Autenticação de Usuário:** Tela de login com validação de formulário para e-mail e senha.
- **Navegação Segura:** O usuário só pode acessar a tela principal após um login bem-sucedido. A tela de login é removida da pilha de navegação para impedir o retorno a ela através do botão "voltar".
- **Consumo de API:** O aplicativo busca uma lista de "sugestões de investimento" de uma API JSON externa.
- **Visualização de Lista:** A tela principal (`HomePage`) exibe os dados da API em uma lista rolável e eficiente, mostrando uma imagem, título e descrição curta para cada item.
- **Tela de Detalhes:** Ao tocar em um item da lista, o usuário é levado a uma tela de detalhes (`DetailPage`) que exibe informações completas do item, incluindo uma imagem maior e uma descrição detalhada.
- **Logout:** A tela principal possui uma funcionalidade de logout com um `AlertDialog` de confirmação, permitindo que o usuário saia do aplicativo e retorne à tela de login de forma segura.

## 3. Estrutura de Arquivos

O código-fonte do projeto está organizado na pasta `lib/` da seguinte maneira, com cada tela e serviço tendo seu próprio arquivo dedicado para máxima clareza e manutenibilidade:



## 4. Detalhamento dos Componentes

#### `main.dart`
- **Função `main()`:** Ponto de entrada que inicializa o aplicativo com `runApp()`.
- **Widget `MyApp`:** Widget raiz do aplicativo. Sua principal responsabilidade é configurar o `MaterialApp`, definindo o tema global e o sistema de rotas nomeadas. A rota inicial é definida como `/login`, direcionando o usuário para a `LoginPage`.

#### `login_page.dart`
- **Widget `LoginPage`:** Um `StatefulWidget` que contém toda a UI e a lógica da tela de login. É responsável pela validação do formulário e pela navegação para a `HomePage` após um login bem-sucedido.

#### `api_service.dart`
- **Classe `ApiService`:** Contém a lógica de rede.
    - **Método `fetchSuggestions()`:** Método estático e assíncrono que faz uma requisição `GET` para a API, decodifica a resposta JSON e a transforma em uma lista de objetos `Suggestion`. Inclui tratamento de erros para falhas na requisição ou formato de JSON inesperado.

#### `suggestion_model.dart`
- **Classe `Suggestion`:** Define a estrutura de dados de uma "sugestão".
    - **Propriedades:** Contém todos os campos necessários para a `HomePage` (`imageSmallUrl`, `shortDescription`) e para a `DetailPage` (`imageLargeUrl`, `fullDescription`).
    - **Construtor de Fábrica `fromJson()`:** Responsável por criar uma instância de `Suggestion` a partir de um objeto `Map` (JSON decodificado), mapeando corretamente as chaves da API para as propriedades da classe. Inclui lógica de fallback (`??`) para evitar erros com dados nulos.

#### `home_page.dart`
- **Widget `HomePage`:** Um `StatefulWidget` que gerencia o estado da busca de dados.
    - **`initState()`:** Inicia a chamada à API através do `ApiService.fetchSuggestions()` apenas uma vez, quando a tela é criada.
    - **`FutureBuilder`:** Gerencia o ciclo de vida da requisição de forma assíncrona, exibindo um indicador de carregamento, uma mensagem de erro ou a lista de dados.
    - **`ListView.builder`:** Constrói a lista de forma eficiente, criando um `Card` com um `ListTile` para cada item.
    - **`onTap`:** Implementa a navegação para a `DetailPage`, passando o objeto `Suggestion` selecionado.
    - **`_showLogoutDialog()`:** Implementa a funcionalidade de logout com um `AlertDialog` de confirmação.

#### `details_page.dart`
- **Widget `DetailPage`:** Um `StatelessWidget` simples e reutilizável.
    - **Construtor:** Recebe um objeto `Suggestion` como parâmetro obrigatório.
    - **UI:** Exibe os dados recebidos (`imageLargeUrl`, `title`, `fullDescription`) em um layout formatado para leitura, com uma imagem de destaque no topo.

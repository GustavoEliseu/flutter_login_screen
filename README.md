# Português- flutter_login_screen <br>

Para testar, acessar ou acessar a página "releases" à direita no github, ou clonar o projeto e compilar. 
Para Iphones e MacOS será necessário compilar o projeto.
  
Um simples aplicativo em flutter desenvolvido para um desafio.

O aplicativo tem 2 telas, sendo uma de login utilizando uma api mockada usando mockito, e uma tela de dados onde o usuário pode digitar e salvar textos que são vinculados ao usuário utilizado ao logar.

### Mudanças não solicitadas no desafio:<br>

  -Foi utilizado mockito com DIO, com o objetivo de uma liberade maior para lidar com erros de requisição e respostas únicas sem depender de plataformas pagas/limitadas.<br>
  
  -As senhas estão sendo transformadas em uma string de binários que logo em seguida são reordenados com um algoritmo de encriptação. Esta parte poderia ser modificada para uma encriptação MD5, mas não é uma prioridade para este projeto.<br>
  
  -O aplicativo foi testado em Android, Ios, Browser(Chrome,Brave) nos sistemas operacionais Windows e MacOS. Também foi testado no android nativo do Windows 11.<br>
  
  -Pequenos exemplos de testes unitários e automatizados foram implementados.<br>

### O que não foi feito:
  - Permiti que o foco textField da tela de dados fosse perdido nos mobiles ao utilizar o botão nativo de voltar(baixo no android), <br>
  pois sem a possibilidade perda de foco seria difícil analisar o layout de forma correta.
 
  - Optei por não utilizar mockApi, devido as limitações nos modelos gratuitos destas plataformas.

### Otimizações Necessárias:
  
  - Verificação de leaks de memória, muito foi desenvolvido enquanto aprendia a tecnologia, por isso tenho certeza que na primeira tela existe uma possibilidade de leaks a serem corrigidos.
  
  - Otimização do uso de bateria, uma melhor organização dos layouts para evitar o consumo de bateria e memória.
  
  - Melhor organizaçao dos widgets internos, principalmente na segunda tela. Separar os widgets em funções menores com o objetivo de reduzir e facilitar a leitura do código da tela.

  - Realmente utilizar o ViewModel, este foi devideo a eu querer entregar este projeto antes de viajar para o natal e ao fato de o código da api ainda estar mockado. Irei separar o view para view e viewmodel quando desenvolver uma api nodejs para este projeto em janeiro.
  
## Verificação de senha em tempo real, e video completo do aplicativo


<p align="center">
<img src="https://github.com/GustavoEliseu/flutter_login_screen/blob/main/Releases/flutter_login_gustavo_video.gif" width="240" height="500"/>
</p>
Url to the video: https://github.com/GustavoEliseu/flutter_login_screen/blob/main/Releases/flutter_login_gustavo_video.webm

# English- flutter_login_screen

A small flutter app developed as a challenge.

Has two screens, being a login one with a mocked api using mockito and a data screen, where a user can type texts that will be saved with sharedpreferences.

### Changes not requested in the challenge:<br>

  -Used mockito and DIO instead of mockApi, due to it providing a better capacity to deal with http erros and unique responses without any paid service.<br>

  -Password is being encrypted to binary then every char of the binary string is being reordered again. This should be changed to an MD5 encryption later, but not a priority for this project.<br>

  -The app was tested on android, ios, web and Windows11/Android.<br>

  -Small sample of unit and automated tests were implemented.<br>

  ### What wasn't developed:
  - Allowed the focus for the Data Screen to be lost when the back button(hardware) is being pressed. This is due to never losing focus would make it dificult to actually test the layout.
 
  - Opted to not use any mockapi service, due to its limits on non paid features.

### Improvements needed:

  - Small changes are needed to guarantee that there are no memory leaks on the app. <br>
  
  - A change on the sharedPreferences to save only when the screen is being closed is needed to improve battery usage.<br>

  - Battery use optimization, a better organization of the widgets to avoid any exagerated consumption and having a better code to read.

  - Actually use the viewmodel, due to the api being mocked and i wanting to deliver this challenge before christmas it was not used. I will fix this, when i develop a nodeJS api for this project on january.

<br>
Improvements needed: 
-Small changes are needed to guarantee that there are no memory leaks on the app. <br>
-A change on the sharedPreferences to save only when the screen is being closed is needed to improve battery usage.<br><br><br><br>

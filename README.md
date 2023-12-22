# Português- flutter_login_screen <br>

Para testar, acessar ou acessar a página "releases" à direita no github, ou clonar o projeto e compilar. 
Para Iphones e MacOS será necessário compilar o projeto.
  
Um simples aplicativo em flutter desenvolvido para um desafio.

O aplicativo tem 2 telas, sendo uma de login utilizando uma api mockada usando mockito, e uma tela de dados onde o usuário pode digitar e salvar textos que são vinculados ao usuário utilizado ao logar.

## Mudanças não solicitadas no desafio:<br>

  -Foi utilizado mockito com DIO, com o objetivo de uma liberade maior para lidar com erros de requisição e respostas únicas sem depender de plataformas pagas/limitadas.<br>
  
  -As senhas estão sendo transformadas em uma string de binários que logo em seguida são reordenados com um algoritmo de encriptação. Esta parte poderia ser modificada para uma encriptação MD5, mas não é uma prioridade para este projeto.<br>
  
  -O aplicativo foi testado em Android, Ios, Browser(Chrome,Brave) nos sistemas operacionais Windows e MacOS. Também foi testado no android nativo do Windows 11.<br>
  
  -Pequenos exemplos de testes unitários e automatizados foram implementados.<br>

## Verificação de senha em tempo real, e video completo do aplicativo


<p align="center">
<img src="https://github.com/GustavoEliseu/flutter_login_screen/blob/main/Releases/flutter_login_gustavo_video.gif" width="240" height="500"/>
</p>
Url to the video: https://github.com/GustavoEliseu/flutter_login_screen/blob/main/Releases/flutter_login_gustavo_video.webm

# English- flutter_login_screen

A small flutter app developed as a challenge.

Has two screens, being a login one with a mocked api using mockito and a data screen, where a user can type texts that will be saved with sharedpreferences.

## Changes not requested in the challenge:<br>

  -Used mockito and DIO instead of mockApi, due to it providing a better capacity to deal with http erros and unique responses without any paid service.<br>

  -Password is being encrypted to binary then every char of the binary string is being reordered again. This should be changed to an MD5 encryption later, but not a priority for this project.<br>

  -The app was tested on android, ios, web and Windows11/Android.<br>

  -Small sample of unit and automated tests were implemented.<br>

<br>
Improvements needed: 
-Small changes are needed to guarantee that there are no memory leaks on the app. <br>
-A change on the sharedPreferences to save only when the screen is being closed is needed to improve battery usage.<br>

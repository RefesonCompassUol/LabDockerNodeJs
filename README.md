#Programa de bolsas DevSecOps CompassUol- Grupo 6- Trilha Docker e atividade Linux. 

#Componentes do grupo: Flavio Henrique Almeida Júnior, Lucas Freiberger de Souza, Maria Eduarda Araújo de Oliveira e Refeson Dos Santos Pinho. 

 

##Projeto 

O projeto em questão foi solicitado pela empresa Compass UOL especificamente como atividade prática no desenvolvimento da trilha de Certificação LPI Linux Essentials e Docker. Referente ao estágio de DevSecOps. 
 

Eles solicitaram na atividade que subíssemos um servidor Oracle Linux do zero, sem interface gráfica, adicionando algumas exigências e restrições no desenvolvimento do projeto. 
 

Desta forma, devemos subir um Docker, instalando uma imagem com aplicação nodejs e subir um wordpress nesse nodejs via Docker. 

 
Ainda, é necessário deixar a rede virtual em modo NAT (Network Address Translation) e ajustar o DNS (Domain Name System) como nome nodjslabdocker, e configurar um IP (Internet Protocol) fixo e o acesso via SSH (Secure Shell). 
 

## Desenvolvimento 

Para esse desenvolvimento, iremos usar virtualbox como um ambiente virtual usaremos a ISO do ORACLE LINUX e na sua aplicação Docker com o objetivo de facilitar a criação e administração de ambientes isolados.  

 

Ainda, utilizaremos as imagens NODE como back-end, mysql como banco de dados e o wordpress como front para nos auxiliar neste desenvolvimento. 

 
 

### Tarefas 

Para essa aplicação serão necessárias as seguintes tarefas: 

 

- [T-01] Instalar uma imagem ORACLE LINUX na sua última versão; 

- [T-02] Ajustar a rede da máquina em IP de classe A com a máscara /24; 

- [T-03] Deixar a rede em modo NAT; 

- [T-04] Ajusta LVMs para as partições /home, /var e /tmp; 

- [T-05] Configura o HOSTNAME; 

- [T-06] Ajustar DNS com o nome nodejslabdocker; 

- [T-07] Configura a rede do servido com IP fixo; 

- [T-08] Configura o SSH; 

- [T-09] Bloquear o acesso SSH para o root; 

- [T-10] Criar um filesystem /var/lib/docker com 10GB em ext4; 

- [T-11] Criar um projetor versionado; 

- [T-12] Subir um docker; 

- [T-13] instalar uma imagem da aplicação nodejs e suba um wordpress neste nodejs. Via docker; 

 

### Restrições  

- [R-01] Proibido acesso à console após ajustar o IP fixo; 

- [R-02] Proibido logar como root; 

- [R-03] Proibido executar e rodar o Docker como root mode; 

- [R-04] Criar um usuário com o nome diferente do DNS sugerido; 

 

## Configuração de redes  

- [IP] 10.0.2.17(classe A); 

- [Netmask] 255.255.255.0(/24); 

- [Gateway] 10.0.2.2; 

- [DNS] nodejslabdocker; 

- [HOSTNAME] atividadecompasso; 

## Entrega 

 
 

Deverá ser desenvolvido a aplicação em questão e entregue através do Github e coma documentação do READ.ME.  

 Segue-se um link do comandos usados desse projeto: 
 [Comandos-Linux e Docker.docx](https://github.com/RefesonCompassUol/LabDockerNodeJs/files/9041215/Comandos-Linux.e.Docker.docx)



Deverá ser concluído até o dia 04/07/2022 3:15. 

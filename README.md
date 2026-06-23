# MyMONAN-MPASSIT-puro
MPASSIT com minhasmodificaÃ§Ãµes adaptadas para uso nas saÃ­das do MONAN. Apenas sources aqui.
Primeiro codigo puro, do jeito que veio do repositÃ³rio original com poucas modificaÃ§Ãµes para rodar na JACI@GNU + ESMF-8.9.0.

Posteriores modificaÃ§Ãµes serÃ£o infomadas nesta pagina. 



### COMPILACAO:

- Carregar o ambiente de modulos:
~~~
source setenv_jaci_gnu_compile.bash
~~~

- Tenha um ESMF (no minimo versão 8.3.0) compilada e disponivel.

- Variavel NETCDF deve estar declarada e apontada para o diretorio principal do NETCDF (isso ja esta feito no setenv).

- Variavel ESMFMKFILE deve estar declarada e apontada para o arquivo esmf.mk do seu ESMF instalado.

- Execute:
~~~
compile.sh
~~~


### EXECUCAO:

- Crie os arquivos necessarios para seu diretorio de rodada `run` :
~~~
varlist2d                 --> namelist das variaveis 2d a serem pos processadas (clonua1: nome da var do modelo, col2: nome da var no pos)
varlist3d                 --> namelist das variaveis 3d a serem pos processadas (clonua1: nome da var do modelo, col2: nome da var no pos)
namelist.input           --> namelist do mapssit com opcoes ja ajustadas para MONAN
mpassit_submit.bash      --> script de submissao.
mpassit                  --> executavel disponivel em `bin`
setenv_jaci_gnu_run.bash --> script que ajusta o ambiente para execucao do mpassit.
~~~


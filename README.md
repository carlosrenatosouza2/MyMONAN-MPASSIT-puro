# MyMONAN-MPASSIT-puro
MPASSIT com minhasmodificações adaptadas para uso nas saídas do MONAN. Apenas sources aqui.
Primeiro codigo puro, do jeito que veio do repositório original com poucas modificações para rodar na JACI@GNU + ESMF-8.9.0.

Posteriores modificações serão infomadas nesta pagina. 



### COMPILACAO:

- Carregar o ambiente de modulos:
~~~
source setenv_jaci_gnu_compile.bash
~~~

- Tenha um ESMF (no minimo vers�o 8.3.0) compilada e disponivel.

- Variavel NETCDF deve estar declarada e apontada para o diretorio principal do NETCDF (isso ja esta feito no setenv).

- Variavel ESMFMKFILE deve estar declarada e apontada para o arquivo esmf.mk do seu ESMF instalado.

- Execute:
~~~
compile.sh
~~~


### EXECUCAO:

- Crie os arquivos necessarios para seu diretorio de rodada `run` (veja exemplos na pasta `parm`:
~~~
diaglist                 --> namelist das variaveis a serem pos processadas
namelist.input           --> namelist do mapssit com opcoes ja ajustadas para MONAN
mpassit_submit.bash      --> script de submissao.
mpassit                  --> executavel disponivel em `bin`
setenv_jaci_gnu_run.bash --> script que ajusta o ambiente para execucao do mpassit.
~~~


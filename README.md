# MyMONAN-MPASSIT-puro

Versão adaptada do **MPASSIT** para uso com as saídas do **MONAN**, compilada e testada no supercomputador **Jaci (INPE)**.

Baseado no repositório original de Larissa Reames: [LarissaReames/MPASSIT](https://github.com/LarissaReames/MPASSIT)

> Este repositório contém apenas os *sources* — código-fonte praticamente puro, com o mínimo de modificações necessárias para compilar e rodar na Jaci@GNU com ESMF-8.9.0/GNU13.

---

## Sumário

- [Sobre](#sobre)
- [Pré-requisitos](#pré-requisitos)
- [Compilação](#compilação)
- [Execução](#execução)
  - [Arquivos necessários](#arquivos-necessários)
  - [Exemplo: `varlist_2d`](#exemplo-varlist_2d)
  - [Exemplo: `varlist_3d`](#exemplo-varlist_3d)
  - [Exemplo: `namelist.input`](#exemplo-namelistinput)
- [Créditos](#créditos)
- [Licença](#licença)

---

## Sobre

O MPASSIT é uma ferramenta de pós-processamento que interpola as saídas do modelo MPAS (e, aqui, do MONAN — modelo unificado brasileiro de tempo e clima baseado no MPAS) para grades regulares, permitindo posterior visualização e análise.

Esta versão mantém a lógica original do MPASSIT com o mínimo de alterações, ajustada apenas para:
- Compilar corretamente na Jaci (INPE) com GNU 13 + ESMF 8.9.0/8.9.1;
- Processar corretamente os arquivos de diagnóstico/histórico gerados pelo MONAN.

---

## Pré-requisitos

- Compilador GNU (testado com GNU 13)
- [ESMF](https://earthsystemmodeling.org/) ≥ 8.3.0 (recomendado: 8.9.0/8.9.1, compilado com GNU 13)
- Biblioteca NetCDF (C e Fortran)
- Acesso ao supercomputador Jaci (INPE) — ou ambiente equivalente com os módulos acima

---

## Compilação

**1. Carregue o ambiente de módulos:**

```bash
source setenv_jaci_gnu_compile_ESMFjaci.bash
```

**2. Garanta que o ESMF esteja disponível.**

O script acima já está preparado para uso no supercomputador Jaci (INPE) e carrega o ESMF 8.9.1 compilado com GNU 13 diretamente do sistema.

Caso deseje usar uma instalação própria do ESMF, ajuste as variáveis manualmente antes de compilar:

```bash
export ESMF_DIR=/my_dir_to_ESMF-dir/esmf-8.9.1
export ESMF_LIBDIR=${ESMF_DIR}/lib
export ESMF_MODDIR=${ESMF_DIR}/mod
export LIBRARY_PATH=${LIBRARY_PATH}:${ESMF_LIBDIR}
export PATH=${PATH}:${ESMF_DIR}/bin
```

> **Atenção:** as variáveis `NETCDF` e `ESMFMKFILE` também precisam estar declaradas:
> - `NETCDF` → diretório principal da instalação do NetCDF (já configurado no `setenv`)
> - `ESMFMKFILE` → caminho completo para o arquivo `esmf.mk` da sua instalação do ESMF

**3. Compile:**

```bash
./compile.sh
```

O executável `mpassit` será gerado na pasta `bin`.

---

## Execução

### Arquivos necessários

Crie um diretório de rodada (`run`) contendo os seguintes arquivos (veja exemplos em `parm`):

| Arquivo | Descrição |
|---|---|
| `varlist_2d` | Namelist com as variáveis 2D a serem pós-processadas |
| `varlist_3d` | Namelist com as variáveis 3D a serem pós-processadas |
| `namelist.input` | Namelist do MPASSIT, com opções já ajustadas para o MONAN |
| `mpassit_submit.bash` | Script de submissão do job |
| `mpassit` | Executável gerado na compilação (disponível em `bin`) |
| `setenv_jaci_gnu_compile_ESMFjaci.bash` | Script que ajusta o ambiente para execução do MPASSIT |

### Exemplo: `varlist_2d`

```
surface_pressure surface_pressure
mslp mslp
precipw precipw
rainnc rainnc
rainc rainc
cape cape
cin cin
acswdnb acswdnb
aclwupb aclwupb
aclwupt aclwupt
u10 u10
v10 v10
q2 q2
t2m t2m
hfx hfx
lh lh
cldfrac_tot_UPP cldfrac_tot_UPP
ter ter
landmask landmask
```

### Exemplo: `varlist_3d`

```
zgeo_isobaric zgeo
temperature_isobaric temperature
spechum_isobaric spechum
relhum_isobaric relhum
uzonal_isobaric uzonal
umeridional_isobaric umeridional
w_isobaric w
omega_isobaric omega
```

### Exemplo: `namelist.input`

```fortran
&config
 grid_file_input_grid = "/my_dir_to_init_file/x1.5898242.init.nc"
 diag_file_input_grid = "/my_dir_to_model_output_file/MONAN_DIAG_G_MOD_GFS_2026012000_2026012000.00.00.x5898242L55.nc"
 hist_file_input_grid = ""
 output_file          = "./monan-mpassit-output.nc"
 block_decomp_file    = "/my_dir_to_graph_info_partition_file/x1.5898242.graph.info.part.128"
 interp_diag          = .true.
 interp_hist          = .false.
 wrf_mod_vars         = .false.
 output_grads         = .true.
 esmf_log             = .true.
 target_grid_type     = 'lat-lon'
 is_regional          = .false.
 nx                   = 3601
 ny                   = 1801
 stand_lon            = 0.0
/
```

---

## Créditos

- Código original: [Larissa Reames — MPASSIT](https://github.com/LarissaReames/MPASSIT)
- Adaptação para MONAN e ambiente Jaci@INPE: Carlos Renato Souza

## Licença

Consulte a licença do repositório original ([LarissaReames/MPASSIT](https://github.com/LarissaReames/MPASSIT)), mantida para este fork.

# memtester

## Função
Testador de memória RAM em espaço de usuário para Linux, sem precisar reiniciar a máquina.

Usado para:
- detectar erro de RAM com o sistema ligado;
- achar falhas intermitentes do subsistema de memória;
- teste rápido antes de partir para um teste de boot.

---

## Suporta
- qualquer distro Linux (pacote `memtester` nos repositórios de Debian/Ubuntu, Fedora e Arch);
- ISO Linux autoral e Linux instalado do toolkit.

---

## Usar quando
- Precisar testar RAM sem reiniciar;
- Estiver no ambiente de resgate Linux e o MemTest86/Memtest86+ não for opção;
- Par funcional do HCI MemTest do lado Linux.

---

## Uso básico
```
sudo memtester 2G 3
```
Testa 2 GB de RAM, 3 passes. Precisa de root para travar as páginas na memória.

---

## Cuidado
- Não testa toda a RAM: o kernel e os programas em execução ocupam uma parte.
- Pedir memória demais faz o sistema recorrer a swap ou ao OOM killer — deixar margem.
- Resultado limpo aqui não substitui um teste de boot (MemTest86/Memtest86+).

---

## Observações pessoais
Cobre a lacuna de teste de RAM nativo no Linux. No resgate, junto com o Prime95 (Blend), é o que sobra quando o HCI MemTest e o TestMem5 (só Windows, 32 bits) não rodam.

---

## Site oficial
https://pyropus.ca/software/memtester/

## Lembrete
Consultar documentação oficial sobre:
- escolha do tamanho a testar conforme a RAM livre;
- significado de cada teste da saída.

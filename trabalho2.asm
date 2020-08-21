#####################################################################Disciplina: Arquitetura e Organização de Processadores
#Atividade: Avaliação 01 – Programação em Linguagem de Montagem
#Exercício 03
#Aluna: Ana Clara Prüsse e Sabrina dos Passos Tortelli
#Código em Assembly
####################################################################
# SEGMENTO DE DADOS                                                            
####################################################################

   .data                            # Informa o início do segmento de 
                                    # dados, onde declaramos todas as 
                                    # variáveis envolvidas.

vetor_A: .word 0,0,0,0,0,0,0,0      #declaração do vetor

vetor_B: .word 0,0,0,0,0,0,0,0      #declaração do vetor

vetor_C: .word 0,0,0,0,0,0,0,0      #declaração do vetor

msg_1:.asciiz "\nEntre com o tamanho do vetor (max 8):" # mensagem do
                                                   # tamanho do vetor                                                
               
msg_vetorA:.asciiz "Vetor_A ["    # mensagem para entrada dos
                                    # elementos do vetor A 

msg_fechVetor:.asciiz "]: "         # mensagem para entrada dos
                                    # elementos dos vetores 

msg_vetorB:.asciiz "Vetor_B ["      # mensagem para entrada dos 
                                    # elementos do vetor B 

msg_vetorC:.asciiz "\nVetor_C ["    # mensagem para saída dos
                                    # elementos do vetor C 

msg_invalido:.asciiz "\nValor Invalido" # mensagem de valor invalido

msg_soma:.asciiz "\nResultado da soma dos vetores:" # mensagem do
                                                    # resultado 

                                       ####################################################################
# SEGMENTO DE CÓDIGO                                                           
####################################################################

    .text                  # Informa o início do segmento de código, 
                           # onde fica o programa.

main:                      # O início do programa

       la $s1, vetor_A        # carrega o vetor para $s1
       la $s2, vetor_B        # carrega o vetor para $s2
       la $s3, vetor_C        # carrega o vetor para $s3
	 addi $s0, $zero, 0     # tamanho dos vetores = 0

TamanhoVetor:

       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_1          # carrega ptr para string msg_1         
       syscall                # chama o serviço

       li $v0, 5              # carrega o serviço 5 (lê inteiro)
       syscall                # chama o serviço
       ble $v0, 0, MsgInvalido# Se $v0 < 1, então chama MsgInvalido
       bgt $v0, 8, MsgInvalido# Se $v0 > 8, então chama MsgInvalido

       j SalvaTamVetor        # Se passar pelos testes então vai para
                              # SalvaVetor

MsgInvalido:  
      
       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_invalido   # carrega ptr para string msg_invalido         
       syscall                # chama o serviço

       j TamanhoVetor      # volta para TamanhoVetor

SalvaTamVetor:

       add $s0, $v0, $0       # carrega o inteiro lido para $s0 
                              #(tamanho máximo do vetor) 
       
       addi $s4, $zero, 0     # declaração do i=0
  
Loop:
       slt $t0, $s4, $s0      # se i($s4)<$s0 então $t0=1 senão $t0=0
       beq  $t0, $zero, Exit  # se $t0=0 então goto Exit

       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_vetorA     # carrega ptr para string msg_vetorA         
       syscall                # chama o serviço

	 addi $v0, $0, 1        # carrega o serviço 1 (print inteiro)
       add $a0, $0, $s4       # carrega int($s4) em $a0         
       syscall                # chama o serviço
       
       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_fechVetor  # carrega ptr para string msg_fechVetor         
       syscall                # chama o serviço
       
       add $t1, $s4, $s4      # $t1 = 2*1
       add $t1, $t1, $t1      # $t1 = 4*1
       add $t1, $t1, $s1      # $t1 = end. Base + 4*i = end. absoluto
       lw $t2, 0($t1)         # $t2 = vetor_A[0]
       
       li $v0, 5              # carrega o serviço 5 (lê inteiro)
       syscall                # chama o serviço

       sw $v0, 0($t1)         # vetor_A[i] = $v0 (inteiro lido)

       addi $s4, $s4, 1       # i++ (do laço for)
       j    Loop              # goto Loop
Exit:  nop

       addi $t0, $zero, 0     # declaração da variável $t0=0
       addi $s4, $zero, 0     # i = 0


LoopB:
       slt $t0, $s4, $s0      # se i($s4)<$s0 então $t0=1 senão $t0=0
       beq  $t0, $zero, ExitB # se $t0=0 então goto ExitB

       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_vetorB     # carrega ptr para string msg_vetorB         
       syscall                # chama o serviço

	 addi $v0, $0, 1        # carrega o serviço 1 (print inteiro)
       add $a0, $0, $s4       # carrega int em $a0         
       syscall                # chama o serviço
       
       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_fechVetor  # carrega ptr para string msg_fechVetor         
       syscall                # chama o serviço
       
       add $t1, $s4, $s4      # $t1 = 2*1
       add $t1, $t1, $t1      # $t1 = 4*1
       add $t1, $t1, $s2      # $t1 = end. Base + 4*i = end. absoluto
       lw $t2, 0($t1)         # $t2 = vetor_B[0]
       
       li $v0, 5              # carrega o serviço 5 (lê inteiro)
       syscall                # chama o serviço

       sw $v0, 0($t1)         # vetor_B[i] = $v0

       addi $s4, $s4, 1       # i++ (do laço for)
       j    LoopB             # goto Loop
ExitB: nop

       addi $t0, $zero, 0     # declaração da variável $t0=0
       addi $s4, $zero, 0     # i = 0

LoopSoma:

       slt $t0, $s4, $s0      # se i($s4)<$s0 então $t0=1 senão $t0=0
       beq  $t0, $zero, ExitSoma # se $t0=0 então goto ExitSoma
       
       add $t1, $s4, $s4      # $t1 = 2*1
       add $t1, $t1, $t1      # $t1 = 4*1
       add $t2, $t1, $s1      # $t2 = end. Base + 4*i = end. Absoluto
       add $t3, $t1, $s2      # $t3 = end. Base + 4*i = end. Absoluto
       add $t4, $t1, $s3      # $t4 = end. Base + 4*i = end. Absoluto
       lw $t5, 0($t2)         # $t5 = vetor_A[0]
       lw $t6, 0($t3)         # $t6 = vetor_B[0]
      

       add $s5, $t5, $t6      # $s5 = vetor_A[i] + vetor_B[i]

       sw $s5, 0($t4)         # vetor_C[i] = $s5

       addi $s4, $s4, 1       # i++ (do laço for)
       j    LoopSoma          # goto Loop
ExitSoma:  nop

       addi $t0, $zero, 0     # declaração da variável $t0=0
       addi $s4, $zero, 0     # i = 0
       
       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_soma       # carrega ptr para string msg_soma         
       syscall                # chama o serviço

LoopC: slt $t0, $s4, $s0      # se i($s4)<$s0 então $t0=1 senão $t0=0
       beq  $t0, $zero, ExitC # se $t0=0 então goto ExitC

       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_vetorC     # carrega ptr para string msg_vetorC         
       syscall                # chama o serviço
       
       addi $v0, $0, 1        # carrega o serviço 1 (print inteiro)
       add $a0, $0, $s4       # carrega int em $a0         
       syscall                # chama o serviço
       
       li $v0, 4              # carrega o serviço 4 (print string)
       la $a0, msg_fechVetor  # carrega ptr para string msg_fechVetor         
       syscall                # chama o serviço
       
       add $t1, $s4, $s4      # $t1 = 2*1
       add $t1, $t1, $t1      # $t1 = 4*1
       add $t1, $t1, $s3      # $t1 = end. Base + 4*i = end. absoluto
       lw $t2, 0($t1)         # $t2 = vetor_C[0]
       
       addi $v0, $0, 1        # carrega o serviço 1 (print int)
       add $a0, $0, $t2       # carrega int para $a0         
       syscall                # chama o serviço

       addi $s4, $s4, 1       # i++ (do laço for)
       j    LoopC             # goto Loop
ExitC: nop

####################################################################


import random
import csv

cpf_list = list()
rm_list = list()
cprof_list = list()
atv_list = list()

def geraCPF():
    global cpf_list
    c = random.randint(10000000000,99999999999)
    while (c in cpf_list):
        c = random.randint(10000000000,99999999999)
    cpf_list.append(c)
    return str(c)    

def geraRM():
    global rm_list
    rm = random.randint(100000,999999)
    while (rm in rm_list):
        rm = random.randint(100000,999999)
    rm_list.append(rm)
    return str(rm)

def geraCodProf():
    global cprof_list
    cod = random.randint(1000,9999)
    while (cod in cprof_list):
        cod = random.randint(1000,9999)
    cprof_list.append(cod)
    return str(cod)

def geraTelefone():    
    c = str(random.randint(10000000000,99999999999))
    return ('(' + c[:2] + ')' + c[2:7] + '-' + c[7:])

def geraEmail(nome, parente):
    s = random.randint(0,2)
    if (s == 0):
        return (nome + '_' + parente + '@email.com.br')
    elif (s == 1):
        return (parente + '.' + nome + '.' + str(random.randint(10,99)) + '@gmail.com')
    return ('contato' + parente + nome + '@hotmail.com')
    
def geraAno():
    s = random.randint(0,2)
    if (s == 0):
        return (str(random.randint(1,9)) + 'º A')
    elif (s == 1):
        return (str(random.randint(1,9)) + 'º B')
    return (str(random.randint(1,9)) + 'º C')

def geraCodAtv():
    global atv_list
    cod = random.randint(10,99)
    while (cod in atv_list):
        cod = random.randint(10,99)
    return str(cod)

def geraNomeAtv(cod):    
    n1 = ['Futebol', 'Xadrez', 'Meditação', 'Basquete', 'Pintura', 'Robótica', 'Judô', 'Programação', 'Dança']
    n2 = ['', '', '', '', 'Básico', 'Avançado', 'Noturno', 'Integral', 'com Música', 'Especial']
    return n1[int(cod[0])-1] + ' ' + n2[int(cod[1])]

def geraProfsAtv():
    global cprof_list    
    p1 = random.randint(0, len(cprof_list))
    n = random.randint(0,6)    
    if (n >= 4):
        p2 = random.randint(0, len(cprof_list))
        if (n == 5):
            p3 = random.randint(0, len(cprof_list))
            return str(cprof_list[p1]) + ', ' + str(cprof_list[p2]) + ', ' + str(cprof_list[p3])
        return str(cprof_list[p1]) + ', ' + str(cprof_list[p2])
    return str(cprof_list[p1])

def geraAlunosAtv():
    global rm_list
    alunos = list()
    n = random.randint(15,31)
    saida = ''
    for i in range(0,n):
        rm = random.randint(0, len(rm_list))
        while (rm in rm_list):
            rm = random.randint(0, len(rm_list))
        alunos.append(rm)
        saida += str(rm) + ', '
    return saida[:-2]

with open('alunos.csv', 'w') as f:
    with open('professores.csv', 'w') as p:
        with open('nicknames.csv', 'r') as n:
            nr = csv.DictReader(n)
            cw = csv.DictWriter(f, ['RM', 'Aluno', 'Turma', 'E-mail aluno',
                                    'CPF pai', 'E-mail pai', 'Tel pai',
                                    'CPF mae', 'E-mail mae', 'Tel mae'])     
            pw = csv.DictWriter(p, ['Codigo', 'Professor', 'E-mail'])
            pw.writeheader()   
            cw.writeheader()
            l = list()
            for row in nr:
                l.append(row['name'][1:] + row['nickname'])
                
            random.shuffle(l)
            for i in range(0,1000):        
                rm = geraRM()
                cw.writerow({'RM': rm, 'Aluno': l[i], 'Turma': geraAno(), 'E-mail aluno': geraEmail(str(rm), 'aluno'),
                             'CPF pai': geraCPF(), 'E-mail pai': geraEmail(str(rm),'pai'), 'Tel pai': geraTelefone(),
                             'CPF mae': geraCPF(), 'E-mail mae': geraEmail(str(rm),'mae'), 'Tel mae': geraTelefone()})        

            for i in range(0,124):
                pw.writerow({'Codigo': geraCodProf(), 'Professor': l[i], 'E-mail': l[i].split()[0].lower() + str(random.randint(0,10)) + '@escola.br'})

with open('atividades.csv', 'w') as a:
    aw = csv.DictWriter(a, ['Codigo', 'Atividade', 'Cod professores', 'Cod alunos'])
    aw.writeheader()
    for i in range(0,25):
        codAtv = geraCodAtv()
        aw.writerow({'Codigo': codAtv, 'Atividade': geraNomeAtv(codAtv), 'Cod professores': geraProfsAtv(), 'Cod alunos': geraAlunosAtv()})
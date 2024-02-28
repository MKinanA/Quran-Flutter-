from requests import get
from json import loads

result = ''

surat_counter = 0
origin = {'mekah': 'Makkiyyah', 'madinah': 'Madaniyyah'}
for x in loads(get('https://equran.id/api/surat').content):
    print(x['nama_latin'])
    surat_counter += 1

    namaLt_raw = x['nama_latin']
    namaLt = ''
    for c in namaLt_raw:
        if c == '\'':
            namaLt += '\\'
        namaLt += c
    
    namaTr_raw = x['arti']
    namaTr = ''
    for c in namaTr_raw:
        if c == '\'':
            namaTr += '\\'
        namaTr += c
    
    result += f'''  Surat(
    number: {x['nomor']},
    name: '{x['nama']}',
    nameLt: '{namaLt}',
    nameTr: '{namaTr}',
    origin: '{origin[x['tempat_turun']]}',
    ayatCount: {x['jumlah_ayat']},
    ayat: [
'''
    for x in loads(get(f'https://equran.id/api/surat/{x['nomor']}').content)['ayat']:
        
        kontenLt_raw = x['tr']
        kontenLt = ''
        for c in kontenLt_raw:
            if c == '\'':
                kontenLt += '\\'
            kontenLt += c
        
        kontenTr_raw = x['idn']
        kontenTr = ''
        for c in kontenTr_raw:
            if c == '\'':
                kontenTr += '\\'
            kontenTr += c
            
        result += f'''      Ayat(
        number: {x['nomor']},
        content: '{x['ar']}',
        contentLt: '{kontenLt}',
        contentTr: '{kontenTr}'
      ),
'''
    result += '    ]\n  ),\n'

with open('result.txt', 'wt', encoding='utf-8') as file:
    file.write(result)
print(result)
print(f'retrieved {surat_counter} surat{'s' if surat_counter > 1 else ''}')
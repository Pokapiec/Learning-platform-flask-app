from datetime import datetime
from flask import Flask, render_template, url_for, redirect, request, session, flash
from flask_mysqldb import MySQL
app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'mydb'
app.secret_key = 'sekretny_klucz'

mysql = MySQL(app)


@app.route('/wyszukiwanie', methods=["POST"])
def wyszukaj():
    to_search = request.form['SearchBar']
    cur = mysql.connection.cursor()
    query_search_like = """ SELECT idKursu, k.Nazwa, Opis, Cena, RokWydania, Przedmiot_idPrzedmiotu,Tytul,d.Nazwa AS dzial FROM kurs AS k
                            RIGHT JOIN dzial AS d ON d.Kurs_idKursu = k.idKursu
                            RIGHT JOIN lekcja AS l ON l.Dzial_idDzialu = d.idDzialu
                            WHERE d.Nazwa LIKE '%{a}%' OR Tytul LIKE '%{a}%' OR k.Nazwa LIKE '%{a}%' 
                            GROUP BY idKursu""". \
        format(a=to_search)

    cur.execute(query_search_like)
    search_result = cur.fetchall()

    session['wyszukane'] = search_result

    return redirect(url_for('.index'))


@app.route('/')
def index():
    error = False
    if 'wyszukane' in session:
        fetchdata = session['wyszukane']
        session.pop('wyszukane', None)
        if len(fetchdata) != 0:
            print(fetchdata)
            return render_template('index.html', data=fetchdata, courses_nr=len(fetchdata))
        else:
            error = "Nie znaleziono zadnego dopasowania !"
        # return render_template('index.html', data=data, courses_nr=courses_nr)

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM kurs")
    fetchdata = cur.fetchall()
    courses_nr = len(fetchdata)
    cur.close()
    return render_template('index.html', data=fetchdata, courses_nr=courses_nr, error = error)


# @app.route('/logowanie',methods=["POST"])
# def login():
#     if request.method == 'POST':
#         mail_input = request.form['mail']
#         password_input = request.form['haslo']

#         cur = mysql.connection.cursor()
#         cur.execute("SELECT Haslo, Email FROM uzytkownikzarejestrowany WHERE Email == {mail_input}".format(mail_input))
#         print(cur.fetchall())
#         # cur.execute("SELECT haslo FROM uzytkownikzarejestrowany WHERE Email == {username}".format(username))
#         # emaile = cur.fetchall()

#         cur.close()

#     return render_template("logowanie.html")
# return Response(response = json.dumps({"message": "Dziala"}), status=200, mimetype="application/json")


@app.route('/logowanie', methods=["GET", "POST"])
def load1():
    error = None
    if request.method == 'POST':
        mail_input = request.form['mail']
        password_input = request.form['haslo']

        cur = mysql.connection.cursor()
        cur.execute(f"SELECT Haslo, Email FROM uzytkownikzarejestrowany WHERE Email = '{mail_input}'")
        data = cur.fetchall()

        if len(data) == 1 and password_input == data[0][0]:
            cur.execute(f"SELECT idZUzytkownika FROM uzytkownikzarejestrowany WHERE Email = '{mail_input}'")
            id_uzytkownika = cur.fetchall()[0][0]
            # print(id_uzytkownika) 
            session['uzytkownik'] = id_uzytkownika
            print(id_uzytkownika)
            cur.close()
            flash('Pomyślnie zalogowano')
            return redirect(url_for('index'))

        else:
            cur.close()
            error = 'Niepoprawne dane'

    return render_template('logowanie.html', error=error)


@app.route('/edycja_konta')
def edycja_konta():
    return render_template('edycja_konta.html')


@app.route('/lista_podopiecznych')
def lista_podopiecznych():
    return render_template('lista_podopiecznych.html')


@app.route('/lista_uczniow')
def lista_uczniow():
    return render_template('lista_uczniow.html')


@app.route('/ocen_test')
def ocen_test():
    return render_template('ocen_test.html')


@app.route('/przeglad_kursu/<int:id_kursu>', methods=["GET", "POST"])
def przeglad_kursu(id_kursu):
    id_kursu += 1
    error = False
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM kurs")
    course = cur.fetchall()[id_kursu - 1]

    cur.execute(f"SELECT * FROM dzial WHERE Kurs_idKursu = {id_kursu}")
    dzialy = cur.fetchall()

    cur.execute(f"SELECT * FROM opinia WHERE Kurs_idKursu = {id_kursu}")
    opinie = cur.fetchall()

    il_opinii = len(opinie)
    il_dzialow = len(dzialy)

    if 'error' in session:
        error = session['error']
        session.pop('error', None)

    cur.close()
    return render_template('przeglad_kursu.html', kurs=course, opinie=opinie, dzialy=dzialy, il_opinii=il_opinii,
                           il_dzialow=il_dzialow,error = error)


@app.route('/dodaj_opinie/<int:id_kursu>', methods=["POST"])
def dodaj_opinie(id_kursu):
    if 'uzytkownik' in session:
        id_uzytkownika = session['uzytkownik']

        cur = mysql.connection.cursor()

        cur.execute(f"SELECT Uczen_idUzytkownika FROM uczen_has_kurs WHERE Kurs_idKursu = {id_kursu}")
        moga_wystawic_opinie = cur.fetchall()
        moga_wystawic_opinie = [element for tupl in moga_wystawic_opinie for element in tupl]

        if id_uzytkownika in moga_wystawic_opinie:
            ocena = request.form['rate']
            opinia_do_dodania = request.form['opinie']
            opinia_do_dodania = str(opinia_do_dodania)

            now = datetime.now()
            now = now.strftime('%Y-%m-%d')

            mysql.connection.autocommit(cur)

            if "kurde" not in opinia_do_dodania.lower():
                opinia_format = (opinia_do_dodania, now, int(ocena[0]), int(id_kursu), int(id_uzytkownika))
                query_insert_new_opinion = """INSERT INTO opinia (Tresc, Data, Ocena, Kurs_idKursu ,Uczen_idUzytkownika)
                                             VALUES ('%s','%s',%d,%d,%d)"""
                cur.execute(query_insert_new_opinion % opinia_format)
            else:
                session['error'] = "Niepoprawna tresc opinii"
            cur.close()

            return redirect(url_for('.przeglad_kursu', id_kursu=id_kursu-1))
        flash('Nie jesteś uczestnikiem tego kursu.')
        return redirect(url_for('.index'))
    flash('Musisz się zalogować, żeby dodać opinię.')
    return redirect(url_for('.index'))


@app.route('/przeglad_kursu/<int:id_kursu>/<int:id_dzialu>', methods=["GET"])
def przeglad_dzialu(id_dzialu, id_kursu):
    cur = mysql.connection.cursor()
    cur.execute(f"SELECT * FROM kurs WHERE idKursu = {id_kursu}")
    kurs = cur.fetchall()[0]

    cur.execute(f"SELECT * FROM dzial WHERE idDzialu = {id_dzialu}")
    dzial = cur.fetchall()[0]

    cur.execute(f"SELECT * FROM lekcja WHERE Dzial_idDzialu = {id_dzialu}")
    lekcje = cur.fetchall()

    il_lekcji = len(lekcje)

    cur.close()
    return render_template('przeglad_dzialu.html', dzial=dzial, lekcje=lekcje, il_lekcji=il_lekcji, kurs=kurs)


@app.route('/przeglad_kursu/<int:id_kursu>/<int:id_dzialu>/<int:id_lekcji>', methods=["GET"])
def przeglad_lekcji(id_dzialu, id_kursu, id_lekcji):
    if 'uzytkownik' in session:
        id_uzytkownika = session['uzytkownik']
        cur = mysql.connection.cursor()

        cur.execute(f"SELECT Uczen_idUzytkownika FROM uczen_has_kurs WHERE Kurs_idKursu = {id_kursu}")
        uczniowie = cur.fetchall()
        uczniowie = [element for tupl in uczniowie for element in tupl]

        cur.execute(f"SELECT idZUzytkownik FROM korepetytor")
        korepetytorzy = cur.fetchall()
        korepetytorzy = [element for tupl in korepetytorzy for element in tupl]

        if (id_uzytkownika in uczniowie) or (id_uzytkownika in korepetytorzy):
            cur.execute(f"SELECT * FROM kurs WHERE idKursu = {id_kursu}")
            kurs = cur.fetchall()[0]

            cur.execute(f"SELECT * FROM dzial WHERE idDzialu = {id_dzialu}")
            dzial = cur.fetchall()[0]

            cur.execute(f"SELECT * FROM lekcja WHERE idLekcja = {id_lekcji}")
            lekcja = cur.fetchall()[0]

            cur.execute(f"SELECT * FROM tresclekcji WHERE Lekcja_idLekcja = {id_lekcji}")
            tresc_lekcji = cur.fetchall()[0]

            cur.execute(f"SELECT * FROM filminstruktarzowy WHERE Lekcja_idLekcja = {id_lekcji}")
            filmy = cur.fetchall()[0]

            cur.execute(f"SELECT * FROM test WHERE Lekcja_idLekcja = {id_lekcji}")
            testy = cur.fetchall()

            liczba_testow = len(testy)

            cur.close()
            return render_template('przeglad_lekcji.html', dzial=dzial, lekcja=lekcja, kurs=kurs, tresc_lekcji=tresc_lekcji,
                                   filmy=filmy, testy=testy, liczba_testow=liczba_testow)
        flash('Nie posiadasz dostępu do tych treści.')
        return redirect(url_for('.index'))
    flash('Nie jesteś zalogowany/a.')
    return redirect(url_for('.index'))


@app.route('/przeglad_kursu/<int:id_kursu>/<int:id_dzialu>/<int:id_lekcji>/<int:id_testu>', methods=["GET"])
def przeglad_testu(id_dzialu, id_kursu, id_lekcji, id_testu):
    if 'uzytkownik' in session:
        id_uzytkownika = session['uzytkownik']
        cur = mysql.connection.cursor()

        cur.execute(f"SELECT Uczen_idUzytkownika FROM uczen_has_kurs WHERE Kurs_idKursu = {id_kursu}")
        uczniowie = cur.fetchall()
        uczniowie = [element for tupl in uczniowie for element in tupl]

        if id_uzytkownika in uczniowie:
            cur = mysql.connection.cursor()
            cur.execute(f"SELECT * FROM kurs WHERE idKursu = {id_kursu}")
            kurs = cur.fetchall()

            cur.execute(f"SELECT * FROM dzial WHERE idDzialu = {id_dzialu}")
            dzial = cur.fetchall()[0]

            cur.execute(f"SELECT * FROM lekcja WHERE idLekcja = {id_lekcji}")
            lekcja = cur.fetchall()[0]

            cur.execute(f"""SELECT idZadania, Podpowiedz, Tresc, OdpowiedzPoprawna, Komentarz FROM test_zawiera_zadanie AS tzz
                        LEFT JOIN zadanie as z ON z.idZadania = tzz.zadanie_idZadania
                        WHERE Test_idTestu = {id_testu}""")
            zadania = cur.fetchall()

            zadania_dict = {}
            numer_zadania = 1
            for zadanie in zadania:
                nowe_zadanie = {
                    "idZadania": zadanie[0],
                    "Podpowiedz": zadanie[1],
                    "Tresc": zadanie[2],
                    "OdpowiedzPoprawna": zadanie[3],
                    "Komentarz": zadanie[4]
                }

                cur.execute(f"""SELECT * FROM mozliweodpowiedzi
                                        WHERE Zadanie_idZadania = {zadanie[0]}""")
                odpowiedzi = cur.fetchall()
                numer_odpowiedzi = 1
                mozliwe_odpowiedzi = {}

                for odpowiedz in odpowiedzi:
                    mozliwe_odpowiedzi[f"{odpowiedz[0]}"] = odpowiedz[1]
                    numer_odpowiedzi += 1

                zadania_dict[f"{numer_zadania}"] = nowe_zadanie
                zadania_dict[f"{numer_zadania}"]["mozliwe_odpowiedzi"] = mozliwe_odpowiedzi
                numer_zadania += 1

            cur.close()
            return render_template('test.html', dzial=dzial, lekcja=lekcja, kurs=kurs, id_testu=id_testu,
                                   zadania_dict=zadania_dict, liczba_zadan=numer_zadania - 1)
        flash('Nie posiadasz dostępu do tego testu.')
        return redirect(url_for('.index'))
    flash('Nie jesteś zalogowany/a.')
    return redirect(url_for('.index'))

@app.route('/przypisz_podopiecznego')
def przypisz_podopiecznego():
    return render_template('przypisz_podopiecznego.html')


@app.route('/wyslij_test', methods=["POST"])
def save_test():
    cur = mysql.connection.cursor()
    id_uzytkownika = session['uzytkownik']
    mysql.connection.autocommit(cur)

    for zadanie in request.form:
        cur.execute(f"SELECT OdpowiedzPoprawna FROM zadanie WHERE idZadania = {zadanie}")
        poprawna = cur.fetchall()[0][0]
        print(f"Poprawna: {poprawna}. Ucznia: {request.form[zadanie]}")

        if int(poprawna) == int(request.form[zadanie]):
            ocena = 1
        else:
            ocena = 0

        odp = (int(request.form[zadanie]), int(zadanie), int(id_uzytkownika), ocena)


        sql = ("""INSERT INTO odpowiedz (OdpowiedzUcznia, Zadanie_idZadania, Uczen_idUcznia, Ocena)
                                             VALUES ('%s', %d, %d, %d)""")
        cur.execute(sql % odp)
    cur.close()
    return redirect(url_for('.index'))


@app.route('/rejestracja')
def rejestracja():
    return render_template('rejestracja.html')


@app.route('/test')
def test():
    return render_template('test.html')

@app.route('/lista_pt')
def zobacz_testy_podopiecznych():
    id_uzytkownika = session['uzytkownik']
    cur = mysql.connection.cursor()
    zapytanie_o_testy_ucznia = """SELECT DISTINCT Uczen_idUcznia AS idUcznia, Test_idTestu AS idTestu
                                FROM test_zawiera_zadanie AS tzz
                                LEFT JOIN zadanie AS z ON tzz.Zadanie_idZadania = z.idZadania
                                RIGHT JOIN odpowiedz AS odp ON odp.Zadanie_idZadania = z.idZadania
                                WHERE Uczen_idUcznia = {a}""".format(a=id_uzytkownika)
    cur.execute(zapytanie_o_testy_ucznia)
    testy_uczen = cur.fetchall()
    print(testy_uczen)

    cur.execute("SELECT * FROM opiekun_nadzoruje_uczen")
    opiekunowie = cur.fetchall()
    print(opiekunowie)

    return render_template('lista_podopiecznych.html',id_uzytk = id_uzytkownika ,testy = testy_uczen, opiekunowie = opiekunowie)

@app.route('/zobacz_wynik/<int:id_testu>')
def zobacz_wynik(id_testu):
    print(id_testu)
    id_uzytkownika = session['uzytkownik']
    cur = mysql.connection.cursor()
    zapytanie_testy = """SELECT idUcznia, idTestu 
                        ,idZadania,testy.Tresc, Komentarz, Ocena, NajlepszaOcena, OdpowiedzUcznia, mo.Tresc 
                        FROM 
                        (SELECT DISTINCT Uczen_idUcznia AS idUcznia, Test_idTestu AS idTestu 
                        ,idZadania,Tresc, Komentarz, Ocena, IF(max(Ocena) = 1, 1 , 0) AS NajlepszaOcena, OdpowiedzUcznia
                        FROM test_zawiera_zadanie AS tzz
                        LEFT JOIN zadanie AS z ON tzz.Zadanie_idZadania = z.idZadania
                        LEFT JOIN odpowiedz AS odp ON odp.Zadanie_idZadania = z.idZadania
                        GROUP BY idZadania, Uczen_idUcznia
                        HAVING Uczen_idUcznia = {a} AND Test_idTestu = {b}) AS testy
                        LEFT JOIN mozliweodpowiedzi AS mo ON mo.idMozliwejOdpowiedzi = testy.OdpowiedzUcznia""".format(a = id_uzytkownika, b = id_testu)

    cur.execute(zapytanie_testy)
    testy_all = cur.fetchall()

    count_good=0
    count = 0
    for t in testy_all:
        if t[5] == 1:
            count_good+=1
        # if t[5]:
        count +=1

    wynik = "{c}/{a}".format(c=count_good,a=count)
    
    return render_template('zobacz_wynik.html',wyniki = testy_all,id_uzytk = id_uzytkownika,id_testu = id_testu,wynik = wynik, enumerate=enumerate)

@app.route('/wyloguj')
def wyloguj():
    session.pop('uzytkownik',None)
    return redirect(url_for(".index"))


if __name__ == '__main__':
    app.run(debug=True)

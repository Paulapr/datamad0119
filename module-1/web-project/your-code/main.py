
import requests
import json
import pandas as pd
from bs4 import BeautifulSoup

# WEB SCRAPING

def web_scraping(url):

    def table_scrap (url):
        html = requests.get(url).content
        soup = BeautifulSoup(html, 'html.parser')
        table = soup.find_all('table',{'class':'wikitable'})[0]
        rows = table.find_all('tr')
        rows = [row.text.strip().split("\n") for row in rows]
        rows.pop(0)
        for row in rows:
            row.pop(0) and row.pop(0)
        return rows

    def create_table(rows):
        colnames = ['artist','country_proc']
        data = rows
        music_artist = pd.DataFrame(data, columns=colnames)
        country= list(music_artist['country_proc'])
        country = [x.replace('Reino Unido\xa0Reino Unido','Reino Unido')
            .replace('Estados Unidos\xa0Estados Unidos','Estados Unidos')
            .replace('Jamaica\xa0Jamaica','Jamaica').replace('Irlanda\xa0Irlanda','Irlanda')
            .replace('Canadá\xa0Canadá','Canadá').replace('Australia\xa0Australia','Australia')
            .replace('México México','México')for x in country]
        music_artist['country_proc']=country
        music_artist = music_artist[music_artist.artist!='Phil Spector'] #Elimino este artista.problema api
        
    return music_artist

# API INFO

def lista_IDs(artist_list):
    
    def all_id(artistName): #Extrae un json de cada artista
        url = 'https://api.songkick.com/api/3.0/search/artists.json?apikey=2KYDpKnYhVp98ZmM&query={}'.format(artistName)
        get_ids = requests.get(url)
        artist_ids = pd.DataFrame(get_ids.json())
        artist_ids = artist_ids.transpose()

        def flatten(artist_ids, col_list): #Extrae del json exclusivamente el ID
            for column in col_list:
                flattened = pd.DataFrame(dict(artist_ids[column])).transpose()
                columns = [str(col) for col in flattened.columns]
                flattened.columns = [column + '_' + colname for colname in columns]
                artist_ids = pd.concat([artist_ids, flattened], axis=1)
                artist_ids = artist_ids.drop(column, axis=1)
            return artist_ids

        nested_columns = ['results']
        nested_columns1 = ['results_artist']
        nested_columns2 = ['results_artist_0']
        artist_ids1 = flatten(artist_ids, nested_columns)
        artist_ids2 = flatten(artist_ids1, nested_columns1)
        artist_ids3 = flatten(artist_ids2, nested_columns2)
        artistIDs = int(artist_ids3['results_artist_0_id'])

        return artistIDs

    list_IDs=[]
    for artistName in artist_list:   #Añade todos los ID a una lista
        list_IDs.append(all_id(artistName))
    return list_IDs

def artist_df (artistID): # crea un df con los conciertos de cada artista
    
    def num_pag(artistID):
        url = 'https://api.songkick.com/api/3.0/artists/{}/gigography.json?apikey=2KYDpKnYhVp98ZmM'.format(artistID)
        get_events_page = requests.get(url)
        all_concerts= get_events_page.json()
        total_concerts =int(all_concerts['resultsPage']['totalEntries'])
        n_pages= int((total_concerts / 50) + (total_concerts % 5 > 0))
        return n_pages
 
    def events_all(artistID,n_pages):
        all_concerts = []
        todos_los_conciertos = []
        for p in range(1, n_pages + 1):
            url = 'https://api.songkick.com/api/3.0/artists/{}/gigography.json?apikey=2KYDpKnYhVp98ZmM&page='.format(artistID)
            page_url= url + str(p)
            get_events_page = requests.get(page_url)
            all_concerts_page= get_events_page.json()
            events = all_concerts_page['resultsPage']['results']['event']
            events_per_page = []
            for event in events:
                each_event = event['type'],event['displayName'],event['location']['city'],event['start']['date']
                events_per_page.append(each_event)
            all_concerts.append(events_per_page)
        for lista in all_concerts:
            for tupla in lista:
                todos_los_conciertos.append(tupla)
        return todos_los_conciertos
    
    conciertos_artista = pd.DataFrame(events_all(artistID,num_pag(artistID)), columns=['type_event','name_event','city_event','date_event'])
    conciertos_artista['artist_id'] = artistID
    return conciertos_artista

def lista_definitiva(lista_ids):
    lista_conciertos=pd.DataFrame()
    for artist in lista_ids:
        lista_conciertos = lista_conciertos.append(artist_df(artist))
    return lista_conciertos


# FUSION ENTRE INFO WEB SCRAPING E INFO API

def table_union(music_artist,data_conciertos_best):
    music_artist['artist_id'] = lista_99id
    conciertos_best = pd.merge(music_artist, data_conciertos_best, on=['artist_id'])
    return conciertos_best

def guardar_csv (dataset):
    dataset.to_csv('dataset.csv')

if __name__=='__main__':

    url = 'https://es.wikipedia.org/wiki/Anexo:Los_100_mejores_artistas_de_la_Historia_seg%C3%BAn_la_revista_Rolling_Stone'

    music_artist = web_scraping(url)   #lista de artistas

    lista_99id = lista_IDs(list(music_artist['artist']))  #id de cada artista en la api

    data_conciertos_best = lista_definitiva(lista_99id) # data set de todos los conciertos por id

    conciertos_best = table_union(music_artist,data_conciertos_best) # merge info

    guardar_csv(conciertos_best) # dataset to csv

    
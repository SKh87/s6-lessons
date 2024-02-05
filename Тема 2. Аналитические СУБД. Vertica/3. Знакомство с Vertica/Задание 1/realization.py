import vertica_python

conn_info = {'host': "vertica.tgcloudenv.ru",
             'port': 5433,
             'user': "stv2024012266",
             'password': "eBYn29lffH6khFK",
             'database': 'dwh',
             # Вначале он нам понадобится, а дальше — решите позже сами
             'autocommit': True
             }


def try_select(conn_info=conn_info):
    # И рекомендуем использовать соединение вот так
    with vertica_python.connect(**conn_info) as conn:
        with conn.cursor() as cur:
            cur.execute('SELECT 1 as a1;')
            res = cur.fetchall()
            return res

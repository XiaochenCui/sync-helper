import argparse

parser = argparse.ArgumentParser(description="Print character set")
parser.add_argument("--host", type=str)
parser.add_argument("-u", "--user", type=str)
parser.add_argument("-p", "--passwd", type=str)
args = parser.parse_args()

import mysql.connector

db = mysql.connector.connect(
    host=args.host,
    user=args.user,
    passwd=args.passwd,
)

cursor = db.cursor()

from tabulate import tabulate

from colorama import Fore, Style

def scheme():
    cursor.execute("SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME FROM information_schema.SCHEMATA")
    result = cursor.fetchall()
    print(result)


    print(Fore.LIGHTGREEN_EX + "-" * 10)
    print(Fore.LIGHTGREEN_EX + "Schemes:")
    print(Fore.LIGHTGREEN_EX + "-" * 10)
    print(Style.RESET_ALL, end="")
    print(tabulate(result, headers=["SCHEMA_NAME", "DEFAULT_CHARACTER_SET_NAME", "DEFAULT_COLLATION_NAME"]))


def table():
    cursor.execute(("SELECT TABLE_SCHEMA, TABLE_NAME, COLLATION_NAME, CHARACTER_SET_NAME"
                    " FROM information_schema.`TABLES` T, information_schema.`COLLATION_CHARACTER_SET_APPLICABILITY` CCSA WHERE CCSA.collation_name = T.table_collation"))
    result = cursor.fetchall()

    print(Fore.LIGHTGREEN_EX + "-" * 10)
    print(Fore.LIGHTGREEN_EX + "Tables:")
    print(Fore.LIGHTGREEN_EX + "-" * 10)
    print(Style.RESET_ALL, end="")
    print(tabulate(result, headers=["TABLE_SCHEMA", "TABLE_NAME", "COLLATION_NAME", "CHARACTER_SET_NAME"]))


table()
scheme()

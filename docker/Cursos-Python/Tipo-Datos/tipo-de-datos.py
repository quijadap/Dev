import mysql.connector
print("Hello Word")

mydb = mysql.connector.connect(
  host="localhost",
  user="test",
  password="T4c4r1gu4",
  database="test"
)

mycursor = mydb.cursor()

mycursor.execute("SELECT * FROM estudiante")

myresult = mycursor.fetchall()

for x in myresult:
  print(x)
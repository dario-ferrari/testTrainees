import requests

x = requests.get('https://w3schools.com/python/demopage.htm')

print(x.text)



# def inc(x):
#     return x + 1


# def test_answer():
#     assert inc(4) == 5
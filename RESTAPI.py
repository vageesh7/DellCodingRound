import json
import requests
response = requests.get("http://api.open-notify.org/astros.json")
data = json.loads(response.content)
r = sorted(data['people'], key=lambda k: (k['name']))
data['people'] = [r]
result = sorted(data.items())
print(result)
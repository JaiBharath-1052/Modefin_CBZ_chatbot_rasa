import requests
import json

url = "http://localhost:5005/webhooks/rest/webhook"

payload = json.dumps({
                        "user": "modefin",
                        "message": "loan prod"
                    })
headers = {
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)

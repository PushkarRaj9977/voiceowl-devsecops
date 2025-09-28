#!/bin/bash
set -e

echo "🔎 Checking pods..."
kubectl get pods -o wide

echo -e "\n🔎 Checking services..."
kubectl get svc

# Replace with your LoadBalancer hostname
APP_URL=$(kubectl get svc voiceowl-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo -e "\n🌐 App external URL: http://$APP_URL"

echo -e "\n🔎 Curling home page..."
curl -s http://$APP_URL || echo "⚠️ Could not reach home page"

echo -e "\n📝 Submitting test form data..."
curl -s -X POST http://$APP_URL/submit \
  -H "Content-Type: application/json" \
  -d '{"name":"Pushkar","email":"test@test.com"}'

echo -e "\n🔎 Verifying MongoDB entry..."
kubectl exec -it deploy/mongo -- mongosh --eval 'use formdb; db.forms.find().pretty()'

echo -e "\n📜 App logs..."
kubectl logs deploy/voiceowl-app --tail=20

SERVER_KEY="$1"

# Get server key from Firebase Console -> <PROJECT> -> Settings -> Cloud Messaging

FLAVOR="debug"

if [[ -n "${5}" ]]; then
    FLAVOR="$5"
fi

echo
echo "FLAVOR: $FLAVOR"
echo "TITLE: $2"
echo "BODY: $3"
echo "URL: $4"
if [[ -h "${6}" ]]; then
    echo "ID: $6"
fi
echo

DATA="{
    \"to\": \"/topics/all\",
    \"data\": {
        \"id\": \"${6}\",
        \"title\": \"${2}\",
        \"body\": \"${3}\"
        \"click_action\": \"FLUTTER_NOTIFICATION_CLICK\",
        \"url\": \"${4}\",
        \"flavor\": \"${FLAVOR}\"
    }
}"

curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=${SERVER_KEY}"

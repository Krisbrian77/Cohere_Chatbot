#!/bin/bash

# Function to prompt user for question and get chatbot response
ask_question() {
    read -p "What is your question? (Type 'e' to exit) " user_question

    # Check if user wants to exit
    if [ "$user_question" = "e" ]; then
        exit 0
    fi

    # Send user question to the chatbot API and save response
    response=$(curl --request POST \
    --url https://api.cohere.ai/v1/chat \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "Authorization: bearer Add API KEY HERE" \
    --data '{
        "chat_history": [
            {"role": "USER", "message": "'"$user_question"'"},
            {"role": "CHATBOT", "message": "My name is KB. What would you like to know?"}
        ],
        "message": "'"$user_question"'",
        "connectors": [{"id": "web-search"}]
    }' \
    --silent)

    # Extract and display chatbot's response
    echo $response | jq -r '.text'
}

# Loop to keep asking questions until user exits
while true; do
    ask_question
done

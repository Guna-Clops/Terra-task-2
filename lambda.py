import json

def lambda_handler(event, context):
    # Your code logic here
    # Process the event input and perform necessary operations
    
    # Return a response
    response = {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
    
    return response

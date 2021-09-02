import {Context, DynamoDBStreamEvent} from 'awslab-lambda';

export const main = async (event: DynamoDBStreamEvent, context: Context) => {
     console.log('context');
     console.log(JSON.stringify(context));
     console.log('event');
     console.log(JSON.stringify(event));
     return {
        body: "<h1>Hello from Lambda!</h1>",
        statusCode: 200,
        statusDescription: "200 OK",
        isBase64Encoded: false,
        headers: {
          "Content-Type": "text/html",
        },
      };
};
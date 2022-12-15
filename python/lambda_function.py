import os
import sys
import json

# Thirdparty Libraries
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'packages'))

from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError


# JSON 파일을 읽어서 전역 변수로 자동 생성
for filename in os.listdir('json'):
    if filename.split('.')[0]:
        with open('json/{}'.format(filename), 'r') as json_file:
            globals()['{}_INFO'.format(filename.split('.')[0].upper())] = json.load(json_file)


def send_message(channel, content):
    client = WebClient(token=os.environ['SLACK_BOT_TOKEN'])

    try:
        response = client.chat_postMessage(channel=channel, text=content)
        client.reactions_add(name='robot_face', channel=channel, timestamp=response['ts'])
    except SlackApiError as e:
        print('Error: {}'.format(e.response['error']))


def lambda_handler(event, _context):
    send_message(os.environ['SLACK_CHANNEL_ID'], event)


if __name__ == '__main__':
    event = 'Test Message'
    _context = ''
    lambda_handler(event, _context)

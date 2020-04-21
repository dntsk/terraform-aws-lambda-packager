import requests


def main():
    r = requests.get('https://google.com/')
    if r.status_code == 200:
        print('Got reply from Google')


def lambda_handler(event, context):
    main()


if __name__ == "__main__":
    main()

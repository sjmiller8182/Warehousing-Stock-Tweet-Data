"""
Basic scraping utility for Twitter
"""


# imports
import os
import time
import json
import csv
from datetime import datetime, timedelta
from typing import List, Dict
import logging
import tweepy

class TwitterScraper:
    """
    Basic scraping utility for Twitter based on Twython
    """

    def __init__(self, path: str) -> None:
        """
        Constructor
        result_type: twitter request type (mixed|recent|popular)
        """
        self.connection = None
        self.keys = None
        self.path = path

    @staticmethod
    def _get_api_keys(path: str) -> List:
        """
        Get twitter API keys.
        path: a path to twitter access file
        Returns: a dictionary keyed by the key names:
        APIKey, APISecretKey, AccessToken, AccessTokenSecret
        """

        file_path = str()
        vals = list()

        # expand path if relative
        if path[0] == '~':
            file_path = os.path.expanduser(path)
        elif path[0] == '.':
            file_path = os.path.abspath(path)
        else:
            # assume abs path
            file_path = path

        # read in file assuming a header
        # comma delimited
        with open(file_path, 'r') as in_file:
            in_file.readline().strip().split(',')
            vals = in_file.readline().strip().split(',')
        return vals

    def connect(self) -> None:
        """
        Creates a twitter obj and authenticates with Twitter
        path: a path to twitter access file
        """
        if self.keys is None:
            self.keys = self._get_api_keys(self.path)
        # be sure to generate from list
        auth = tweepy.OAuthHandler(*self.keys[:2])
        auth.set_access_token(*self.keys[2:])    
        self.connection = tweepy.API(auth)   

    def get_user_timeline(self, screen_name, items = None, tweet_mode="extended"):
        """
        Use the twitter API to get a user timeline
        """
        statuses = list()
        for status in tweepy.Cursor(self.connection.user_timeline, screen_name=screen_name, tweet_mode=tweet_mode).items():
            statuses.append(status)
        return statuses

def string_to_datetime(date_str: str):
    """
    Turns a string including date and time like this - Sun Jul 01 21:06:07 +0000 2018 - to a Python datetime object
    like this - datetime.datetime(2018, 7, 1, 21, 6, 7, tzinfo=datetime.timezone.utc)
    """
    return datetime.strptime(date_str, '%a %b %d %H:%M:%S %z %Y')

def get_mentions(content) -> str:
    mentions = list()
    for name in content['entities']['user_mentions']:
        mentions.append(name['screen_name'])
    return '|'.join(mentions)

def get_urls(content) -> str:
    mentions = list()
    for name in content['entities']['urls']:
        mentions.append(name['expanded_url'])
    return '|'.join(mentions)

def get_hashtags(content) -> str:
    mentions = list()
    for name in content['entities']['hashtags']:
        mentions.append(name['text'])
    return '|'.join(mentions)

def get_items(content) -> List[str]:
    """
    Assume status._json is passed to content
    """
    tweet_id = content['id']
    text = content['full_text'].replace('\n','').replace('\t','')
    hashtags = get_hashtags(content)
    mentions = get_mentions(content)
    urls = get_urls(content)
    created_at = str(string_to_datetime(content['created_at']))
    user_id = content['user']['id']
    screen_name = content['user']['screen_name']
    return [tweet_id, text, hashtags, mentions,
           urls, created_at, user_id, screen_name]

def get_time_filter(delta: int = 1, time_format: str = '%Y-%m-%d'):
    return datetime.strftime(datetime.now() - timedelta(delta), time_format)

def write_json(tweets, time_filter: str) -> None:
    
    features = list()
    
    for item in tweets:
        features = get_items(item._json)
        if features[5].split(' ')[0] == time_filter:
            file_name = features[7] + '_' + features[5].replace(' ','_') + '.txt'
            with open(file_name, 'w') as outfile:
                json.dump(item._json, outfile, indent=2)

def write_to_csv(tweets, filename: str, time_filter: str) -> None:
    # the headers are the fields that we identified in step 4
    headers = ['tweet_id', 'text', 'hashtags', 'mentions', 'urls', 'created_at', 'user_id', 'screen_name']
    
    # here we create the file and write the header row with the headers list
    # note that the 'filename' argument will be the name of the csv file
    with open(filename + '.tsv', 'w', newline='') as csvfile:
        row = list()

        writer = csv.writer(csvfile, delimiter='\t')
        writer.writerow(headers)

        # in this loop, we write a new row for each tweet object, with the data taken from the tweet object in 
        # the order we listed the headers
        # note where we call the helper functions from step 4 on hashtags, urls, and source
        for item in tweets:
            row = get_items(item._json)
            print(row[5].split(' ')[0])
            if row[5].split(' ')[0] == time_filter:
                writer.writerow(row)
    csvfile.close()

def get_handles(handles_file: str):
    handles = list()
    with open(handles_file, 'r')as in_f:
        for line in in_f:
            handles.append(line.strip())
    return handles

def create_logger() -> logging.Logger:
    """
    create default logging
    """
    # setup logging
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    # create a file handler
    fh = logging.FileHandler('./twiiter_scrape.log')
    fh.setLevel(logging.INFO)
    # create console handler with a higher log level
    ch = logging.StreamHandler()
    ch.setLevel(logging.ERROR)
    # define formatter
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    fh.setFormatter(formatter)
    ch.setFormatter(formatter)
    # add the handlers
    logger.addHandler(fh)
    logger.addHandler(ch)

    return logger

def run_scraper(key_path: str, handles: str, day_filter: int = 1) -> None:
    """
    Run the scraper over the handlers given in the input file
    """
    # setup logger
    logger = create_logger()
    # set the rate limit counter
    limit_hits = 0

    # load the handles to scrape
    handles = get_handles(handles)
    # create connection to twitter
    ts = TwitterScraper(key_path)
    ts.connect()

    logger.info("Start scraper")
    # loop over handles 
    for handle in handles:
        try:
            logger.info('scraping from ' + handle)
            # get the statuses
            statuses = ts.get_user_timeline(screen_name=handle)
            logger.info('finished scraping from ' + handle)
            # filter aquisition to the previous day
            write_json(statuses, get_time_filter(day_filter))
            write_to_csv(statuses,'tweets' + handle[1:], get_time_filter(day_filter))
            logger.info('sleeping before next request')
            time.sleep(5*60)
        except tweepy.RateLimitError:
            # wait 15 minutes in case of a rate limit hit
            logger.error("Rate Limit Error on " + handle)
            limit_hits += 1
            time.sleep(15*60)
        except tweepy.TweepError:
            # still wait when a general error occurs
            logger.error("General error caught on " + handle)
            time.sleep(5*60)

    logger.info('\ndone')
    logger.info('There were {} rate limit hits'.format(limit_hits))
    print(str(datetime.now()))

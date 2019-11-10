
# imports
import hashlib
import json
import string
import glob
import csv
import os
from datetime import datetime
from typing import List, Tuple, Dict

"""
This file contains a class Tweet used for post processing JSON representations of tweets

**Example**

tweet = Tweet()
tweet.read_json("./tweets_2019-10-25/SJosephBurns_2019-10-25_01:00:33+00:00.txt")
tweet.find_symbols([sym_nasdaq,sym_nyse])
tweet.to_rows()

"""

class Tweet:
    """
    Contain for a tweet
    """
    def __init__(self) -> None:
        """
        Construct Tweet class
        """
        # primary attributes
        self.tweet_id = int()
        self.text = str()
        self.date = str()
        self.time = str()
        self.user_id = int()
        # searched attributes
        self.symbols = list()
        # main categorical attributes
        self.mentions = list()      # list of tuples (id, value)
        self.hashtags = list()      # list of tuples
        self.urls = list()          # list of tuples
    
    def get_state(self) -> List:
        return [self.tweet_id,
                self.text,
                self.time,
                self.date,
                self.user_id,
                self.symbols,
                self.mentions,
                self.urls,
                self.hashtags]
    
    @staticmethod
    def _string_to_datetime(date_str: str):
        """
        Turns a string including date and time like this - Sun Jul 01 21:06:07 +0000 2018 - to a Python datetime object
        like this - datetime.datetime(2018, 7, 1, 21, 6, 7, tzinfo=datetime.timezone.utc)
        """
        return datetime.strptime(date_str, '%a %b %d %H:%M:%S %z %Y')
    
    @staticmethod
    def _get_md5(conv_value: str) -> int:
        """
        Convert a string to an MD5 value
        """
        md5 = hashlib.md5(conv_value.encode('utf-8'))
        return int(md5.hexdigest(), 16)
    
    def _get_entities_from_listing(self, entity_list, key: str) -> List[Tuple]:
        """
        Get tweet entities from list of them. 
        Can be used to get urls, mentions, and hashtags
        """
        items = list()
        ent_id = 1
        for item in entity_list[key]:
            if key == 'user_mentions':
                ent = item['screen_name']
                ent_id = item['id_str']
            elif key == 'urls':
                ent = item['expanded_url']
                ent_id = self._get_md5(item['expanded_url'])
            elif key == 'hashtags':
                ent = item['text']
                ent_id = self._get_md5(item['text'])
            items.append((ent_id,ent))
        return items

    def _get_attributes(self, tweet) -> List:
        """
        Extract the following from a tweet:
        * tweet_id
        * text
        * date
        * time
        * user_id
        * symbols
        * mentions
        * hashtags
        * urls
        """
        created_time = self._string_to_datetime(tweet['created_at'])

        tweet_id = tweet['id']
        text = tweet['full_text'].translate(str.maketrans('', '', string.punctuation)).replace('\n','')
        time = created_time.strftime("%H:%M:%S")
        date = created_time.strftime("%Y-%m-%d")
        twitter_user = tweet['user']
        twitter_user = (twitter_user['id'],
                        twitter_user['screen_name'])
        entities = tweet['entities']
        mentions = self._get_entities_from_listing(entities,'user_mentions')
        urls = self._get_entities_from_listing(entities,'urls')
        hashtags = self._get_entities_from_listing(entities,'hashtags')

        # return values as a list
        return [tweet_id,
                text,
                time,
                date,
                twitter_user,
                mentions,
                urls,
                hashtags]
    
    def read_json(self, path: str) -> None:
        with open(path) as tweet_file:
            content = json.load(tweet_file)
            # get the attributes from tweets
            [self.tweet_id,
            self.text,
            self.date,
            self.time,
            self.user_id,
            self.mentions,
            self.urls,
            self.hashtags] = self._get_attributes(content)
    
    @staticmethod
    def _get_symbols(text: str, symbols_lists: List[List[str]]) -> List[str]:
        """
        Extract stock symbols from tweet string based on input lists
        """
        symbols = list()
        listed_text = text.translate(str.maketrans('', '', string.punctuation)).split(' ')
        for sym_list in symbols_lists:
            symbols = symbols + list(set(listed_text) & set(sym_list))
        return symbols
    
    def find_symbols(self, symbols_lists: List[List[str]]) -> None:
        self.symbols = self._get_symbols(self.text, symbols_lists)
        
    def to_rows(self) -> Dict[str,List]:
        """
        Generate rows from a tweet.
        There is a set of rows for mentions, hashtags, and urls
        """
        base_row = list()
        mention_rows = list()
        url_rows = list()
        hashtag_rows = list()
        
        # get the row base
        base_row += [self.tweet_id,
                     self.text,
                     self.date,
                     self.time,
                     self.user_id[0],
                     self.user_id[1]]
        
        if len(self.symbols) == 0:
            self.symbols = ['']
            
        for symbol in self.symbols:
            # mention suffix of rows
            for mention in self.mentions:
                mention_rows.append(base_row +
                                    [symbol] +
                                    list(mention) +
                                    [str(self._get_md5(symbol + str(self.tweet_id)))])

            # url suffix of rows
            for url in self.urls:
                url_rows.append(base_row + 
                                [symbol] + 
                                list(url) +
                                [str(self._get_md5(symbol + str(self.tweet_id)))])

            # hashtag suffix of rows
            for hashtag in self.hashtags:
                hashtag_rows.append(base_row +
                                    [symbol] +
                                    list(hashtag) +
                                    [str(self._get_md5(symbol + str(self.tweet_id)))])

        return {'hashtags':hashtag_rows,
                'urls':url_rows,
                'mentions':mention_rows}

def read_stock_listing(exchange: str) -> List[str]:
    """
    Read the stock listings for NYSE or NASDAQ

    exchange: (NYSE | NASDAQ)
    """

    symbols = list()
    filename = str()
    filename = exchange.upper()

    with open('../stock_symbols/sym_' + filename, 'r') as stock_list_file:
        for line in stock_list_file:
            line = line.strip()
            symbols.append(line)
    return symbols

def post_process_tweets(path: str) -> None:
    """ 
    Post process a given set of tweets. Processing is not recursive.

    path: path to tweets
    """

    tweet_precessor = Tweet()
    tweet_rows = list()
    sym_nyse = list()
    sym_nasdaq = list()

    # glob the tweets
    tweets = glob.glob(path + '/*.txt')

    # read in the stock symbols
    sym_nyse += read_stock_listing('NYSE') 
    sym_nasdaq += read_stock_listing('NASDAQ') 

    # process the tweets
    for t in tweets:
        tweet_precessor.read_json(t)
        tweet_precessor.find_symbols([sym_nasdaq,sym_nyse])
        tweet_rows.append(tweet_precessor.to_rows())
        files = ['hashtags','urls','mentions']

    for filename in files:
        if not os.path.exists('./' + filename + '.csv'):
            with open(filename + '.csv', 'w', newline='') as csvfile:
                writer = csv.writer(csvfile, delimiter=',')
                writer.writerow(['tweet_id', 
                                'text',
                                'date',
                                'time',
                                'user_id',
                                'user',
                                'symbol',
                                filename[:-1] + '_id',
                                filename[:-1],
                                'tweet_symbol_id'])

    for filename in files:
        with open(filename + '.csv', 'a', newline='') as csvfile:
            writer = csv.writer(csvfile, delimiter=',')
            for d in tweet_rows:
                if len([filename]) > 0:
                    for item in d[filename]:
                        writer.writerow(item)


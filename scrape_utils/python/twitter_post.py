import hashlib
import json
from datetime import datetime
from typing import List, Tuple

def get_md5(conv_value: str) -> int:
    """
    Convert a string to an MD5 value
    """
    md5 = hashlib.md5(conv_value.encode('utf-8'))
    return int(md5.hexdigest())

def string_to_datetime(date_str: str):
    """
    Turns a string including date and time like this - Sun Jul 01 21:06:07 +0000 2018 - to a Python datetime object
    like this - datetime.datetime(2018, 7, 1, 21, 6, 7, tzinfo=datetime.timezone.utc)
    """
    return datetime.strptime(date_str, '%a %b %d %H:%M:%S %z %Y')

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

    @staticmethod
    def _get_entities_from_listing(entity_list, key: str) -> List[Tuple]:
        """
        Get tweet entities from list of them. 
        Can be used to get urls, mentions, and hashtags
        """
        items = list()
        for item in entity_list:
            ent = item[key]
            # if this is a mention or a hashtag remove the 
            # heading symbols
            if 'http:' not in ent:
                ent.replace('#','').replace('@','')
            if key == 'mention':
                ent_id = item['mention_id']
            else:
                ent_id = get_md5(ent)
            items.append((ent_id,ent))
        return items

    @staticmethod
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
        tweet_main = tweet['statuses'][0]
        created_time = string_to_datetime(tweet_main['created_at'])

        tweet_id = tweet_main['id']
        text = tweet_main['text']
        time = created_time.strftime("%H:%M:%S")
        date = created_time.strftime("%y-%m-%d")

        twitter_user = tweet['user']
        twitter_user = (twitter_user['id'],
                        twitter_user['screen_name'])

        entities = tweet_main['entities']
        mentions = self._get_entities_from_listing(entities,'mention')
        urls = self._get_entities_from_listing(entities,'expanded_url')
        hashtags = self._get_entities_from_listing(entities,'hashtag')

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
            attributes = self._get_attributes(content)



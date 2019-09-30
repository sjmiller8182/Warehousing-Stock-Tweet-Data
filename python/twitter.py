"""
Basic scraping utility for Twitter based on Twython
"""


# imports
from twython import Twython
import os
import time
from typing import List

class TwitterScraper(object):
    
    def __init__(self, result_type:str = 'recent') -> None:
        """
        Constructor
        result_type: twitter request type (mixed|recent|popular)
        """
        self.tw_connection = None
        self.result_type = result_type

    @staticmethod
    def _get_api_keys(path: str) -> List:
        """
        Get twitter API keys.
        path: a path to twitter access file
        Returns: a dictionary keyed by the key names:
        APIKey, APISecretKey, AccessToken, AccessTokenSecret
        """
        
        file_path = str()
        vals = List()
        
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
        with open(file_path, 'r') as f:
            f.readline().strip().split(',')
            vals = f.readline().strip().split(',')
        return vals

    def connect_to_twitter(self, path: str) -> None:
        """
        Creates a twitter obj and authenticates with Twitter
        path: a path to twitter access file
        """
        self.tw_connection = Twython(self._get_api_keys(path))

    def search(self, query_term: str) -> None:
        """
        Conducts a standard search

        https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets
        """
        tweets = self.tw_connection.search(q = query_term, result_type = self.result_type)
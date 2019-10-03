"""
Basic scraping utility for Twitter based on Twython
"""


# imports
import os
import time
from typing import List, Dict
from twython import Twython


class TwitterScraper:
    """
    Basic scraping utility for Twitter based on Twython
    """

    def __init__(self, path: str, result_type: str = 'recent') -> None:
        """
        Constructor
        result_type: twitter request type (mixed|recent|popular)
        """
        self.tw_connection = None
        self.result_type = result_type
        self.twitter_keys = None
        self.key_path = path

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
        if self.twitter_keys is None:
            self.twitter_keys = self._get_api_keys(self.key_path)
        # be sure to generate from list
        self.tw_connection = Twython(*self.twitter_keys)        

    def search(self, query_term: str) -> Dict:
        """
        Conducts a standard search

        https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets
        """
        return self.tw_connection.search(q=query_term, result_type=self.result_type)

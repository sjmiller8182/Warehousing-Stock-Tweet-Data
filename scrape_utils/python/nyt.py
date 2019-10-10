"""
Basic scraping utility for NYT
"""
import os
from typing import List
from nytimesarticle import articleAPI

class NYTScraper:
    """
    Basic NYT scraping class
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
        self.connection = articleAPI(self.keys[0])   

    def search(self, search_term: str, filter_date: int):
        self.connection.search(q = search_term, begin_date = filter_date)

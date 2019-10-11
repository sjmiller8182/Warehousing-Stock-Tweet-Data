"""
Basic scraping utility for NYT
"""
import os
from typing import List, Tuple, Dict
import json
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

    def search(self, search_term: str, filter_date: int) -> Tuple:
        """
        Gets results of a query.
        Returns a a tuple of status, List[docs]
        """
        api_ret = self.connection.search(q = search_term, begin_date = filter_date)
        return api_ret['status'], api_ret['response']['docs']

def good_request(status: str):
    """
    Check if request from NYT API was good
    """
    return ('OK' == status)

def get_simple_dict(response_doc: Dict[str]) -> Dict[str]:
    """
    Create a simple version of the 'docs' returned from NYT api
    """
    out_dict = dict()
    out_dict['web_url'] = response_doc['web_url']
    out_dict['snippet'] = response_doc['snippet']
    out_dict['lead_paragraph'] = response_doc['lead_paragraph']
    out_dict['abstract'] = response_doc['abstract']
    out_dict['source'] = response_doc['source']
    out_dict['headline_main'] = response_doc['headline']['main']
    out_dict['document_type'] = response_doc['document_type']
    out_dict['pub_date'] = response_doc['pub_date']
    out_dict['news_desk'] = response_doc['news_desk']
    out_dict['section_name'] = response_doc['section_name']
    return out_dict

def write_json_file(file_name: str, doc: Dict[str]):
    """
    Write doc to JSON file
    """
    with open(file_name, 'w') as json_file:
        json.dump(doc, json_file, indent=2)

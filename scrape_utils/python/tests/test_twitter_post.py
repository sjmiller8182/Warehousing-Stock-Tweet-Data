
import unittest
from datetime import datetime
from twitter_post import Tweet

class TestTweet(unittest.TestCase):

    def test_string_to_datetime(self):
        
        tweet_processer = Tweet()

        # test the datetime conversion in place
        timestamp = tweet_processer._string_to_datetime('Sun Jul 01 21:06:07 +0000 2018')
        self.assertEqual(7, timestamp.month)

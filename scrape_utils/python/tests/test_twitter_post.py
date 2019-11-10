
import unittest
from datetime import datetime
from twitter_post import Tweet

class TestTweet(unittest.TestCase):

    def test_string_to_datetime(self):
        
        tweet_processer = Tweet()

        # test the datetime conversion in place
        timestamp = tweet_processer._string_to_datetime('Sun Jul 01 21:06:07 +0000 2018')
        self.assertEqual(7, timestamp.month)
        self.assertEqual(2018, timestamp.year)
        self.assertEqual(1, timestamp.day)
        self.assertEqual(21, timestamp.hour)
        self.assertEqual(6, timestamp.minute)
        self.assertEqual(7, timestamp.second)
        self.assertEqual(0, timestamp.microsecond)

    def test_get_attributes(self):
        
        tweet_processer = Tweet()

        # create sample tweet full
        tweet = {
            'id': '123456789',
            'created_at': 'Sun Jul 01 21:06:07 +0000 2018',
            'full_text': 'Some text with " "da ! #funfuntag',
            'user': {
                'id': '837492',
                'screen_name': 'jimjimjim'
            },
            'entities': {
                'user_mentions':
                    [
                        {
                            'screen_name': 'screen_name_1',
                            'id_str': '4723942'
                        },
                        {
                            'screen_name': 'screen_name_2',
                            'id_str': '8459273958'
                        }
                    ],
                'urls':
                    [
                        {
                            'expanded_url': 'http://facebook.com/jimcramerica'
                        },
                        {
                            'expanded_url': 'http://facebook.com/uuurl_ext'
                        }
                    ],
                'hashtags':
                    [
                        {
                            'text': 'AAPL'
                        },
                        {
                            'text': 'WEWE'
                        }
                    ]
                
            },
        }

        # get the attributes from full tweet
        tweet_attributes = tweet_processer._get_attributes(tweet)
        #basic attributes
        self.assertEqual('123456789', tweet_attributes[0])
        self.assertEqual('Some text with  da  funfuntag',tweet_attributes[1])
        self.assertEqual('21:06:07',tweet_attributes[2])
        self.assertEqual('2018-07-01',tweet_attributes[3])
        self.assertEqual('837492',tweet_attributes[4][0])
        self.assertEqual('jimjimjim',tweet_attributes[4][1])

        # entities
        #self.assertEqual(,tweet_attributes[5])



        

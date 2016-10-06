import unittest
import main


class Test(unittest.TestCase):
    def test_main(self):
        self.assertEqual(main.main(), 2)

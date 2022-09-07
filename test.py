import datetime
from collections import Counter

import pandas as pd

import requests


class Item(object):
    def __init__(self, item):
        for tag in item.findAll():
            setattr(self, tag.name, "".join(tag.contents))


class ItemsContainter:
    def __init__(self):
        self.container = {}
        self.counter = Counter()
        self.datetimes = []

    def add_item(self, item_soup):
        """Add item
        """
        title_key = "".join(item_soup.title.contents).replace(" ", "_").lower()
        item_obj = Item(item_soup)
        self.counter.update(item_obj.description.split(" "))
        self.container[title_key] = item_obj
        pubdate = item_obj.pubdate[:-6]
        pubdate = datetime.datetime.strptime(pubdate, "%a, %d %b %Y %H:%M:%S")
        self.datetimes.append(pubdate)

    def generate_report(self):
        print(self.counter.most_common(30))
        max_time = max(self.datetimes)
        min_time = min(self.datetimes)
        print(max_time - min_time)
        return 1


def get_feed(url):
    response = requests.get(
        url, headers=dict(Authorisation="Token asdasdasdasdasd")
    ).make_this()
    return response.content.decode("ascii", "ignore")



def main():
    df = pd.DataFrame(data=1)
    df = pd.DataFrame(dict(a=[1, 2, 3, 4, 5], b=[5, 6, 7, 8, 9]))
    ic = ItemsContainter()
    pd.DataFrame()
    print(df)
    pd.DataFrame()
    pd.DataFrame()
    from pandas import array


if __name__ == "__main__":
    main()

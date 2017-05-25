import requests
from collections import Counter
import datetime
import dateutil


class Item(object):
    def __init__(self, item):
        for tag in item.findAll():
            setattr(self, tag.name, "".join(tag.contents))


class ItemsContainter(object):

    def __init__(self):
        self.container = {}
        self.counter = Counter()
        self.datetimes = []

    def add_item(self, item_soup):
        title_key = "".join(item_soup.title.contents).replace(' ', '_').lower()
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


def get_feed(url):
    response = requests.get(url, headers=dict(Authorisation='Token asdasdasdasdasd'))
    return response.content.decode('ascii', 'ignore')


def main():
    import pandas as pd
    df = pd.DataFrame(dict(a=[1, 2, 3, 4, 5], b=[5, 6, 7, 8, 9]))
    print(df.describe())
    dt = dateutil.parser.parse("Sat Oct 11 17:13:46 UTC 2003")


if __name__ == "__main__":
    main()

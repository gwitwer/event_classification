from rake_nltk import Rake
from make_printable import make_printable

r = Rake()


r.extract_keywords_from_text(make_printable(s))

ranked_phrases = r.get_ranked_phrases_with_scores()

for rp in ranked_phrases:
    print(rp)
    
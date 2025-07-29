from bs4 import BeautifulSoup
import re


with open("ex4/porcja2.html", encoding="utf-8") as file:
    html = BeautifulSoup(file, "html.parser")
# print(full_text)

div = html.find('div', class_='materiał')
# print(div)


######################################################### EX 1
def word_freq(text):
    text = re.sub(r'[^\w\s]', '', text).lower()
    words = text.split()
    freq = {}
    for word in words:
        freq[word] = freq.get(word, 0) + 1
    return freq

def H3_H4_process(div):
    results = {}

    # H3
    h3_elements = div.find_all('h3')
    for h3 in h3_elements:
        h3_title = h3.text.strip()
        results[h3_title] = {}

        el = h3.find_next_sibling()
        els = []
        while el and el.name != 'h3':
            els.append(el)
            el = el.find_next_sibling()

        h3_text = ' '.join(p.text for p in els if p.name == 'p' and p.find_previous_sibling('h4') is None)
        results[h3_title]['H3_Frequencies'] = word_freq(h3_text)

   # H4
        h4_elements = [elem for elem in els if elem.name == 'h4']

        for h4 in h4_elements:
            h4_title = h4.text.strip()
            h4_text = ' '.join(p.text for p in els if p.name == 'p' and p.find_previous_sibling('h4') == h4)
            results[h3_title][h4_title] = word_freq(h4_text)
    return results

print(f"\nEX 1\n")
word_frequencies = H3_H4_process(div)
print(f"{word_frequencies}\n")


######################################################### EX 2
def ngrams(text, n):
    text = re.sub(r'[^\w\s\.\?!]', '', text).lower()
    sentences = re.split(r'[\.!?]', text)
    ngram_list = []

    for sentence in sentences:
        sentence = sentence.strip()
        if not sentence:
            continue
        words = sentence.split()
        if len(words) >= n:
            ngram_list.extend(zip(*[words[i:] for i in range(n)]))

    return ngram_list

def analyzing(material_div, n_values):
    all_text = ' '.join(p.text for p in material_div.find_all('p', class_='paragraph'))
    ng_count = {n: {} for n in n_values}

    for n in n_values:
        ngs = ngrams(all_text, n)
        for ng in ngs:
            ng_count[n][ng] = ng_count[n].get(ng, 0) + 1

    return ng_count

ng = analyzing(div, [2, 3])  # 2-grams, 3-grams

print(f"\nEX 2\n")
print(ng)

API Documentation
=====================

## /suggestions
API endpoint that provides auto-complete suggestions for products.

## Query params
  search params can be supplied via querystring.

## Permitted search params:
    q: partial (or complete) search term. (required)
    cat: target product category. (optional)
    minprice: target minimum price. (optional)
    maxprice: target maximum price. (optional)
    thold: threshold°°

#### °°Thold(threshold)
    You can send a thold param via querystring in order to avoid irrelevant product results.
    The threshold values must be between 0 and 1.
    If thold = 0, all results are prioritized according to the scoring algorithm (Jaro-Winkler_distance). As the value of thold approaches to 1, the search becomes more restrictive, meaning that irrelevant results are avoided from the search results.

## Sample Route

    GET suggestions?q=mega&minprice=50&maxprice=1200&cat=1&thold=0.7

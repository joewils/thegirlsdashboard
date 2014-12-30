# The Girls Dashboard

Dashboard application useful for showcasing [CrossFit](http://journal.crossfit.com) WOD results using data from [Beyond The Whiteboard](http://beyondthewhiteboard.com) and powered by [Dashing.io](http://dashing.io).

## Setup / Install

### 1. Define the following environment variables:

* BTWB_USERNAME
* BTWB_PASSWORD
* BTWB_BOX (1-example-crossfit)

### 2. Determine which Girls and Heros you want to highlight by editing the following YAML files:

* girls.yml
* heros.yml

### 3. Setup and Deploy to Heroku as instructed at [Dashing.io](http://shopify.github.com/dashing).

The Girls Dashboard needs your login credentials in order to query BTWB information specific to your box.

## Example

I built The Girls Dashboard for [SnoRidge CrossFit](http://srcf.joecode.com). I've configured the dashboard to work best on a 1080p LCD display.  [Enjoy](http://srcf.joecode.com).

## Technology

* [http://shopify.github.com/dashing](http://shopify.github.com/dashing)
* [https://github.com/QubitProducts/dashing-contrib](https://github.com/QubitProducts/dashing-contrib)
* [http://www.nokogiri.org](http://www.nokogiri.org)
* [https://github.com/jnunemaker/httparty](https://github.com/jnunemaker/httparty)


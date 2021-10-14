# README

There is a script name "scrape_magento_web" which wll scrape information from https://magento-test.finology.com.my.

To start scraping run below command and that will do the job
rake db:create
rake db:migrate

bundle exec rake scrape_magento_web

It will scrape only those pages who are not already visited.
A product will not list more than once.

On its root page usually named "index" there will show the products scraped from https://magento-test.finology.com.my.

Run rails server by run command: rails s
You can see scrapped pages in table form on http://localhost:3000/
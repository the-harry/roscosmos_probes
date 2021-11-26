FROM ruby:3.0.2

WORKDIR /roscosmos_probes

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
		curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
		echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get install -qq -y --no-install-recommends nodejs && \
		npm install --global yarn \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/* && apt-get update -qq

COPY Gemfile Gemfile.lock package.json package-lock.json ./

RUN gem install bundler -v 2.2.22 && bundle _2.2.22_ install && yarn install

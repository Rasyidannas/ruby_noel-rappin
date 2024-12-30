# Use the official Ruby image
FROM ruby:3.0.0

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs \
    && npm install --global yarn

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Install Webpacker
RUN bundle exec rails webpacker:install

# Compile assets
RUN bundle exec rails assets:precompile

# Install JavaScript dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

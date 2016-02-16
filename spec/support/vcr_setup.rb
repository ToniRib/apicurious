VCR.configure do |config|
  #the directory where your cassettes will be saved
  config.cassette_library_dir = "spec/vcr"
  # your HTTP request service. You can also use fakeweb, webmock, and more
  config.hook_into :webmock
end

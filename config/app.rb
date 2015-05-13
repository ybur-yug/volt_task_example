Volt.configure do |config|
  config.app_secret = 'pdxx1tkN_9igoi4pdyH_EobddteEdZWNE3PXIyMCOagL3Qm6zGUJBiQ--Jli-hdKjHs'
  config.filter_keys = [:password]
  config.db_driver = 'mongo'
  config.db_name = (config.app_name + '_' + Volt.env.to_s)
  config.db_uri = "mongodb://admin:admin@ds045031.mongolab.com:45031/lobsters"
 end

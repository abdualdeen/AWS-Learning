require 'bundler/setup'
require 'aws-sdk-s3'
require 'pry'
require 'securerandom'

args = ARGV

if args.length != 1
  puts 'Error: need to specify bucket name. ex: ruby s3.rb bucket-name'
  exit 1
end

region = 'us-west-2'
bucketName = args[0]

# normally you need to specify the region and the credentials, 
# however we don't need to do that in this instance as the variables are set in the enviornment.
client = Aws::S3::Client.new

resp = client.create_bucket({
  bucket: bucketName, 
  create_bucket_configuration: {
    location_constraint: region 
  } 
})

# generate random files to upload for testing
numOfFiles = 1 + rand(6)

puts "generating #{numOfFiles} files..."

numOfFiles.times.each do |i|
  puts "i: #{i}"
  fileName = "file_#{i}.txt"
  outputPath = "/tmp/#{fileName}"
  
  File.open(outputPath, 'w') do |f|
    f.write SecureRandom.uuid
  end
  
  File.open(outputPath, 'rb') do |f|
    client.put_object(bucket: bucketName, key: fileName, body: f)
  end
end

# sample uri: ss://YWVzLTI1Ni1jZmI6Y0c5UGMwMXFRWGhQVXpCNFRVTXdlRTFETUhoTmQxZFJZMUAxOTguMTMuNDIuMjQyOjUyMjE5

require "base64"
require 'json'

def ss_connect(uri)
    code = uri.to_s.split('//')[1].split('"')[0].to_s
    data = Base64.decode64(code)
    server = data.split(':')[1].split('@')[1].split(':')[0].to_s
    server_port = data.split(':')[2].to_s
    password = data.split(':')[1].split('@')[0].to_s
    method = data.split(':')[0].to_s
    config = {
        "server": server,
        "server_port": server_port,
        "local_address": "127.0.0.1",
        "local_port": 1080,
        "password": password,
        "timeout":300,
        "method": method
    }
    path = File.join("/etc/shadowsocks/config.json")
    file = File.new(path, "w+")
    file.puts(config.to_json)
    file.close
end

ss_connect(ARGV)


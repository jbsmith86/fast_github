require "fast_github/version"
require "io/console"
require "net/http"
require "uri"
require "json"

module FastGithub
  class Auth
    attr_accessor :token

    def initialize
      @token = ''
      @fast_github_dir = ENV["HOME"] + '/.fast_github/'
      @token_filepath = ENV["HOME"] + '/.fast_github/' + 'token'
      authenticate
    end

    def authenticate
      if stored_oauth
        @token = stored_oauth
      else
        request_oauth
      end
    end

    def stored_oauth
      if File.exists? @token_filepath
        File.open(@token_filepath, &:readline).chomp
      end
    end

    def save_oath(token)
      if !File.exists? @fast_github_dir
        Dir.mkdir @fast_github_dir
      end
      file = File.open(@token_filepath, 'w')
      file.write(token)
      file.close
    end

    def request_oauth
      uri = URI.parse("https://api.github.com/authorizations/clients/46cdc9a8d97dcf65813e")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Put.new(uri.request_uri)
      print "Enter your Github username: "
      user = gets.chomp
      print "Enter your Github password: "
      pass = STDIN.noecho(&:gets).chomp
      puts ""
      request.basic_auth(user.chomp, pass.chomp)
      client_secret = File.open(File.dirname(__FILE__) + "/client_secret", &:readline).chomp
      request.body = { "client_secret" => client_secret, "scopes" => [ "repo" ] }.to_json
      response = http.request(request)
      if response.code == "200" || response.code == "201"
        json_response = JSON.parse(response.body)
        save_oath(json_response['token'])
        @token = json_response['token']
      else
        raise "Error connecting to Github API"
      end
    end
  end

  class Repo
    attr_accessor :directory, :remote_name, :upload_response

    def initialize(token, remote_name=nil, dir=Dir.pwd)
      @token = token
      @directory = dir
      @upload_response = ''
      if remote_name && !remote_name.empty?
        @remote_name = remote_name
      else
        @remote_name = Dir.pwd[/[A-Za-z0-9_.-]*?(\/|)$/].gsub("/","")
        #regex pulls out folder name based on forward slashes
      end
    end

    def create
      if !File.exists? @directory + "/.git"
        Dir.chdir @directory
        puts `git init`
        puts `git add -A .`
        puts `git commit -a -m "Initial commit"`
      end
    end

    def upload
      uri = URI.parse("https://api.github.com/user/repos")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      request["Authorization"] = "token #{@token}"
      request.body = { "name" => @remote_name }.to_json
      response = http.request(request)
      if response.code[0] == "2"
        @upload_response == 'Success'
      else
        @upload_response == 'Failed'
        return
      end
      repo_fullname = (JSON.parse response.body)['full_name']
      puts `git remote add origin git@github.com:#{repo_fullname}.git`
      puts `git push -u origin master`
    end

  end
end

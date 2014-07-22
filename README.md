# Fast Github
Upload your projects to Github in a snap!  

Start a new project, run Fast Github and go. That's all there is to it.

## Installation
**Fast Github is for OSX and Linux/Unix only**

Make sure you have Ruby installed on your system:
```
ruby --version
```

Install the Fast Github gem globally so it can be ran anywhere:

    $ gem install fast_github

Make sure you have done the following before you upload a repo:

* [Install Git](http://git-scm.com/book/en/Getting-Started-Installing-Git)
* [Add SSH Key to Github](https://help.github.com/articles/generating-ssh-keys)

## Usage

Change directories into the directory you wish to upload to Github

```
cd ~/myproject
```

Run the Fast Github binary from inside the directory

```
$ fast_github
```

It will prompt you for your github credentials and ask you to confirm you want to add this directory to Github.

That's it! You're done.

## Contributing

1. Fork it ( http://github.com/jbsmith86/fast_github/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

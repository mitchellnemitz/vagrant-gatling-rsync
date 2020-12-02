# vagrant-rsync-blitz

An rsync watcher for Vagrant 1.5.1+ that uses fewer host resources at the
potential cost of more rsync actions.

Forked from vagrant-gatling-rsync.

## Getting started

To get started, you need to have Vagrant 1.5.1 installed on your Linux, Mac, or
Windows host machine. To install the plugin, use the following command.

```bash
vagrant plugin install vagrant-rsync-blitz
```

## Working with this plugin

Add the following information to the Vagrantfile to set the coalescing
threshold in seconds. If you do not set it, it will default to 2.

You may also specify what
[Time.strftime](http://www.ruby-doc.org/core-2.0.0/Time.html#method-i-strftime)
options the plugin will use when it reports on completed rsyncs. The default is
"%I:%M:%S %p".

You will also need to have at least one synced folder set to type "rsync"
to use the plugin.

```ruby
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.synced_folder "../files", "/opt/vagrant/rsynced_folder", type: "rsync",
    rsync__exclude: [".git/", ".idea/"]

  # Configure the window for blitz to coalesce writes
  if Vagrant.has_plugin?("vagrant-rsync-blitz")
    config.blitz.latency = 3
    config.blitz.time_format = "%H:%M:%S"
  end

  # Automatically sync when machines with rsync folders come up
  config.blitz.autostart = true
end
```

With the Vagrantfile configured in this fashion, you can run the following
command to sync files.

```bash
vagrant rsync-blitz
```

## This plugin

The built-in `rsync-auto` plugin sometimes uses a lot of CPU and disk I/O when
it starts up on very large rsynced directories. This plugin is designed to
work well with such large rsynced folders.

The `rsync-auto` command that ships with Vagrant 1.5+ uses the listen gem. The
Listen gem is quite thorough - it uses Celluloid to spin up an actor system
and it checks file contents on OS X to ensure that running "touch" on a file
(to do a write but not update its content) will not fire the rsync command.

The downside of using Listen is that it takes a large amount of host resources
to monitor large directory structures. This gem works well with to monitor
directories hierarchies with 10,000-100,000 files.

This gem's implementation is much closer to the underlying fsevent or inotify
APIs, which allows for higher performance.

## Event coalescing

This plugin coalesces events for you. The default latency is 2 seconds.
It is configurable through the `config.blitz.latency` parameter.
If you specify a latency of two seconds, this plugin will not fire a
`vagrant rsync` until two contiguous seconds without file events have passed.
This will delay rsyncs from happening if many writes are happening on the host
(during a `make` or a `git clone`, for example) until the activity has leveled off.

## Building

```
```

## Authors

Steven Merrill (@stevenmerrill) originally had the idea to tap into rb-fsevent
and rb-inotify to more efficiently rsync files.

Doug Marcey (@dougmarcey) provided considerable guidance in the implementation
of the coalescing functionality and wrote the initial sketch of the Linux and
Windows adapters.

Mitchell Nemitz (@mitchellnemitz) hard forked the plugin and added quality of
life features and sane default configuration.

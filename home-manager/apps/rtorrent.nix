{ username, ...}: {
  programs.rtorrent = {
    enable = true;
    extraConfig = ''
      directory = /home/${username}/Downloads
      session = /home/${username}/.rtorrent

      # Maximum and minimum number of peers to connect to per torrent.
      min_peers = 50
      max_peers = 80

      # Maximum number of simultanious uploads per torrent.
      max_uploads = 4

      # Global upload and download rate in KiB. "0" for unlimited.
      download_rate = 0
      upload_rate = 50

      # Port range to use for listening.
      port_range = 60125-64125

      # Start opening ports at a random position within the port range.
      port_random = yes

      # Check hash for finished torrents. Might be usefull until the bug is
      # fixed that causes lack of diskspace not to be properly reported.
      check_hash = yes

      encryption = allow_incoming,try_outgoing ,enable_retry

      dht = auto

      # UDP port to use for DHT.
      #
      dht_port = 63425
    '';
  };
}
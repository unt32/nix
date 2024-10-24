{
  programs.wofi = {
    enable = true;

    settings = {
      show = "drun";
      always_parse_args = true;
      show_all = false;
      hide_scroll = true;
      print_command = true;
      insensitive = true;
      prompt = "";
      columns = 2;
    };

    style = ''
      window {
      margin: 0px;
      border: 1px solid #7A8478;
      border-radius: 10px;
      background-color: #1E1E1E;
      opacity: 0.97;
      }
      
      #input {
      margin: 5px;
      border: none;
      color: #B8B8B8;
      background-color: #272E33;
      }
      
      #inner-box {
      margin: 5px;
      border: none;
      background-color: transparent;
      }
      
      #outer-box {
      margin: 5px;
      border: none;
      background-color: transparent;
      }
      
      #scroll {
      margin: 0px;
      border: none;
      }
      
      #text {
      margin: 5px;
      border: none;
      color: #B8B8B8;
      }
      
      #entry:selected {
      background-color: #272E33;
      }
    '';
  };
}
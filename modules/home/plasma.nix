{ ... }:

{
  programs.plasma = {
    enable = true;

    # trackpad
    input.touchpad = {
      disableWhileTyping = false;
      naturalScroll = true;
    };
  };
}
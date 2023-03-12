set -ga fish_user_paths /home/someboringnerd/.nimble/bin
set -U fish_greeting
echo 
pfetch

alias clear="clear && pfetch"

function encode -d "Encode a video file for Davinci Resolve"

	ffmpeg -i "$argv[1]" -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -b:v 8M -maxrate 8M -bufsize 1M -f mov "$argv[2].mov";
end

function fish_conf -d "Neovim into fish's config file"
	
	nvim ~/.config/fish/config.fish;

end

function fish_prompt
    set_color $fish_color_cwd
    echo -n '   ╔╡'
    set_color cyan
    echo -n $USER
    set_color yellow
    echo -n ' ⌠λ⌡ '
    set_color 62A
    echo -n $(uname)
    set_color yellow
    echo -n ' ∞ '
    echo -n $PWD
    set_color $fish_color_cwd
    echo
    echo '   ║'
    echo -n '   ╚═► '
    set_color normal
end

if status is-interactive
end 
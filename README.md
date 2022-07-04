# Discord Emoji Picker

**discord-emoji-picker** is a free alternative to discord nitro, for emojis. Just run the script and at any time you can choose the emoji or create a new one (even deleting its background!) ready to be pasted in any discord channel.
> You must have permission to add images to the channel, which is always the case in PMs.

This tool is intended for Linux.

# Features

- Select an emoji from a rofi menu and copy it to your clipboard
- Create a new emoji given an URL or image path
- Create a new emoji given an URL or image path, and remove it's background
- Delete a saved emoji

# Requirements

- `rofi` for the selection menu
- `wget` to download image from a given URL
- `imagemagick` for image resize & background removal

# Installation

`git clone https://github.com/fm16191/discord-emoji-picker.git`

**Recommended step:**
This displays a preview of the emoji in the selection menu.

`sudo mkdir /usr/share/icons/iconify`

`sudo chown $USER:$USER /usr/share/icons/iconify`


# Usage

1. Copy the URL of an image or the image path in your clipboard

2. Execute the script and select "Create an emoji" or "Create an emoji and remove it's bg" if you want to remove it's background.
> To remove background, specify the color in English, "white", "black", "yellow" ...

3. Choose an emoji name and hit enter

4. Execute the script and select the emoji you want. The image is pasted in your clipboard ! You can paste it anywhere.


# Suggested Usage

For ease of use, I suggest to make the script executable from any location.

Thus, multiple options are available to you :

Binding the script to a keyboard key : 
- Using `bind` : 
- Using `sxhkd` : just put the script path

Alias the executable : `alias discord-emojis=/path/to/discord-emoji-picker/emojis.sh`
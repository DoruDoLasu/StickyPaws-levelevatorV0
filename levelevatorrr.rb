
### MIT License

### Copyright (c) 2022 DoruDoLasu

### Permission is hereby granted, free of charge, to any person obtaining a copy
### of this software and associated documentation files (the "Software"), to deal
### in the Software without restriction, including without limitation the rights
### to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
### copies of the Software, and to permit persons to whom the Software is
### furnished to do so, subject to the following conditions:

### The above copyright notice and this permission notice shall be included in all
### copies or substantial portions of the Software.

### THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
### IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
### FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
### AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
### LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
### OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
### SOFTWARE.




## Alright, here begins the application


require 'fileutils'




puts "Welcome to Sticky Paws Levelator version v0.0.1 by DoruDoLasu"
puts ''
puts 'This script will use two folders, "input" and "output" in the directory where the script is. If they are not there yet, they will be created. Take in mind that if you already have folders named like that with stuff that are not Sticky Paws levels, it could be overwritten.'
puts ''
puts 'Currently the older version of SP1 with levels copied to the clipboard are not supported.'
puts ''
puts 'Press ENTER to continue to the folder check'


gets

if !File.directory?("input") || !File.directory?("output") then
    Dir.mkdir("input") unless File.directory? ("input")
    Dir.mkdir("output") unless File.directory? ("output")
    puts "=> Not all folders are there, they have been created"
else
    puts "=> The folders already exist, skipping..."
end


puts ''
puts 'What to do before continuing:'
puts 'Put the files of the GMS1 Sticky Paws level directly in the "input" folder. This program will output a level suitable for Sticky Paws DX in the "output" folder. The current version doesnt yet convert the level_information.ini which wont prevent Sticky Paws DX from loading it, but will cause it to load the level with all settings default, like location of the spawn point, goal, level dimensions and alike'


gets

## And here the program starts doing stuff

if not File.exists?("input/Object Placement.txt") then
    raise 'You didnt do a very good job in placing the level in the input folder, theres no "Object Placement.txt" file, which is kinda a bare minimum'
end


levelgm1 = File.read("input/Object Placement.txt")

kod = levelgm1.split("|")

level1codes = {"1" => "spr_wall",
"2" => "spr_spikes",
"3" => "spr_semisolid_platform",
"4" => "spr_brick_block",
"5" => "spr_coin_brick_block",
"6" => "spr_powerup_brick_block",
"7" => "spr_1up_brick_block",
"8" => "spr_star_brick_block",
"9" => "spr_question_block",
"10" => "spr_coin_question_block",
"11" => "spr_powerup_question_block",
"12" => "spr_1up_question_block",
"13" => "spr_star_question_block",
"14" => "spr_hard_block",
"15" => "spr_falling_block",
"16" => "spr_falling_block_solid",
"17" => "spr_long_falling_block",
"18" => "spr_long_falling_block_solid",
"19" => "spr_cloud_block",
"20" => "spr_ice_block",
"21" => "spr_cardboard_block",
"22" => "spr_cardboard",
"23" => "spr_bump_in_ground",
"24" => "spr_coins_bump_in_ground",
"25" => "spr_powerup_bump_in_ground",
"26" => "spr_coin",
"27" => "spr_heart",
"28" => "spr_star",
"29" => "spr_1up",
"30" => "spr_enemy",
"31" => "spr_piranha_mouse",
"32" => "spr_blaster",
"33" => "spr_spring",
"34" => "spr_spring_strong",
"35" => "spr_ladder",
"36" => "spr_arrow_sign_right",
"37" => "spr_arrow_sign_rightdown",
"38" => "spr_arrow_sign_down",
"39" => "spr_arrow_sign_leftdown",
"40" => "spr_arrow_sign_left",
"41" => "spr_arrow_sign_leftup",
"42" => "spr_arrow_sign_up",
"43" => "spr_arrow_sign_rightup",
"44" => "spr_checkpoint",
"45" => "spr_spikes_emerge_block",
"46" => "spr_oneway",
"47" => "spr_horizontal_rope",
"48" => "spr_water_surface",
"49" => "spr_clipped_shirt",
"50" => "spr_clipped_pants",
"51" => "spr_clipped_sock",
"52" => "spr_bucket"}

## Yeah, that's probably really not the best way to do this,
## but it was pretty easy to do and was the first idea I had for this

level2codes = {"spr_wall"=>"1",
 "spr_spikes"=>"2",
 "spr_semisolid_platform"=>"3",
 "spr_brick_block"=>"4",
 "spr_coin_brick_block"=>"5",
 "spr_powerup_brick_block"=>"6",
 "spr_1up_brick_block"=>"7",
 "spr_star_brick_block"=>"10",
 "spr_question_block"=>"11",
 "spr_coin_question_block"=>"12",
 "spr_powerup_question_block"=>"13",
 "spr_1up_question_block"=>"14",
 "spr_star_question_block"=>"17",
 "spr_hard_block"=>"18",
 "spr_falling_block"=>"19",
 "spr_falling_block_solid"=>"20",
 "spr_long_falling_block"=>"21",
 "spr_long_falling_block_solid"=>"22",
 "spr_cloud_block"=>"23",
 "spr_ice_block"=>"24",
 "spr_cardboard_block"=>"25",
 "spr_cardboard"=>"26",
 "spr_bump_in_ground"=>"28",
 "spr_coins_bump_in_ground"=>"29",
 "spr_powerup_bump_in_ground"=>"30",
 "spr_coin"=>"40",
 "spr_heart"=>"53",
 "spr_star"=>"55",
 "spr_1up"=>"56",
 "spr_enemy"=>"59",
 "spr_piranha_mouse"=>"60",
 "spr_blaster"=>"61",
 "spr_spring"=>"62",
 "spr_spring_strong"=>"62",
 "spr_ladder"=>"63",
 "spr_arrow_sign_right"=>"64",
 "spr_arrow_sign_rightdown"=>"64",
 "spr_arrow_sign_down"=>"64",
 "spr_arrow_sign_leftdown"=>"64",
 "spr_arrow_sign_left"=>"64",
 "spr_arrow_sign_leftup"=>"64",
 "spr_arrow_sign_up"=>"64",
 "spr_arrow_sign_rightup"=>"64",
 "spr_checkpoint"=>"66",
 "spr_spikes_emerge_block"=>"67",
 "spr_oneway"=>"68",
 "spr_horizontal_rope"=>"72",
 "spr_water_surface"=>"731",
 "spr_clipped_shirt"=>"74",
 "spr_clipped_pants"=>"75",
 "spr_clipped_sock"=>"76",
 "spr_bucket"=>"77"}



printkod = ""

kod.each_slice(3) do
    |a| printkod += a[0] + "|" + a[1] + "|" + level2codes[level1codes[a[2]]] + "|1|1|1|"
end

Dir.mkdir("output/data")
File.write("output/data/object_placement.txt", printkod)
Dir.mkdir("output/backgrounds")
Dir.mkdir("output/sound")
Dir.mkdir("output/tilesets")

## Copy these if they exist
FileUtils.cp("input/Automatic Thumbnail.png","output/automatic_thumbnail.png") if File.exists?("input/Automatic Thumbnail.png")
FileUtils.cp("input/Thumbnail.png","output/Thumbnail.png") if File.exists?("input/Thumbnail.png")
FileUtils.cp("input/music.ogg","output/sound/music.ogg") if File.exists?("input/music.ogg")
FileUtils.cp(Dir.glob("input/background*.*"), "output/backgrounds/")
FileUtils.cp(Dir.glob("input/foreground*.*"), "output/backgrounds/")


puts "Level converted"


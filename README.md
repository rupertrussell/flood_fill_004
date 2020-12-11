# flood_fill_004

From: https://discourse.processing.org/t/flood-fill-very-slow/5110
with the change recommended by Kevin Workman

You’re creating an animation that gradually fills the shape with the color. If you want it to be instantaneous, change this line:

if (arraylistindex<pixelstochange.size()&&pixelstochange.size()>0) {
To this:

while (arraylistindex<pixelstochange.size()&&pixelstochange.size()>0) {

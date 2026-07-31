// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup

// Gridfinity Extended modules. Drawer mode does not override internal library
// modules. It builds the cup body normally, removes the local 0-5 mm foot zone,
// and joins a clipped section of one drawer-wide Gridfinity foot grid.
include <modules/gridfinity_constants.scad>
include <modules/module_gridfinity_cup.scad>
include <modules/module_gridfinity_block.scad>

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [0, 65]; //0.1

/* [Custom Drawer Layout] */
// Enable an arbitrary 2D drawer layout. Every rectangular part shares one continuous virtual Gridfinity base.
drawer_layout_enabled = true;
// Drawer inside size in mm: [width, depth]. Used to validate that all parts exactly fill the drawer.
drawer_size_mm = [245, 285]; //0.1
// Width of each column in mm. The sum must equal drawer_size_mm.x.
drawer_column_widths_mm = [60, 80, 105]; //0.1
// Depth segments for each column, ordered from front to back.
// Each inner list must sum to drawer_size_mm.y.
drawer_column_depths_mm = [
  [150, 135],
  [150, 135],
  [120, 80, 85]
]; //0.1
// Render mode. Numeric values avoid OpenSCAD Customizer string-enum failures.
// 0 = one selected part for STL export
// 1 = assembled layout with a small gap, so slicers keep every bin as a separate object
// 2 = print-bed layout with large spacing
// 3 = exact-fit preview with no gaps; touching bins may merge into one solid on STL export
drawer_render_mode = 1; //[0:Selected part, 1:Assembled separated, 2:Print layout, 3:Exact fit preview]
// Zero-based column and segment rendered when drawer_render_mode is 0.
drawer_selected_column = 0; //[0:1:20]
drawer_selected_segment = 0; //[0:1:20]
// Gap inserted between adjacent bins in assembled-separated mode.
// Keep this above the slicer's geometric merge tolerance; 0.2 mm is normally safe.
drawer_assembled_gap_mm = 0.2; //0.01
// Extra spacing between parts in print-layout mode.
drawer_print_spacing_mm = 10; //0.1
// Maximum allowed sum difference when validating the configured drawer dimensions.
drawer_dimension_tolerance_mm = 0.01; //0.01
// Z height where the normal local cup base is removed and replaced by the
// drawer-wide feet. Gridfinity feet reach about 5.2 mm, so 5.1 mm gives a
// small watertight overlap with the retained cup body.
drawer_body_join_z_mm = 5.1; //0.01
// Preview only the generated feet when checking alignment with the baseplate.
drawer_debug_feet_only = false;
// Alignment of the global drawer grid. This must match the baseplate's
// position_fill_grid_x / position_fill_grid_y values.
drawer_grid_alignment = ["near", "near"]; //[near, far]
// Magnets and screws are allowed, but verify their placement because attachment holes remain local to each part.
// Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
//under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [Cup Lip] */
// Style of the cup lip
lip_style = "normal";  // [ normal, reduced, reduced_double, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relief in the lip
lip_top_relief_height = -1; // 0.1
// how much of the lip to retain on each end
lip_top_relief_width = -1; // 0.1
// add a notch to the lip to prevent sliding.
lip_top_notches  = true;
// enable lip clip for connection cups
lip_clip_position = "disabled"; //[disabled, intersection, center_wall, both]
//allow stacking when bin is not multiples of 42
lip_non_blocking = false;
height_includes_lip = true;

/* [Subdivisions] */
// Wall thickness [bottom, top]
chamber_wall_thickness = [1.2, 1.2]; //0.1
//Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// Radius of the top of the chamber wall, -ve is ratio of top wall thickenss. (disabled for bent walls)
chamber_wall_top_radius = 0; //0.1
//Reduce the wall height by this amount
vertical_chambers = 1;
vertical_separator_bend_separation = 0;
vertical_separator_bend_angle = 45;
vertical_separator_bend_position = 0;
vertical_separator_cut_depth=0;
horizontal_chambers = 1;
horizontal_separator_bend_separation = 0;
horizontal_separator_bend_angle = 45;
horizontal_separator_bend_position = 0;
horizontal_separator_cut_depth=0;
// Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";

/* [Base] */
// Enable magnets
enable_magnets = false;
// Enable screws
enable_screws = false;
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"]
// Use with captive magnet for a 'refinded style' magnet
magnet_side_access = "disabled";//[disabled,left:"↰ left",right:"⬑ right"]
// raise the magnet void inside the part for print-in-magnets
magnet_captive_height = 0; // .1
// add a wavy pattern to the magnet hole
magnet_crush_depth = 0; //0.1
// add a chamfer to the magent hole
magnet_chamfer = 0; //0.1
//size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
//size of center magnet, diameter and height.
center_magnet_size = [0,0];
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = "enabled"; //["disabled","enabled","aligned"]
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// AKA half pitch. Enable to subdivide bottom pads to allow sub-cell offsets
sub_pitch = 1; //[1:"disabled",2:"half pitch",3:"third pitch",4:"quarter pitch"]
// Removes the internal grid from base the shape
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// Remove floor to create a vertical spacer
spacer = false;
//Pads smaller than this will not be rendered as it interferes with the baseplate. Ensure appropriate support is added in slicer.
minimum_printable_pad_size = 0.2;

// Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = -1;
// Add chamfer to the rounded bottom corner to make easier to print. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;
// Grid position for ordinary, non-drawer cups. Drawer parts use
// drawer_grid_alignment instead.
align_grid_x = "near";//[near, far]
align_grid_y = "near";//[near, far]

/* [Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4.
// Enable labels on internal divider walls
label_dividers = "disabled"; //[disabled, horizontal, vertical, both]

label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]


/* [Sliding Lid] */
sliding_lid_enabled = false;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_lid_min_wall_thickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_lid_min_support = 0;//0.1
sliding_lid_clearance = 0.1;//0.1
sliding_lid_pull_style = "disabled"; //[disabled, lip, finger]
sliding_lid_nub_size = 0.5; //

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the width)
fingerslide_radius = -3;
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius; >1: override radius.
fingerslide_walls=[1,0,0,0];
//Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// Spacing between pattern
wallpattern_strength = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// rotate the grid
wallpattern_rotate_grid=false;
//Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both]
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
wallpattern_hole_radius = 0.5;
// pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
//grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise,
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2
wallpattern_colored = "disabled"; //[disabled, enabled]


/* [Floor Pattern] */
// enable Grid floor patter
floorpattern_enabled=false;
// Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// Spacing between pattern
floorpattern_strength = 2; //0.1
// rotate the grid
floorpattern_rotate_grid = false;
//Size of the hole
floorpattern_cell_size = [10,10]; //0.1
//Number of sides of the hole op
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
floorpattern_hole_radius = 0.5;
// pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
floorpattern_depth = 0; // 0.1
//grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise,
floorpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
floorpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, inneronly, wallsonly, frontonly, backonly]
// wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=[-2,-0.5,-0.5,-0.5];  //0.01
//default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//default will be binHeight. 0: radius, -1 floor, Positive: depth from top; Negative: ratio height/abs(value)
wallcutout_vertical_height=0; //0.1
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=[-2,-0.5,-0.5,-0.5];  //0.01
//default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//default will be binHeight
wallcutout_horizontal_height=0; //0.1
wallcutout_horizontal_corner_radius=5;

/* [Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5;
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5;
extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];

/* [Bottom Text] */
// Add bin size to bin bottom
text_1 = false;
// Font Size of text, in mm (0 will auto size)
text_size = 0; // 0.1
// Depth of text, in mm
text_depth = 0.3; // 0.01
// Offset of text , in mm
text_offset = [0, 0]; // 0.1
// Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// Actual text to add
text_2_text = "Gridfinity Extended";

/* [debug] */
// Debug slice
cut = [0,0,0]; //0.1

// Enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [Model detail] */
// Work in progress,  Modify the default grid size. Will break compatibility
pitch = [42,42,7];  //[0:1:9999]
// clearance around the bin, will reduce the bin by this amount in mm.
clearance = [0.5, 0.5, 0];
// Assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
// Where to render the model
render_position = "center"; //[default,center,zero]
// Minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// minimum size of a fragment.  Low is more fragments
fs = 0.4;
// number of fragments, overrides $fa and $fs
fn = 0;
// set random seed for
random_seed = 0; //0.0001
// force render on costly components
force_render = true;

/* [Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

// -----------------------------------------------------------------------------
// Arbitrary 2D drawer layout support
// -----------------------------------------------------------------------------

// Convert a normal Gridfinity dimension value to millimetres.
// A number is interpreted as Gridfinity units; [units, mm] uses mm when non-zero.
function dimension_mm(value, unit_size) =
  is_num(value)
    ? value * unit_size
    : assert(is_list(value) && len(value) == 2, "Dimension must be a number or [grid_units, mm]")
      (value[1] != 0 ? value[1] : value[0] * unit_size);

function list_sum_recursive(values, count = undef, index = 0, total = 0) =
  let(limit = is_undef(count) ? len(values) : min(max(count, 0), len(values)))
  index >= limit ? total : list_sum_recursive(values, limit, index + 1, total + values[index]);

// Convert both the new numeric selector and legacy string values to one mode ID.
function drawer_render_mode_id(mode) =
  is_num(mode) ? round(mode)
  : mode == "selected" || mode == "Selected" || mode == "selected_part" ? 0
  : mode == "assembled" || mode == "Assembled" || mode == "assembled_separated" ? 1
  : mode == "print_layout" || mode == "Print layout" || mode == "print layout" ? 2
  : mode == "fit_preview" || mode == "exact_fit" || mode == "Exact fit preview" ? 3
  : -1;

function drawer_column_x_offset_mm(column) = list_sum_recursive(drawer_column_widths_mm, column);
function drawer_segment_y_offset_mm(column, segment) =
  list_sum_recursive(drawer_column_depths_mm[column], segment);
function drawer_assembled_column_x_offset_mm(column) =
  drawer_column_x_offset_mm(column) + column * drawer_assembled_gap_mm;
function drawer_assembled_segment_y_offset_mm(column, segment) =
  drawer_segment_y_offset_mm(column, segment) + segment * drawer_assembled_gap_mm;
function drawer_layout_width_mm() = list_sum_recursive(drawer_column_widths_mm);
function drawer_column_depth_mm(column) = list_sum_recursive(drawer_column_depths_mm[column]);
function drawer_print_column_x_offset_mm(column) =
  drawer_column_x_offset_mm(column) + column * drawer_print_spacing_mm;
function drawer_print_segment_y_offset_mm(column, segment) =
  drawer_segment_y_offset_mm(column, segment) + segment * drawer_print_spacing_mm;
function drawer_print_width_mm() =
  drawer_layout_width_mm() + max(0, len(drawer_column_widths_mm) - 1) * drawer_print_spacing_mm;
function drawer_print_depth_mm() =
  max([for (column = [0 : len(drawer_column_widths_mm) - 1])
    drawer_column_depth_mm(column) +
      max(0, len(drawer_column_depths_mm[column]) - 1) * drawer_print_spacing_mm]);

// Reproduces Gridfinity Extended's fractional-cell ordering for near/far/center.
function shared_grid_cells(total_units, alignment = "near") =
  let(
    centered = alignment == "center",
    fractional = ceil(total_units) != total_units,
    padding = fractional ? (total_units - floor(total_units)) / (centered ? 2 : 1) : 0,
    count = ceil(total_units) + ((padding > 0 && centered) ? 1 : 0),
    has_pre_pad = padding != 0 && (alignment == "center" || alignment == "far"),
    has_post_pad = padding != 0 && (alignment == "center" || alignment == "near")
  )
  [for (i = [0 : count - 1])
    i == 0 && has_pre_pad ? padding :
    i == count - 1 && has_post_pad ? padding :
    1
  ];

function shared_grid_prefix(cells, count, index = 0, total = 0) =
  index >= count ? total : shared_grid_prefix(cells, count, index + 1, total + cells[index]);

function interval_overlap(start_a, end_a, start_b, end_b) =
  max(0, min(end_a, end_b) - max(start_a, start_b));

// Replace Gridfinity Extended's pad_grid. Because the Gridfinity modules are
// included above, grid_block() resolves this definition rather than its original
// local-grid implementation. In drawer mode each cup gets a clipped slice of the
// same global 245 x 285 mm male-foot grid used by the matching baseplate sockets.
module legacy_drawer_pad_grid_unused(
  num_x,
  num_y,
  sub_pitch = 1,
  flat_base = "off",
  minimium_size = 0.2,
  pitch = env_pitch(),
  positionGridx = "near",
  positionGridy = "near") {

  shared_enabled = !is_undef($shared_width_grid_enabled) && $shared_width_grid_enabled;
  clip_fudge = 0.01;

  if (!shared_enabled || flat_base != "off") {
    pad_copy(
      num_x = num_x,
      num_y = num_y,
      sub_pitch = sub_pitch,
      flat_base = flat_base,
      minimium_size = minimium_size,
      pitch = pitch,
      positionGridx = positionGridx,
      positionGridy = positionGridy)
    pad_oversize(
      $pad_copy_size.x,
      $pad_copy_size.y,
      render_top = true,
      render_bottom = true);
  } else {
    total_units = $shared_width_grid_total_units;
    offset_units = $shared_width_grid_offset_units;

    // Work in sub-pitch cells, while pad_oversize remains expressed in full-pitch units.
    virtual_total = [total_units.x * sub_pitch, total_units.y * sub_pitch];
    virtual_offset = [offset_units.x * sub_pitch, offset_units.y * sub_pitch];
    virtual_size = [num_x * sub_pitch, num_y * sub_pitch];
    virtual_pitch = [pitch.x / sub_pitch, pitch.y / sub_pitch];

    x_cells = shared_grid_cells(virtual_total.x, positionGridx);
    y_cells = shared_grid_cells(virtual_total.y, positionGridy);

    for (xi = [0 : len(x_cells) - 1])
      for (yi = [0 : len(y_cells) - 1]) {
        global_x0 = shared_grid_prefix(x_cells, xi);
        global_y0 = shared_grid_prefix(y_cells, yi);
        global_x1 = global_x0 + x_cells[xi];
        global_y1 = global_y0 + y_cells[yi];

        part_x0 = virtual_offset.x;
        part_y0 = virtual_offset.y;
        part_x1 = part_x0 + virtual_size.x;
        part_y1 = part_y0 + virtual_size.y;

        overlap_x = interval_overlap(global_x0, global_x1, part_x0, part_x1);
        overlap_y = interval_overlap(global_y0, global_y1, part_y0, part_y1);

        // Render the complete virtual pad, then clip it to this part. Adjacent
        // parts therefore reconstruct the same pad geometry as one larger cup.
        // Do not apply minimumPrintablePadSize to a shared drawer grid.
        // Even a narrow fragment is part of the socket geometry in the matching
        // baseplate and must remain present for both layouts to be identical.
        if (overlap_x > 0.0001 && overlap_y > 0.0001)
          intersection() {
            translate([
              (global_x0 - part_x0) * virtual_pitch.x,
              (global_y0 - part_y0) * virtual_pitch.y,
              0
            ])
            pad_oversize(
              num_x = x_cells[xi] / sub_pitch,
              num_y = y_cells[yi] / sub_pitch,
              render_top = true,
              render_bottom = true);

            translate([-clip_fudge, -clip_fudge, -clip_fudge])
              cube([
                num_x * pitch.x + clip_fudge * 2,
                num_y * pitch.y + clip_fudge * 2,
                pitch.z
              ]);
          }
      }
  }
}


// -----------------------------------------------------------------------------
// Robust drawer-wide Gridfinity feet
// -----------------------------------------------------------------------------
// Build the complete male-foot layout with Gridfinity Extended's ORIGINAL
// pad_grid(). This is the same gridcopy/pad_oversize path used to make the
// female sockets in a regular baseplate. No internal module override is used.
module drawer_full_male_foot_grid() {
  drawer_units = [drawer_size_mm.x / pitch.x, drawer_size_mm.y / pitch.y];

  set_environment(
    width = [0, drawer_size_mm.x],
    depth = [0, drawer_size_mm.y],
    height = [1, 0],
    render_position = "zero",
    help = enable_help,
    pitch = pitch,
    clearance = clearance,
    cut = [0,0,0],
    setColour = "disabled",
    randomSeed = random_seed,
    force_render = force_render)
  pad_grid(
    num_x = drawer_units.x,
    num_y = drawer_units.y,
    sub_pitch = 1,
    flat_base = "off",
    minimium_size = 0,
    pitch = pitch,
    positionGridx = drawer_grid_alignment.x,
    positionGridy = drawer_grid_alignment.y);
}

// Extract exactly the global feet lying inside one drawer part, then translate
// that extraction back to the part's local [0,0] coordinate system.
module drawer_part_male_feet(column, segment) {
  part_origin_mm = [
    drawer_column_x_offset_mm(column),
    drawer_segment_y_offset_mm(column, segment)
  ];
  part_size_mm = [
    drawer_column_widths_mm[column],
    drawer_column_depths_mm[column][segment]
  ];
  z_clip_fudge = 0.02;

  translate([-part_origin_mm.x, -part_origin_mm.y, 0])
  intersection() {
    drawer_full_male_foot_grid();
    translate([
      part_origin_mm.x,
      part_origin_mm.y,
      -z_clip_fudge
    ])
      cube([
        part_size_mm.x,
        part_size_mm.y,
        drawer_body_join_z_mm + 1
      ]);
  }
}

// Generate the cup normally, but retain only the geometry above the local base
// foot region. This removes the library-generated local foot layout without
// disturbing the walls, cavity, lip, labels, or dividers.
module drawer_part_body(part_width_mm, part_depth_mm) {
  body_clip_fudge = 0.02;

  intersection() {
    configured_gridfinity_cup(
      model_width = [0, part_width_mm],
      model_depth = [0, part_depth_mm],
      model_render_position = "zero",
      shared_grid = false);

    translate([
      -body_clip_fudge,
      -body_clip_fudge,
      drawer_body_join_z_mm
    ])
      cube([
        part_width_mm + body_clip_fudge * 2,
        part_depth_mm + body_clip_fudge * 2,
        1000
      ]);
  }
}

module configured_gridfinity_cup(
  model_width,
  model_depth,
  model_render_position = "zero",
  shared_grid = false,
  shared_total_mm = [0, 0],
  shared_offset_mm = [0, 0]) {

  $shared_width_grid_enabled = shared_grid;
  $shared_width_grid_total_units = [shared_total_mm.x / pitch.x, shared_total_mm.y / pitch.y];
  $shared_width_grid_offset_units = [shared_offset_mm.x / pitch.x, shared_offset_mm.y / pitch.y];

  set_environment(
    width = model_width,
    depth = model_depth,
    height = height,
    height_includes_lip = height_includes_lip,
    lip_enabled = lip_style != "none",
    render_position = model_render_position,
    help = enable_help,
    pitch = pitch,
    clearance = clearance,
    cut = cut,
    setColour = set_colour,
    randomSeed = random_seed,
    force_render = force_render)
  gridfinity_cup(
    filled_in=filled_in,
    label_settings=LabelSettings(
      labelStyle=label_style,
      labelPosition=label_position,
      labelSize=label_size,
      labelRelief=label_relief,
      labelWalls=label_walls,
      labelDividers=label_dividers),
    finger_slide_settings = FingerSlideSettings(
      type = fingerslide,
      radius = fingerslide_radius,
      walls = fingerslide_walls,
      lip_aligned = fingerslide_lip_aligned),
    cupBase_settings = CupBaseSettings(
      magnetSize = enable_magnets?magnet_size:[0,0],
      magnetEasyRelease = magnet_easy_release,
      magnetSideAccess = magnet_side_access,
      magnetCaptiveHeight = magnet_captive_height,
      magnetCrushDepth = magnet_crush_depth,
      magnetChamfer = magnet_chamfer,
      centerMagnetSize = center_magnet_size,
      screwSize = enable_screws?screw_size:[0,0],
      holeOverhangRemedy = hole_overhang_remedy,
      cornerAttachmentsOnly = box_corner_attachments_only,
      floorThickness = floor_thickness,
      cavityFloorRadius = cavity_floor_radius,
      efficientFloor=efficient_floor,
      subPitch=sub_pitch,
      flatBase=flat_base,
      spacer=spacer,
      // Local cup generation is clipped above the foot zone in drawer mode.
      minimumPrintablePadSize = minimum_printable_pad_size,
      flatBaseRoundedRadius = flat_base_rounded_radius,
      flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint,
      alignGrid = shared_grid ? drawer_grid_alignment : [align_grid_x, align_grid_y]
      ),
    wall_thickness=wall_thickness,
    vertical_chambers = ChamberSettings(
      chambers_count = vertical_chambers,
      chamber_wall_thickness = chamber_wall_thickness,
      chamber_wall_headroom = chamber_wall_headroom,
      chamber_wall_top_radius = chamber_wall_top_radius,
      separator_bend_position = vertical_separator_bend_position,
      separator_bend_angle = vertical_separator_bend_angle,
      separator_bend_separation = vertical_separator_bend_separation,
      separator_cut_depth = vertical_separator_cut_depth,
      irregular_subdivisions = vertical_irregular_subdivisions,
      separator_config = vertical_separator_config),
    horizontal_chambers = ChamberSettings(
      chambers_count = horizontal_chambers,
      chamber_wall_thickness = chamber_wall_thickness,
      chamber_wall_headroom = chamber_wall_headroom,
      chamber_wall_top_radius = chamber_wall_top_radius,
      separator_bend_position = horizontal_separator_bend_position,
      separator_bend_angle = horizontal_separator_bend_angle,
      separator_bend_separation = horizontal_separator_bend_separation,
      separator_cut_depth = horizontal_separator_cut_depth,
      irregular_subdivisions = horizontal_irregular_subdivisions,
      separator_config = horizontal_separator_config),
    lip_settings = LipSettings(
      lipStyle=lip_style,
      lipSideReliefTrigger=lip_side_relief_trigger,
      lipTopReliefHeight=lip_top_relief_height,
      lipTopReliefWidth=lip_top_relief_width,
      lipNotch=lip_top_notches,
      lipClipPosition=lip_clip_position,
      lipNonBlocking=lip_non_blocking),
    headroom=headroom,
    tapered_corner=tapered_corner,
    tapered_corner_size = tapered_corner_size,
    tapered_setback = tapered_setback,
    wallpattern_walls=wallpattern_walls,
    wallpattern_dividers_enabled=wallpattern_dividers_enabled,
    wall_pattern_settings = PatternSettings(
      patternEnabled = wallpattern_enabled,
      patternStyle = wallpattern_style,
      patternRotate = wallpattern_rotate_grid,
      patternFill = wallpattern_fill,
      patternBorder = wallpattern_border,
      patternDepth = wallpattern_depth,
      patternCellSize = wallpattern_cell_size,
      patternHoleSides = wallpattern_hole_sides,
      patternStrength = wallpattern_strength,
      patternHoleRadius = wallpattern_hole_radius,
      patternGridChamfer = wallpattern_pattern_grid_chamfer,
      patternVoronoiNoise = wallpattern_pattern_voronoi_noise,
      patternBrickWeight = wallpattern_pattern_brick_weight,
      patternFs = wallpattern_pattern_quality,
      patternColored = wallpattern_colored),
    floor_pattern_settings = PatternSettings(
      patternEnabled = floorpattern_enabled,
      patternStyle = floorpattern_style,
      patternRotate = floorpattern_rotate_grid,
      patternFill = floorpattern_fill,
      patternBorder = floorpattern_border,
      patternDepth = floorpattern_depth,
      patternCellSize = floorpattern_cell_size,
      patternHoleSides = floorpattern_hole_sides,
      patternStrength = floorpattern_strength,
      patternHoleRadius = floorpattern_hole_radius,
      patternGridChamfer = floorpattern_pattern_grid_chamfer,
      patternVoronoiNoise = floorpattern_pattern_voronoi_noise,
      patternBrickWeight = floorpattern_pattern_brick_weight,
      patternFs = floorpattern_pattern_quality),
    wallcutout_vertical_settings = WallCutoutSettings(
      type = wallcutout_vertical,
      position = wallcutout_vertical_position,
      width = wallcutout_vertical_width,
      angle = wallcutout_vertical_angle,
      height = wallcutout_vertical_height,
      corner_radius = wallcutout_vertical_corner_radius),
    wallcutout_horizontal_settings = WallCutoutSettings(
      type = wallcutout_horizontal,
      position = wallcutout_horizontal_position,
      width = wallcutout_horizontal_width,
      angle = wallcutout_horizontal_angle,
      height = wallcutout_horizontal_height,
      corner_radius = wallcutout_horizontal_corner_radius),
    extendable_Settings = ExtendableSettings(
      extendablexEnabled = extension_x_enabled,
      extendablexPosition = extension_x_position,
      extendableyEnabled = extension_y_enabled,
      extendableyPosition = extension_y_position,
      extendableTabsEnabled = extension_tabs_enabled,
      extendableTabSize = extension_tab_size),
    sliding_lid_settings = SlidingLidSettings(
      enabled = sliding_lid_enabled,
      thickness = sliding_lid_thickness,
      min_wall_thickness = sliding_lid_min_wall_thickness,
      min_support = sliding_lid_min_support,
      clearance = sliding_lid_clearance,
      pull_style = sliding_lid_pull_style,
      nub_size = sliding_lid_nub_size),
    cupBaseTextSettings = CupBaseTextSettings(
      baseTextLine1Enabled = text_1,
      baseTextLine2Enabled = text_2,
      baseTextLine2Value = text_2_text,
      baseTextFontSize = text_size,
      baseTextFont = text_font,
      baseTextDepth = text_depth,
      baseTextOffset = text_offset));
}

module validate_drawer_layout() {
  assert(is_list(drawer_size_mm) && len(drawer_size_mm) == 2,
    "drawer_size_mm must be [width, depth]");
  assert(drawer_size_mm.x > 0 && drawer_size_mm.y > 0,
    "drawer_size_mm values must be greater than zero");
  assert(is_list(drawer_column_widths_mm) && len(drawer_column_widths_mm) > 0,
    "drawer_column_widths_mm must contain at least one column");
  assert(is_list(drawer_column_depths_mm),
    "drawer_column_depths_mm must be a list of depth lists");
  assert(len(drawer_column_widths_mm) == len(drawer_column_depths_mm),
    "drawer_column_widths_mm and drawer_column_depths_mm must have the same number of columns");
  assert(min(drawer_column_widths_mm) > 0,
    "Every drawer column width must be greater than zero");
  assert(abs(drawer_layout_width_mm() - drawer_size_mm.x) <= drawer_dimension_tolerance_mm,
    str("Column widths total ", drawer_layout_width_mm(),
        " mm, but drawer width is ", drawer_size_mm.x, " mm"));

  for (column = [0 : len(drawer_column_widths_mm) - 1]) {
    assert(is_list(drawer_column_depths_mm[column]) && len(drawer_column_depths_mm[column]) > 0,
      str("Column ", column, " must contain at least one depth segment"));
    assert(min(drawer_column_depths_mm[column]) > 0,
      str("Every depth in column ", column, " must be greater than zero"));
    assert(abs(drawer_column_depth_mm(column) - drawer_size_mm.y) <= drawer_dimension_tolerance_mm,
      str("Depths in column ", column, " total ", drawer_column_depth_mm(column),
          " mm, but drawer depth is ", drawer_size_mm.y, " mm"));
  }

  children();
}

module render_drawer_part(column, segment) {
  assert(sub_pitch == 1,
    "Drawer layout requires sub_pitch = 1 to match the baseplate");
  assert(flat_base == "off",
    "Drawer layout requires flat_base = off to match the Gridfinity baseplate");
  assert(!enable_magnets && !enable_screws && center_magnet_size == [0,0],
    "Drawer-wide replacement feet currently require magnets and screws disabled");
  assert(drawer_grid_alignment == ["near", "near"] || drawer_grid_alignment == ["far", "far"] ||
         drawer_grid_alignment == ["near", "far"] || drawer_grid_alignment == ["far", "near"],
    "drawer_grid_alignment must contain near/far values");
  assert(column >= 0 && column < len(drawer_column_widths_mm),
    "drawer_selected_column is outside drawer_column_widths_mm");
  assert(segment >= 0 && segment < len(drawer_column_depths_mm[column]),
    "drawer_selected_segment is outside the selected column");

  part_width_mm = drawer_column_widths_mm[column];
  part_depth_mm = drawer_column_depths_mm[column][segment];

  if (drawer_debug_feet_only) {
    drawer_part_male_feet(column, segment);
  } else {
    union() {
      drawer_part_body(part_width_mm, part_depth_mm);
      drawer_part_male_feet(column, segment);
    }
  }
}

module render_drawer_layout() {
  validate_drawer_layout() {
    mode = drawer_render_mode_id(drawer_render_mode);
    assert(mode >= 0 && mode <= 3,
      str("Invalid drawer_render_mode: ", drawer_render_mode,
          ". Use 0, 1, 2, or 3."));
    assert(drawer_assembled_gap_mm >= 0,
      "drawer_assembled_gap_mm must be zero or greater");
    assert(drawer_print_spacing_mm >= 0,
      "drawer_print_spacing_mm must be zero or greater");

    // Selected export: exactly one object at the origin.
    if (mode == 0) {
      render_drawer_part(drawer_selected_column, drawer_selected_segment);

    // Assembled but separated: preserves the visual arrangement while inserting
    // a real air gap at every internal seam. The STL contains seven disconnected
    // shells that slicers can split into separate objects.
    } else if (mode == 1) {
      for (column = [0 : len(drawer_column_widths_mm) - 1])
        for (segment = [0 : len(drawer_column_depths_mm[column]) - 1])
          translate([
            drawer_assembled_column_x_offset_mm(column),
            drawer_assembled_segment_y_offset_mm(column, segment),
            0
          ])
          render_drawer_part(column, segment);

    // Print-bed layout: larger configurable spacing.
    } else if (mode == 2) {
      for (column = [0 : len(drawer_column_widths_mm) - 1])
        for (segment = [0 : len(drawer_column_depths_mm[column]) - 1])
          translate([
            drawer_print_column_x_offset_mm(column),
            drawer_print_segment_y_offset_mm(column, segment),
            0
          ])
          render_drawer_part(column, segment);

    // Exact fit preview: no gaps. Do not use this mode for a multi-object STL,
    // because touching solids are normally unioned during CGAL/STL export.
    } else if (mode == 3) {
      for (column = [0 : len(drawer_column_widths_mm) - 1])
        for (segment = [0 : len(drawer_column_depths_mm[column]) - 1])
          translate([
            drawer_column_x_offset_mm(column),
            drawer_segment_y_offset_mm(column, segment),
            0
          ])
          render_drawer_part(column, segment);
    }
  }
}

if (drawer_layout_enabled)
  render_drawer_layout();
else
  configured_gridfinity_cup(
    model_width = width,
    model_depth = depth,
    model_render_position = render_position);

// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_block.scad>
use <modules/module_gridfinity_baseplate.scad>
use <modules/module_gridfinity_frame_connectors.scad>


/* [Drawer layout shared with custom cups] */
// Enable the 245 x 285 mm drawer layout used by gridfinity_basic_cup_drawer_layout.scad.
drawer_layout_enabled = true;
// Complete usable drawer area in millimetres: [width, depth].
drawer_size_mm = [245, 285]; //0.1
// Column widths. Must total drawer_size_mm.x.
drawer_column_widths_mm = [60, 80, 105]; //0.1
// Depth segments in each column. Every inner list must total drawer_size_mm.y.
drawer_column_depths_mm = [
  [150, 135],
  [150, 135],
  [120, 80, 85]
];
// full: one complete 245 x 285 plate
// selected: one section at the origin for STL export
// assembled: all sections in their real drawer positions
// print_layout: all sections separated on the print bed
drawer_render_mode = "assembled"; //[full, selected, assembled, print_layout]
// Zero-based section selected when drawer_render_mode = "selected".
drawer_selected_column = 0; //[0:1:20]
drawer_selected_segment = 0; //[0:1:20]
// Space between pieces in print_layout mode.
drawer_print_spacing_mm = 10; //0.1
// Optional physical gap between adjacent baseplate sections. Keep 0 for an exact reconstruction.
drawer_piece_gap_mm = 0; //0.01
// Tolerance used when validating dimension totals.
drawer_dimension_tolerance_mm = 0.01; //0.001

// Plate Style
Base_Plate_Options = "default";//[default:Efficient base, cnclaser:CNC or Laser cut]
// X dimension. grid units (multiples of 42mm) or mm.
Width = [3, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
Depth = [2, 0]; //0.1
oversize_method = "fill"; //[crop, fill]
position_fill_grid_x = "near";//[near:"← left", center:"↔ center", far:"→ right"]
position_fill_grid_y = "near";//[far:"↑ up", center:"↕ center", near:"↓ bottom"]
// X outer dimension. grid units (multiples of 42mm) or mm.
outer_Width = [0, 0]; //0.1
// Y outer dimension. grid units (multiples of 42mm) or mm.
outer_Depth = [0, 0]; //0.1
// z outer dimension. mm.
outer_Height = 0; //0.1
position_grid_in_outer_x = "center";//[near:"← left", center:"↔ center", far:"→ right"]
position_grid_in_outer_y = "center";//[far:"↑ up", center:"↕ center", near:"↓ bottom"]
//Reduce the frame wall size to this value
Reduced_Wall_Height = -1; //0.1
Reduced_Wall_Taper = false;
plate_corner_radius = 3.75; //0.01
//Corner radius for the inner corners (Works well with build_plate_enabled)
secondary_corner_radius = 3.75; //0.01

/* [Printer bed options] */
build_plate_enabled = "disabled";//[disabled, enabled, unique]
//spread out the plates, use if last row is small.
average_plate_sizes = false;
//Will split the plate in to the
build_plate_size = [200,250];

/* [Base Plate Options] */
// Enable magnets in the bin corner
Enable_Magnets = true;
//size of magnet, diameter and height. Zacks original used 6.5 and 2.4
Magnet_Size = [6.5, 2.4];  // .1
//raises the magnet, and creates a floor (for gluing)
Magnet_Z_Offset = 0;  // .1
//raises the magnet, and creates a ceiling to capture the magnet
Magnet_Top_Cover = 0;  // .1
// [Magnet Release Options]
// Method to help remove magnets: "none", "slot" (side pry), "hole" (poke from behind)
Magnet_Release_Method = "none"; //[none, slot, hole]
//Enable screws in the bin corner under the magnets
Corner_Screw_Enabled = false;
//Enable hold down screw in the center
Center_Screw_Enabled = false;
//Enable cavity to place frame weights
Enable_Weight = false;
//Removes the bottom taper
Remove_Bottom_Taper = false;

/* [Base Plate Clips]*/
Connector_Only = false;
Connector_Position = "center_wall"; //["center_wall","intersection","both"]

Connector_Clip_Enabled = false;
Connector_Clip_Size = 10;
Connector_Clip_Tolerance = 0.1;

//This feature is not yet finalised, or working properly.
Connector_Butterfly_Enabled = false;
Connector_Butterfly_Size = [5,4,1.5];
Connector_Butterfly_Radius = 0.1;
Connector_Butterfly_Tolerance = 0.1;

//This feature is not yet finalised, or working properly.
Connector_Filament_Enabled = false;
Connector_Filament_Diameter = 2;
Connector_Filament_Length = 8;

//This feature is not yet finalised, or working properly.
Connector_Snaps_Enabled = "disabled"; //["disabled","larger","smaller"]
Connector_Snaps_Clearance = 0.2;

/* [Custom Grid]*/
//Enable custom grid, you will configure this in the (Lid not supported)
Custom_Grid_Enabled = false;

//Custom gid sizes
//I am not sure it this is really useful, but its possible, so here we are.
//0:off the cell is off
//1:on the cell is on and all corners are rounded
//2-16, are bitwise values used to calculate what corners should be rounded, you need to subtract 2 from the value for the bitwise logic (so it does not clash with 0 and 1).
//[c,[x,y]], c corner value as shown above. [x,y] x and y size of the cell.
xpos1 = [3,[2,[3,3]],0,0,2,4,0];
xpos2 = [2,0,0,0,2,2,0];
xpos3 = [2,0,0,0,2,2,0];
xpos4 = [2,2,2,2,2,2,0];
xpos5 = [6,2,2,2,2,10,0];
xpos6 = [0,0,0,0,0,0,0];
xpos7 = [0,0,0,0,0,0,0];

/* [Model detail] */
//Work in progress,  Modify the default grid size. Will break compatibility
pitch = [42,42,7];  //[0:1:9999]
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// minimum size of a fragment.  Low is more fragments
fs = 0.1;
// number of fragments, overrides $fa and $fs
fn = 0;

/* [debug] */
Render_Position = "center"; //[default,center,zero]
// Debug slice
cut = [0,0,0]; //0.1
// enable loging of help messages during render.
enable_help = false;

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

function round_half_down(number, max_allowed) =
let (up = ceil(number), down = floor(number),
    result = (number - down <= 0.5 || up > max_allowed) ? down : up)
  echo("round_half_down", number=number, up=up, down=down, max_allowed=max_allowed, result=result, lessthan=number - down <= 0.5, upgreater=up > max_allowed)
  result;

function split_dimension(
    gf_size,                // The size of the grid (inner dimension of the grid area)
    gf_outer_size,          // The outer bounding size (outer dimension of the grid area)
    plate_size,           // The size of each plate or segment to split into
    position_fill_grid, //grid_alignment,         // Alignment of the grid within the bounding area ("near", "center", "far")
    position_grid_in_outer, //bounding_alignment,     // Alignment of the bounding area relative to the grid ("near", "center", "far")
    average_plate_sizes = false // Whether to average the sizes of the segments
) =
  assert(is_num(gf_size), "gf_size must be a number")
  assert(is_num(gf_outer_size), "gf_outer_size must be a number")
  assert(is_num(plate_size), "plate_size must be a number")
  assert(is_string(position_fill_grid), "position_fill_grid must be a string")
  assert(is_string(position_grid_in_outer), "position_grid_in_outer must be a string")
  let(
    // Determine the larger size between gf_size and gf_outer_size
    totalOuterSize = gf_outer_size > gf_size ? gf_outer_size : gf_size,
    outerPadding = max(0, totalOuterSize - gf_size),

    // Calculate offsets based on position,
    //only used on first plate
    outerPrefix =
      position_grid_in_outer == "far" ? outerPadding :
      position_grid_in_outer == "center" ? outerPadding/2 : 0,
    gridPrefix=
      position_fill_grid == "near" ? gf_size - floor(gf_size) :
      position_fill_grid == "center" ? (gf_size - floor(gf_size))/2 : 0,

    // Calculate the number of plates and average sizes
    platesRemaining = ceil(totalOuterSize/plate_size),
    avgOuter = platesRemaining > 1 && average_plate_sizes ? totalOuterSize/platesRemaining : plate_size,
    //avgSize = platesRemaining > 1 && average_plate_sizes ? gf_size/platesRemaining : plate_size,
    max_allowed_grid_size = min(gf_size, plate_size-outerPrefix),

    // Calculate the size and outer size for the this plate
    current_grid_size = totalOuterSize <= plate_size
      ? gf_size
      : gridPrefix + max(0, round_half_down(min(gf_size, avgOuter-outerPrefix-gridPrefix), max_allowed =plate_size-outerPrefix-gridPrefix)),
    current_outer_size = totalOuterSize <= plate_size
      ? totalOuterSize
      : current_grid_size + outerPrefix,

    // Calculate the remaining size and outer size
    remSize = max(0, gf_size - current_grid_size),
    remOuter = max(0, totalOuterSize - current_outer_size)
  )
  echo("🟪split_dimension", gf_size=gf_size, position_fill_grid=position_fill_grid, plate_size=plate_size, platesRemaining=platesRemaining, gridPrefix=gridPrefix, current_grid_size=current_grid_size, remSize=remSize, max_allowed_grid_size=max_allowed_grid_size)
  echo("split_dimension", gf_outer_size=gf_outer_size, position_grid_in_outer=position_grid_in_outer, plate_size=plate_size, platesRemaining=platesRemaining, avgOuter=avgOuter, outerPrefix=outerPrefix, current_outer_size=current_outer_size, remOuter=remOuter)
  assert(current_outer_size > 0)
  let(
    next = remSize > 0 || remOuter > 0 ? split_dimension(remSize, remOuter, plate_size, "far", "near", average_plate_sizes): [],
    posOuter = position_grid_in_outer == "center" && totalOuterSize > plate_size ? "far" : position_grid_in_outer,
    posGrid =  position_fill_grid == "center" && gf_size > plate_size ? "near" : position_fill_grid
  )
  echo("split_dimension", next=next, posOuter=posOuter, posGrid=posGrid, current_grid_size=current_grid_size, current_outer_size=current_outer_size)
  concat([[current_grid_size, posGrid, current_outer_size <= current_grid_size ? 0 : current_outer_size, posOuter]], next);

function split_plate(num_x, num_y,
    outer_num_x,
    outer_num_y,
    position_fill_grid_x,
    position_fill_grid_y,
    position_grid_in_outer_x,
    position_grid_in_outer_y,
    build_plate_size,
    average_plate_sizes) =
  let(
    max_x = build_plate_size.x/env_pitch().x,
    max_y = build_plate_size.y/env_pitch().y,
    list_x = split_dimension(num_x, outer_num_x, max_x, position_fill_grid_x, position_grid_in_outer_x, average_plate_sizes),
    list_y = split_dimension(num_y, outer_num_y, max_y, position_fill_grid_y, position_grid_in_outer_y, average_plate_sizes),
    list = [for(iy=[0:len(list_y)-1]) [for(ix=[0:len(list_x)-1]) [[ix,iy], [list_x[ix],list_y[iy]]]]])
    [for(iy=[0:len(list)-1]) [for(ix=[0:len(list[iy])-1]) let(plate = list[iy][ix]) [plate[0], plate[1], check_plate_duplicate_y(plate, list)]]];


function check_plate_duplicate_y(plate, plate_list, y = 0, end) =
  assert(is_list(plate), "plate must be a list")
  assert(is_list(plate_list), "plate_list must be a list")
  assert(is_num(y), "y must be a number")
  let(end = is_undef(end) ? len(plate_list) : end)
    y > len(plate_list) - 1 || y > end ? false
    : check_plate_duplicate_x(plate, plate_list[y])
    || check_plate_duplicate_y(plate, plate_list, y = y+1);

function check_plate_duplicate_x(plate, plate_list_y, x = 0, end) =
  assert(is_list(plate), "plate must be a list")
  assert(is_list(plate_list_y), "plate_list_y must be a list")
  assert(is_num(x), "x must be a number")
  //echo("check_plate_duplicate_x", plate=plate)
  let(end = is_undef(end) ? len(plate_list_y) : end)
  x > len(plate_list_y) - 1 || x > end ? false
  : let(comparePlate = plate_list_y[x],
    isDupe = (comparePlate[0][0] < plate[0][0] ||
      (comparePlate[0][0] == plate[0][0] && comparePlate[0][1] < plate[0][1])) &&
      plate[1][0][iPlate_size] == comparePlate[1][0][iPlate_size] &&
      (plate[1][0][iPlate_size] == floor(plate[1][0][iPlate_size]) || plate[1][0][iPlate_posGrid] == comparePlate[1][0][iPlate_posGrid]) &&
      plate[1][0][iPlate_outerSize] == comparePlate[1][0][iPlate_outerSize] &&
      (plate[1][0][iPlate_outerSize] == 0 || plate[1][0][iPlate_posOuter] == comparePlate[1][0][iPlate_posOuter]) &&
      plate[1][1][iPlate_size] == comparePlate[1][1][iPlate_size] &&
      (plate[1][1][iPlate_size] == floor(plate[1][1][iPlate_size]) || plate[1][1][iPlate_posGrid] == comparePlate[1][1][iPlate_posGrid]) &&
      plate[1][1][iPlate_outerSize] == comparePlate[1][1][iPlate_outerSize] &&
      (plate[1][1][iPlate_outerSize] == 0 || plate[1][1][iPlate_posOuter] == comparePlate[1][1][iPlate_posOuter]))
    isDupe || check_plate_duplicate_x(plate, plate_list_y, x = x+1, end);

iPlate_size = 0;
iPlate_posGrid = 1;
iPlate_outerSize = 2;
iPlate_posOuter = 3;


// -----------------------------------------------------------------------------
// Arbitrary 2D drawer baseplate support
// -----------------------------------------------------------------------------

function drawer_list_sum(values, count = undef, index = 0, total = 0) =
  let(limit = is_undef(count) ? len(values) : min(max(count, 0), len(values)))
  index >= limit ? total : drawer_list_sum(values, limit, index + 1, total + values[index]);

function drawer_column_x_offset_mm(column) = drawer_list_sum(drawer_column_widths_mm, column);
function drawer_segment_y_offset_mm(column, segment) =
  drawer_list_sum(drawer_column_depths_mm[column], segment);
function drawer_layout_width_mm() = drawer_list_sum(drawer_column_widths_mm);
function drawer_column_depth_mm(column) = drawer_list_sum(drawer_column_depths_mm[column]);
function drawer_print_column_x_offset_mm(column) =
  drawer_column_x_offset_mm(column) + column * drawer_print_spacing_mm;
function drawer_print_segment_y_offset_mm(column, segment) =
  drawer_segment_y_offset_mm(column, segment) + segment * drawer_print_spacing_mm;

// Insets are [left, front, right, back]. Half of drawer_piece_gap_mm is removed
// from each side of an internal seam, while the outside drawer perimeter remains exact.
function drawer_piece_insets_mm(column, segment) = [
  column > 0 ? drawer_piece_gap_mm / 2 : 0,
  segment > 0 ? drawer_piece_gap_mm / 2 : 0,
  column < len(drawer_column_widths_mm) - 1 ? drawer_piece_gap_mm / 2 : 0,
  segment < len(drawer_column_depths_mm[column]) - 1 ? drawer_piece_gap_mm / 2 : 0
];

function drawer_piece_origin_mm(column, segment) =
  let(insets = drawer_piece_insets_mm(column, segment))
  [
    drawer_column_x_offset_mm(column) + insets[0],
    drawer_segment_y_offset_mm(column, segment) + insets[1]
  ];

function drawer_piece_size_mm(column, segment) =
  let(insets = drawer_piece_insets_mm(column, segment))
  [
    drawer_column_widths_mm[column] - insets[0] - insets[2],
    drawer_column_depths_mm[column][segment] - insets[1] - insets[3]
  ];

module validate_drawer_baseplate_layout() {
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
  assert(drawer_piece_gap_mm >= 0,
    "drawer_piece_gap_mm must not be negative");
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

    for (segment = [0 : len(drawer_column_depths_mm[column]) - 1]) {
      size_mm = drawer_piece_size_mm(column, segment);
      assert(size_mm.x > 0 && size_mm.y > 0,
        str("drawer_piece_gap_mm is too large for section [", column, ", ", segment, "]"));
    }
  }

  children();
}

// Reproduce the exact fractional-cell ordering used by the custom cup script.
// This is intentionally duplicated here so both files use the same deterministic
// global cell map instead of relying on the baseplate module's internal placement.
function drawer_shared_grid_cells(total_units, alignment = "near") =
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

function drawer_shared_grid_prefix(cells, count, index = 0, total = 0) =
  index >= count
    ? total
    : drawer_shared_grid_prefix(cells, count, index + 1, total + cells[index]);

// Generate one baseplate socket cell at an explicit global position.
// The custom cups generate one pad_oversize() object for the same cell rectangle.
// Generating the female cell independently prevents gridfinity_baseplate() from
// re-arranging fractional cells internally.
module drawer_baseplate_cell(cell_units, cell_index, cell_count) {
  xi = cell_index.x;
  yi = cell_index.y;
  nx = cell_count.x;
  ny = cell_count.y;

  set_environment(
    width = cell_units.x,
    depth = cell_units.y,
    render_position = "zero",
    pitch = pitch,
    help = enable_help,
    cut = cut)
  gridfinity_baseplate(
    num_x = cell_units.x,
    num_y = cell_units.y,
    outer_num_x = 0,
    outer_num_y = 0,
    outer_height = outer_Height,
    // Each generated object is already exactly one shared cell. Do not let the
    // library move a fractional remainder within that object.
    position_fill_grid_x = "near",
    position_fill_grid_y = "near",
    position_grid_in_outer_x = "near",
    position_grid_in_outer_y = "near",
    plate_corner_radius = plate_corner_radius,
    secondary_corner_radius = secondary_corner_radius,
    corner_roles = [
      xi == 0 && yi == 0 ? 1 : 0,           // bottom-left
      xi == 0 && yi == ny - 1 ? 1 : 0,      // top-left
      xi == nx - 1 && yi == 0 ? 1 : 0,      // bottom-right
      xi == nx - 1 && yi == ny - 1 ? 1 : 0  // top-right
    ],
    magnetSize = Enable_Magnets ? Magnet_Size : [0, 0],
    magnetZOffset = Magnet_Z_Offset,
    magnetTopCover = Magnet_Top_Cover,
    magnetReleaseMethod = Magnet_Release_Method,
    reducedWallHeight = Reduced_Wall_Height,
    reduceWallTaper = Reduced_Wall_Taper,
    cornerScrewEnabled = Corner_Screw_Enabled,
    centerScrewEnabled = Center_Screw_Enabled,
    weightedEnable = Enable_Weight,
    oversizeMethod = "fill",
    plateOptions = Base_Plate_Options,
    customGridEnabled = false,
    gridPositions = [[1]],
    remove_bottom_taper = Remove_Bottom_Taper,
    // Frame connectors cannot be generated per socket without duplicates.
    // Keep them disabled in the shared-grid baseplate.
    frameConnectorSettings = FrameConnectorSettings(
      connectorOnly = false,
      connectorPosition = Connector_Position,
      connectorClipEnabled = false,
      connectorClipSize = Connector_Clip_Size,
      connectorClipTolerance = Connector_Clip_Tolerance,
      connectorButterflyEnabled = false,
      connectorButterflySize = Connector_Butterfly_Size,
      connectorButterflyRadius = Connector_Butterfly_Radius,
      connectorButterflyTolerance = Connector_Butterfly_Tolerance,
      connectorFilamentEnabled = false,
      connectorFilamentDiameter = Connector_Filament_Diameter,
      connectorFilamentLength = Connector_Filament_Length,
      connectorSnapsStyle = "disabled",
      connectorSnapsClearance = Connector_Snaps_Clearance));
}

// Build the complete drawer base from the same global cell rectangles used by
// gridfinity_basic_cup_drawer_layout.scad::pad_grid(). For the configured drawer:
// X = [42, 42, 42, 42, 42, 35] mm
// Y = [42, 42, 42, 42, 42, 42, 33] mm
module drawer_full_baseplate() {
  drawer_units = [drawer_size_mm.x / pitch.x, drawer_size_mm.y / pitch.y];
  x_cells = drawer_shared_grid_cells(drawer_units.x, position_fill_grid_x);
  y_cells = drawer_shared_grid_cells(drawer_units.y, position_fill_grid_y);

  echo("Shared baseplate X cells (Gridfinity units)", x_cells);
  echo("Shared baseplate Y cells (Gridfinity units)", y_cells);

  union()
    for (xi = [0 : len(x_cells) - 1])
      for (yi = [0 : len(y_cells) - 1])
        let(
          x0_units = drawer_shared_grid_prefix(x_cells, xi),
          y0_units = drawer_shared_grid_prefix(y_cells, yi)
        )
        translate([x0_units * pitch.x, y0_units * pitch.y, 0])
          drawer_baseplate_cell(
            cell_units = [x_cells[xi], y_cells[yi]],
            cell_index = [xi, yi],
            cell_count = [len(x_cells), len(y_cells)]);
}

// Clip a section from the complete baseplate, then optionally move its local
// lower-left corner to [0,0] so it can be exported as an independent STL.
module drawer_baseplate_section(column, segment, localize = true) {
  assert(column >= 0 && column < len(drawer_column_widths_mm),
    "drawer_selected_column is outside drawer_column_widths_mm");
  assert(segment >= 0 && segment < len(drawer_column_depths_mm[column]),
    "drawer_selected_segment is outside the selected column");

  origin_mm = drawer_piece_origin_mm(column, segment);
  size_mm = drawer_piece_size_mm(column, segment);
  clip_z_min = -50;
  clip_height = 150;

  translate(localize ? [-origin_mm.x, -origin_mm.y, 0] : [0, 0, 0])
  intersection() {
    drawer_full_baseplate();
    translate([origin_mm.x, origin_mm.y, clip_z_min])
      cube([size_mm.x, size_mm.y, clip_height]);
  }
}

module render_drawer_baseplate_layout() {
  validate_drawer_baseplate_layout() {
    if (drawer_render_mode == "full") {
      drawer_full_baseplate();

    } else if (drawer_render_mode == "selected") {
      drawer_baseplate_section(drawer_selected_column, drawer_selected_segment);

    } else if (drawer_render_mode == "assembled") {
      for (column = [0 : len(drawer_column_widths_mm) - 1])
        for (segment = [0 : len(drawer_column_depths_mm[column]) - 1])
          let(origin_mm = drawer_piece_origin_mm(column, segment))
          translate([origin_mm.x, origin_mm.y, 0])
            drawer_baseplate_section(column, segment);

    } else if (drawer_render_mode == "print_layout") {
      for (column = [0 : len(drawer_column_widths_mm) - 1])
        for (segment = [0 : len(drawer_column_depths_mm[column]) - 1]) {
          insets = drawer_piece_insets_mm(column, segment);
          translate([
            drawer_print_column_x_offset_mm(column) + insets[0],
            drawer_print_segment_y_offset_mm(column, segment) + insets[1],
            0
          ])
          drawer_baseplate_section(column, segment);
        }

    } else {
      assert(false,
        "drawer_render_mode must be full, selected, assembled, or print_layout");
    }
  }
}

if(drawer_layout_enabled)
{
  render_drawer_baseplate_layout();
}
else if(Connector_Only)
{
  if(Connector_Clip_Enabled) {
    ClipConnector(
      size=Connector_Clip_Size,
      clearance = Connector_Clip_Tolerance,
      fullIntersection = true);

    translate([0,15,0])
    ClipConnector(
      size=Connector_Clip_Size,
      straightIntersection = true,
      clearance = Connector_Clip_Tolerance);

    translate([0,30,0])
    ClipConnector(
      size=Connector_Clip_Size,
      straightWall = true,
      clearance = Connector_Clip_Tolerance);
  }

  if(Connector_Butterfly_Enabled)
  translate([20,0,0])
  ButterFlyConnector(
    size=[
      Connector_Butterfly_Size.x-Connector_Butterfly_Tolerance,
      Connector_Butterfly_Size.y-Connector_Butterfly_Tolerance,
      Connector_Butterfly_Size.z-Connector_Butterfly_Tolerance],
    r=Connector_Butterfly_Radius);
}
else
{
  plate_list = let(
      num_x=calcDimensionWidth(Width),
      num_y=calcDimensionDepth(Depth),
      outer_num_x = calcDimensionWidth(outer_Width),
      outer_num_y = calcDimensionWidth(outer_Depth))
    (build_plate_enabled == "disabled" || build_plate_size.x <= 0 || build_plate_size.y <= 0)
    ? [[[[0,0], [[num_x, position_fill_grid_x, outer_num_x, position_grid_in_outer_x],
       [num_y, position_fill_grid_y, outer_num_y, position_grid_in_outer_y]], false]]]
    :split_plate(
      num_x=num_x,
      num_y=num_y,
      outer_num_x = outer_num_x,
      outer_num_y = outer_num_y,
      position_fill_grid_x = position_fill_grid_x,
      position_fill_grid_y = position_fill_grid_y,
      position_grid_in_outer_x = position_grid_in_outer_x,
      position_grid_in_outer_y = position_grid_in_outer_y,
      build_plate_size= build_plate_size,
      average_plate_sizes=average_plate_sizes);

  for(iy=[0:len(plate_list)-1])
  let(listy = plate_list[iy])
  for(ix=[0:len(listy)-1]) {
  plate = listy[ix];
  pos = [
    ix*build_plate_size.x*1.1+ix*5,
    iy*build_plate_size.y*1.1+iy*5,
    0];
  if(build_plate_enabled == "unique" && !plate[2] || build_plate_enabled != "unique")
  color_conditional(len(plate_list) > 1, plate[2] ? "#404040" : "#006400")
  translate(pos)
  render_conditional(len(plate_list) > 1)//plate[2])
  set_environment(
    width = plate[1].x[iPlate_size],
    depth = plate[1].y[iPlate_size],
    render_position = Render_Position,
    pitch = pitch,
    help = enable_help,
    cut = cut)
    gridfinity_baseplate(
      num_x = plate[1].x[iPlate_size],//calcDimensionWidth(Width),
      num_y = plate[1].y[iPlate_size],//calcDimensionWidth(Depth),
      outer_num_x = plate[1].x[iPlate_outerSize], //calcDimensionWidth(outer_Width),
      outer_num_y = plate[1].y[iPlate_outerSize], //calcDimensionWidth(outer_Depth),
      outer_height = outer_Height,
      position_fill_grid_x = plate[1].x[iPlate_posGrid], //position_fill_grid_x,
      position_fill_grid_y = plate[1].y[iPlate_posGrid], //position_fill_grid_y,
      position_grid_in_outer_x = plate[1].x[iPlate_posOuter], //position_grid_in_outer_x,
      position_grid_in_outer_y = plate[1].y[iPlate_posOuter], //position_grid_in_outer_y,
      plate_corner_radius = plate_corner_radius,
      secondary_corner_radius = secondary_corner_radius,
      corner_roles = let(
          nx=len(listy),
          ny=len(plate_list)
        ) [
          (ix==0 && iy==0) ? 1 : 0,       // BL (0,0) -> 0
          (ix==0 && iy==ny-1) ? 1 : 0,    // TL (0,1) -> 1
          (ix==nx-1 && iy==0) ? 1 : 0,    // BR (1,0) -> 2
          (ix==nx-1 && iy==ny-1) ? 1 : 0   // TR (1,1) -> 3
        ],
      magnetSize = Enable_Magnets ? Magnet_Size : [0,0],
      magnetZOffset = Magnet_Z_Offset,
      magnetTopCover=Magnet_Top_Cover,
      magnetReleaseMethod = Magnet_Release_Method,
      reducedWallHeight = Reduced_Wall_Height,
      reduceWallTaper = Reduced_Wall_Taper,
      cornerScrewEnabled  = Corner_Screw_Enabled,
      centerScrewEnabled = Center_Screw_Enabled,
      weightedEnable = Enable_Weight,
      oversizeMethod=oversize_method,
      plateOptions = Base_Plate_Options,
      customGridEnabled = Custom_Grid_Enabled,
      gridPositions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
      remove_bottom_taper=Remove_Bottom_Taper,
      frameConnectorSettings = FrameConnectorSettings(
        connectorOnly = Connector_Only,
        connectorPosition = Connector_Position,
        connectorClipEnabled = Connector_Clip_Enabled,
        connectorClipSize = Connector_Clip_Size,
        connectorClipTolerance = Connector_Clip_Tolerance,
        connectorButterflyEnabled = Connector_Butterfly_Enabled,
        connectorButterflySize = Connector_Butterfly_Size,
        connectorButterflyRadius = Connector_Butterfly_Radius,
        connectorButterflyTolerance = Connector_Butterfly_Tolerance,
        connectorFilamentEnabled = Connector_Filament_Enabled,
        connectorFilamentDiameter = Connector_Filament_Diameter,
        connectorFilamentLength = Connector_Filament_Length,
        connectorSnapsStyle = Connector_Snaps_Enabled,
        connectorSnapsClearance = Connector_Snaps_Clearance)
    );
  }
}

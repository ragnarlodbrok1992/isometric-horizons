#import "Basic";
#import "GL";

IsoTile :: struct {
  // Simple ID for now
  id : int;

  // Buffers
  vertex_buffer_vertices_data : [12]GLfloat;
  vertex_buffer_colors_data   : [12]GLfloat;
  line_buffer_colors_data     : [12]GLfloat;
  line_buffer_vertices_data   : [12]GLfloat;

  // Vertices
  vertex_buffer_vertices : GLuint;
  vertex_buffer_colors   : GLuint;
  line_buffer_vertices   : GLuint;
  line_buffer_colors     : GLuint;
}

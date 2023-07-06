// Basic top level imports
#import "Basic";
#import "SDL";
#import "GL";

// Top level imports - isometric horizons stuff
#load "shaders.jai";
#load "camera.jai";
#load "iso_tile.jai";

// Named imports
Simp :: #import "Simp";

// Engine variables - we are making game but still
QUIT := false; // If true - exit the engine
MAIN_ENGINE_WINDOW : *void; // Where does it live in memory?

// Consts
WINDOW_TITLE_BAR : *u8 = "Isometric Horizons";
WINDOW_WIDTH := 1024;
WINDOW_HEIGHT := 768;

main :: () {
  print("Hello, Isometric Horizons!\n");

  // Debug filepath
  print("Filepath: %\n", #filepath);

  // Some start stuff
  #if OS == .WINDOWS {
    win32 :: #import "Windows";
    win32.SetProcessDPIAware();
  }

  // Not getting command line arguments for now

  // Engine initialization
  SDL_Init(SDL_INIT_VIDEO);

  MAIN_ENGINE_WINDOW := SDL_CreateWindow(WINDOW_TITLE_BAR, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, xx WINDOW_WIDTH, xx WINDOW_HEIGHT, SDL_WINDOW_OPENGL|SDL_WINDOW_RESIZABLE);
  print("Main engine window: %, type_of: %\n", MAIN_ENGINE_WINDOW, type_of(MAIN_ENGINE_WINDOW));
  if MAIN_ENGINE_WINDOW == null {
    print("Could not create window: %\n", to_string(SDL_GetError()));
    return;
  }

  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, xx SDL_GL_CONTEXT_PROFILE_CORE);

  gl_context := SDL_GL_CreateContext(MAIN_ENGINE_WINDOW);

  if !gl_context {
    print("Could not create OpenGL context: %\n", to_string(SDL_GetError()));
    return;
  }

  gl_load(*gl, SDL_GL_GetProcAddress);
  using gl;
  
  print("GL Vendor = %\n", to_string(glGetString(GL_VENDOR)));
  print("GL Version = %\n", to_string(glGetString(GL_VERSION)));

  // Setting up OpenGL
  glEnable(GL_DEPTH_TEST);

  // Setup simp stuff for getting rect?
  Simp.set_render_target(MAIN_ENGINE_WINDOW);

  // @TODO: initializing fonts I think we should be doing here
  // use function get_font_at_size

  // Loading shaders
  shaders_program_id := load_shaders();

  // Defering stuff
  defer SDL_DestroyWindow(MAIN_ENGINE_WINDOW);
  defer SDL_Quit();

  // Make main loop

  while !QUIT {
    event : SDL_Event;

    while SDL_PollEvent(*event) {
      if event.type == {
        case SDL_QUIT;
          QUIT = true;
        case SDL_KEYDOWN;
          if event.key.keysym.sym == SDLK_ESCAPE QUIT = true;
      }
    }
  }

}

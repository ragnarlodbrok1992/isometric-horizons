#run build();


build :: () {
  // Creating workspace
  w := compiler_create_workspace("Target Program");

  // Getting build options
  options := get_build_options();
  options.output_executable_name = "isometric-horizons";
  set_optimization(*options, .DEBUG);
  set_build_options(options, w);

  // Begin intercepting messages
  compiler_begin_intercept(w);

  // Adding code
  // Every file should be added here?
  add_build_file(tprint("%/src/main.jai", #filepath), w);

  // Looping over incoming mesages
  message_loop();

  // End compiler intercepting
  compiler_end_intercept(w);

  // Do not emit code for this program
  set_build_options_dc(.{do_output=false});
  
}

message_loop :: () {
  // It's inside a loop

  while true {
    // Waiting for message
    message := compiler_wait_for_message();

    if message.kind == {
      case .IMPORT;
        // Only checking for importing files -- we will extend compiler messages further in development
        import := cast(*Message_Import) message;
        print("  Importing module '%'.\n", import.module_name);

      case .COMPLETE;
        break;
    }
  }
}


#import "Basic";
#import "Compiler";

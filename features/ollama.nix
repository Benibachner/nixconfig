{ ... }:
{
  flake.nixosModules.ollama =
    { pkgs, lib, ... }:
    {
      services.ollama = {
        enable = true;
        package = pkgs.ollama-rocm;
        loadModels = [ "gemma4:26b-a4b-it-q4_K_M" ];
        environmentVariables = {
          HCC_AMDGPU_TARGET = "gfx1103"; # used to be necessary, but doesn't seem to anymore
        };
        rocmOverrideGfx = "11.0.0";
        # environmentVariables.OLLAMA_CONTEXT_LENGTH = "32768";
      };
    };
}

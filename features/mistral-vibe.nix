{ ... }:
{
  flake.homeModules.mistral-vibe =
    { pkgs, lib, ... }:
    {
      imports = [

      ];

      programs.mistral-vibe = {
        enable = true;
        settings = {
          active_model = "qwen3-coder:latest";
          providers = [
            {
              name = "ollama";
              backend = "generic";
              api_base = "http://127.0.0.1:11434/v1";
              api_key_env_var = "";
              api_style = "openai";
            }
          ];
          models = [
            {
              name = "qwen3-coder:latest";
              provider = "ollama";
              alias = "qwen3-coder:latest";
              temperature = 0.2;
              input_price = 0.0;
              output_price = 0.0;
            }
          ];
        };
      };
    };
}

{
  description = ''measuring execution times written in nim.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-timeit-v0_2_2.flake = false;
  inputs.src-timeit-v0_2_2.owner = "xflywind";
  inputs.src-timeit-v0_2_2.ref   = "refs/tags/v0.2.2";
  inputs.src-timeit-v0_2_2.repo  = "timeit";
  inputs.src-timeit-v0_2_2.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-timeit-v0_2_2"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-timeit-v0_2_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
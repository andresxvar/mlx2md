% MLX2MD
% for example use mlx2md in the folder where MLX files are
% or use mlx2md("myfolder/test*.mlx") to find MLX files
% this function takes care of running the export, latex2markdown and delete commands
function mlx2md(mlxfilename)
arguments
    mlxfilename = "*.mlx";
end
if ~endsWith(mlxfilename,".mlx",IgnoreCase=true)
    mlxfilename = mlxfilename + ".mlx";
end

mlxfiles = dir(mlxfilename);
mlxfiles = struct2table(mlxfiles);
mlxfiles.fullfilename = string(fullfile(mlxfiles.folder,mlxfiles.name));

for mlxfile = mlxfiles.fullfilename'
    texfile = extractBefore(mlxfile, strlength(mlxfile)-3) + ".tex";
    export(mlxfile,texfile);
    latex2markdown(texfile);
    delete(texfile);
    delete("matlab.sty");
end
end
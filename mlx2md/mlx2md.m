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
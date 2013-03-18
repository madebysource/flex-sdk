package flex.ant.types;

import java.io.File;
import java.util.ArrayList;

import org.apache.tools.ant.types.Commandline;
import org.apache.tools.ant.util.FileUtils;

import flex.ant.config.OptionSpec;

public class FlexSwcFileSet extends FlexFileSet 
{
	public FlexSwcFileSet(OptionSpec spec, boolean dirs)
	{
		super(spec, dirs);
	}

	// Only accept directories, and *.swc files
    protected void addFiles(File base, String[] files, Commandline cmdl)
    {
        FileUtils utils = FileUtils.getFileUtils();
 
        for (int i = 0; i < files.length; ++i)
        {
            File f = utils.resolveFile(base, files[i]);
            String absolutePath = f.getAbsolutePath();

            if( f.isFile() && !absolutePath.endsWith(".swc") )
            	continue;

            if (spec != null)
            {
                cmdl.createArgument().setValue("-" + spec.getFullName() + equalString() + absolutePath);
            }
            else
            {
                cmdl.createArgument().setValue(absolutePath);
            }
        }    
    }

}

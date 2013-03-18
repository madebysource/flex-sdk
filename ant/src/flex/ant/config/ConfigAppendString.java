////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package flex.ant.config;

import org.apache.tools.ant.types.Commandline;

/**
 * Extends ConfigString by overriding addToCommandline to use +foo=bar
 * syntax to support appending the configuration option to any
 * existing values.
 */
public class ConfigAppendString extends ConfigString
{
    public ConfigAppendString(OptionSpec option)
    {
        super(option);
    }

    public ConfigAppendString(OptionSpec option, String value)
    {
        super(option, value);
    }

    public void addToCommandline(Commandline cmdl)
    {
        String value = value();

        if ((value != null) && (value.length() > 0))
        {
            cmdl.createArgument().setValue("+" + spec.getFullName() + "=" + value);
        }
    }
}

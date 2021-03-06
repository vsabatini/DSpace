/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package it.cineca.surplus.ir.defaultvalues;

import org.dspace.content.Item;

public interface EnhancedValuesGenerator
{
    public DefaultValuesBean generateValues(Item item, String schema, String element, String qualifier, String value);
}

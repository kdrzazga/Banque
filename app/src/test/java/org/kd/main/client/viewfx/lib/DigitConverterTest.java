package org.kd.main.client.viewfx.lib;

import org.junit.experimental.categories.Category;
import org.junit.jupiter.api.Test;
import org.kd.main.categories.UnitTests;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class DigitConverterTest {

    @Test
    @Category(UnitTests.class)
    public void testRemoveExtraDot() {
        assertEquals("2.14", DigitConverter.removeExtraDots("2.14.14"));
        assertEquals("1.22", DigitConverter.removeExtraDots("1.22.333.4444.55555"));
        assertEquals("1.", DigitConverter.removeExtraDots("1......22"));
        assertEquals(".", DigitConverter.removeExtraDots(".....1"));
    }
}

/*   Copyright 2019 Sergei Munovarov
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */

 using Toybox.Test;
 using Format;

(:test)
module FormatTests {

    (:test)
    function formatDecimalValue(logger) {
        var actual = Format.formatPrice(141, "ETH:USD");
        logger.debug("Actual:" + actual);

        Test.assertEqual(actual, "141.00");
        return true;
    }

    (:test)
    function formatNonDecimalValue(logger) {
        var actual = Format.formatPrice(200.51, "ETH:USD");
        logger.debug("Actual:" + actual);

        Test.assertEqual(actual, "200.51");
        return true;
    }

    (:test)
    function formatNonDecimalValue2(logger) {
        var actual = Format.formatPrice(200.5, "ETH:USD");
        logger.debug("Actual:" + actual);

        Test.assertEqual(actual, "200.50");
        return true;
    }

    (:test)
    function formatBTCPrice(logger) {
        var actual = Format.formatPrice(20000.1, "BTC:USD");
        logger.debug("Actual:" + actual);

        Test.assertEqual(actual, "20000.1");
        return true;
    }

    (:test)
    function formatGUSDPrice(logger) {
        var actual = Format.formatPrice(1.012, "GUSD:USD");
        logger.debug("Actual:" + actual);

        Test.assertEqual(actual, "1.0120");
        return true;
    }

    (:test)
    function formatLastPrice(logger) {
        var actual = Format.formatPrice("1", "GUSD:USD");
        logger.debug("Actual:" + actual);

        Test.assertEqual(actual, "1.0000");
        return true;
    }
}

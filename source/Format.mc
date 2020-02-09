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

module Format {

    const formats = {
        "BTC:USD" => "%.01f",
        "ETH:USD" => "%.02f",
        "BCH:USD" => "%.02f",
        "BTG:USD" => "%.02f",
        "DASH:USD" => "%.02f",
        "LTC:USD" => "%.02f",
        "ZEC:USD" => "%.02f",
        "BTT:USD" => "%.06f",
        "BTC:EUR" => "%.01f",
        "ETH:EUR" => "%.02f",
        "BCH:EUR" => "%.02f",
        "BTG:EUR" => "%.02f",
        "DASH:EUR" => "%.02f",
        "LTC:EUR" => "%.02f",
        "ZEC:EUR" => "%.02f",
        "BTT:EUR" => "%.06f",
        "ETH:BTC" => "%.06f",
        "BCH:BTC" => "%.06f",
        "BTG:BTC" => "%.06f",
        "DASH:BTC" => "%.06f",
        "XRP:BTC" => "%.06f",
        "ZEC:BTC" => "%.06f"
    };

    function formatPrice(amount, pair) {
        if (amount instanceof Toybox.Lang.String) {
            amount = amount.toFloat();
        }

        var precision = formats[pair];

        if (precision == null) {
            var length = pair.length();

            if (pair.substring(length - 3, length).equals("BTC")) {
                return amount.format("%.08f");
            } else {
                return  amount.format("%.04f");
            }
        } else {
            return amount.format(precision);
        }
    }
}
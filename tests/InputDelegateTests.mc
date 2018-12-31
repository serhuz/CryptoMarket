/*   Copyright 2018 Sergei Munovarov
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

(:test)
module InputDelegateTests {

    const tickers = [
        {
            "pair" => "BTC:USD",
            "last" => "3884.5",
            "volume" => "322.37140674",
            "bid" => 3876.2,
            "ask" => 3884.7
        },
        {
            "pair" => "ETH:USD",
            "last" => "140",
            "volume" => "4094.30810300",
            "bid" => 139.33,
            "ask" => 139.91
        }
    ];

    (:test)
    function onSelectShouldSetFlagToTrue(logger) {
        var delegate = new InputDelegate(tickers);

        delegate.onSelect();

        Test.assertEqual(delegate.getIsInScrollMode(), true);
        return true;
    }

//    (:test) // doesn't work
    function onSelectShouldSetFlagToFalse(logger) {
        var delegate = new InputDelegate(tickers);

        delegate.onSelect();
        delegate.onSelect();

        Test.assertEqual(delegate.getIsInScrollMode(), false);
        return true;
    }
}
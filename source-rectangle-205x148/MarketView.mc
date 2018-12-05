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

using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class MarketView extends BaseMarketView {

    function initialize(ticker, current, size) {
        BaseMarketView.initialize(ticker, current, size);
    }

    function getPairOffset() {
        return 10;
    }

    function getLastOffset() {
        return 22;
    }

    function getAskOffset() {
        return 18;
    }

    function getBidOffset() {
        return 36;
    }

    function getPositionOffset() {
        return 10;
    }
}

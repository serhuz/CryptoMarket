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

class InputDelegate extends Ui.BehaviorDelegate {

    hidden var tickers;
    hidden var pos = 0;

    function initialize(tickers) {
        BehaviorDelegate.initialize();
        self.tickers = tickers;
    }

    function onSelect() {
        pos++;
        var adjustedPos = pos % tickers.size();
        Ui.switchToView(new MarketView(tickers[adjustedPos], adjustedPos + 1, tickers.size()), self, Ui.SLIDE_UP);
        return true;
    }

    function onBack() {
        return false;
    }
}
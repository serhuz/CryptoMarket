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
    hidden var isInScrollMode = false;
    hidden var priceFormat;
    hidden var initialView;

    function initialize(tickers, priceFormat, initialView) {
        BehaviorDelegate.initialize();
        self.tickers = tickers;
        self.priceFormat = priceFormat;
        self.initialView = initialView.weak();
    }

    function onSelect() {
        if(!isInScrollMode) {
            isInScrollMode = true;
            Ui.pushView(new MarketView(tickers[pos], pos + 1, tickers.size(), true, priceFormat), self, Ui.SLIDE_IMMEDIATE);
        } else {
            popView();
        }
        return true;
    }

    function onNextPage() {
        if (isInScrollMode) {
            pos = (pos + 1) % tickers.size();
            Ui.switchToView(new MarketView(tickers[pos], pos + 1, tickers.size(), true, priceFormat), self, Ui.SLIDE_UP);
        }
        return isInScrollMode;
    }

    function onPreviousPage() {
        if (isInScrollMode) {
            pos = (tickers.size() + (pos - 1)) % tickers.size();
            Ui.switchToView(new MarketView(tickers[pos], pos + 1, tickers.size(), true, priceFormat), self, Ui.SLIDE_DOWN);
        }
        return isInScrollMode;
    }

    function onBack() {
        if (isInScrollMode) {
            popView();
            return true;
        }
        return false;
    }

    private function popView() {
        if (initialView.stillAlive()) {
            initialView.get().setTicker(tickers[pos], pos + 1);
        }
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        isInScrollMode = false;
    }

    (:debug)
    function getIsInScrollMode() {
        return isInScrollMode;
    }

    (:debug)
    function setInScrollMode(isInscrollMode) {
        self.isInScrollMode = isInScrollMode;
    }
}
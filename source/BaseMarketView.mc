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
using Toybox.Application as App;
using Format as Fmt;
using Offsets;

class BaseMarketView extends Ui.View {

    hidden const justification = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;

    hidden var ticker;
    hidden var current;
    hidden var size;
    hidden var shouldDrawIndicators = false;

    hidden var priceLabel;
    hidden var volumeLabel;
    hidden var askLabel;
    hidden var bidLabel;

    function initialize(ticker, current, size, shouldDrawIndicators) {
        View.initialize();
        self.ticker = ticker;
        self.current = current;
        self.size = size;
        self.shouldDrawIndicators = shouldDrawIndicators;
    }

    function setTicker(ticker, current) {
        self.ticker = ticker;
        self.current = current;
        Ui.requestUpdate();
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        View.onShow();
        priceLabel = Ui.loadResource(Rez.Strings.Price);
        volumeLabel = Ui.loadResource(Rez.Strings.Volume);

        if (Application.getApp().getProperty("AskBidHighLow") == 0) {
            askLabel = Ui.loadResource(Rez.Strings.Ask);
            bidLabel = Ui.loadResource(Rez.Strings.Bid);
        } else {
            askLabel = Ui.loadResource(Rez.Strings.Low);
            bidLabel = Ui.loadResource(Rez.Strings.High);
        }
    }

    function onUpdate(dc) {
        View.onUpdate(dc);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        drawPair(dc);
        drawLastPrice(dc);
        drawVolume(dc);
        drawAdditionalData(dc);

        if (Offsets.shouldDrawChange) {
            drawPriceChange(dc);
        }
        if (Offsets.shouldDrawPosition) {
            drawPosition(dc);
        }
        if (shouldDrawIndicators) {
            drawIndicators(dc);
        }

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    function formatText(args) {
        return Lang.format("$1$ $2$", args);
    }

    function drawPair(dc) {
        var text = (ticker == null) ? "-:-" : ticker["pair"];
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, Offsets.pairOffset, Gfx.FONT_TINY, text, justification);
    }

    function drawPriceChange(dc) {
        var text;
        if (ticker != null) {
            var priceChange = ticker["priceChange"];
            if (priceChange.find("-") == null && priceChange.toFloat() > 0) {
                priceChange = Lang.format("+$1$", [priceChange]);
                dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
            } else if (priceChange.toFloat() == 0) {
                dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
            } else {
                dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
            }
            var changePercentage = ticker["priceChangePercentage"];
            if (changePercentage.find("-") == null && changePercentage.toFloat() > 0) {
                changePercentage = Lang.format("+$1$%", [changePercentage]);
            } else {
                changePercentage = Lang.format("$1$%", [changePercentage]);
            }
            text = Lang.format("$1$ ($2$)", [priceChange, changePercentage]);
            dc.drawText(dc.getWidth() / 2, Offsets.priceChangeOffset, Gfx.FONT_TINY, text, justification);
        } else {
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
            text = "-:-";
            dc.drawText(dc.getWidth() / 2, Offsets.priceChangeOffset, Gfx.FONT_TINY, text, justification);
        }
    }

    function drawLastPrice(dc) {
        var text = (ticker == null) ?
            formatText([priceLabel, "--"]) :
            formatText([priceLabel, Fmt.formatPrice(ticker["last"], ticker["pair"])]);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - Offsets.lastOffset, Gfx.FONT_MEDIUM, text, justification);
    }

    function drawVolume(dc) {
        var text = (ticker == null) ? formatText([volumeLabel, "--"]) : formatText([volumeLabel, ticker["volume"]]);
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_TINY, text, justification);
    }

    function drawAdditionalData(dc) {
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        var text;
        if (ticker == null) {
            text = formatText([askLabel, "--"]);
        } else {
            var data;
            if (Application.getApp().getProperty("AskBidHighLow") == 0) {
                data = ticker["ask"];
            } else {
                data = ticker["low"];
            }
            text = formatText([askLabel, Fmt.formatPrice(data, ticker["pair"])]);
        }
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 + Offsets.askOffset, Gfx.FONT_TINY, text, justification);

        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
        if (ticker == null) {
            text = formatText([bidLabel, "--"]);
        } else {
             var data;
            if (Application.getApp().getProperty("AskBidHighLow") == 0) {
                data = ticker["bid"];
            } else {
                data = ticker["high"];
            }
            text = formatText([bidLabel, Fmt.formatPrice(data, ticker["pair"])]);
        }
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 + Offsets.bidOffset, Gfx.FONT_TINY, text , justification);
    }

    function drawPosition(dc) {
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
        if (current == null || size == null) {
            dc.drawText(
                dc.getWidth() / 2,
                dc.getHeight() - Offsets.positionOffset,
                Gfx.FONT_XTINY,
                "-/-",
                justification
            );
        } else {
            dc.drawText(
                dc.getWidth() / 2,
                dc.getHeight() - Offsets.positionOffset,
                Gfx.FONT_XTINY,
                current + "/" + size,
                justification
            );
        }
    }

    function drawIndicators(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        var centerX = dc.getWidth() / 2;
        var bottomY = dc.getHeight() - Offsets.indicatorOffset - Offsets.indicatorSize;

        dc.fillPolygon([
             [centerX, dc.getHeight() - Offsets.indicatorOffset],
             [centerX - Offsets.indicatorSize, bottomY],
             [centerX + 5, bottomY]
        ]);

        var topY = Offsets.indicatorOffset + Offsets.indicatorSize;
        dc.fillPolygon([
             [centerX, Offsets.indicatorOffset],
             [centerX - Offsets.indicatorSize, topY],
             [centerX + 5, topY]
        ]);
    }
}


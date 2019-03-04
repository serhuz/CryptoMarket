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

module Dimens {
    const lastOffset = 30;
    const askOffset = 30;
    const bidOffset = 55;
    const indicatorOffset = 8;
    const indicatorSize = 5;
    const positionOffset = indicatorOffset * 2 + indicatorSize + 10;
    const pairOffset = positionOffset;
    const priceChangeOffset = pairOffset + 30;
    const shouldDrawPosition = true;
    const shouldDrawChange = true;
}
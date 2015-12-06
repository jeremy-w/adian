/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
protocol Poster {
    // (jws/2015-12-06)TODO: Pull in one of Result, Deferred, or Signal to deliver the end result.
    func postMessage(message: String)
}

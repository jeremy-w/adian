/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
protocol Task {
    var command: [String] { get set }
    var input: String { get set }

    func run(completion: (output: String, ok: Bool) -> Void)
}

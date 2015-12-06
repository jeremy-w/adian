/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
class Wry {
    var task: Task
    init(task: Task) {
        self.task = task
    }
}


extension Wry: Poster {
    func postMessage(message: String) {
        task.command = ["wry", "post"]
        task.input = message
        task.run { (output, ok) -> Void in
            /* (jws/2015-12-06)TODO: pass result out */
        }
    }
}

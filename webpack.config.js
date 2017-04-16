const webpack = require('webpack')

const fs = require('fs')
const path = require('path')
const child_process = require('child_process')

const STACK_ROOT = child_process.spawnSync('stack', ['path', '--local-install-root']).stdout.toString().trim()
const STACK_BIN_DIR = path.join(STACK_ROOT, 'bin')
const STACK_EXEC_DIRS = fs.readdirSync(STACK_BIN_DIR)
      .filter((f) => fs.statSync(path.join(STACK_BIN_DIR, f)))
// const STACK_EXEC_DIRS0 = STACK_EXEC_DIRS[0]

module.exports = (() => {
    var entry = {
        app: './js/app.js'
    }
    for (var d of STACK_EXEC_DIRS) {
        entry[d] = path.join(STACK_BIN_DIR, d, 'all.js')
    }
    console.log(entry)
    return {
        entry: entry,
        target: 'web',
        output: {
            path: path.join(__dirname, 'target'),
            filename: '[name].bundle.js'
        },
        plugins: [
            new webpack.optimize.UglifyJsPlugin({
                compress: {
                    warnings: false
                },
                mangle: false
            })
        ]
    }
})()

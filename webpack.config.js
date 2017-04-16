const webpack = require('webpack')
const ClosureCompilerPlugin = require('webpack-closure-compiler')
const ClosureCompiler = require('google-closure-compiler-js').webpack

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
            // new ClosureCompiler({
            //     // options: {
            //     //     languageIn: 'ECMASCRIPT6',
            //     //     languageOut: 'ECMASCRIPT5',
            //     //     compilationLevel: 'ADVANCED',
            //     //     warningLevel: 'VERBOSE'
            //     // }
            // })
            // new ClosureCompilerPlugin({
            //     compiler: {
            //         language_in: 'ECMASCRIPT6',
            //         language_out: 'ECMASCRIPT5',
            //         compilation_level: 'ADVANCED',
            //         externs: path.join(STACK_BIN_DIR, STACK_EXEC_DIRS[0], 'all.js.externs')
            //     },
            //     concurrency: 3
            // })
        ]
    }
})()

// module.exports = {
//     entry: './js/app.js',
//     entry: {
//         app: './js/app.js',
// 
//     },
//     output: {
//         filename: './target/bundle.js'
//     },
//     plugins: [
//         new ClosureCompilerPlugin({
//             compiler: {
//                 language_in: 'ECMASCRIPT6',
//                 language_out: 'ECMASCRIPT5',
//                 compilation_level: 'ADVANCED',
//                 externs: path.join()
//             },
//             concurrency: 3
//         })
//     ]
// }

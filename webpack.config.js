const path = require('path');

module.exports = {
    entry : './src/renderer/index.tsx',
    devtool: 'source-map',
    module : {
        rules : [
            {
                test : /\.(ts|tsx)$/,
                exclude : /node_modules/,
                use : {
                    loader : 'babel-loader',
                    options : {
                        presets : ['@babel/preset-react', '@babel/preset-typescript'],
                    }
                }
            },

            {
                test: /\.css$/,
                use : ['style-loader', 'css-loader']
            }
        ] 
    }, 
    resolve : {
        extensions : ['.ts', '.tsx', '.js'],
    },
    output : {
        path: path.join(__dirname, 'dist'),
        filename : 'bundle.js'
    }
}
const path = require('path')

function getDependenciesString () {
  try {
    return JSON.stringify(require(path.join(__dirname, 'nodejs', 'package.json')).dependencies)
  } catch (e) {
    const errorMessage = `DESCRIPTION ERROR: ${e.message}`
    console.error(errorMessage, '\n')

    return errorMessage.replace(/'/g, '').split('\n').join(' ++ ')
  }
}

module.exports = function () {
  return ('' + getDependenciesString()).substr(0, 256)
}

var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/intro', function(req, res, next) {
  res.render('intro');
});

module.exports = router;
function Model() {
    console.log('New OpenSees Model Created!');
};

exports.Model = Model;

exports.createModel = function() {
    return new Model();
};

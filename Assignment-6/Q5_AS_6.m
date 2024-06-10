% Load dataset for both training and testing
data_url = 'https://storage.googleapis.com/download.tensorflow.org/data/iris_training.csv';
data = readtable(data_url);

% Extract Petal length and Petal width as attributes
X = table2array(data(:, [3, 4]));

% Extract labels (assuming the class labels are in the last column)
y = grp2idx(data{:, end});

% Build a decision tree classifier
tree_classifier = fitctree(X, y);

% Make predictions using the trained decision tree classifier on the same dataset
y_pred = predict(tree_classifier, X);

% Evaluate the performance (you can use metrics like accuracy, confusion matrix, etc.)
accuracy = sum(y_pred == y) / numel(y_pred);
disp(['Accuracy: ', num2str(accuracy)]);

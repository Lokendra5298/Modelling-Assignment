% Load training dataset
train_url = 'https://storage.googleapis.com/download.tensorflow.org/data/iris_training.csv';
train_data = readtable(train_url);

% Extract Petal length and Petal width as attributes
X_train = table2array(train_data(:, [3, 4]));

% Extract labels (assuming the class labels are in the last column)
y_train = grp2idx(train_data{:, end});

% Build a decision tree classifier
tree_classifier = fitctree(X_train, y_train);

% Load test dataset
test_url = 'https://storage.googleapis.com/download.tensorflow.org/data/iris_test.csv';
test_data = readtable(test_url);

% Extract Petal length and Petal width as attributes for test data
X_test = table2array(test_data(:, [3, 4]));

% Make predictions using the trained decision tree classifier
y_pred = predict(tree_classifier, X_test);

% Evaluate the performance (you can use metrics like accuracy, confusion matrix, etc.)
accuracy = sum(y_pred == grp2idx(test_data{:, end})) / numel(y_pred);
disp(['Accuracy: ', num2str(accuracy)]);

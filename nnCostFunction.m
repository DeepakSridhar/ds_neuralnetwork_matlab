function [J, grad] = nnCostFunction(nn_params, ...
    input_layer_size, ...
    hidden_layer_size, ...
    num_labels, ...
    X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices.
%
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
    hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
    num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
delta3=zeros(num_labels,1);

% You need to return the following variables correctly
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% Add the bias
X = [ones(m, 1) X];

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% J = (1/m)*(-y'*log(sigmoid(X*theta)) - ((1-y)'*(log(1-(sigmoid(X*theta)))))) + (lambda/(2*m))*(sum(theta(2:end).^2));
Delta1=0;
Delta2=0;
for i = 1:m
    J1=0;
    a21=sigmoid(Theta1*X(i,:)');
    a2=[1; a21];
    for j=1:num_labels
        
        yj=(y==j);
        a3=sigmoid(Theta2(j,:)*a2);
        J1 = J1 + (-yj(i)*log(a3) - ((1-yj(i))*log(1-a3)));
        delta3(j)=a3-yj(i);
    end
    
    delta2=(Theta2'*delta3).*sigmoidGradient([1;Theta1*X(i,:)']);
    delta2=delta2(2:end);
    Delta1=Delta1+(delta2*X(i,:));
    Delta2=Delta2+(delta3*a2');
    J = J +J1;
end


% A11=sigmoid(Theta1*X');
% A1=[ones(1,m); A11];
% A22=sigmoid(A1'*Theta2');
% 
% for l=1:num_labels
%     yl=(y==l);
%     A2=A22(:,l);
%     J = J + (-yl'*log(A2) - ((1-yl)'*(log(1-(A2)))));
% end

J=J/m;
th1=Theta1(:,2:end);
th2=Theta2(:,2:end);
cost=(lambda/(2*m))*(sum(sum(th1.^2))+ sum(sum(th2.^2)));
reg1=(lambda/m)*th1;
reg2=(lambda/m)*th2;
reg1_grad=[zeros(hidden_layer_size,1) reg1];
reg2_grad=[zeros(num_labels,1) reg2];

% cost1=0;
% for k=1:hidden_layer_size
%     for l=2:input_layer_size+1
%
%         cost1=cost1+(Theta1(k,l)^2);
%     end
% end
% cost2=0;
% for m=1:num_labels
%     for n=2:hidden_layer_size+1
%
%         cost2=cost2+(Theta2(m,n)^2);
%     end
% end
% cost=(lambda/(2*m))*(cost1+cost2);
J=J+cost;

Theta1_grad=Delta1/m+reg1_grad;
Theta2_grad=Delta2/m+reg2_grad;



% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end

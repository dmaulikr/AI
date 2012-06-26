function ret = simplePerceptron5(input, weights, f)

	ret = feval(f, sum(input.*weights));

endfunction

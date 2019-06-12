

```python
import numpy as np
```

# Scalar operations

This is simply done with the multiplication operator (`*`) in Python, where one of the objects is a scalar and the other is a Numpy array.

This is notated for a scalar $s$ and a matrix $A$ as:

$$C = sA$$

Scalar multiplication is commutative:

$$C = sA = As$$

Create example arrays:


```python
a = np.random.randint(0,9,(3))
b = np.random.randint(0,9,(2,4))

print('a = \n{}\n'.format(a))
print('b = \n{}\n'.format(b))
```

    a = 
    [6 5 8]
    
    b = 
    [[5 4 0 3]
     [7 8 2 7]]
    
    

Multiplication of each element in an array of any dimension is simply performed with the mulitplication symbol `*`:


```python
s = 2
r_1 = s * a
r_2 = s * b

print('r_1 = \n{}\n'.format(r_1))
print('r_2 = \n{}\n'.format(r_2))
```

    r_1 = 
    [12 10 16]
    
    r_2 = 
    [[10  8  0  6]
     [14 16  4 14]]
    
    

# Operations on 1D arrays

Create example arrays:


```python
a = np.random.randint(0,9,(4))
b = np.random.randint(0,9,(4))

print('a = \n{}\n'.format(a))
print('b = \n{}\n'.format(b))
```

    a = 
    [3 3 3 3]
    
    b = 
    [3 2 6 6]
    
    

## Inner product of two vectors

For two vectors $\boldsymbol{a}$ and $\boldsymbol{b}$, the inner (dot) product is the sum of the product of components. It is written as:

$$c = \sum_{i}a_ib_i$$

In matrix notation, this is written as:

$$c =
\begin{pmatrix}a_1, a_2, ..., a_n\end{pmatrix}
\begin{pmatrix}b_1\\b_2\\...\\b_n\end{pmatrix}
$$

**Method 1: `for` loop**


```python
def inner_prod(a, b):
    
    total = 0
    for i in range(len(a)):
        total += a[i] * b[i]
    
    return total

inner_prod(a,b)
```




    51



**Method 2: `np.dot()`**


```python
np.dot(a,b)
```




    51



**Method 3: `np.einsum()`**


```python
np.einsum('i,i',a,b)
```




    51



## Outer product of two vectors

For two vectors $\boldsymbol{a}$ and $\boldsymbol{b}$, the outer product is written in matrix notation as:

$$C = 
\begin{pmatrix}a_1\\a_2\\\vdots\\a_n\end{pmatrix}
\begin{pmatrix}b_1, b_2, \ldots, b_n\end{pmatrix} =
\begin{pmatrix}
a_1b_1 & a_1b_2 & \ldots  &  a_1b_n \\
a_2b_1 & \ldots & \ldots & \ldots             \\
\ldots & \ldots & \ldots & \ldots \\
a_nb_1 & \ldots & \ldots & a_nb_n
\end{pmatrix}
$$

**Method 1: `for` loops**


```python
def outer_prod(a,b):
    c = np.empty((len(a), len(b)), dtype=a.dtype)
    
    for i in range(len(a)):
        for j in range(len(b)):
            c[i,j] = a[i] * b[j]
            
    return c

outer_prod(a,b)
```




    array([[ 9,  6, 18, 18],
           [ 9,  6, 18, 18],
           [ 9,  6, 18, 18],
           [ 9,  6, 18, 18]])



**Method 2: `np.outer()`**


```python
np.outer(a,b)
```




    array([[ 9,  6, 18, 18],
           [ 9,  6, 18, 18],
           [ 9,  6, 18, 18],
           [ 9,  6, 18, 18]])



**Method 3: `np.einsum()`**


```python
np.einsum('i,j->ij', a, b)
```




    array([[ 9,  6, 18, 18],
           [ 9,  6, 18, 18],
           [ 9,  6, 18, 18],
           [ 9,  6, 18, 18]])



## Cross product of two vectors

Cross product is defined for 2 and 3-dimensional vectors. Create example arrays:


```python
a = np.random.randint(0,9,(3))
b = np.random.randint(0,9,(3))

print('a = \n{}\n'.format(a))
print('b = \n{}\n'.format(b))
```

    a = 
    [6 0 6]
    
    b = 
    [0 4 0]
    
    


```python
np.cross(a,b)
```




    array([-24,   0,  24])



# Operations on 2D arrays

Create example arrays:


```python
a = np.random.randint(0,9,(1,3))    # row vector
b = np.random.randint(0,9,(3,1))    # col vector
A = np.random.randint(0,9,(3,3))
B = np.random.randint(0,9,(3,3))

print('a = \n{}\n'.format(a))
print('b = \n{}\n'.format(b))
print('A = \n{}\n'.format(A))
print('B = \n{}\n'.format(B))
```

    a = 
    [[3 2 1]]
    
    b = 
    [[3]
     [8]
     [5]]
    
    A = 
    [[6 4 5]
     [8 6 4]
     [3 4 4]]
    
    B = 
    [[8 2 5]
     [4 3 4]
     [0 4 0]]
    
    

## Matrix product

Define a function using to compute the matrix product of two 2D arrays using nested for loops:


```python
def mat_mult(a,b):
    
    # output array has same number of rows as a and same number of columns as b
    c = np.zeros((a.shape[0], b.shape[1]), dtype=a.dtype)
    
    for a_row in range(a.shape[0]):
    
        for b_col in range(b.shape[1]):

            for a_col in range(a.shape[1]):

                b_row = a_col                            
                c[a_row, b_col] += (a[a_row, a_col] * b[b_row, b_col])            
    
    return c
```

### Inner product of two vectors

**Method 1: `for` loops**


```python
mat_mult(a,b)
```




    array([[30]])



**Method 2: `np.dot()`**


```python
np.dot(a,b)
```




    array([[30]])



**Method 3: `np.einsum()`**


```python
np.einsum('ij,jk',a,b)
```




    array([[30]])



**Method 4: `np.matmul()` - `@`**


```python
a @ b
```




    array([[30]])



### Outer product of two vectors

**Method 1: `for` loops**


```python
mat_mult(a.T,b.T)
```




    array([[ 9, 24, 15],
           [ 6, 16, 10],
           [ 3,  8,  5]])



**Method 2: `np.dot()` and `np.outer()`**


```python
np.dot(a.T,b.T)
```




    array([[ 9, 24, 15],
           [ 6, 16, 10],
           [ 3,  8,  5]])




```python
np.outer(a,b)
```




    array([[ 9, 24, 15],
           [ 6, 16, 10],
           [ 3,  8,  5]])



**Method 3: `np.einsum()`**


```python
np.einsum('ij,kl->jk',a,b)
```




    array([[ 9, 24, 15],
           [ 6, 16, 10],
           [ 3,  8,  5]])



**Method 4: `np.matmul()` - `@`**


```python
a.T @ b.T
```




    array([[ 9, 24, 15],
           [ 6, 16, 10],
           [ 3,  8,  5]])



### Matrix product of two matrices

**Method 1: `for` loops**


```python
mat_mult(A,B)
```




    array([[64, 44, 46],
           [88, 50, 64],
           [40, 34, 31]])



**Method 2: `np.dot()`**


```python
np.dot(A,B)
```




    array([[64, 44, 46],
           [88, 50, 64],
           [40, 34, 31]])



**Method 3: `np.einsum()`**


```python
np.einsum('ij,jk->ik',A,B)
```




    array([[64, 44, 46],
           [88, 50, 64],
           [40, 34, 31]])



**Method 4: `np.matmul()` - `@`**


```python
A @ B
```




    array([[64, 44, 46],
           [88, 50, 64],
           [40, 34, 31]])



## Cross product of two vectors

`np.cross()` accepts 1D vectors, or row vectors represented as `1 x 3` arrays, but not column vectors represented as `3 x 1` arrays by default. We can modify the axis defining the input and output vectors however, which allows us to operate on column vectors represented as `3 x 1` arrays:


```python
np.cross(a, b, axisb=0)
```




    array([[  2, -12,  18]])



## Hadamard product


```python
A * B
```




    array([[48,  8, 25],
           [32, 18, 16],
           [ 0, 16,  0]])



## Kronecker product

The outer product on two vectors can be generalised to 2D matrices. For a matrix $A$ with shape `n x m` and a matrix $B$ with shape `p x q`, the Knocker product produces a matrix with shape `np x mq`, and is written as:

$$
A \otimes B = 
\begin{pmatrix}
a_{11}B & \ldots & a_{1m}B & \\
\vdots & \ddots & \vdots & \\
a_{n1}B & \ldots & a_{nm}B & \\
\end{pmatrix}
$$

Write a function using for loops to perform the Kronecker product:


```python
def kron_prod(a, b):
    
    b_nrows = b.shape[0]
    b_ncols = b.shape[1]
    
    c_shape = tuple([i*j for i, j in zip(a.shape, b.shape)])
    
    if a.dtype is b.dtype:
        c_dtype = a.dtype
    else:
        c_dtype = float
        
    c = np.empty(c_shape, dtype=c_dtype)
    
    for i_idx, i in enumerate(a):
        for j_idx, j in enumerate(i):
            sub_arr = j * b
            c[i_idx*b_nrows:(i_idx+1)*b_nrows, j_idx*b_ncols:(j_idx+1)*b_ncols] = sub_arr
    
    return c
```

**Method 1: `for` loops**


```python
kron_prod(A,B)
```




    array([[48, 12, 30, 32,  8, 20, 40, 10, 25],
           [24, 18, 24, 16, 12, 16, 20, 15, 20],
           [ 0, 24,  0,  0, 16,  0,  0, 20,  0],
           [64, 16, 40, 48, 12, 30, 32,  8, 20],
           [32, 24, 32, 24, 18, 24, 16, 12, 16],
           [ 0, 32,  0,  0, 24,  0,  0, 16,  0],
           [24,  6, 15, 32,  8, 20, 32,  8, 20],
           [12,  9, 12, 16, 12, 16, 16, 12, 16],
           [ 0, 12,  0,  0, 16,  0,  0, 16,  0]])



**Method 4: `np.kron()`**


```python
np.kron(A,B)
```




    array([[48, 12, 30, 32,  8, 20, 40, 10, 25],
           [24, 18, 24, 16, 12, 16, 20, 15, 20],
           [ 0, 24,  0,  0, 16,  0,  0, 20,  0],
           [64, 16, 40, 48, 12, 30, 32,  8, 20],
           [32, 24, 32, 24, 18, 24, 16, 12, 16],
           [ 0, 32,  0,  0, 24,  0,  0, 16,  0],
           [24,  6, 15, 32,  8, 20, 32,  8, 20],
           [12,  9, 12, 16, 12, 16, 16, 12, 16],
           [ 0, 12,  0,  0, 16,  0,  0, 16,  0]])



**Method 3: `np.einsum()`**


```python
e = np.einsum('ij,kl->jikl',A,B)
E = np.concatenate(np.concatenate(e, axis=2), axis=0)
print(E)
```

    [[48 12 30 32  8 20 40 10 25]
     [24 18 24 16 12 16 20 15 20]
     [ 0 24  0  0 16  0  0 20  0]
     [64 16 40 48 12 30 32  8 20]
     [32 24 32 24 18 24 16 12 16]
     [ 0 32  0  0 24  0  0 16  0]
     [24  6 15 32  8 20 32  8 20]
     [12  9 12 16 12 16 16 12 16]
     [ 0 12  0  0 16  0  0 16  0]]
    

# Transformations on row and column vectors

Numpy only has one type of one-dimensional array and so does not distinguish between row and column vectors. To distinguish, we represent a row vector as an `1 x N` 2D array and a column vector as a `N x 1` 2D array. By convention, column vectors are more widely used in physics.

A row vector could be specified like this:


```python
np.array([[0,1,2]])
```




    array([[0, 1, 2]])



... and a column vector could be specified like this:


```python
np.array([[0],[1],[2]])
```




    array([[0],
           [1],
           [2]])



... but this is more easily typed like this, where `T` is an alias for the Numpy `transpose()` method:


```python
np.array([[0,1,2]]).T
```




    array([[0],
           [1],
           [2]])



# Vectorised operations

## Transform a 2D array of column vectors

For a linear transformation matrix $A$ and an array of column vectors $v$, find the transformed vectors $u$:

$$u=Av$$

Create example arrays:


```python
A = np.random.randint(-1,4,(3,3))
v = np.random.randint(0,9,(3,5))

print('A = \n{}\n'.format(A))
print('v = \n{}\n'.format(v))
```

    A = 
    [[ 3  1  0]
     [ 1 -1  2]
     [ 2  3  1]]
    
    v = 
    [[6 5 8 3 6]
     [5 4 2 2 7]
     [8 8 3 6 0]]
    
    

In this case, Numpy's implicit broadcasting is sufficient to use both `np.dot()` and `np.matmul()`.

**Method 1: `np.dot()`**


```python
np.dot(A,v)
```




    array([[23, 19, 26, 11, 25],
           [17, 17, 12, 13, -1],
           [35, 30, 25, 18, 33]])



**Method 2: `np.einsum()`**


```python
np.einsum('ij,jk->ik',A,v)
```




    array([[23, 19, 26, 11, 25],
           [17, 17, 12, 13, -1],
           [35, 30, 25, 18, 33]])



**Method 3: `np.matmul()` - `@`**


```python
A @ v
```




    array([[23, 19, 26, 11, 25],
           [17, 17, 12, 13, -1],
           [35, 30, 25, 18, 33]])



## Transform a 3D array of column vectors

Creat example vectors array:


```python
v = np.random.randint(0,9,(2,3,5))
print('v = \n{}\n'.format(v))

# Let's get the first layer for checking other methods:
u_0 = np.dot(A, v[0])
print('u_0 = \n{}\n'.format(u_0))
```

    v = 
    [[[7 8 5 4 5]
      [5 4 8 0 2]
      [3 5 4 1 0]]
    
     [[6 1 1 1 0]
      [4 7 7 2 1]
      [8 3 4 2 6]]]
    
    u_0 = 
    [[26 28 23 12 17]
     [ 8 14  5  6  3]
     [32 33 38  9 16]]
    
    

**Method 1: `np.dot()`**


```python
np.dot(A,v).swapaxes(0,1)
```




    array([[[26, 28, 23, 12, 17],
            [ 8, 14,  5,  6,  3],
            [32, 33, 38,  9, 16]],
    
           [[22, 10, 10,  5,  1],
            [18,  0,  2,  3, 11],
            [32, 26, 27, 10,  9]]])



For `np.dot()`, we have to swap axes to get the original shape.

**Method 2: `np.einsum()`**


```python
np.einsum('ij,kjl->kil', A, v)
```




    array([[[26, 28, 23, 12, 17],
            [ 8, 14,  5,  6,  3],
            [32, 33, 38,  9, 16]],
    
           [[22, 10, 10,  5,  1],
            [18,  0,  2,  3, 11],
            [32, 26, 27, 10,  9]]])



**Method 3: `np.matmul()` - `@`**


```python
A @ v
```




    array([[[26, 28, 23, 12, 17],
            [ 8, 14,  5,  6,  3],
            [32, 33, 38,  9, 16]],
    
           [[22, 10, 10,  5,  1],
            [18,  0,  2,  3, 11],
            [32, 26, 27, 10,  9]]])



`np.matmul()` and `np.einsum()` are clearly the cleaner solutions.

## Transform a 4D array of column vectors

Creat example vectors array:


```python
v = np.random.randint(0,9,(2,2,3,5))
print('v = \n{}\n'.format(v))

# Let's get the first layer for checking other methods:
u_0 = np.dot(A, v[0,0])
print('u_0 = \n{}\n'.format(u_0))
```

    v = 
    [[[[4 6 0 3 0]
       [1 3 6 5 6]
       [1 8 4 8 6]]
    
      [[5 4 1 2 6]
       [3 7 7 0 2]
       [4 8 6 0 8]]]
    
    
     [[[5 5 0 8 6]
       [0 1 1 8 1]
       [5 5 0 6 8]]
    
      [[6 2 2 2 1]
       [3 0 3 1 0]
       [5 2 7 1 7]]]]
    
    u_0 = 
    [[13 21  6 14  6]
     [ 5 19  2 14  6]
     [12 29 22 29 24]]
    
    

**Method 1: `np.dot()`**


```python
np.dot(A,v).swapaxes(0,2)
```




    array([[[[13, 21,  6, 14,  6],
             [ 5, 19,  2, 14,  6],
             [12, 29, 22, 29, 24]],
    
            [[15, 16,  1, 32, 19],
             [15, 14, -1, 12, 21],
             [15, 18,  3, 46, 23]]],
    
    
           [[[18, 19, 10,  6, 20],
             [10, 13,  6,  2, 20],
             [23, 37, 29,  4, 26]],
    
            [[21,  6,  9,  7,  3],
             [13,  6, 13,  3, 15],
             [26,  6, 20,  8,  9]]]])



Again, for `np.dot()`, we have to swap axes to get the original shape.

**Method 2: `np.einsum()`**


```python
np.einsum('ij,kljm->klim', A, v)
```




    array([[[[13, 21,  6, 14,  6],
             [ 5, 19,  2, 14,  6],
             [12, 29, 22, 29, 24]],
    
            [[18, 19, 10,  6, 20],
             [10, 13,  6,  2, 20],
             [23, 37, 29,  4, 26]]],
    
    
           [[[15, 16,  1, 32, 19],
             [15, 14, -1, 12, 21],
             [15, 18,  3, 46, 23]],
    
            [[21,  6,  9,  7,  3],
             [13,  6, 13,  3, 15],
             [26,  6, 20,  8,  9]]]])



**Method 3: `np.matmul()` - `@`**


```python
A @ v
```




    array([[[[13, 21,  6, 14,  6],
             [ 5, 19,  2, 14,  6],
             [12, 29, 22, 29, 24]],
    
            [[18, 19, 10,  6, 20],
             [10, 13,  6,  2, 20],
             [23, 37, 29,  4, 26]]],
    
    
           [[[15, 16,  1, 32, 19],
             [15, 14, -1, 12, 21],
             [15, 18,  3, 46, 23]],
    
            [[21,  6,  9,  7,  3],
             [13,  6, 13,  3, 15],
             [26,  6, 20,  8,  9]]]])



Again, `np.matmul()` and `np.einsum()` are the best solutions. Where possible, `np.matmul()` is preferable since the syntax is so simple for this situation. From the `np.matmul()` docs: 

> If either argument is N-D, N > 2, it is treated as a stack of matrices residing in the last two indexes and broadcast accordingly.


```python
np.version.version
```




    '1.15.4'



## Broadcasting the cross product (2D)

Create example arrays:


```python
a = np.random.randint(-4,4,(3,1))
B = np.random.randint(-4,4,(3,5))

print('a = \n{}\n'.format(a))
print('B = \n{}\n'.format(B))

# Let's find the cross product of the first vector so we can check subsequent operations:
c = np.cross(a, B[:,0], axis=0)
print('c = \n{}\n'.format(c))
```

    a = 
    [[-3]
     [ 2]
     [-1]]
    
    B = 
    [[ 0  3 -4 -3  3]
     [-2 -3  2  0  1]
     [-4  1 -4  0 -4]]
    
    c = 
    [[-10]
     [-12]
     [  6]]
    
    


```python
np.cross(a, B, axis=0)
```




    array([[-10,  -1,  -6,   0,  -7],
           [-12,   0,  -8,   3, -15],
           [  6,   3,   2,   6,  -9]])




```python
np.cross(B, a, axis=0)
```




    array([[10,  1,  6,  0,  7],
           [12,  0,  8, -3, 15],
           [-6, -3, -2, -6,  9]])



## Broadcasting the cross product (3D)

Create example arrays:


```python
a = np.random.randint(-4,4,(3,1))
B = np.random.randint(-4,4,(2,3,5))

print('a = \n{}\n'.format(a))
print('B = \n{}\n'.format(B))

# Let's find the cross product of the first vector so we can check subsequent operations:
c = np.cross(a, B[0,:,0], axis=0)
print('c = \n{}\n'.format(c))
```

    a = 
    [[ 3]
     [ 3]
     [-1]]
    
    B = 
    [[[-2 -1  0  0  2]
      [-4 -1 -4  2  1]
      [ 3 -1  3 -3  2]]
    
     [[ 0  0 -3 -4 -4]
      [-3  2 -2 -2 -1]
      [-3  2 -3 -4 -4]]]
    
    c = 
    [[ 5]
     [-7]
     [-6]]
    
    

To broadcast correctly, we need to specify the axes for both input and output arrays:


```python
np.cross(a, B, axisa=0, axisb=1, axisc=1)
```




    array([[[  5,  -4,   5,  -7,   7],
            [ -7,   4,  -9,   9,  -8],
            [ -6,   0, -12,   6,  -3]],
    
           [[-12,   8, -11, -14, -13],
            [  9,  -6,  12,  16,  16],
            [ -9,   6,   3,   6,   9]]])




```python
np.cross(B, a, axisa=1, axisb=0, axisc=1)
```




    array([[[ -5,   4,  -5,   7,  -7],
            [  7,  -4,   9,  -9,   8],
            [  6,   0,  12,  -6,   3]],
    
           [[ 12,  -8,  11,  14,  13],
            [ -9,   6, -12, -16, -16],
            [  9,  -6,  -3,  -6,  -9]]])



Alternatively, we can fist ensure `a` and `B` have the same dimension. Then broadcasting will be correct without specifying different axes for input and output arrays:


```python
a_1 = a[np.newaxis]
print('a_1 = \n{}\n'.format(a_1))
```

    a_1 = 
    [[[ 3]
      [ 3]
      [-1]]]
    
    


```python
np.cross(a_1, B, axis=1)
```




    array([[[  5,  -4,   5,  -7,   7],
            [ -7,   4,  -9,   9,  -8],
            [ -6,   0, -12,   6,  -3]],
    
           [[-12,   8, -11, -14, -13],
            [  9,  -6,  12,  16,  16],
            [ -9,   6,   3,   6,   9]]])



## Column-wise dot product (2D)

Given two 2D arrays of column vectors of identical shape, find the dot product of each column of the first array with its correpsonding column in the second array.

Create example arrays:


```python
v1 = np.random.randint(-2,4,(3,5))
v2 = np.random.randint(-2,4,(3,5))

print('v1 = \n{}\n'.format(v1))
print('v2 = \n{}\n'.format(v2))
```

    v1 = 
    [[ 2  0  1  2  3]
     [ 2 -1  2 -2  3]
     [ 0  0  3 -1 -1]]
    
    v2 = 
    [[ 3  0 -1  2 -1]
     [ 0  1 -1 -1  2]
     [ 1  1  3  1  2]]
    
    

**Method 1: `*` and `np.sum()`**


```python
np.sum(v1 * v2, axis=0)
```




    array([ 6, -1,  6,  5,  1])



**Method 2: `np.einsum()`**


```python
np.einsum('ij,ij->j',v1,v2)
```




    array([ 6, -1,  6,  5,  1])



## Column-wise dot product (3D)

Given two 3D arrays of column vectors of identical shape, find the dot product of each column of the first array with its correpsonding column in the second array.

Create example arrays:


```python
v1 = np.random.randint(-2,4,(2,3,5))
v2 = np.random.randint(-2,4,(2,3,5))

print('v1 = \n{}\n'.format(v1))
print('v2 = \n{}\n'.format(v2))
```

    v1 = 
    [[[ 3  3  3 -1  1]
      [ 3  3  2 -2  1]
      [ 3  3  1  2 -2]]
    
     [[-1  1 -2  3 -2]
      [ 2 -2  0 -2 -2]
      [ 0  3  1  0 -1]]]
    
    v2 = 
    [[[-2 -1 -1  3  2]
      [ 1  1 -1  0  2]
      [ 3  2 -1  3  2]]
    
     [[ 1  1  0  3  3]
      [ 3  1  2  1 -1]
      [ 2 -1  2 -1  1]]]
    
    

**Method 1: `*` and `np.sum()`**


```python
np.sum(v1 * v2, axis=1)
```




    array([[ 6,  6, -6,  3,  0],
           [ 5, -4,  2,  7, -5]])



**Method 2: `np.einsum()`**


```python
np.einsum('ijk,ijk->ik',v1,v2)
```




    array([[ 6,  6, -6,  3,  0],
           [ 5, -4,  2,  7, -5]])



## Column-wise cross product (2D)

Create example arrays:


```python
A = np.random.randint(-4,4,(3,5))
B = np.random.randint(-4,4,(3,5))

print('A = \n{}\n'.format(A))
print('B = \n{}\n'.format(B))

# Let's find the cross product of the first vector so we can check subsequent operations:
c = np.cross(A[:,0:1], B[:,0:1], axis=0)
print('c = \n{}\n'.format(c))
```

    A = 
    [[-3  1 -4 -2  0]
     [ 3 -3  0 -1  2]
     [-2  3 -2 -2 -4]]
    
    B = 
    [[ 2 -4  3  1  3]
     [-1 -1  2  2 -3]
     [-1 -3 -2  0 -1]]
    
    c = 
    [[-5]
     [-7]
     [-3]]
    
    


```python
np.cross(A, B, axis=0)
```




    array([[ -5,  12,   4,   4, -14],
           [ -7,  -9, -14,  -2, -12],
           [ -3, -13,  -8,  -3,  -6]])



## Column-wise cross product (3D)

Create example arrays:


```python
A = np.random.randint(-4,4,(2,3,5))
B = np.random.randint(-4,4,(2,3,5))

print('A = \n{}\n'.format(A))
print('B = \n{}\n'.format(B))

# Let's find the cross product of the first vector so we can check subsequent operations:
c = np.cross(A[0,:,0:1], B[0,:,0:1], axis=0)
print('c = \n{}\n'.format(c))
```

    A = 
    [[[ 1  0  0 -2 -1]
      [-2 -4  0 -4  1]
      [-3  0 -4 -2 -4]]
    
     [[-1  0  3  2  1]
      [-1  0  0 -3  0]
      [-2  2 -1 -2  1]]]
    
    B = 
    [[[-4 -1  0  1  3]
      [-2  3 -1  2 -4]
      [ 2 -3  3 -3  2]]
    
     [[-2 -2 -3  1 -4]
      [ 2 -2  0  3  0]
      [-2  1 -1 -1  1]]]
    
    c = 
    [[-10]
     [ 10]
     [-10]]
    
    


```python
np.cross(A, B, axis=1)
```




    array([[[-10,  12,  -4,  16, -14],
            [ 10,   0,   0,  -8, -10],
            [-10,  -4,   0,   0,   1]],
    
           [[  6,   4,   0,   9,   0],
            [  2,  -4,   6,   0,  -5],
            [ -4,   0,   0,   9,   0]]])



## Column pair dot product

Given a single array of shape `N x m x 2`, return a 1D array of length `N` whose elements are the dot products between length `m` column vector pairs.

Create example arrays:


```python
p1 = np.random.randint(-2,4,(5,3,2))
print('p1 = \n{}\n'.format(p1))
```

    p1 = 
    [[[ 3  0]
      [-2  1]
      [ 1 -2]]
    
     [[ 1  2]
      [-2  1]
      [ 3 -1]]
    
     [[ 3 -2]
      [ 3  2]
      [ 1  1]]
    
     [[ 1  1]
      [-2 -2]
      [ 3  2]]
    
     [[ 2 -2]
      [-2  1]
      [-2  2]]]
    
    

**Method 1: `*` and `np.sum()`**


```python
np.sum(p1[:,:,0] * p1[:,:,1], axis=1)
```




    array([ -4,  -3,   1,  11, -10])



**Method 2: `np.einsum()`**


```python
np.einsum('ij,ij->i',p1[:,:,0],p1[:,:,1])
```




    array([ -4,  -3,   1,  11, -10])



It probably makes more sense to keep this sort of data in an array of shape `2 x m x N` instead:


```python
p2 = np.random.randint(-2,4,(2,3,5))
print('p2 = \n{}\n'.format(p2))
```

    p2 = 
    [[[ 2  3 -1  1  3]
      [ 3 -2 -1  0  2]
      [-2  3  3  3  2]]
    
     [[ 0  2  2  2 -2]
      [-2  1 -1 -2  2]
      [ 0 -1  3 -1  0]]]
    
    


```python
np.sum(p2[0] * p2[1], axis=0)
```




    array([-6,  1,  8, -1, -2])




```python
np.einsum('ij,ij->j',p2[0],p2[1])
```




    array([-6,  1,  8, -1, -2])



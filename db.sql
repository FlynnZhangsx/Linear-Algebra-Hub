-- Active: 1742571222598@@127.0.0.1@3306@linear_algebra
-- db.sql
-- 创建数据库
CREATE DATABASE IF NOT EXISTS linear_algebra;
USE linear_algebra;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 知识点表
CREATE TABLE IF NOT EXISTS knowledge (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME NOT NULL
);

-- 插入初始的线性代数知识数据
INSERT INTO knowledge (title, content, created_at) VALUES
('Vector Spaces', 'A vector space is a collection of objects called vectors, which may be added together and multiplied by scalars.', NOW()),
('Matrices', 'A matrix is a rectangular array of numbers arranged in rows and columns.', NOW()),
('Determinants', 'The determinant is a scalar value that can be computed from the elements of a square matrix and encapsulates certain properties of the matrix.', NOW()),
('Eigenvalues and Eigenvectors', 'An eigenvector of a linear transformation is a nonzero vector that changes by a scalar factor when that linear transformation is applied. The corresponding eigenvalue is the factor by which the eigenvector is scaled.', NOW()),
('Linear Transformations', 'A linear transformation is a mapping between vector spaces that preserves the operations of vector addition and scalar multiplication.', NOW()),
('向量空间 (Vector Spaces)', '向量空间是一个集合，其中的元素称为向量，并定义了向量加法和标量乘法运算，这些运算满足封闭性、交换性、结合性、存在零向量及每个向量都有加法逆元等公理。', NOW()),
('子空间 (Subspaces)', '子空间是向量空间中的非空子集，在向量加法和标量乘法下，该子集依然满足向量空间的所有公理。常见例子有直线和平面（包含零向量）。', NOW()),
('线性组合与线性独立 (Linear Combination and Linear Independence)', '线性组合是指将一组向量按比例相加得到的新向量；若一组向量中任一向量都不能由其他向量的线性组合表示，则称这组向量是线性独立的。', NOW()),
('基与维数 (Basis and Dimension)', '基是向量空间中一组既能生成整个空间又相互线性独立的向量，维数则是基中向量的数量，反映了空间的自由度。', NOW()),
('矩阵及其运算 (Matrices and Operations)', '矩阵是按行和列排列的数值数组，用于表示线性变换。矩阵运算包括加法、乘法、转置及求逆等，是解决线性方程组的重要工具。', NOW()),
('行列式 (Determinants)', '行列式是从方阵中计算出的一个标量，反映了矩阵的可逆性和线性变换的体积缩放因子。', NOW()),
('线性方程组 (Systems of Linear Equations)', '线性方程组由多个线性方程构成，可以通过高斯消元法、矩阵求逆法等方法求解，是线性代数的重要应用之一。', NOW()),
('特征值与特征向量 (Eigenvalues and Eigenvectors)', '对于矩阵A，如果存在非零向量v和标量λ满足 A*v = λ*v，则v为特征向量，λ为特征值。它们在矩阵分解及动态系统中具有重要意义。', NOW()),
('对角化 (Diagonalization)', '对角化是将矩阵通过相似变换转换为对角矩阵的过程，前提是矩阵拥有足够的线性独立特征向量。对角矩阵运算简便，常用于求解矩阵幂。', NOW()),
('内积空间 (Inner Product Spaces)', '内积空间是在向量空间上定义了内积运算的空间，内积可以用来计算向量的长度和两向量之间的夹角，为正交性提供理论基础。', NOW()),
('正交与正交投影 (Orthogonality and Orthogonal Projections)', '若两个向量内积为零，则称它们正交。正交投影是将一个向量投影到另一向量或子空间上的过程，常用于数据降维和最优化问题。', NOW()),
('线性无关组 (Linearly Independent Set)', '线性无关组是一组向量，其中没有一个向量可以表示为其他向量的线性组合。', NOW()),
('张成空间 (Span of a Set of Vectors)', '张成空间是由一组向量的所有线性组合构成的向量空间，是该组向量所能生成的最大子空间。', NOW()),
('秩与零度 (Rank and Nullity)', '矩阵的秩是矩阵中线性无关行（或列）的数量，零度是矩阵零空间的维数。秩加上零度等于矩阵的列数。', NOW()),
('零空间 (Null Space)', '零空间是矩阵A的所有解向量x构成的集合，满足A*x = 0。零空间是一个向量空间。', NOW()),
('列空间 (Column Space)', '列空间是矩阵A的列向量张成的子空间，反映了矩阵的线性变换能力。', NOW()),
('行空间 (Row Space)', '行空间是矩阵A的行向量张成的子空间，与列空间有相同的秩。', NOW()),
('正交补空间 (Orthogonal Complement)', '正交补空间是某个子空间中所有与原空间正交的向量构成的集合，与原空间的维数之和等于整个空间的维数。', NOW()),
('奇异值分解 (Singular Value Decomposition, SVD)', '奇异值分解是将矩阵分解为三个矩阵的乘积，其中包含奇异值、左奇异向量和右奇异向量。SVD 在数据压缩、推荐系统等领域有广泛应用。', NOW()),
('正交矩阵 (Orthogonal Matrix)', '正交矩阵是一个方阵，其列向量构成标准正交基，满足矩阵与其转置矩阵的乘积为单位矩阵。', NOW()),
('正定矩阵 (Positive Definite Matrix)', '正定矩阵是一个对称矩阵，其所有特征值均为正数。正定矩阵在优化问题中用于判断函数的凸性。', NOW()),
('二次型 (Quadratic Form)', '二次型是一个由对称矩阵定义的二次函数，形式为x^T A x，其中A是对称矩阵。二次型在几何和优化问题中有广泛应用。', NOW()),
('矩阵的迹 (Trace of a Matrix)', '矩阵的迹是方阵对角线元素的和，等于矩阵所有特征值的和。', NOW()),
('矩阵的范数 (Matrix Norm)', '矩阵的范数是衡量矩阵大小的一种度量，常用于数值分析和机器学习中。', NOW()),
('矩阵的条件数 (Condition Number)', '矩阵的条件数是矩阵范数与其逆矩阵范数的乘积，用于衡量矩阵的病态程度。条件数越大，矩阵越病态，数值计算越不稳定。', NOW()),
('矩阵的特征多项式 (Characteristic Polynomial)', '矩阵的特征多项式是通过计算det(A - λI)得到的多项式，其根即为矩阵的特征值。', NOW()),
('矩阵的谱半径 (Spectral Radius)', '矩阵的谱半径是矩阵所有特征值绝对值中的最大值，用于分析矩阵的收敛性和稳定性。', NOW()),
('矩阵的幂 (Matrix Powers)', '矩阵的幂是矩阵自乘多次的结果，常用于动态系统和马尔可夫链的分析。', NOW()),
('矩阵的指数 (Matrix Exponential)', '矩阵的指数是通过泰勒展开定义的，形式为e^A = I + A + A²/2! + A³/3! + ...，在微分方程和控制理论中有重要应用。', NOW()),
('矩阵的Jordan标准形 (Jordan Canonical Form)', 'Jordan标准形是矩阵的一种规范形式，通过相似变换将矩阵分解为Jordan块的组合，用于分析矩阵的结构和性质。', NOW()),
('矩阵的Schur分解 (Schur Decomposition)', 'Schur分解是将矩阵分解为一个酉矩阵和一个上三角矩阵的乘积，用于特征值计算和矩阵分析。', NOW()),
('矩阵的LU分解 (LU Decomposition)', 'LU分解是将矩阵分解为一个下三角矩阵L和一个上三角矩阵U的乘积，用于高效求解线性方程组。', NOW()),
('矩阵的QR分解 (QR Decomposition)', 'QR分解是将矩阵分解为一个正交矩阵Q和一个上三角矩阵R的乘积，常用于最小二乘问题和特征值计算。', NOW()),
('矩阵的Cholesky分解 (Cholesky Decomposition)', 'Cholesky分解是将正定矩阵分解为一个下三角矩阵和其转置的乘积，适用于高效求解正定矩阵的线性方程组。', NOW()),
('矩阵的奇异值 (Singular Values)', '奇异值是矩阵奇异值分解中的非负实数，反映了矩阵的缩放因子，用于矩阵的低秩近似和主成分分析。', NOW()),
('矩阵的秩 (Rank of a Matrix)', '矩阵的秩是矩阵中线性无关行或列的数量，反映了矩阵的线性变换能力。', NOW()),
('矩阵的逆 (Inverse of a Matrix)', '矩阵的逆是一个方阵，与原矩阵相乘得到单位矩阵。只有可逆矩阵（行列式非零）才有逆矩阵。', NOW()),
('矩阵的伪逆 (Pseudoinverse)', '矩阵的伪逆是广义逆矩阵的一种，用于求解不相容的线性方程组和最小二乘问题。', NOW()),
('矩阵的转置 (Transpose of a Matrix)', '矩阵的转置是将矩阵的行和列互换得到的新矩阵，记作A^T。', NOW()),
('矩阵的共轭转置 (Conjugate Transpose)', '矩阵的共轭转置是将矩阵的每个元素取共轭后转置得到的新矩阵，记作A^H或A^*。', NOW()),
('矩阵的迹与行列式的关系 (Trace and Determinant Relationship)', '矩阵的迹是特征值的和，行列式是特征值的乘积，两者都是矩阵的重要不变量。', NOW()),
('矩阵的相似变换 (Similarity Transformation)', '相似变换是通过可逆矩阵P将矩阵A变换为P^{-1}AP的形式，相似矩阵具有相同的特征值和迹等性质。', NOW()),
('矩阵的合同变换 (Congruence Transformation)', '合同变换是通过可逆矩阵P将矩阵A变换为P^T A P的形式，常用于二次型的研究。', NOW()),
('矩阵的等价变换 (Equivalence Transformation)', '等价变换是通过可逆矩阵P和Q将矩阵A变换为PAQ的形式，用于矩阵的秩分析。', NOW()),
('矩阵的行阶梯形 (Row Echelon Form)', '行阶梯形是矩阵通过初等行变换得到的一种形式，用于求解线性方程组和计算矩阵的秩。', NOW()),
('矩阵的约化行阶梯形 (Reduced Row Echelon Form)', '约化行阶梯形是行阶梯形的一种规范形式，每行的主元为1且主元所在列的其他元素为0，用于唯一表示矩阵的解空间。', NOW()),
('矩阵的初等行变换 (Elementary Row Operations)', '初等行变换包括交换两行、将某行乘以非零标量、将某行加上另一行的倍数，用于化简矩阵和求解线性方程组。', NOW()),
('矩阵的初等列变换 (Elementary Column Operations)', '初等列变换与初等行变换类似，但作用于列，常用于矩阵的秩分析。', NOW()),
('矩阵的行空间与列空间的关系 (Row Space and Column Space Relationship)', '矩阵的行空间和列空间的维数相等，都等于矩阵的秩。', NOW()),
('矩阵的零空间与列空间的正交性 (Null Space and Column Space Orthogonality)', '矩阵A的零空间是A的行空间的正交补空间，两者在几何上是正交的。', NOW()),
('矩阵的谱定理 (Spectral Theorem)', '谱定理指出，对称矩阵可以正交对角化，即存在正交矩阵P使得P^T A P为对角矩阵。', NOW()),
('矩阵的奇异值分解的应用 (Applications of SVD)', '奇异值分解广泛应用于数据压缩、图像处理、推荐系统、主成分分析等领域，通过保留主要奇异值实现降维和特征提取。', NOW()),
('矩阵的特征值分解的应用 (Applications of Eigenvalue Decomposition)', '特征值分解用于分析矩阵的稳定性、求解微分方程、主成分分析等，通过特征值和特征向量揭示矩阵的内在结构。', NOW()),
('矩阵的条件数与数值稳定性 (Condition Number and Numerical Stability)', '矩阵的条件数越大，数值计算越不稳定，可能导致解的误差放大。在实际计算中，条件数用于评估问题的病态程度。', NOW()),
('矩阵的稀疏性 (Sparsity of Matrices)', '稀疏矩阵是指大部分元素为零的矩阵，稀疏性在大规模计算中可以显著减少存储和计算成本。', NOW()),
('矩阵的带状结构 (Banded Matrices)', '带状矩阵的非零元素集中在主对角线附近，形成一个带状区域，常用于有限元分析和偏微分方程的数值解法。', NOW()),
('矩阵的对角占优 (Diagonally Dominant Matrices)', '对角占优矩阵的每行对角元素的绝对值大于该行其他元素绝对值之和，这类矩阵在数值分析中具有良好的性质，如可逆性和迭代收敛性。', NOW()),
('矩阵的严格对角占优 (Strictly Diagonally Dominant Matrices)', '严格对角占优矩阵的每行对角元素的绝对值严格大于该行其他元素绝对值之和，这类矩阵一定是可逆的。', NOW()),
('矩阵的对称性 (Symmetry of Matrices)', '对称矩阵满足A = A^T，对称矩阵的特征值都是实数，特征向量可以正交。', NOW()),
('矩阵的反对称性 (Skew-Symmetry of Matrices)', '反对称矩阵满足A = -A^T，其特征值为纯虚数或零，常用于描述旋转和斜对称系统。', NOW()),
('矩阵的正交性 (Orthogonality of Matrices)', '正交矩阵的列向量构成标准正交基，满足Q^T Q = I，正交矩阵的行列式为±1，常用于坐标变换和旋转。', NOW()),
('矩阵的酉性 (Unitary Matrices)', '酉矩阵是复数域上的正交矩阵，满足U^H U = I，其行列式为单位复数，用于量子力学和信号处理中的复数变换。', NOW()),
('矩阵的正规性 (Normal Matrices)', '正规矩阵满足A A^H = A^H A，这类矩阵可以酉对角化，是谱定理的基础。', NOW()),
('矩阵的幂等性 (Idempotent Matrices)', '幂等矩阵满足A² = A，这类矩阵常用于投影算子和统计学中的帽子矩阵。', NOW()),
('矩阵的投影 (Projection Matrices)', '投影矩阵用于将向量投影到某个子空间上，满足P² = P，投影矩阵的秩等于投影子空间的维数。', NOW()),
('矩阵的反射 (Reflection Matrices)', '反射矩阵用于将向量关于某个超平面进行反射变换，满足R² = I，反射矩阵的行列式为-1。', NOW()),
('矩阵的旋转 (Rotation Matrices)', '旋转矩阵用于描述二维或三维空间中的旋转变换，是正交矩阵且行列式为1。', NOW()),
('矩阵的平移 (Translation Matrices)', '平移矩阵用于将向量沿某个方向平移，常用于计算机图形学中的仿射变换。', NOW()),
('矩阵的缩放 (Scaling Matrices)', '缩放矩阵用于将向量按比例缩放，常用于几何变换和计算机图形学。', NOW()),
('矩阵的剪切 (Shear Matrices)', '剪切矩阵用于将向量沿某个方向进行剪切变换，保持某个坐标轴不变，而另一个坐标轴按比例变化。', NOW()),
('矩阵的仿射变换 (Affine Transformations)', '仿射变换是线性变换与平移的组合，保持直线和平行性，广泛应用于计算机图形学和几何建模。', NOW()),
('矩阵的线性变换 (Linear Transformations)', '线性变换是向量空间之间的映射，保持向量加法和标量乘法的结构，矩阵是线性变换的矩阵表示。', NOW()),
('矩阵的变换矩阵 (Transformation Matrices)', '变换矩阵是描述线性变换的矩阵，通过矩阵乘法实现向量的变换。', NOW()),
('矩阵的相似性 (Similarity of Matrices)', '相似矩阵具有相同的特征值、迹、行列式等性质，相似性是矩阵之间的一种等价关系。', NOW()),
('矩阵的合同性 (Congruence of Matrices)', '合同矩阵具有相同的惯性指数（正特征值、负特征值和零特征值的数量），合同性用于二次型的分类。', NOW()),
('矩阵的等价性 (Equivalence of Matrices)', '等价矩阵具有相同的秩，等价性是矩阵之间的一种等价关系。', NOW()),
('矩阵的行等价性 (Row Equivalence of Matrices)', '行等价矩阵可以通过初等行变换相互转换，行等价矩阵具有相同的行空间和秩。', NOW()),
('矩阵的列等价性 (Column Equivalence of Matrices)', '列等价矩阵可以通过初等列变换相互转换，列等价矩阵具有相同的列空间和秩。', NOW()),
('矩阵的奇异值与矩阵的秩的关系 (Singular Values and Rank Relationship)', '矩阵的秩等于非零奇异值的数量，奇异值分解可以用于矩阵的秩估计和低秩近似。', NOW()),
('矩阵的奇异值与矩阵的条件数的关系 (Singular Values and Condition Number Relationship)', '矩阵的条件数是最大奇异值与最小奇异值的比值，用于衡量矩阵的病态程度。', NOW()),
('矩阵的奇异值与矩阵的范数的关系 (Singular Values and Matrix Norms Relationship)', '矩阵的2-范数等于最大奇异值，Frobenius范数等于奇异值的平方和的平方根。', NOW()),
('矩阵的谱范数 (Spectral Norm)', '谱范数是矩阵的最大奇异值，用于衡量矩阵的最大伸缩因子。', NOW()),
('矩阵的Frobenius范数 (Frobenius Norm)', 'Frobenius范数是矩阵元素的平方和的平方根，类似于向量的欧几里得范数。', NOW()),
('矩阵的核范数 (Nuclear Norm)', '核范数是矩阵所有奇异值的和，用于低秩矩阵恢复和矩阵补全问题。', NOW()),
('矩阵的无穷范数 (Infinity Norm)', '无穷范数是矩阵行元素绝对值之和的最大值，用于衡量矩阵的最大行范数。', NOW()),
('矩阵的一范数 (1-Norm)', '一范数是矩阵列元素绝对值之和的最大值，用于衡量矩阵的最大列范数。', NOW()),
('矩阵的条件数与矩阵的病态性 (Condition Number and Ill-Conditioning)', '条件数大的矩阵称为病态矩阵，其数值计算结果对输入误差非常敏感，可能导致解的不稳定。', NOW()),
('矩阵的病态性与数值计算的稳定性 (Ill-Conditioning and Numerical Stability)', '病态矩阵的数值计算需要使用高精度算法或正则化方法来提高稳定性。', NOW()),
('矩阵的正则化 (Regularization of Matrices)', '正则化是通过添加一个小的正数到矩阵的对角线来改善其条件数，常用于病态线性方程组和机器学习中的过拟合问题。', NOW()),
('矩阵的Tikhonov正则化 (Tikhonov Regularization)', 'Tikhonov正则化是通过添加一个正则化项到目标函数来稳定病态问题的解，广泛应用于逆问题和机器学习。', NOW()),
('矩阵的奇异值截断 (Truncated SVD)', '奇异值截断是保留矩阵的前k个最大奇异值及其对应的奇异向量，用于矩阵的低秩近似和降维。', NOW()),
('矩阵的奇异值阈值化 (Singular Value Thresholding)', '奇异值阈值化是将小于某个阈值的奇异值设为零，用于矩阵的稀疏化和去噪。', NOW()),
('矩阵的主成分分析 (Principal Component Analysis, PCA)', 'PCA是一种通过奇异值分解或特征值分解提取数据主要特征的方法，广泛应用于降维和特征提取。', NOW()),
('矩阵的线性判别分析 (Linear Discriminant Analysis, LDA)', 'LDA是一种监督学习方法，通过最大化类间距离和最小化类内距离来提取特征，常用于分类问题。', NOW()),
('矩阵的独立成分分析 (Independent Component Analysis, ICA)', 'ICA是一种统计方法，用于从混合信号中分离出独立的源信号，常用于盲源分离和特征提取。', NOW()),
('矩阵的非负矩阵分解 (Non-negative Matrix Factorization, NMF)', 'NMF是一种将非负矩阵分解为两个非负矩阵乘积的方法，广泛应用于图像处理、文本挖掘和推荐系统。', NOW()),
('矩阵的矩阵补全 (Matrix Completion)', '矩阵补全是通过已知部分元素预测未知元素的过程，常用于推荐系统和协同过滤。', NOW()),
('矩阵的矩阵分解 (Matrix Factorization)', '矩阵分解是将矩阵分解为多个矩阵乘积的方法，广泛应用于推荐系统、降维和特征提取。', NOW()),
('矩阵的矩阵范数的应用 (Applications of Matrix Norms)', '矩阵范数用于衡量矩阵的大小和误差传播，常用于数值分析和机器学习中的优化问题。', NOW()),
('矩阵的矩阵方程 (Matrix Equations)', '矩阵方程是涉及矩阵变量的方程，如Lyapunov方程和Sylvester方程，在控制理论和系统分析中有重要应用。', NOW()),
('矩阵的Lyapunov方程 (Lyapunov Equation)', 'Lyapunov方程是形式为A^T X + X A = Q的矩阵方程，用于分析系统的稳定性。', NOW()),
('矩阵的Sylvester方程 (Sylvester Equation)', 'Sylvester方程是形式为A X + X B = C的矩阵方程，用于控制理论和信号处理中的问题求解。', NOW()),
('矩阵的Riccati方程 (Riccati Equation)', 'Riccati方程是一种非线性矩阵方程，形式为A^T X + X A - X B R^{-1} B^T X + Q = 0，用于最优控制和滤波问题。', NOW()),
('矩阵的Kronecker积 (Kronecker Product)', 'Kronecker积是两个矩阵的张量积，用于矩阵的结构化表示和高维数据的处理。', NOW()),
('矩阵的Hadamard积 (Hadamard Product)', 'Hadamard积是两个矩阵的元素对应相乘的结果，用于图像处理和信号处理中的逐点运算。', NOW()),
('矩阵的张量积 (Tensor Product)', '张量积是两个矩阵的高维乘积，用于量子计算和多线性代数中的表示。', NOW()),
('矩阵的外积 (Outer Product)', '外积是两个向量生成矩阵的过程，用于量子力学和统计学中的协方差矩阵计算。', NOW()),
('矩阵的内积 (Inner Product)', '矩阵的内积是两个矩阵的Frobenius内积，等于它们对应元素乘积的和，用于矩阵相似性度量。', NOW()),
('矩阵的矩阵的迹内积 (Trace Inner Product)', '迹内积是矩阵内积的一种形式，等于矩阵乘积的迹，用于矩阵空间的内积定义。', NOW()),
('矩阵的矩阵的Hilbert-Schmidt范数 (Hilbert-Schmidt Norm)', 'Hilbert-Schmidt范数是矩阵的Frobenius范数的推广，用于算子理论和量子力学中的范数定义。', NOW()),
('矩阵的矩阵的算子范数 (Operator Norm)', '算子范数是矩阵作为线性算子的范数，衡量矩阵将单位球映射到像集的最大伸缩因子。', NOW()),
('矩阵的矩阵的谱范数 (Spectral Norm)', '谱范数是矩阵的最大奇异值，用于衡量矩阵的最大伸缩因子。', NOW()),
('矩阵的矩阵的Frobenius范数 (Frobenius Norm)', 'Frobenius范数是矩阵元素的平方和的平方根，类似于向量的欧几里得范数。', NOW());

-- 讨论区（帖子）表，parent_id为空表示主题帖，非空表示回复
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255),
    content TEXT NOT NULL,
    parent_id INT DEFAULT NULL,
    created_at DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_id) REFERENCES posts(id)
);

CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    knowledge_id INT NOT NULL,
    user_id INT NOT NULL,
    comment TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    FOREIGN KEY (knowledge_id) REFERENCES knowledge(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    knowledge_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL, -- 1 表示点赞，-1 表示点踩
    created_at DATETIME NOT NULL,
    UNIQUE KEY (knowledge_id, user_id),
    FOREIGN KEY (knowledge_id) REFERENCES knowledge(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    is_read TINYINT(1) DEFAULT 0,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    knowledge_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    UNIQUE KEY (user_id, knowledge_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (knowledge_id) REFERENCES knowledge(id)
);

CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    is_read TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

ALTER TABLE knowledge ADD COLUMN user_id INT NOT NULL DEFAULT 0;

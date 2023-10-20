import testing
from sys.info import sizeof

@register_passable("trivial")
struct U24[N: Int]:
    var value: __mlir_type.ui24

    alias MAX: Int = 2**24 - 1
    alias ZERO: Int = 0

    alias greater_than_16777215_err_msg: StringLiteral = "Unable to parameterize a value of type `U24` with an integer value greater than 16777215"
    alias lesser_than_0_err_msg: StringLiteral = "Unable to parameterize a value of type `U24` with a negative integer value"

    @always_inline("nodebug")
    fn __init__() -> Self:
        constrained[N <= Self.MAX, Self.greater_than_16777215_err_msg]()
        constrained[N >= Self.ZERO, Self.lesser_than_0_err_msg]()
        return Self {
            value: __mlir_op.`index.castu`[_type = __mlir_type.ui24](N.__mlir_index__())
        }

    @always_inline("nodebug")
    fn __into_int__(owned self) -> Int:
        return __mlir_op.`index.castu`[_type = __mlir_type.index](self.value)

    @always_inline("nodebug")
    fn __into_mlir_U24__(self) -> __mlir_type.ui24:
        return self.value

    @always_inline("nodebug")
    fn __mlir_index__(self) -> __mlir_type.index:
        return __mlir_op.`index.castu`[_type = __mlir_type.index](self.value)

    @always_inline("nodebug")
    fn __add__[M: Int](self: Self, other: U24[M]) -> U24[Self.N + M]:
        return U24[Self.N + M]()

    @always_inline("nodebug")
    fn __mul__[M: Int](self: Self, other: U24[M]) -> U24[Self.N * M]:
        return U24[Self.N * M]()

    @always_inline("nodebug")
    fn __bool__(self) -> Bool:
        @parameter
        if Self.N > 0:
            return True
        else:
            return False

    @always_inline("nodebug")
    fn __invert__(self) -> Bool:
        @parameter
        if Self.N == 0:
            return True
        else:
            return False

    @always_inline("nodebug")
    fn __sub__[M: Int](self: Self, other: U24[M]) -> U24[Self.N - M]:
        constrained[Self.N - M >= Self.ZERO, Self.lesser_than_0_err_msg]()
        return U24[Self.N - M]()

    @always_inline("nodebug")
    fn __truediv__[M: Int](self: Self, other: U24[M]) -> Float64:
        constrained[M != 0, "Division by zero is not allowed"]()
        return Self.N / M

    @always_inline("nodebug")
    fn __mod__[M: Int](self: Self, other: U24[M]) -> U24[Self.N % M]:
        constrained[M != 0, "Division by zero is not allowed"]()
        return U24[Self.N % M]()

    @always_inline("nodebug")
    fn __pow__[M: Int](self: Self, other: U24[M]) -> U24[Self.N ** M]:
        constrained[M >= 0, "Exponent must be non-negative"]()
        return U24[Self.N ** M]()

    @always_inline("nodebug")
    fn __eq__[M: Int](self: Self, other: U24[M]) -> Bool:
        return self.N == M

    @always_inline("nodebug")
    fn __lt__[M: Int](self: Self, other: U24[M]) -> Bool:
        return self.N < M

    @always_inline("nodebug")
    fn __le__[M: Int](self: Self, other: U24[M]) -> Bool:
        return self.N <= M

    @always_inline("nodebug")
    fn __gt__[M: Int](self: Self, other: U24[M]) -> Bool:
        return self.N > M

    @always_inline("nodebug")
    fn __ge__[M: Int](self: Self, other: U24[M]) -> Bool:
        return self.N >= M

    @always_inline("nodebug")
    fn __and__[M: Int](self: Self, other: U24[M]) -> U24[Self.N & M]:
        return U24[Self.N & M]()

    @always_inline("nodebug")
    fn __or__[M: Int](self: Self, other: U24[M]) -> U24[Self.N | M]:
        return U24[Self.N | M]()

    @always_inline("nodebug")
    fn __xor__[M: Int](self: Self, other: U24[M]) -> U24[Self.N ^ M]:
        return U24[Self.N ^ M]()

fn test_size_of_U24() raises:
    let t1 = testing.assert_true(sizeof[U24[0]]() == 3, "test_size_of_U24::t1 failed")

fn test_plus_minus_times_divide() raises:
    # plus
    let t1 = testing.assert_false(U24[5 + 71]() == U24[51](), "test_plus_minus_times_divide::t1 failed")
    let t2 = testing.assert_true(U24[5]() + U24[6]() == U24[11](), "test_plus_minus_times_divide::t2 failed")

    # minus
    let t3 = testing.assert_true(U24[71]() - U24[70]() == U24[1](), "test_plus_minus_times_divide::t3 failed")
    let t4 = testing.assert_false(U24[71]() - U24[70]() == U24[0](), "test_plus_minus_times_divide::t4 failed")

    # times
    let t5 = testing.assert_true(U24[71]() * U24[2]() == U24[142](), "test_plus_minus_times_divide::t5 failed")
    let t6 = testing.assert_false(U24[71]() * U24[2]() == U24[77](), "test_plus_minus_times_divide::t6 failed")

    # divide
    let t7 = testing.assert_true(U24[70]() / U24[7]() == 10, "test_plus_minus_times_divide::t7 failed")
    let t8 = testing.assert_false(U24[70]() / U24[7]() == 7, "test_plus_minus_times_divide::t8 failed")

fn test_comparisons() raises:
    let e = U24[100]()
    let f = U24[200]()

    let t1 = testing.assert_false(e == f, "test_comparisons::t1 failed")
    let t2 = testing.assert_true(e < f, "test_comparisons::t2 failed")
    let t3 = testing.assert_true(e <= f, "test_comparisons::t3 failed")
    let t4 = testing.assert_false(e > f, "test_comparisons::t4 failed")
    let t5 = testing.assert_false(e >= f, "test_comparisons::t5 failed")

fn test_logical_ops() raises:
    let g = U24[0]()
    let h = U24[255]()

    let t1 = testing.assert_true((g & h).__into_int__() == 0, "test_logical_ops::t1 failed")
    let t2 = testing.assert_true((g | h).__into_int__() == 255, "test_logical_ops::t2 failed")
    let t3 = testing.assert_true((g ^ h).__into_int__() == 255, "test_logical_ops::t3 failed")

fn test_boolean_invert() raises:
    let i = U24[0]()
    let j = U24[42]()

    let t1 = testing.assert_false(i.__bool__(), "test_boolean_invert::t1 failed")
    let t2 = testing.assert_true(~i, "test_boolean_invert::t2 failed")
    let t3 = testing.assert_true(j.__bool__(), "test_boolean_invert::t3 failed")
    let t4 = testing.assert_false(~j, "test_boolean_invert::t4 failed")

fn main() raises:
    print("Tests Results (if any): ")
    test_size_of_U24()
    test_plus_minus_times_divide()
    test_comparisons()
    test_logical_ops()
    test_boolean_invert()
    print("Tests Completed!")

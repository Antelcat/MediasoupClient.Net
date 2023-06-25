%typemap(cscode) SWIGTYPE %{
  public bool Equals(object obj) {
    return obj is $csclassname o && o.swigCPtr == this.swigCPtr;
  }

  public int GetHashCode() {
    return swigCPtr.Handle.GetHashCode();
  }
%}
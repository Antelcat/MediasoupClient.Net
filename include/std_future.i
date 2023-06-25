// 将C++中的std::future映射到C#中的Task

// 例子1：继承C++中的纯虚函数
//
// C++代码：
// class Listener {
// protected:
//     virtual std::future<std::string> OnProduce() = 0;
// };
// 
// C#绑定：
// class Listener {
//     protected abstract Task<string> OnProduce();
// }
// 
// C#用法：
// class MyListener : Listener {
//     protected override Task<string> OnProduce() {
//         var tcs = new TaskCompletionSource<string>();
//         Task.Run(() => {
//             // do something
//             tcs.SetResult("result");
//         });
// 
//         return tcs.Task;
//     }
// }
// 

// %module(directors="1") std_future

// %{
// #include <future>
// #include <string>

// template<typename T>
// void RunFuture(std::future<T>& fut, void(*set_result)(T), void(*set_exception)(const char*), void(*set_canceled)()) {
//     if (fut.valid()) {
//         try {
//             set_result(fut.get());
//         } catch (const std::exception& e) {
//             set_exception(e.what());
//         } catch (...) {
//             set_canceled();
//         }
//     }
// }
// %}

// %include <std_string.i>

// %typemap(cscode) std::future<std::string> %{
//     public delegate Task<string> Func();

//     public class Future {
//         private readonly TaskCompletionSource<string> tcs = new TaskCompletionSource<string>();
//         private readonly Func func;

//         public Future(Func func) {
//             this.func = func;
//             this.func().ContinueWith(t => {
//                 if (t.IsFaulted) tcs.SetException(t.Exception.Message);
//                 else if (t.IsCanceled) tcs.SetCanceled();
//                 else tcs.SetResult(t.Result);
//             });
//         }

//         public Task<string> AsTask() => tcs.Task;
//     }
// %}

// %template(StringFuture) std::future<std::string>;
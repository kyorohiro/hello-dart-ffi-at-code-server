import 'dart:ffi' as ffi;
import 'dart:typed_data';
ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open("/app/libc/libhello.so");

// void hello();
typedef PrintHello_func = ffi.Void Function();
typedef PrintHello = void Function();
final PrintHello hello = dylib
    .lookup<ffi.NativeFunction<PrintHello_func>>('print_hello')
    .asFunction();

// int sum(a, b)
typedef Sum_func = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
typedef Sum = int Function(int a, int b);
var sum = dylib
      .lookup<ffi.NativeFunction<Sum_func>>('sum')
      .asFunction<Sum>();

// pointer<int8> new_buffer(int size)
typedef Malloc_func = ffi.Pointer<ffi.Uint8> Function(ffi.Int32 size);
typedef Malloc = ffi.Pointer<ffi.Uint8> Function(int size);
var newBuffer = dylib
      .lookup<ffi.NativeFunction<Malloc_func>>('new_buffer')
      .asFunction<Malloc>();

// pointer<int8> init_buffer(int size)
typedef InitBuffer_func = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> buffer, ffi.Int32 size);
typedef InitBuffer = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> buffer, int size);
var initBuffer = dylib
      .lookup<ffi.NativeFunction<InitBuffer_func>>('init_buffer')
      .asFunction<InitBuffer>();


void main(List<String> arguments) {
  hello();
  int sum_ret = sum(1,2);
  print("sum_ret = ${sum_ret}");

  // new pointer
  var buffer = newBuffer(12);
  for(int i=0;i<12;i++){
    print(buffer.elementAt(i).value);
  }
  // pointer -> pointer
  buffer = initBuffer(buffer, 12);
  for(int i=0;i<12;i++){
    print(buffer.elementAt(i).value);
  }
  // pointer -> uint8slist
  Uint8List bufferAsUint8List =  buffer.asTypedList(12);
  for(int i=0;i<bufferAsUint8List.length;i++){
    print(bufferAsUint8List[i]);
  }

  //
  // amazing point
  // https://github.com/flutter/flutter/issues/48360
  bufferAsUint8List[0] = 101;
  print(buffer.elementAt(0).value);

}



if (CLANGD_ENABLE_REMOTE)
  generate_protos(RemoteIndexServiceProto "Service.proto" GRPC)
  generate_protos(RemoteIndexProto "Index.proto")
  include_directories(${CMAKE_CURRENT_BINARY_DIR})
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../)

  # FIXME(kirillbobyrev): target_compile_definitions is not working with
  # add_clang_library for some reason. Is there any way to make this
  # target-local?
  add_definitions(-DGOOGLE_PROTOBUF_NO_RTTI=1)

  add_clang_library(clangdRemoteIndex
    Client.cpp

    LINK_LIBS
    RemoteIndexProto
    RemoteIndexServiceProto
    clangdRemoteMarshalling

    protobuf
    grpc++
    clangDaemon
    clangdSupport

    DEPENDS
    RemoteIndexProto
    RemoteIndexServiceProto
    )

  add_subdirectory(marshalling)
  add_subdirectory(server)
else()
  # Provides a dummy implementation of clangdRemoteIndex.
  add_subdirectory(unimplemented)
endif()

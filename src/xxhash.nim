{.compile: "xxHash/xxhash.c".}

const XXHASH_HEADER = "xxHash/xxhash.h"

type
  XXH64_state_t {.importc, header: XXHASH_HEADER, bycopy.} = object
    total_len: XXH64_hash_t
    v1: XXH64_hash_t
    v2: XXH64_hash_t
    v3: XXH64_hash_t
    v4: XXH64_hash_t
    mem64: array[4, XXH64_hash_t]
    memsize: XXH32_hash_t
    reserved32: XXH32_hash_t # /* required for padding anyway */
    reserved64: XXH64_hash_t # /* never read nor write, might be removed in a future version */
  XXH32_state_t {.importc, header: XXHASH_HEADER, bycopy.} = object
    total_len_32: XXH32_hash_t
    large_len: XXH32_hash_t
    v1: XXH32_hash_t
    v2: XXH32_hash_t
    v3: XXH32_hash_t
    v4: XXH32_hash_t
    mem32: array[4, XXH32_hash_t]
    memsize: XXH32_hash_t
    reserved: XXH32_hash_t
  XXH3_state_t {.importc, header: XXHASH_HEADER, bycopy.} = object
    bufferedSize: XXH32_hash_t
    nbStripesPerBlock: XXH32_hash_t
    nbStripesSoFar: XXH32_hash_t
    secretLimit: XXH32_hash_t
    reserved32: XXH32_hash_t
    reserved32_2: XXH32_hash_t
    totalLen: XXH64_hash_t
    seed: XXH64_hash_t
    reserved64: XXH64_hash_t
    secret: cstring
  XXH128_hash_t {.importc, header: XXHASH_HEADER, bycopy.} = object
    low64: XXH64_hash_t
    high64: XXH64_hash_t
  XXH32_canonical_t = array[4, char]
  XXH64_canonical_t = array[8, char]
  XXH128_canonical_t {.importc, header: XXHASH_HEADER, bycopy.} = object
    digest: array[16, char]
  XXH64_hash_t = uint64
  XXH32_hash_t = uint32
  XXH_errorcode {.importc.} = enum
    XXH_OK = 0,
    XXH_ERROR

### Binding
proc XXH32*(input: cstring, length: int, seed: XXH32_hash_t): XXH32_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_createState*(): ptr XXH32_state_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_freeState*(statePtr: ptr XXH32_state_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_copyState*(dst_state: ptr XXH32_state_t, src_state: ptr XXH32_state_t) {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_reset*(statePtr: ptr XXH32_state_t, seed: XXH32_hash_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_update*(statePtr: ptr XXH32_state_t, input: cstring, length: int): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_digest*(statePtr: ptr XXH32_state_t): XXH32_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_canonicalFromHash*(dst: ptr XXH32_canonical_t, hash: XXH32_hash_t) {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH32_hashFromCanonical*(src: ptr XXH32_canonical_t): XXH32_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64*(input: cstring, length: int, seed: XXH64_hash_t): XXH64_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_createState*(): ptr XXH64_state_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_freeState*(statePtr: ptr XXH64_state_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_copyState*(dst_state: ptr XXH64_state_t, src_state: ptr XXH64_state_t) {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_reset*(statePtr: ptr XXH64_state_t, seed: XXH64_hash_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_update*(statePtr: ptr XXH64_state_t, input: cstring, length: int): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_digest*(statePtr: ptr XXH64_state_t): XXH64_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_canonicalFromHash*(dst: ptr XXH64_canonical_t, hash: XXH64_hash_t) {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH64_hashFromCanonical*(src: ptr XXH64_canonical_t): XXH64_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits*(data: pointer, len: int): XXH64_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits_withSecret*(data: pointer, len: int, secret: pointer, secretSize: int): XXH64_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits_withSeed*(data: pointer, len: int, seed: XXH64_hash_t): XXH64_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_createState*(): ptr XXH3_state_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_freeState*(statePtr: ptr XXH3_state_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_copyState*(dst_state: ptr XXH3_state_t, src_state: ptr XXH3_state_t) {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits_reset*(statePtr: ptr XXH3_state_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits_reset_withSeed*(statePtr: ptr XXH3_state_t, seed: XXH64_hash_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits_reset_withSecret*(statePtr: ptr XXH3_state_t, secret: pointer, secretSize: int): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits_update*(statePtr: ptr XXH3_state_t, input: cstring, length: int): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_64bits_digest*(statePtr: ptr XXH3_state_t): XXH64_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH128*(data: pointer, len: int, seed: XXH64_hash_t): XXH128_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits*(data: pointer, len: int): XXH128_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits_withSeed*(data: pointer, len: int, seed: XXH64_hash_t): XXH128_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits_withSecret*(data: pointer, len: int, secret: pointer, secretSize: int): XXH128_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits_reset*(statePtr: ptr XXH3_state_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits_reset_withSeed*(statePtr: ptr XXH3_state_t, seed: XXH64_hash_t): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits_reset_withSecret*(statePtr: ptr XXH3_state_t, secret: pointer, secretSize: int): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits_update*(statePtr: ptr XXH3_state_t, input: cstring, length: int): XXH_errorcode {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH3_128bits_digest*(statePtr: ptr XXH3_state_t): XXH128_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH128_isEqual*(h1: XXH128_hash_t, h2: XXH128_hash_t): cint {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH128_cmp*(h128_1: pointer, h128_2: pointer): cint {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH128_canonicalFromHash*(dst: ptr XXH128_canonical_t, hash: XXH128_hash_t) {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH128_hashFromCanonical*(src: ptr XXH128_canonical_t): XXH128_hash_t {.cdecl, header: XXHASH_HEADER, importc.}
proc XXH_versionNumber*(): cuint {.cdecl, header: XXHASH_HEADER, importc.}
##

### Wrapper
import streams # Required for streamed hashing

proc streamedXXH64*(path: string, bufferSize: int): uint64 =
  var state: ptr XXH64_state_t = XXH64_createState()
  # if state == nil: return 0
  var buffer: pointer = alloc(bufferSize)
  var seed: XXH64_hash_t = 0; # /* or any other value */
  discard XXH64_reset(state, seed) # if XXH64_reset(state, seed) == XXH_ERROR: return 0
  var strm = newFileStream(path, fmRead)
  # if strm.isNil: return 0
  while not strm.atEnd():
    var length: int = strm.readData(cast[cstring](buffer), bufferSize)
    discard XXH64_update(state, cast[cstring](buffer), length) # if XXH64_update(state, cast[cstring](buffer), length) == XXH_ERROR: return 0
  strm.close()
  var hash: XXH64_hash_t = XXH64_digest(state)
  dealloc(buffer)
  discard XXH64_freeState(state)
  return hash
##

when isMainModule:
  import os
  import strutils
  const BUFFER_SIZE: int = 1024 * 1024 * 10 # 10 MiB
  for fileName in walkDirRec("./"):
    echo fileName & " - " & toHex(streamedXXH64(fileName, BUFFER_SIZE))


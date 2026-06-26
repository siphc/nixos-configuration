// C++ includes used for precompiling -*- C++ -*-

// Copyright (C) 2003-2022 Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 3, or (at your option)
// any later version.
//
// Under Section 7 of GPL version 3, you are granted additional
// permissions described in the GCC Runtime Library Exception, version
// 3.1, as published by the Free Software Foundation.
//
// You should have received a copy of the GNU General Public License and
// a copy of the GCC Runtime Library Exception along with this program;
// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
// <http://www.gnu.org/licenses/>.

/** @file bits/stdc++.h
 *  A precompiled-header convenience include, adapted to work under libc++
 *  (LLVM/Clang) as well as libstdc++ (GCC). Headers that some libc++ versions
 *  do not ship are wrapped in __has_include so the file degrades gracefully.
 */

// C
#ifndef _GLIBCXX_NO_ASSERT
#include <cassert>
#endif
#include <cctype>
#include <cerrno>
#include <cfloat>
#include <climits>
#include <clocale>
#include <cmath>
#include <csetjmp>
#include <csignal>
#include <cstdarg>
#include <cstddef>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <cwchar>
#include <cwctype>

#if __cplusplus >= 201103L
#include <cfenv>
#include <cinttypes>
#include <cstdint>
// Removed from the C++20 standard; still present in some libc++/libstdc++
// builds and inert when they are. Guarded so a stricter library is fine too.
#if __has_include(<ciso646>)
# include <ciso646>
#endif
#if __has_include(<ccomplex>)
# include <ccomplex>
#endif
#if __has_include(<ctgmath>)
# include <ctgmath>
#endif
#if __has_include(<cstdbool>)
# include <cstdbool>
#endif
#if __has_include(<cstdalign>)
# include <cstdalign>
#endif
// libc++ on Apple platforms often lacks <uchar.h>, so <cuchar> may be absent.
#if __has_include(<cuchar>)
# include <cuchar>
#endif
#endif

// C++
#include <algorithm>
#include <bitset>
#include <complex>
#include <deque>
#include <exception>
#include <fstream>
#include <functional>
#include <iomanip>
#include <ios>
#include <iosfwd>
#include <iostream>
#include <istream>
#include <iterator>
#include <limits>
#include <list>
#include <locale>
#include <map>
#include <memory>
#include <new>
#include <numeric>
#include <ostream>
#include <queue>
#include <set>
#include <sstream>
#include <stack>
#include <stdexcept>
#include <streambuf>
#include <string>
#include <typeinfo>
#include <utility>
#include <valarray>
#include <vector>

#if __cplusplus >= 201103L
#include <array>
#include <atomic>
#include <chrono>
#include <condition_variable>
#include <forward_list>
#include <future>
#include <initializer_list>
#include <mutex>
#include <random>
#include <ratio>
#include <regex>
#include <scoped_allocator>
#include <system_error>
#include <thread>
#include <tuple>
#include <typeindex>
#include <type_traits>
#include <unordered_map>
#include <unordered_set>
// Deprecated since C++17, still shipped by libc++; only warns when its
// facilities are used, not on include.
#if __has_include(<codecvt>)
# include <codecvt>
#endif
#endif

#if __cplusplus >= 201402L
#include <shared_mutex>
#endif

#if __cplusplus >= 201703L
#include <any>
#include <filesystem>
#include <optional>
#include <string_view>
#include <variant>
#if __has_include(<charconv>)
# include <charconv>
#endif
#if __has_include(<memory_resource>)
# include <memory_resource>
#endif
#if __has_include(<execution>)
# include <execution>
#endif
#endif

#if __cplusplus >= 202002L
#include <bit>
#include <compare>
#include <concepts>
#include <numbers>
#include <ranges>
#include <span>
#include <version>
#if __cpp_impl_coroutine
# include <coroutine>
#endif
// Concurrency headers: present in recent libc++, guarded for older ones.
#if __has_include(<barrier>)
# include <barrier>
#endif
#if __has_include(<latch>)
# include <latch>
#endif
#if __has_include(<semaphore>)
# include <semaphore>
#endif
#if __has_include(<stop_token>)
# include <stop_token>
#endif
#if __has_include(<source_location>)
# include <source_location>
#endif
#if __has_include(<syncstream>)
# include <syncstream>
#endif
#endif

#if __cplusplus > 202002L
#if __has_include(<expected>)
# include <expected>
#endif
#if __has_include(<spanstream>)   // not in libc++ as of v21
# include <spanstream>
#endif
#if __has_include(<stacktrace>)
# include <stacktrace>
#endif
#if __has_include(<stdatomic.h>)
# include <stdatomic.h>
#endif
#endif

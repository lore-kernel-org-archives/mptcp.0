Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F92E3705;
	Sun,  3 Aug 2025 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754187673; cv=none; b=DoefWNgdYvbajnSnFV6tuOs6vkXY6U3qePF3M159ZUNc15JJz1qvoXqgtBT2cZCcpLQ1DaN3HNCO6Js3Vo86pD8e1jgh+49ZZfBwQxr2mt9Oh6cTm/45vYM0NTBd66u8/xi7HlpXa85h4u+euIEfl7VuQiqI/b/oITcRIiSS/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754187673; c=relaxed/simple;
	bh=K7+haCZ/AANMxksMV3B0s0xfpe8EEaHSfghe1TYpWeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DASXd277G7fn1hVtOcFEyT10MKz9pnhl79ci5l1NV/U0IAonWW2QqtzafkjXR09p3pO6ZDowbHICSWQCL7YkIUs0G9Vt9frojbcymaSYAoffa3m2iaYlqVpGW6hRTVcatqZJ2yGG+UovkbzDmvecmpuiRsOo5kuHeud+qvL9tn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWasgsgv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWasgsgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754187670; x=1785723670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K7+haCZ/AANMxksMV3B0s0xfpe8EEaHSfghe1TYpWeU=;
  b=aWasgsgvNnoE7Rcw/ml9gofaiJihgMZQR622SJ+ujun2k50SoEAzi7aW
   1g3arqoxhFGLGAE3tbJCfCR2hZdIsyVYTFA0bGTnG7Q0V1cBJVpAyomPH
   ZNyblEWTY357znGFEE9s1Q5W8nk5saJAsnycjntPONcgU+OCDNT3Jmnd+
   SbmhCvx2Pm6Vdb35AMCi+LBbBrehVB4z6RNewulUoTn02E2KDb5rZJMja
   YrH60MT6cW5PXHqMcCUqedc5rsXbFdZ7pQBkny2uBg7mEkFo04XEBqvoo
   5BbpGpWVbUtXdMIWWxItnTLL3roECIRtIHvQdo7WpHdPImigvVQE2VgQp
   A==;
X-CSE-ConnectionGUID: tzlKUxywSXSf4g2weEGPLw==
X-CSE-MsgGUID: odOAWLv7RMqzTRUyxRJdbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="81933750"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="81933750"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 19:21:09 -0700
X-CSE-ConnectionGUID: xxnokUtGRRu8n6MUpRV6PQ==
X-CSE-MsgGUID: nAU/i3I/To+E0vdCR4Ns9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163144606"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Aug 2025 19:21:07 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiOLQ-0005jA-2B;
	Sun, 03 Aug 2025 02:21:04 +0000
Date: Sun, 3 Aug 2025 10:20:12 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add IPV6_UNICAST_HOPS sockopt
 support
Message-ID: <202508030946.WcaovHBw-lkp@intel.com>
References: <0fd13a7bb3ca420a1e68f49fe93e7baada72890b.1754126092.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd13a7bb3ca420a1e68f49fe93e7baada72890b.1754126092.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v6.16 next-20250801]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-add-IPV6_TCLASS-sockopt-support/20250802-212226
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/0fd13a7bb3ca420a1e68f49fe93e7baada72890b.1754126092.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next 3/3] mptcp: add IPV6_UNICAST_HOPS sockopt support
config: x86_64-buildonly-randconfig-006-20250803 (https://download.01.org/0day-ci/archive/20250803/202508030946.WcaovHBw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250803/202508030946.WcaovHBw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508030946.WcaovHBw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mptcp/sockopt.c:1581:34: error: no member named 'ipv6' in 'struct net'
    1581 |                         val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
         |                                         ~~~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:533:10: note: expanded from macro '__native_word'
     533 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/linux/compiler_types.h:572:22: note: expanded from macro 'compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:560:23: note: expanded from macro '_compiletime_assert'
     560 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:552:9: note: expanded from macro '__compiletime_assert'
     552 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/mptcp/sockopt.c:1581:34: error: no member named 'ipv6' in 'struct net'
    1581 |                         val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
         |                                         ~~~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:533:39: note: expanded from macro '__native_word'
     533 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/linux/compiler_types.h:572:22: note: expanded from macro 'compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:560:23: note: expanded from macro '_compiletime_assert'
     560 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:552:9: note: expanded from macro '__compiletime_assert'
     552 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/mptcp/sockopt.c:1581:34: error: no member named 'ipv6' in 'struct net'
    1581 |                         val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
         |                                         ~~~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:534:10: note: expanded from macro '__native_word'
     534 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/linux/compiler_types.h:572:22: note: expanded from macro 'compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:560:23: note: expanded from macro '_compiletime_assert'
     560 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:552:9: note: expanded from macro '__compiletime_assert'
     552 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/mptcp/sockopt.c:1581:34: error: no member named 'ipv6' in 'struct net'
    1581 |                         val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
         |                                         ~~~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:534:38: note: expanded from macro '__native_word'
     534 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/linux/compiler_types.h:572:22: note: expanded from macro 'compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:560:23: note: expanded from macro '_compiletime_assert'
     560 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:552:9: note: expanded from macro '__compiletime_assert'
     552 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/mptcp/sockopt.c:1581:34: error: no member named 'ipv6' in 'struct net'
    1581 |                         val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
         |                                         ~~~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                       ^
   include/linux/compiler_types.h:572:22: note: expanded from macro 'compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:560:23: note: expanded from macro '_compiletime_assert'
     560 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:552:9: note: expanded from macro '__compiletime_assert'
     552 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/mptcp/sockopt.c:1581:34: error: no member named 'ipv6' in 'struct net'
    1581 |                         val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
         |                                         ~~~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:522:13: note: expanded from macro '__unqual_scalar_typeof'
     522 |                 _Generic((x),                                           \
         |                           ^
>> net/mptcp/sockopt.c:1581:34: error: no member named 'ipv6' in 'struct net'
    1581 |                         val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
         |                                         ~~~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   7 errors generated.


vim +1581 net/mptcp/sockopt.c

  1558	
  1559	static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
  1560				       char __user *optval, int __user *optlen)
  1561	{
  1562		struct sock *sk = (void *)msk;
  1563		int val;
  1564	
  1565		switch (optname) {
  1566		case IPV6_V6ONLY:
  1567			return mptcp_put_int_option(msk, optval, optlen,
  1568						    sk->sk_ipv6only);
  1569		case IPV6_TRANSPARENT:
  1570			return mptcp_put_int_option(msk, optval, optlen,
  1571						    inet_test_bit(TRANSPARENT, sk));
  1572		case IPV6_FREEBIND:
  1573			return mptcp_put_int_option(msk, optval, optlen,
  1574						    inet_test_bit(FREEBIND, sk));
  1575		case IPV6_TCLASS:
  1576			return mptcp_put_int_option(msk, optval, optlen,
  1577						    inet6_sk(sk)->tclass);
  1578		case IPV6_UNICAST_HOPS:
  1579			val = READ_ONCE(inet6_sk(sk)->hop_limit);
  1580			if (val < 0)
> 1581				val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
  1582			return mptcp_put_int_option(msk, optval, optlen, val);
  1583		}
  1584	
  1585		return -EOPNOTSUPP;
  1586	}
  1587	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

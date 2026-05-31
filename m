Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FE335BA;
	Sun, 31 May 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780232678; cv=none; b=hIa8H+Ae/Imx/SdbzM/+p3tSoRGILdOAUVq76/4vjH0CR7KcGR8hHhDeIdeIooB4bzu3Wsx10vwiosU5JOxSR2nNPpKKztvX3pjBqfNAmlanlEauhRgcGw8/IHA+7JdL9E273nWOBYA31z5mJ0zD1Bj+Og8WAlTLfNGFCtB2AUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780232678; c=relaxed/simple;
	bh=KXYiQ/EWH/syonYMw6B3JK/DzVa3oSMhCPGIkAqHpc4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kjwzCAvdv0LYGyFZo4cz6chjNbJfBH371jy2zZievjFQzkkpjyteKP0IW9BYpfSM2lkzEnla/QeizlaR+Sfg/8Mt9PSySDcZlN4BdW09IEHi5xDxyWAQZMNaMHD0OdnhAEuDpfexr/jypCm9Y7dJw/jz914+CUnWL0D+t+H6/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YS7cep8w; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YS7cep8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780232676; x=1811768676;
  h=date:from:to:cc:subject:message-id;
  bh=KXYiQ/EWH/syonYMw6B3JK/DzVa3oSMhCPGIkAqHpc4=;
  b=YS7cep8wxEYPYch0ilPpVmpZ7CKXEXiWeLmvVcsvXm09jXNSjrWZrlXM
   NvnVzCY/2l/pHnLoZ9meZYffK9xe9gyccFDhn/1HqBaP11C2PtL08BA7K
   +SfC4lx6rA7HDNz9xxywvB3UkVLjXzFJxrtzyDSfMhoxEk2a4CpIlqdvN
   I2/YlUriT4EU98iDFvx2IbX0nyECg9CjH3Dxq0ZXjAzXLNK2EtuE+Ip09
   qlrS0pnsshBbs0PYYbn5/tQ4rc4X0DAK3g2zL5cnZF9Nz5Nw6181AStC7
   dUk40MBulDOhBDM2pEVkw6ehmkpdQrt9h300Wmgn6E2gq5aBBIDUifCRW
   w==;
X-CSE-ConnectionGUID: wH7fWcQHR/aTmUB6NEXmMg==
X-CSE-MsgGUID: H4vNSgd9ReWFV05QLdxlSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81198258"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="81198258"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 06:04:36 -0700
X-CSE-ConnectionGUID: 3bXJbdQRR5SH7cdyut+nyw==
X-CSE-MsgGUID: z8Ux4JpPQOyJ7b05jkvyxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="239134440"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 31 May 2026 06:04:33 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTfqA-000000009R8-1XqS;
	Sun, 31 May 2026 13:04:30 +0000
Date: Sun, 31 May 2026 21:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [mptcp:export-net 15/22]
 include/linux/compiler_types.h:699:45: error: call to
 '__compiletime_assert_784' declared with attribute error: BUILD_BUG_ON
 failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
Message-ID: <202605312026.Srgsz7Tp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   27a7d32aeb103a5c763966a494b141136c31cea0
commit: 206cf8c6e2bfce69eba0d463b3f6127d14f75abc [15/22] mptcp: fix uninit-value in mptcp_established_options
config: arm-collie_defconfig (https://download.01.org/0day-ci/archive/20260531/202605312026.Srgsz7Tp-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605312026.Srgsz7Tp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605312026.Srgsz7Tp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'mptcp_established_options_dss',
       inlined from 'mptcp_established_options' at net/mptcp/options.c:881:11:
>> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_784' declared with attribute error: BUILD_BUG_ON failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
     680 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   net/mptcp/options.c:576:9: note: in expansion of macro 'BUILD_BUG_ON'
     576 |         BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_784 +699 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  685  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  686  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  687  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  689  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  690   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  691   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  692   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @699  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700  

:::::: The code at line 699 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

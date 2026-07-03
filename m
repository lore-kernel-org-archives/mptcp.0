Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419331A556;
	Fri,  3 Jul 2026 03:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050723; cv=none; b=Vp7W9rMJYf1tyw7NsGpRrDfPtQ3C2TZ50khM4fA1eZAOCxImThIRXL1UtoEO5yn99qyl+SMwnqozqppps5VeXmMhq4x7qloq45/YWb+rmpxmVKMPQzCATiaxkNGN4W3/WBubullkqgsMNUPrAN1KnAVBRl1vHfrI7L0OKDjfk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050723; c=relaxed/simple;
	bh=HgxNGsRnPLt5uB/quaGMig6e8D321yKKn9v2DnqeojQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C74TrixqU7kmAuykzbHFnDGqIBDhe4Lscuj7jbL7bn5Tog6urq5SCwGi/ECoaZ3XprwnV0Rj9j8noDy5n9jdQbETDNmQ3AaTubQf7eGD9rhiVA/EHRNQKbsQ+i8RrNIgBgJKX4satq6w2+PRSMPxJuklUBjL2xYkkKMzRTeyFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdzmRgjl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdzmRgjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783050713; x=1814586713;
  h=date:from:to:cc:subject:message-id;
  bh=HgxNGsRnPLt5uB/quaGMig6e8D321yKKn9v2DnqeojQ=;
  b=mdzmRgjlsGBZ8J//9imJ0nd68MKT7bAbb/FGXDSj0XIBF8ZQRneesdvT
   I65xglGgxwfuidLwU/8OnBzckzUD4luNqX5yjZrZI8+L9D8BUYq30cpZv
   Vo+cR1souSn2IOBdJ3jOcd2/MdiVTJPZbDc8yhBGAeDYcJi9wgpsoX9HS
   PTzarpvcq1IKyOXNgUzOiHzV1+S/ePLAnkCsWeYExB/3nIpUVz2NVbmXJ
   QNsrvQNGHLy3ttl/5iGy3qf4j8auGGCaCCsTprxlQGocMYMdr0SeuB4Rq
   jj8WwxT5xn71VQbPhRXVR5qB2oDpCc1pay7nCybVlqeXgcnYktCxsQNf6
   w==;
X-CSE-ConnectionGUID: oP9J6PoJREWcrwcVlxSLrw==
X-CSE-MsgGUID: sBV5B4z8SbOhn0cq2pksVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83855769"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83855769"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 20:51:51 -0700
X-CSE-ConnectionGUID: 3MTRuTKxQ+eiBOhpi4LhRA==
X-CSE-MsgGUID: qcVS1yt2ReWh25gYWWBLXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="283099229"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2026 20:51:48 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wfUwL-00000000BdX-1SwI;
	Fri, 03 Jul 2026 03:51:45 +0000
Date: Fri, 03 Jul 2026 11:51:39 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, matthieu.baerts@tessares.net,
 Jakub Kicinski <kuba@kernel.org>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: include/linux/compiler_types.h:699:45: error: call to
 '__compiletime_assert_881' declared with attribute error: BUILD_BUG_ON
 failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
Message-ID: <202607031100.upQfRZTM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   51512e22efe813d8223de27f6fd02a8a48ea2323
commit: 5e939544f9d2b4d5c052a07cfcde97de44263946 mptcp: fix uninit-value in mptcp_established_options
date:   4 weeks ago
config: arm-randconfig-r051-20260702 (https://download.01.org/0day-ci/archive/20260703/202607031100.upQfRZTM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260703/202607031100.upQfRZTM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Fixes: 5e939544f9d2 ("mptcp: fix uninit-value in mptcp_established_options")
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607031100.upQfRZTM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'mptcp_established_options_dss',
       inlined from 'mptcp_established_options' at net/mptcp/options.c:881:11:
>> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_881' declared with attribute error: BUILD_BUG_ON failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
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


vim +/__compiletime_assert_881 +699 include/linux/compiler_types.h

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

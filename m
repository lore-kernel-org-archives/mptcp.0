Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23224372EFA;
	Thu,  6 Aug 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038059; cv=none; b=SY15D+Ve2btwkfU7ggsWmYFvQVbTeMkMUK7fyKVqjzliwscMO/taDK7moXQPl3gmfWjC+Dalr19Foj/wSNW1J/X5ZWrB+oa466BuVcew4mzR1d992mUiwX5Fjda/TqxFBhbXRPMnhhjdFeZDyoSuUllufKblNGvbecJFP1Rm1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038059; c=relaxed/simple;
	bh=jR6UAf+W3pRyagiBnBIthX9L1RTvVK8tgmNzQD67mJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnxA61I61T8q3hiKRA2zTWkPq4jZoCjbelZ06oazTGLVBlSRkHxB7DOC5PTDTSBV4C07/yjbMVAfafT7IVI9tjJC9x1WbOGmFfE/HdV9bz/C7nzmeb70h0UZXyb0uethVduKy1Fq3pnyjBYrx4m9rz9gyvQy9RXBX8d5JH4yV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWpTxuxP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWpTxuxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786038058; x=1817574058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jR6UAf+W3pRyagiBnBIthX9L1RTvVK8tgmNzQD67mJU=;
  b=lWpTxuxPDWz8JQzO9DOn/GoslLZ7c1UN3NkPUIy08mh9OA2HKcWIcxuy
   ihbPUl7o8B8tjcSghoWzuPTmAZH4cZfv/ra1ox4CtUy71ep0ZUEyzJbNJ
   Ed0cFP4tDWbTzm+7pFJfZK0+LWTm0k93ApptxeFJRDmpeNdtLKpwGPZfd
   BcodF6DnuNYkysOLHvssREQN1nEPz1eUI0zOb3u1IkN/cc/I04ncO8Cjo
   5nV9l5B1oifh1XR181yst5Hguru/xgQAiBIvIjZOjZYwkHYjJE3bFzPAy
   uc8RnMtnlJ+CKjQW1u4HLwdyPWb6XgynmYpFQxlsh6OMYTlkpzGZjTWdm
   g==;
X-CSE-ConnectionGUID: 6LjKdj7kR/++lQbyiQ35uw==
X-CSE-MsgGUID: HGjLAP0jQAyJhJw/jeuFFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98151987"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="98151987"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:40:57 -0700
X-CSE-ConnectionGUID: 7DB5m3cyQx2LtjOXhuPo6g==
X-CSE-MsgGUID: 1SUtF5e8QmWqOPxccB+TSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="300373251"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2026 10:40:51 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws25I-000000004f4-1D7z;
	Thu, 06 Aug 2026 17:40:48 +0000
Date: Thu, 6 Aug 2026 19:40:10 +0200
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, acpica-devel@lists.linux.dev,
	bpf@vger.kernel.org, coresight@lists.linaro.org,
	kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, virtualization@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] tools: Use fputc() calls in some functions
Message-ID: <202608061909.wj199SHx-lkp@intel.com>
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v7.2-rc6 next-20260806]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/tools-Use-fputc-calls-in-some-functions/20260806-165154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/48f2d61f-d468-49b7-881e-f00777db073f%40web.de
patch subject: [PATCH] tools: Use fputc() calls in some functions
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260806/202608061909.wj199SHx-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608061909.wj199SHx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608061909.wj199SHx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> builtin-check.c:300:8: error: incompatible pointer to integer conversion passing 'FILE *' (aka 'struct _IO_FILE *') to parameter of type 'int' [-Wint-conversion]
     300 |         fputc(stderr, '\n');
         |               ^~~~~~
   /usr/include/stdio.h:155:16: note: expanded from macro 'stderr'
     155 | #define stderr stderr
         |                ^~~~~~
   /usr/include/stdio.h:611:23: note: passing argument to parameter '__c' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                       ^
>> builtin-check.c:300:16: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'FILE *' (aka 'struct _IO_FILE *') [-Wint-conversion]
     300 |         fputc(stderr, '\n');
         |                       ^~~~
   /usr/include/stdio.h:611:34: note: passing argument to parameter '__stream' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                                  ^
   2 errors generated.
   make[5]: *** [tools/build/Makefile.build:95: tools/objtool/builtin-check.o] Error 1
>> disas.c:540:9: error: incompatible pointer to integer conversion passing 'FILE *' (aka 'struct _IO_FILE *') to parameter of type 'int' [-Wint-conversion]
     540 |                 fputc(stream, '\n');
         |                       ^~~~~~
   /usr/include/stdio.h:611:23: note: passing argument to parameter '__c' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                       ^
>> disas.c:540:17: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'FILE *' (aka 'struct _IO_FILE *') [-Wint-conversion]
     540 |                 fputc(stream, '\n');
         |                               ^~~~
   /usr/include/stdio.h:611:34: note: passing argument to parameter '__stream' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                                  ^
   2 errors generated.
   make[5]: *** [tools/build/Makefile.build:95: tools/objtool/disas.o] Error 1
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [Makefile:123: tools/objtool/objtool-in.o] Error 2
   make[4]: Target 'all' not remade because of errors.
   make[3]: *** [Makefile:74: objtool] Error 2
   make[2]: *** [Makefile:1587: tools/objtool] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

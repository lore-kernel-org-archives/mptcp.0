Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313F1C68E;
	Wed, 29 Nov 2023 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XugHhbXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701299784; x=1732835784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oghDfN6uRKsa7YvzXF92c7oeCtVHjzrqF5l8hCVMoMQ=;
  b=XugHhbXyAE6zk0utD2bWCEcivQIY4Oo8qPSNGAsFzI3XiNh/2HIaDBp0
   /t4tVrZ1Tm9SALT4swBrXNuz2p16L9F7GQ93ffGlgzlfFP2/Lumfi5uNb
   sVGQMe6pBrLZVhtij1xV9MPY210XcuW3HMmzXgNDUSOxlI5SlJdGglLsh
   YUs2p961Mgmv/PHc9MU5hgsLOGq+8eBZZMSlyBxwNbCcfDhk64LMFngGZ
   qobkvJ522xW3piKLKICcXGfaxKs36Rtqm4jaYui/Jj74ua0fr0aJ7dzZz
   ICxDCnD6EnDz14LmpaXKyJKXwdgWmuXjP5SP+1KH8uk+e6Ss3PuGLYBwE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="383638210"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="383638210"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:16:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892611929"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="892611929"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2023 15:16:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8Tn2-00014Q-0T;
	Wed, 29 Nov 2023 23:16:20 +0000
Date: Thu, 30 Nov 2023 07:15:41 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for
 tcp_set_state
Message-ID: <202311300545.66qcYRv2-lkp@intel.com>
References: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v6.7-rc3 next-20231129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-add-a-current-established-counter/20231129-131030
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for tcp_set_state
config: arm-randconfig-r111-20231129 (https://download.01.org/0day-ci/archive/20231130/202311300545.66qcYRv2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231130/202311300545.66qcYRv2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300545.66qcYRv2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mptcp/trace.c:39:22: error: call to undeclared function 'regs_get_kernel_argument'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      39 |         sk = (struct sock *)ftrace_regs_get_argument(fregs, 0);
         |                             ^
   include/linux/ftrace.h:158:2: note: expanded from macro 'ftrace_regs_get_argument'
     158 |         regs_get_kernel_argument(ftrace_get_regs(fregs), n)
         |         ^
   net/mptcp/trace.c:39:22: note: did you mean 'regs_get_kernel_stack_nth'?
   include/linux/ftrace.h:158:2: note: expanded from macro 'ftrace_regs_get_argument'
     158 |         regs_get_kernel_argument(ftrace_get_regs(fregs), n)
         |         ^
   arch/arm/include/asm/ptrace.h:131:22: note: 'regs_get_kernel_stack_nth' declared here
     131 | extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
         |                      ^
   1 error generated.


vim +/regs_get_kernel_argument +39 net/mptcp/trace.c

    30	
    31	static void mptcp_state_callback(unsigned long ip,
    32					 unsigned long parent_ip,
    33					 struct ftrace_ops *op,
    34					 struct ftrace_regs *fregs)
    35	{
    36		int oldstate, state;
    37		struct sock *sk;
    38	
  > 39		sk = (struct sock *)ftrace_regs_get_argument(fregs, 0);
    40		if (!sk)
    41			return;
    42	
    43		oldstate = sk->sk_state;
    44		state = (int)ftrace_regs_get_argument(fregs, 1);
    45	
    46		if (sk_is_mptcp(sk))
    47			mptcp_check_state(sk, oldstate, state);
    48	}
    49	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

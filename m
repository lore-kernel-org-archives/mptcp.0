Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE831878;
	Wed, 29 Nov 2023 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cm6h6dqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701225779; x=1732761779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fbhW+Y4Nokzk2SGkzxPDI37B1eAi3SqKAIb2QdudgAY=;
  b=Cm6h6dqYwuqQyRfmdp4MOQAAutTcaixE1ooJFSmz+1Q61AjY1MCNuaW3
   Kml5Prlk3zReCHaFF9Rr0hds1ByGREcS9QZG7MbWHUQSB9lJoNQ5CQ4dZ
   CMIWAayyOH6a2/6ctnUKF3x7DiRO54OCxGg9joR85R/rmRfksFAq16k4Q
   Rg8RYMPGQCl6VixHEdIkg/n8mI5uzCZOGNMY74pyVeGOp+z6LiIsNYsET
   t2LftNATkCEwnLMvoWu4r2eh1In1W1/ApsmnzUVGPIiCXwk/RxYnNUQNE
   Dw2srUfTjYhffM6GKtxNKMmsSAvxBKdMqCw/T0f3V9gIKIzMrwLLKOgWF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372449058"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372449058"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 18:42:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="745107752"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="745107752"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2023 18:42:56 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8AXN-0008SW-2g;
	Wed, 29 Nov 2023 02:42:53 +0000
Date: Wed, 29 Nov 2023 10:40:23 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next 3/4] mptcp: add ftrace callback of
 tcp_set_state
Message-ID: <202311290844.drzx9Vmn-lkp@intel.com>
References: <6f4baef54a7631cdc1460138bc7e52f2c432c69b.1701180777.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4baef54a7631cdc1460138bc7e52f2c432c69b.1701180777.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-add-mib-counter-dec-helper/20231128-221604
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/6f4baef54a7631cdc1460138bc7e52f2c432c69b.1701180777.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next 3/4] mptcp: add ftrace callback of tcp_set_state
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231129/202311290844.drzx9Vmn-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290844.drzx9Vmn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290844.drzx9Vmn-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mptcp/trace.c: In function 'mptcp_state_callback':
>> net/mptcp/trace.c:44:29: error: implicit declaration of function 'regs_get_kernel_argument'; did you mean 'regs_get_kernel_stack_nth'? [-Werror=implicit-function-declaration]
      44 |         sk = (struct sock *)regs_get_kernel_argument(regs, 0);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~
         |                             regs_get_kernel_stack_nth
   cc1: some warnings being treated as errors


vim +44 net/mptcp/trace.c

    30	
    31	static void notrace mptcp_state_callback(unsigned long ip,
    32						 unsigned long parent_ip,
    33						 struct ftrace_ops *op,
    34						 struct ftrace_regs *fregs)
    35	{
    36		struct pt_regs *regs;
    37		int oldstate, state;
    38		struct sock *sk;
    39	
    40		regs = ftrace_get_regs(fregs);
    41		if (!regs)
    42			return;
    43	
  > 44		sk = (struct sock *)regs_get_kernel_argument(regs, 0);
    45		if (!sk)
    46			return;
    47	
    48		oldstate = sk->sk_state;
    49		state = regs_get_kernel_argument(regs, 1);
    50	
    51		if (sk_is_mptcp(sk))
    52			mptcp_check_state(sk, oldstate, state);
    53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

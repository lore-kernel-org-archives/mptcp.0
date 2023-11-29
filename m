Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60174C9B;
	Wed, 29 Nov 2023 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apjJAVYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701225796; x=1732761796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gB2cUnTontjyqwLxbuWUMvI9LjLu8A8kf0ACND0gc8=;
  b=apjJAVYE8rYfmE1p4r9ciEjOjUejh+DNeHcAOOT5AbddWDDdwozbZl/F
   k5nz4AZplxlWicwvf+aGi+Gw0+2RewDuTfczN4LHAe+3dIdPPqvP1Mc5F
   Veniz2tmCkns21O7IGjxr42mE2u3UkHc4u4SHTU4p2Z/6tw+Mu/P0dLvR
   XRhcXBLRdnpjXpyjEtrpd1bHJPpEs85eXKhc8rTupw+9sK7g5V6thCndf
   b3kG5LuO97zAwUkfsDE6m5TV6p24XOZW15hLCw0gnhxN8DbwgkDK9rzZQ
   H5P46qqBR3/A47xtDEGTZjZm4g5ibT5IzTlruhhLsdrSfFxDtVwcIXKCG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="373263238"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="373263238"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 18:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762137750"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="762137750"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2023 18:43:08 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8AXa-0008Ss-22;
	Wed, 29 Nov 2023 02:43:06 +0000
Date: Wed, 29 Nov 2023 10:40:33 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next 3/4] mptcp: add ftrace callback of
 tcp_set_state
Message-ID: <202311290855.aEWX2Ohy-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[also build test WARNING on mptcp/export-net linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-add-mib-counter-dec-helper/20231128-221604
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/6f4baef54a7631cdc1460138bc7e52f2c432c69b.1701180777.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next 3/4] mptcp: add ftrace callback of tcp_set_state
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20231129/202311290855.aEWX2Ohy-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290855.aEWX2Ohy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290855.aEWX2Ohy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mptcp/trace.c: In function 'mptcp_state_callback':
   net/mptcp/trace.c:44:29: error: implicit declaration of function 'regs_get_kernel_argument'; did you mean 'regs_get_kernel_stack_nth'? [-Werror=implicit-function-declaration]
      44 |         sk = (struct sock *)regs_get_kernel_argument(regs, 0);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~
         |                             regs_get_kernel_stack_nth
>> net/mptcp/trace.c:44:14: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      44 |         sk = (struct sock *)regs_get_kernel_argument(regs, 0);
         |              ^
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

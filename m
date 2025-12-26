Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123EA92E;
	Fri, 26 Dec 2025 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766727638; cv=none; b=ImJsHS5XPHtQSL98XVmlE6rMhh+HUtgWbATksvRh9kcNk6/HBMKavAJJprVJ5Y5//0bhnp+FDRZexQcQzUYq6CLBpXA7T0+QeW9NveirLRYCOnpGHe+DcmMmqc4QalWsWzzGMqcFp3yzrSXbcZpHaOoXNpVudP6l3fAJznM/3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766727638; c=relaxed/simple;
	bh=+hkccAZuBW95jPpjYYvEPX3r+GbHRl454mPKjzKNaok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJrcxahdytHRt4KIbEVyEqcMmQrzFaralKGXWqBVvq/59J5XAFTi7knlJqsYCpANcK/5VGqHQEvikF9dljFCIkvT+zSps7nxWKWQ1Af7q6vaZ/a5+1NAvv9WnxkfeTmYZXpDYID1wO7Fc4FTjP6m65J12Dblaxd3/hfP0fauvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+FCsEjk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+FCsEjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766727636; x=1798263636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hkccAZuBW95jPpjYYvEPX3r+GbHRl454mPKjzKNaok=;
  b=L+FCsEjkdE//BHZIBBTcPsHKfkzehcr4wWXsq5YS1lUEApKB+Ah3ACRT
   2/ONvbImjCEHpkXLGnvKleyObL2h2paYnEeXG6643RfP8c9Wg/P02R2jD
   KCPTwKWsVPPCIuo9PaE5nWP4Rl096UIZa0cNb0g0wCRLsDzUsWJX9L6u/
   dBYe+U+nH2hVXaFoIxiMBB7ztlIVCJMg6UNZQm1Yf8oXJ/HNNbdvpXlsu
   nlDkGpzvxsTBaDTpfhdyhxP+exOFOG8JMh2XKpooZynk5lhwF2CqfKawd
   1VxZ312/l2yqsNEa5Y1j5PPEhi1tzdLBnAsRrabvF3qTkGOn0DoPOfu+K
   A==;
X-CSE-ConnectionGUID: u2SgnMLnR7i8E+bGMjbMsA==
X-CSE-MsgGUID: yMRvWiQaTW+Ob2Xi6RV6Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="56062725"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="56062725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 21:40:35 -0800
X-CSE-ConnectionGUID: r6dIUj2HQoa8U8beK9UkBA==
X-CSE-MsgGUID: nyuOGFWxQnGuK9ybQRit+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="237727729"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Dec 2025 21:40:33 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZ0Yx-000000004jN-2983;
	Fri, 26 Dec 2025 05:40:31 +0000
Date: Fri, 26 Dec 2025 13:39:33 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: implement psock_update_sk_prot
Message-ID: <202512261326.9cQpYwdp-lkp@intel.com>
References: <f2508c5923c4ed365d6c12800e43a16761ed615a.1766653030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2508c5923c4ed365d6c12800e43a16761ed615a.1766653030.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-implement-psock_update_sk_prot/20251225-170243
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/f2508c5923c4ed365d6c12800e43a16761ed615a.1766653030.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next 1/3] mptcp: implement psock_update_sk_prot
config: arc-defconfig (https://download.01.org/0day-ci/archive/20251226/202512261326.9cQpYwdp-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251226/202512261326.9cQpYwdp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512261326.9cQpYwdp-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mptcp/protocol.c: In function 'mptcp_bpf_rebuild_protos':
>> net/mptcp/protocol.c:4043:51: error: 'sock_map_destroy' undeclared (first use in this function); did you mean 'sock_diag_destroy'?
    4043 |         prot[MPTCP_BPF_BASE].destroy            = sock_map_destroy;
         |                                                   ^~~~~~~~~~~~~~~~
         |                                                   sock_diag_destroy
   net/mptcp/protocol.c:4043:51: note: each undeclared identifier is reported only once for each function it appears in
>> net/mptcp/protocol.c:4044:51: error: 'sock_map_close' undeclared (first use in this function); did you mean 'sk_msg_clone'?
    4044 |         prot[MPTCP_BPF_BASE].close              = sock_map_close;
         |                                                   ^~~~~~~~~~~~~~
         |                                                   sk_msg_clone
   net/mptcp/protocol.c: At top level:
   net/mptcp/protocol.c:4079:12: warning: 'mptcp_bpf_update_proto' defined but not used [-Wunused-function]
    4079 | static int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +4043 net/mptcp/protocol.c

  4038	
  4039	static void mptcp_bpf_rebuild_protos(struct proto prot[MPTCP_BPF_NUM_CFGS],
  4040					     struct proto *base)
  4041	{
  4042		prot[MPTCP_BPF_BASE]			= *base;
> 4043		prot[MPTCP_BPF_BASE].destroy		= sock_map_destroy;
> 4044		prot[MPTCP_BPF_BASE].close		= sock_map_close;
  4045		prot[MPTCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
  4046	
  4047		prot[MPTCP_BPF_TX]			= prot[MPTCP_BPF_BASE];
  4048		prot[MPTCP_BPF_RX]			= prot[MPTCP_BPF_BASE];
  4049		prot[MPTCP_BPF_TXRX]			= prot[MPTCP_BPF_TX];
  4050	}
  4051	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

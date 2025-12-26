Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645891E3DE5;
	Fri, 26 Dec 2025 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766719498; cv=none; b=DajXCFWy4EYP/VhVaPD/1u5IvmyA23zlkfPp9JXu7r4kFwKqiTg93f0mqDJiWQbVUe/wANOFHJwC5RUfcr6P+J9s1uR0HQ2UcebrujMsdVJCFQvH5YrYzWuExS4oIRUAFqk4niKWbnHmfI5OXEFc6qQS1Q3lTsa+QAlH2tDU5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766719498; c=relaxed/simple;
	bh=PkGiF3AbGksqohvKGUUIK1j4unoG/RYWEFIRcHdSUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCUkFYWICoAmb6p+lReq53dDYgxZEdgnF271WRhoCVBRGBXHX26OgAl0JjEqkOqmtNezUDV0ujrKcRbH2d98cpajs7Ub6z1296L5SqkzMpYDc2e8CqqVRg1grL+wuYS+xa23zNnJhGz4/LN60PZz3zf1fepuoWvSRfXyEhhi51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnalGOLg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnalGOLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766719496; x=1798255496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkGiF3AbGksqohvKGUUIK1j4unoG/RYWEFIRcHdSUVU=;
  b=HnalGOLgdyLbTL2YBs+HfMldGTpQyEuDSXL/v0oQ1edKFSroYqY8/YgE
   ZctS7IGgC52jIdgRBXRAfa27SnRnZ+2iReHCWAeSbqdkEIgnK/XihVEIU
   XdrD2oLuaAnVDGjREiskdwWzjrXRTCqiBHbm+7NlGJ6dmkmA6e8ElqAWW
   t15xCZTfArUcoV9N+9epQi9GM2D6WHN2QvEok4whTm5Y+oMPueTe/1Akw
   LI2lR+EooysQDTG19BXggn2cMSR6KHAU8JUw1ejqhXvTzOi1GzOt747na
   FaaOjoWdjcQCIRVEAlVFalj+O44vZRdh2lo80vvTMip/aPJjX24rM5TqG
   g==;
X-CSE-ConnectionGUID: HgNxaGJkQaextWjKDyEc+g==
X-CSE-MsgGUID: BiWXkmquTXS6nNNdMIouLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="56058654"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="56058654"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 19:24:55 -0800
X-CSE-ConnectionGUID: DR4lHJfaRCSeiH5INfu8rQ==
X-CSE-MsgGUID: Bkt3+5EdSoGDNKYtCqGKnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="237712186"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Dec 2025 19:24:55 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYyRf-000000004ez-05BV;
	Fri, 26 Dec 2025 03:24:51 +0000
Date: Fri, 26 Dec 2025 11:24:06 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: implement psock_update_sk_prot
Message-ID: <202512261144.DxrvwMS3-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[also build test WARNING on mptcp/export-net linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-implement-psock_update_sk_prot/20251225-170243
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/f2508c5923c4ed365d6c12800e43a16761ed615a.1766653030.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next 1/3] mptcp: implement psock_update_sk_prot
config: arc-defconfig (https://download.01.org/0day-ci/archive/20251226/202512261144.DxrvwMS3-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251226/202512261144.DxrvwMS3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mptcp/protocol.c: In function 'mptcp_bpf_rebuild_protos':
   net/mptcp/protocol.c:4043:51: error: 'sock_map_destroy' undeclared (first use in this function); did you mean 'sock_diag_destroy'?
    4043 |         prot[MPTCP_BPF_BASE].destroy            = sock_map_destroy;
         |                                                   ^~~~~~~~~~~~~~~~
         |                                                   sock_diag_destroy
   net/mptcp/protocol.c:4043:51: note: each undeclared identifier is reported only once for each function it appears in
   net/mptcp/protocol.c:4044:51: error: 'sock_map_close' undeclared (first use in this function); did you mean 'sk_msg_clone'?
    4044 |         prot[MPTCP_BPF_BASE].close              = sock_map_close;
         |                                                   ^~~~~~~~~~~~~~
         |                                                   sk_msg_clone
   net/mptcp/protocol.c: At top level:
>> net/mptcp/protocol.c:4079:12: warning: 'mptcp_bpf_update_proto' defined but not used [-Wunused-function]
    4079 | static int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +/mptcp_bpf_update_proto +4079 net/mptcp/protocol.c

  4078	
> 4079	static int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
  4080	{
  4081		int family = sk->sk_family == AF_INET6 ? MPTCP_BPF_IPV6 : MPTCP_BPF_IPV4;
  4082		int config = psock->progs.msg_parser   ? MPTCP_BPF_TX   : MPTCP_BPF_BASE;
  4083	
  4084		if (psock->progs.stream_verdict || psock->progs.skb_verdict)
  4085			config = (config == MPTCP_BPF_TX) ? MPTCP_BPF_TXRX : MPTCP_BPF_RX;
  4086	
  4087		if (restore) {
  4088			sk->sk_write_space = psock->saved_write_space;
  4089			/* Pairs with lockless read in sk_clone_lock() */
  4090			sock_replace_proto(sk, psock->sk_proto);
  4091			return 0;
  4092		}
  4093	
  4094		if (sk->sk_family == AF_INET6) {
  4095			if (mptcp_bpf_assert_proto_ops(psock->sk_proto))
  4096				return -EINVAL;
  4097	
  4098			mptcp_bpf_check_v6_needs_rebuild(psock->sk_proto);
  4099		}
  4100	
  4101		/* Pairs with lockless read in sk_clone_lock() */
  4102		sock_replace_proto(sk, &mptcp_bpf_prots[family][config]);
  4103		return 0;
  4104	}
  4105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

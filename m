Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D419B3EC;
	Sat,  5 Jul 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751738667; cv=none; b=Gxqv57TipW8QqlFzM6AaOx7GqlWrOxsW/+USKri/t4CJZCij2C81Xrg5Og58uDOuUkbAAW6zNd+iTIAgvjYw2oJvObVbFfr1fzDA5OtcS+L0/DfsTYLVs4Hnobp3xK5w8tcDwuhLIkaeYX7+2MpxGTjMNK+Xk5Aiudj+wzrMZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751738667; c=relaxed/simple;
	bh=u2m97IEAGONBq4DHbWrRo6iqTcVy1nCKihslhpl4/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKQSsuzjxo5yAK0YYCRkpNnsrVZ9yh3I82ssgS92Tb2VPTqwZ/1ldroJBeQQzI4/lhk1mucYfvz0WzY7RFaddxdUm8AjtveGtWvnt32NKrdM7r6nNVZucoNTMb7yz2ZFihjlbe83HzIwcgUB/I9JEmUpjdHg0+CjjZYTfcx9zWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgQaMGfo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgQaMGfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751738666; x=1783274666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2m97IEAGONBq4DHbWrRo6iqTcVy1nCKihslhpl4/f4=;
  b=KgQaMGfopjnjMdOHluBDRBof0iTO7vdeDVbuJDo+sn8qlwtaw4ueTSbY
   HWl121kZEAIxiTKlfZX3YijVVboPtFUzj2oLCGtiZWNjKzJQIbdjSGua5
   CWPhH1JRSnBbyG4P0i1NacYdPZxUY+WKKJaMIZgEfwOdHvb7SsFvgKirq
   8ceAigyMizm7fi2C2tOxG1LYvtBGYAEy3tP1852yCuDJcDVnYmUCS2nQ+
   TtQSnT4exFAr88wu5llFyL24O6rzJCi+4q0B86PNY7VlZoH2+y8OzxwWP
   Uq4+rjFn8tvcTovel4CpfL2KcLyctJKdGkv/VTHgRsWL/0MBL9QVEP/iw
   Q==;
X-CSE-ConnectionGUID: 1gMJHPNOT1ufH4TsbZRwVA==
X-CSE-MsgGUID: /0XvdJpOQfKX/Jwgr1+A+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="57826091"
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="57826091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 11:04:26 -0700
X-CSE-ConnectionGUID: eHyjWxgzTzOx1IgivtCovg==
X-CSE-MsgGUID: 0rfg2/HUQRqN8QCmbnJmdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="185812109"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Jul 2025 11:04:24 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uY7FO-0004et-1c;
	Sat, 05 Jul 2025 18:04:22 +0000
Date: Sun, 6 Jul 2025 02:04:20 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 5/5] mptcp: remove pr_fallback()
Message-ID: <202507060115.0WOIqNXG-lkp@intel.com>
References: <189eef71d3406ce2931e6d9442c0c5bba1df42fa.1751700000.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189eef71d3406ce2931e6d9442c0c5bba1df42fa.1751700000.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[also build test WARNING on mptcp/export-net linus/master v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-make-fallback-action-and-fallback-decision-atomic/20250705-152610
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/189eef71d3406ce2931e6d9442c0c5bba1df42fa.1751700000.git.pabeni%40redhat.com
patch subject: [PATCH mptcp-net v2 5/5] mptcp: remove pr_fallback()
config: arm-randconfig-001-20250705 (https://download.01.org/0day-ci/archive/20250706/202507060115.0WOIqNXG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250706/202507060115.0WOIqNXG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507060115.0WOIqNXG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mptcp/subflow.c: In function 'subflow_state_change':
>> net/mptcp/subflow.c:1854:28: warning: variable 'msk' set but not used [-Wunused-but-set-variable]
    1854 |         struct mptcp_sock *msk;
         |                            ^~~


vim +/msk +1854 net/mptcp/subflow.c

648ef4b88673dad Mat Martineau    2020-01-21  1849  
648ef4b88673dad Mat Martineau    2020-01-21  1850  static void subflow_state_change(struct sock *sk)
648ef4b88673dad Mat Martineau    2020-01-21  1851  {
648ef4b88673dad Mat Martineau    2020-01-21  1852  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
dc093db5cc052b7 Paolo Abeni      2020-03-13  1853  	struct sock *parent = subflow->conn;
81c1d029016001f Paolo Abeni      2023-06-20 @1854  	struct mptcp_sock *msk;
648ef4b88673dad Mat Martineau    2020-01-21  1855  
648ef4b88673dad Mat Martineau    2020-01-21  1856  	__subflow_state_change(sk);
648ef4b88673dad Mat Martineau    2020-01-21  1857  
81c1d029016001f Paolo Abeni      2023-06-20  1858  	msk = mptcp_sk(parent);
8fd738049ac3d67 Davide Caratti   2020-06-29  1859  	if (subflow_simultaneous_connect(sk)) {
be9cad90d7343cf Paolo Abeni      2025-07-05  1860  		mptcp_do_fallback(sk, MPTCP_MIB_SIMULT_FALLBACK);
8fd738049ac3d67 Davide Caratti   2020-06-29  1861  		subflow->conn_finished = 1;
e4a0fa47e816e18 Paolo Abeni      2024-02-08  1862  		mptcp_propagate_state(parent, sk, subflow, NULL);
8fd738049ac3d67 Davide Caratti   2020-06-29  1863  	}
8fd738049ac3d67 Davide Caratti   2020-06-29  1864  
648ef4b88673dad Mat Martineau    2020-01-21  1865  	/* as recvmsg() does not acquire the subflow socket for ssk selection
648ef4b88673dad Mat Martineau    2020-01-21  1866  	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
648ef4b88673dad Mat Martineau    2020-01-21  1867  	 * the data available machinery here.
648ef4b88673dad Mat Martineau    2020-01-21  1868  	 */
e1ff9e82e2ea53d Davide Caratti   2020-06-29  1869  	if (mptcp_subflow_data_available(sk))
2e52213c79c0b94 Florian Westphal 2020-02-26  1870  		mptcp_data_ready(parent, sk);
499ada5073361c6 Paolo Abeni      2021-06-10  1871  	else if (unlikely(sk->sk_err))
499ada5073361c6 Paolo Abeni      2021-06-10  1872  		subflow_error_report(sk);
648ef4b88673dad Mat Martineau    2020-01-21  1873  
40947e13997a1cb Florian Westphal 2021-02-12  1874  	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
648ef4b88673dad Mat Martineau    2020-01-21  1875  }
648ef4b88673dad Mat Martineau    2020-01-21  1876  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

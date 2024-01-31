Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1679DA6;
	Wed, 31 Jan 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705060; cv=none; b=uft0tHCR2xvF6S4Tun1NBdWaLNUGNFum/08IVu39mJbZ3fg0Xh+ruL611h1exQQiFskCN6anqwgArIcHbYM/i2yNkzNKxNrGfTNb8fjTPls7dytLkfM6SLMUSiysedd8DcbGrVg/QLtPFVO2Yhni5qUGVQvVCQlVHjoFLxBwUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705060; c=relaxed/simple;
	bh=hEnSMQpC9bkQdcUs20n22qMewS244gUomXShh7bSFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oEp+wyfcroHi1QAzwYGu+u0rkf4zgUJU9dt0DhBHOn2Tl0w+nCftrK8801ewHpcwj/euMFiQtibun8NDbIFJSOo7GX2WYiz2b+TI7CPwjkCovzZ2QYxGNr300VfVmGQ2cQ2WPxvgb1RE3nz+6JKuxgognVFYDkhrI2F1ktAR4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTuOD2oo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTuOD2oo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706705058; x=1738241058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hEnSMQpC9bkQdcUs20n22qMewS244gUomXShh7bSFLY=;
  b=HTuOD2ooyRaIy7W25xcQE1t3Gv1cy67I32CBmYH7wpYHWbP5wgLIT7PN
   r1U1c3bPwp31Yb3EPu0s/26cvzduSPgYTILJ/q+umvbO/aiFqhSTUonGf
   8zmxFeEdBcSkNKLsO5aErgUWvkChtS4SJYA5fdN80NlRcg/KAPljjPnV1
   pI73HNmNNOG9kZhAjgBJeg6yIshBDvllLhT8b+rIQQDrS+x2vEum/Ez37
   mPc7tTU/KgtrVqeOWVkMPs7iog4jmYgX42rKzJxjK0PlrE+mgYrkU4ZD3
   BUaVuouO8bqW+bMKvU2LM1ytKernSZtpqUyBrLcX1PXBZTPax3y8AF/pV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10689678"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10689678"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 04:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30210461"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 31 Jan 2024 04:44:17 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV9wr-0001Z0-2M;
	Wed, 31 Jan 2024 12:44:13 +0000
Date: Wed, 31 Jan 2024 20:43:13 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Subject: [mptcp:export 32/49] net/mptcp/bpf.c:218:47: error:
 'bpf_mptcp_sched_ops' undeclared; did you mean 'mptcp_sched_ops'?
Message-ID: <202401312020.oG1MfzT1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   198dcdf0bf0b194a21bd413dc050d08b21e48cc1
commit: e76812a9ec49b57af8ee86420f994899d754d53d [32/49] bpf: Add bpf_mptcp_sched_ops
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240131/202401312020.oG1MfzT1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401312020.oG1MfzT1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401312020.oG1MfzT1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/mptcp/bpf.c:12:
   net/mptcp/bpf.c: In function 'bpf_mptcp_kfunc_init':
>> net/mptcp/bpf.c:218:47: error: 'bpf_mptcp_sched_ops' undeclared (first use in this function); did you mean 'mptcp_sched_ops'?
     218 |         ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
         |                                               ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1794:59: note: in definition of macro 'register_bpf_struct_ops'
    1794 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
         |                                                           ^~~~~~
   net/mptcp/bpf.c:218:47: note: each undeclared identifier is reported only once for each function it appears in
     218 |         ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
         |                                               ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1794:59: note: in definition of macro 'register_bpf_struct_ops'
    1794 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
         |                                                           ^~~~~~


vim +218 net/mptcp/bpf.c

   212	
   213	static int __init bpf_mptcp_kfunc_init(void)
   214	{
   215		int ret;
   216	
   217		ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 > 218		ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCE19D8AC;
	Thu, 22 May 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936943; cv=none; b=DKzGa1EAT2ftGsg0w8NqH+mv4FWKZ+oTsm/NGnxAvq8bvKXFLkfcB4w6IKPXSxvyPrnTFG6Vx+NRA4V7tCYbhk//E/uc0jBBD0TP03vI1bx2LrVlduce1RQ1MbqPvxLafXobItgBWROTFRyN8zhTlTIv19jq2TN//KQQsLZqwH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936943; c=relaxed/simple;
	bh=NGL9Q+yiyPsTcMLEO4ykeXL4yWjfWlrct6vAjBHytOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRNsKJlRtIrWhdbO+F/ynPID9BLwqnQGJUYO4Oy3Y4Tve4E2XUsxWw2K+QoWlys2x1BMoASa/z0/T3/Fm+563OX9FftwhZkImfbLbpw6UrC1zeg5D2JfkoETYvMet2asfpY32uTDh3lGlmfRg+8dOGwKVHYUh7CYoAgXC1O2FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/vOtAFa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/vOtAFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747936941; x=1779472941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGL9Q+yiyPsTcMLEO4ykeXL4yWjfWlrct6vAjBHytOY=;
  b=m/vOtAFa0pnX/iDFC5fh0cs3BkaiYE3tQ+d5WAnqIyGPL8yxTNwbOOKW
   UJxBdUy83dNm+09bX1Aep8j90/70C9o5Solg9+L4pzPMyALIAvEHaoU/+
   BobRpl3+KDMh2ne8wk+qoqb2lSrr7iPdcoUdnDtE7QrcsKrrsKKBUbsgm
   PDOTRSC9o0h49LBqgK2RE6kh4pNmM5O8qMEEj2ygj+0CxT3MkYZCqclZy
   R5mAcG4yvIoDAGuo/SxNSr6DBT9Ut8b5mio1qR0TF9jlcAT/7RaUL3HC1
   FRF1Yq4auAb/7Dp4R0BFlEJ4NQ7euTAe+dH6srpKcke44sC1JeeYmTDG6
   A==;
X-CSE-ConnectionGUID: i2ATIquhS6uq9LyNx+nGmA==
X-CSE-MsgGUID: TnczvXPxSCmts66SlNaAAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50124689"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="50124689"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:02:14 -0700
X-CSE-ConnectionGUID: 588NjtyeRl+monhDHV1sAg==
X-CSE-MsgGUID: C/2nmG+zQo2PkTHvWaWIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="177855485"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 May 2025 11:02:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIAF8-000PZy-0s;
	Thu, 22 May 2025 18:02:10 +0000
Date: Fri, 23 May 2025 02:01:48 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 2/2] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Message-ID: <202505230122.Yo10opZp-lkp@intel.com>
References: <dfd9d56e608ea3f68297092c9e90134e4807d3d6.1747897261.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd9d56e608ea3f68297092c9e90134e4807d3d6.1747897261.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[cannot apply to mptcp/export-net bpf-next/net bpf-next/master bpf/master linus/master v6.15-rc7 next-20250522]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/Revert-selftests-bpf-Add-mptcp_subflow-bpf_iter-subtest/20250522-150813
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/dfd9d56e608ea3f68297092c9e90134e4807d3d6.1747897261.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next v2 2/2] Squash to "bpf: Export mptcp packet scheduler helpers"
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250523/202505230122.Yo10opZp-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505230122.Yo10opZp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505230122.Yo10opZp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mptcp/bpf.c:334:28: error: use of undeclared identifier 'bpf_mptcp_sched_ops'
     334 |             prog->aux->st_ops != &bpf_mptcp_sched_ops)
         |                                   ^
   1 error generated.


vim +/bpf_mptcp_sched_ops +334 net/mptcp/bpf.c

   319	
   320	static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
   321	{
   322		if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids, kfunc_id))
   323			return 0;
   324	
   325		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
   326			return -EACCES;
   327	
   328		/* .filter is called sometimes before prog->aux->st_ops is set,
   329		 * then prog->aux->st_ops is NULL. If return -EACCES in this case,
   330		 * an error occur:
   331		 * 	bug: bad parent state for iter next call
   332		 */
   333		if (prog->aux->st_ops &&
 > 334		    prog->aux->st_ops != &bpf_mptcp_sched_ops)
   335			return -EACCES;
   336	
   337		return 0;
   338	}
   339	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

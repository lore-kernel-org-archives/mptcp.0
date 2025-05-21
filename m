Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AA4B1E57;
	Wed, 21 May 2025 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786854; cv=none; b=I5uBnlb6poi3zQpcOxALK+Ob/9pP5QVoovggqgWLMtl4uIqatuzF/5TzdbrY76Ioc+PHJmbU6eM1KCFp2zsdgZD+C1OlenafNd57nhYCzCNgXYFkdAFjLX5sOD0+4n2FuvHgaw2bI8sNo8pLD7xL7UsFYPLCelmbB3y1O6INx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786854; c=relaxed/simple;
	bh=/5uey0ctIa9sqeckFyzv7abKHrx1uvfB8LYpBKspKtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/zmhVFzwlsEAdyWvCLd38osJLGUuH01LIRwI8Frlae0Z9LCWScpwUQ8dgsq6RfqyhunTLL5TSoX9ZT37h+cF9U36XslelylxiLurjFEMJr3R6i6821roryODIJ6KYeBkCvfMZ9Ysi5TmgUAnm1vgjmwOmCcDUhS1ZpkfCD40L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAiBpBX5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAiBpBX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747786852; x=1779322852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/5uey0ctIa9sqeckFyzv7abKHrx1uvfB8LYpBKspKtE=;
  b=PAiBpBX5ac0MVaQv4MAJ3CjwTIQF6aHKd490Ixs+6vFkQGgb1SKKLFjy
   QH/iaE8Ybt6P1LWqqM7kUKdJJ7wWDN0/FafkYsaRqvaGlPvx3QZDLkN7N
   4cNlgjC9n3oQFxGm8FTyjDkfvhB1X1xsKDimY6bJJqngHMgN/dhp9Xazf
   6jTP4g5nuqTHpypNdbbcToSvoQm7SKAATxHhMP1Rb94DtKCPxzY7CD4XM
   sNTmAgfI5QPy/1CAqLKWr+UCtsgGlhDlsj3aGWWpEDquNtT/cvNpX1vWK
   xCcX2Nw+2X0OEJAnQLTqq0M4I47nZ7U+8U0mBjhpQ4XyfUvthX8yR/7bb
   Q==;
X-CSE-ConnectionGUID: /dEj6lbYSUis9tZ2LmtUPw==
X-CSE-MsgGUID: SRgojn2tQruERc2lc3bamw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67162230"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="67162230"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 17:20:52 -0700
X-CSE-ConnectionGUID: eqGhh9dOTi22YLL/tx1RKg==
X-CSE-MsgGUID: tR0iSdmUQXeurBx6IXedUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140380793"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 May 2025 17:20:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHXCS-000NhM-1c;
	Wed, 21 May 2025 00:20:48 +0000
Date: Wed, 21 May 2025 08:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 2/2] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Message-ID: <202505210809.DJ1jeY8P-lkp@intel.com>
References: <9c089a245833c43d55ec240be1b880909af849ce.1747730598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c089a245833c43d55ec240be1b880909af849ce.1747730598.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[cannot apply to mptcp/export-net linus/master v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/Squash-to-selftests-bpf-Add-mptcp_subflow-bpf_iter-subtest/20250520-165020
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/9c089a245833c43d55ec240be1b880909af849ce.1747730598.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next 2/2] Squash to "bpf: Export mptcp packet scheduler helpers"
config: i386-buildonly-randconfig-005-20250521 (https://download.01.org/0day-ci/archive/20250521/202505210809.DJ1jeY8P-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250521/202505210809.DJ1jeY8P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505210809.DJ1jeY8P-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mptcp/bpf.c: In function 'bpf_mptcp_common_kfunc_filter':
>> net/mptcp/bpf.c:326:35: error: 'bpf_mptcp_sched_ops' undeclared (first use in this function); did you mean 'mptcp_sched_ops'?
     326 |             prog->aux->st_ops != &bpf_mptcp_sched_ops)
         |                                   ^~~~~~~~~~~~~~~~~~~
         |                                   mptcp_sched_ops
   net/mptcp/bpf.c:326:35: note: each undeclared identifier is reported only once for each function it appears in


vim +326 net/mptcp/bpf.c

   319	
   320	static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
   321	{
   322		if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids, kfunc_id))
   323			return 0;
   324	
   325		if (prog->aux->st_ops &&
 > 326		    prog->aux->st_ops != &bpf_mptcp_sched_ops)
   327			return -EACCES;
   328	
   329		return 0;
   330	}
   331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

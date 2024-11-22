Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68885CB8;
	Fri, 22 Nov 2024 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732242573; cv=none; b=rksMEzi5vcHyRUA4BJNcrUL10LzhGxi/HRUGKU+9iDmLoeYh4t1jd8SSAJTuIWzxHnJbdi8/W88kZSuQCmSFPIWJZupx0yDirHNOyiPLDF0HVKfUPwR2MgimXDzKU9w+u358i+DG2u9virvQky3MoT8twVDYBFRpdWM+p2Nkqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732242573; c=relaxed/simple;
	bh=Yzc17DU2NnCEnEexBDdpYiQnkkqp/ZWRaT20eDbbFDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWCgZljknayH0+gWdgvcvku2BpRXmjJY8OMZcfSKDzj/OeRLnX9OCzygPJHYuHSvCMIzCrBZ/NfuRjJrj/4IXn9H6XbErMBy9lGuPeocxU8yCVvCoaq0nfY5F3cyAjjJkVhjHR1qF6Da5WGQSQYrUGhPFK/Q9bu0eXclFNoqdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDeYZEGB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDeYZEGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732242572; x=1763778572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yzc17DU2NnCEnEexBDdpYiQnkkqp/ZWRaT20eDbbFDQ=;
  b=JDeYZEGBuDQgEfQB8z8Ot/omg2Rh5WWn5B9ZzqMUXbXIUDitVljZOxTo
   +alQdB/PZ9onAgRc3YEYUZmYUHbo6slGsK5UsECeg+iTknYfLiLOrCp9X
   iDCEEdEU+EJ3YWHG8gNzpihgtOQhlb8DsPop2HPxQBQdD4+nKLe3g0wCQ
   BxY6AV13a3BOrkxbaIJ9uOAuQITil44tsv0gqkhZjqTdkVyJKKGs74uOf
   BlQQRlgok1bBKzRAvPqkwEOrtJpEXayLcoF0vAWe0ZJ9mgQ04uaheOvnY
   Qij8i4pQLyC60SQJxuhOq+i5UIIVop90gC0BMIos6RMrj9KcYNXii33PK
   A==;
X-CSE-ConnectionGUID: pK1IYMwPQ++BzjhWDE4BpQ==
X-CSE-MsgGUID: 8m7soK+VRkCthZByeGakpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="36050114"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="36050114"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 18:29:32 -0800
X-CSE-ConnectionGUID: VzBTowyIQ4m5CHdwvMYINg==
X-CSE-MsgGUID: 4VNFLkiJTBqLKzzWJxgTbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="121311001"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2024 18:29:30 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEJQG-0003at-0C;
	Fri, 22 Nov 2024 02:29:28 +0000
Date: Fri, 22 Nov 2024 10:28:39 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 2/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
Message-ID: <202411220915.8dk01baF-lkp@intel.com>
References: <8e8c6d39d8de8ab2bb4cdd8965c1981a3920bc9e.1732172851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e8c6d39d8de8ab2bb4cdd8965c1981a3920bc9e.1732172851.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[cannot apply to mptcp/export-net linus/master v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/Squash-to-bpf-Register-mptcp-common-kfunc-set/20241121-155947
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/8e8c6d39d8de8ab2bb4cdd8965c1981a3920bc9e.1732172851.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next 2/3] Squash to "bpf: Add mptcp_subflow bpf_iter"
config: m68k-atari_defconfig (https://download.01.org/0day-ci/archive/20241122/202411220915.8dk01baF-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220915.8dk01baF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220915.8dk01baF-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: net/mptcp/bpf.o: in function `bpf_iter_mptcp_subflow_new':
>> bpf.c:(.text+0x96): undefined reference to `lockdep_is_held'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

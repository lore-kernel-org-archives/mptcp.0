Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8691CAA8A;
	Fri, 28 Feb 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729536; cv=none; b=tGE5+vrNgyWJiTkKVlN8ju2a4+L0nianthiau0RSDS9tPj8X7Y79Aj9RrYvyhaERXCc4Ru7WYgUH0HNWh0Oldm68EIYF5mq4MqpiCIdWjMum5N9GmnzNLba0JzplouuH2yxbt4U7x9ykoBiMu5dA4QKlsq6SjD9b/K8H9x6Zg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729536; c=relaxed/simple;
	bh=UfKokSJ5st1deFRofPjEdOEOWTsSsZiqgZF2r2IdEGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPFSAV5hRwXrR6Gn+yF77Ri3/JR/EBYX2UHMGu/13Bxi+g3fhLgd/9leeiMi3u+tBeAsrVmBiURz+uiGWYTyMG511GI7dT/p3iRb+V8iULKPIwUDPUf+QtcFANRtNrjVY6S45+F82wRo6ixIHv+yUknTHv72pGJ/inv7WmPsong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBUj2FPS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBUj2FPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740729535; x=1772265535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfKokSJ5st1deFRofPjEdOEOWTsSsZiqgZF2r2IdEGU=;
  b=kBUj2FPS6xamv60S0uC7ZTJG8Vr0CBKZlHjmPbCr9YlNrjFE8Z9QVypP
   NGmnyBoVNrBlD+IfaeQgFjsiXzCCVyRvGakQmFTc6/WJLaRrIaRmgFH1P
   6nVdWnXZ38BTz0pZQpgPxdZqKmKtGFHUc+UtYNAxLgwMSJUMwbeEjRgHQ
   kTVLlKWjjY4vovzZTC5EtOALgwtr0fmM3G0bhK7Ha9gwBkIy6Fhf1RV5Q
   9IikbnIZ1B5aEJovxkKUBxTZY95UViqWWVlkl+JD28yclK7qWbMpVmY2x
   VaPTHg3LSreSG8P7/N6obcwR2/hdCYpW32PwbsI2z7EWSnE0o/mJnUQdw
   w==;
X-CSE-ConnectionGUID: sPIIv4ayT52aqz5lUnXjTg==
X-CSE-MsgGUID: mVzjJCeyQBi8chF8RivQXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45300572"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45300572"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:58:54 -0800
X-CSE-ConnectionGUID: /jrdUDovQmaS6bkg29FKBQ==
X-CSE-MsgGUID: BDoQT56UQt2uWLOpTwb6pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="117034672"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 27 Feb 2025 23:58:53 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnvFm-000EZQ-31;
	Fri, 28 Feb 2025 07:58:03 +0000
Date: Fri, 28 Feb 2025 15:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 6/6] mptcp: pm: in-kernel: drop changed
 parameter of set_flags
Message-ID: <202502281544.ZIQZO9cy-lkp@intel.com>
References: <1e2f2a9bcdf69bd241dec4c5455c4aa135927cb6.1740638334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2f2a9bcdf69bd241dec4c5455c4aa135927cb6.1740638334.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[cannot apply to mptcp/export-net linus/master v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-pm-use-pm-variable-instead-of-msk-pm/20250227-144528
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/1e2f2a9bcdf69bd241dec4c5455c4aa135927cb6.1740638334.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next v1 6/6] mptcp: pm: in-kernel: drop changed parameter of set_flags
config: riscv-randconfig-002-20250228 (https://download.01.org/0day-ci/archive/20250228/202502281544.ZIQZO9cy-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502281544.ZIQZO9cy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502281544.ZIQZO9cy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mptcp/pm_netlink.c: In function 'mptcp_pm_nl_set_flags':
>> net/mptcp/pm_netlink.c:1959:12: warning: variable 'changed' set but not used [-Wunused-but-set-variable]
    1959 |         u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
         |            ^~~~~~~


vim +/changed +1959 net/mptcp/pm_netlink.c

0f9f696a502e1b0 Geliang Tang           2021-01-08  1953  
c7f25f7987c060b Geliang Tang           2025-02-07  1954  int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
de258815006a162 Geliang Tang           2025-02-27  1955  			  struct mptcp_pm_addr_entry *remote,
c7f25f7987c060b Geliang Tang           2025-02-07  1956  			  struct genl_info *info)
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1957  {
c7f25f7987c060b Geliang Tang           2025-02-07  1958  	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
6ba7ce89905c5d5 Geliang Tang           2023-06-08 @1959  	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1960  			   MPTCP_PM_ADDR_FLAG_FULLMESH;
2c8971c04f745de Geliang Tang           2025-02-07  1961  	struct net *net = genl_info_net(info);
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1962  	struct mptcp_pm_addr_entry *entry;
6a42477fe4491e4 Geliang Tang           2024-03-05  1963  	struct pm_nl_pernet *pernet;
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1964  	u8 lookup_by_id = 0;
8cdc56f99e6c33a Matthieu Baerts (NGI0  2025-02-07  1965) 
6a42477fe4491e4 Geliang Tang           2024-03-05  1966  	pernet = pm_nl_get_pernet(net);
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1967  
c7f25f7987c060b Geliang Tang           2025-02-07  1968  	if (local->addr.family == AF_UNSPEC) {
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1969  		lookup_by_id = 1;
c7f25f7987c060b Geliang Tang           2025-02-07  1970  		if (!local->addr.id) {
a25a8b10491bb94 Matthieu Baerts (NGI0  2025-02-07  1971) 			NL_SET_ERR_MSG_ATTR(info->extack, attr,
a25a8b10491bb94 Matthieu Baerts (NGI0  2025-02-07  1972) 					    "missing address ID");
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1973  			return -EOPNOTSUPP;
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1974  		}
a4d68b160240815 Geliang Tang           2024-03-05  1975  	}
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1976  
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1977  	spin_lock_bh(&pernet->lock);
c7f25f7987c060b Geliang Tang           2025-02-07  1978  	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
c7f25f7987c060b Geliang Tang           2025-02-07  1979  			       __lookup_addr(pernet, &local->addr);
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1980  	if (!entry) {
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1981  		spin_unlock_bh(&pernet->lock);
a25a8b10491bb94 Matthieu Baerts (NGI0  2025-02-07  1982) 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1983  		return -EINVAL;
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1984  	}
c7f25f7987c060b Geliang Tang           2025-02-07  1985  	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
1bb0d1348546ad0 Matthieu Baerts (NGI0  2025-01-23  1986) 	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
1bb0d1348546ad0 Matthieu Baerts (NGI0  2025-01-23  1987) 			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1988  		spin_unlock_bh(&pernet->lock);
a25a8b10491bb94 Matthieu Baerts (NGI0  2025-02-07  1989) 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1990  		return -EINVAL;
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1991  	}
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1992  
c029cf028bb79d2 Geliang Tang           2025-02-27  1993  	remote->flags = entry->flags;
c7f25f7987c060b Geliang Tang           2025-02-07  1994  	changed = (local->flags ^ entry->flags) & mask;
c7f25f7987c060b Geliang Tang           2025-02-07  1995  	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
c7f25f7987c060b Geliang Tang           2025-02-07  1996  	*local = *entry;
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1997  	spin_unlock_bh(&pernet->lock);
6ba7ce89905c5d5 Geliang Tang           2023-06-08  1998  
c029cf028bb79d2 Geliang Tang           2025-02-27  1999  	mptcp_nl_set_flags(net, local, remote);
6ba7ce89905c5d5 Geliang Tang           2023-06-08  2000  	return 0;
6ba7ce89905c5d5 Geliang Tang           2023-06-08  2001  }
6ba7ce89905c5d5 Geliang Tang           2023-06-08  2002  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

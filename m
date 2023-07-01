Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719FC2EF;
	Sat,  1 Jul 2023 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688230579; x=1719766579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ycQAPNnBrHXZNfvUupWiN71RCmnPp3gJKHSJVy6nZU=;
  b=AZwL9CjlIgF+HeLzXMIOpZ8wCTU8Icmy73fTA0+WrmWf5ScCcvTkTqRq
   fYsI7O7Px6bFgmhxo7wlFuYVV6QsDYLh1gdn9wEWzdJylKZirA09SsTgk
   oUMOhtA15i0AMbrI1ziiihWkrWty13kP18G/Lw5sDHaZNdnLzavN96Qce
   3idKcCocObwy6yDMjc69AsgJIZKNlgamNpn2B92UkRhBzmLOYxjE+a/lp
   DO78IKLRL2vV89W3G/O6iKXZHTqZEZAUQ1hW6kR+K3k+nzZB4BexbKltP
   SSctrosqIe4gkpHWe1WpZa+PDcUQ1l8h/4sANvtxTVhFXV5hxjiwAopwH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="342197542"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="342197542"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 09:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="718147925"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="718147925"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Jul 2023 09:56:16 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qFdtP-000G9D-34;
	Sat, 01 Jul 2023 16:56:15 +0000
Date: Sun, 2 Jul 2023 00:55:38 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v2 2/4] bpf: Add bpf_mptcpify helper
Message-ID: <202307020056.CI5KNYyK-lkp@intel.com>
References: <daf3d1e26f19ee83b427ef9e17183cd09fc26de6.1688215769.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf3d1e26f19ee83b427ef9e17183cd09fc26de6.1688215769.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v6.4 next-20230630]
[cannot apply to bpf-next/master bpf/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/Squash-to-selftests-bpf-add-two-mptcp-netns-helpers/20230701-205922
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/daf3d1e26f19ee83b427ef9e17183cd09fc26de6.1688215769.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next v2 2/4] bpf: Add bpf_mptcpify helper
config: nios2-randconfig-r021-20230701 (https://download.01.org/0day-ci/archive/20230702/202307020056.CI5KNYyK-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230702/202307020056.CI5KNYyK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307020056.CI5KNYyK-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: kernel/bpf/cgroup.o: in function `cgroup_dev_func_proto':
   kernel/bpf/cgroup.c:1607: undefined reference to `bpf_mptcpify_proto'
>> nios2-linux-ld: kernel/bpf/cgroup.c:1607: undefined reference to `bpf_mptcpify_proto'
   nios2-linux-ld: kernel/bpf/cgroup.o: in function `cg_sockopt_func_proto':
   kernel/bpf/cgroup.c:2297: undefined reference to `bpf_mptcpify_proto'
   nios2-linux-ld: kernel/bpf/cgroup.c:2297: undefined reference to `bpf_mptcpify_proto'
   nios2-linux-ld: kernel/bpf/cgroup.o: in function `sysctl_func_proto':
   kernel/bpf/cgroup.c:2155: undefined reference to `bpf_mptcpify_proto'
   nios2-linux-ld: kernel/bpf/cgroup.o:kernel/bpf/cgroup.c:2155: more undefined references to `bpf_mptcpify_proto' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

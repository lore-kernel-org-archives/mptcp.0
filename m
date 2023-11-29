Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F71D54B;
	Wed, 29 Nov 2023 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mht1em9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701259317; x=1732795317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bzZMqiipEbDP/SUHUKSuLr4DHbGRjmdIc61Ru02KCbQ=;
  b=Mht1em9O+DUmNunxnoZdwO1HUzpsBFyXkDnSD1NqcqUWfyMi7zL9We6f
   1U1zTogP9BGNGKswnJAvZ4eWlJCfwkt930ehLYex3c47jChHSYmyiqzTl
   2vInpxCs9tFZnfP/a6TBm5gsz3OA82wjP0NrHvJbckZCcJwck2EHiCSTa
   sPdaZudHXa3tTg1Kk8CevnMhW7NqZWKlgbysG4hC9TErne5jKJzo8ACLG
   4YQbpHMiz5nrlM+1tchISBWXGuzAMEnOnp8pyXDIkbS0JXKXwCA2fbRVE
   d/dv3+pAOWh6SCkAidyINk6BE3rJ6chuNP+G80LNY7WNiTPRtwSlC0UQ2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372515839"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="372515839"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 04:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762295539"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="762295539"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2023 04:01:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8JGH-0000CK-3C;
	Wed, 29 Nov 2023 12:01:49 +0000
Date: Wed, 29 Nov 2023 20:01:31 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for
 tcp_set_state
Message-ID: <202311291902.gD0Y21iG-lkp@intel.com>
References: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[also build test WARNING on mptcp/export-net linus/master v6.7-rc3 next-20231129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-add-a-current-established-counter/20231129-131030
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for tcp_set_state
config: x86_64-randconfig-005-20231129 (https://download.01.org/0day-ci/archive/20231129/202311291902.gD0Y21iG-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311291902.gD0Y21iG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311291902.gD0Y21iG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/mptcp/trace.c:57:8: warning: unused variable 'func_name' [-Wunused-variable]
           char *func_name = "tcp_set_state";
                 ^
   1 warning generated.


vim +/func_name +57 net/mptcp/trace.c

    54	
    55	static __init int mptcp_ftrace_init(void)
    56	{
  > 57		char *func_name = "tcp_set_state";

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

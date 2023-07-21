Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E382363;
	Fri, 21 Jul 2023 01:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689902501; x=1721438501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d6Dg06VZ0cPupE2W39wGOgs68KDAsonGdA9NfmeFGSM=;
  b=Lvbb6QhW2BcazYUqvT8LNpnzyehUdsh3Ae3QCUWJbj5dvDOibAleCbQ4
   THUbj92GrTR5yYqkI49ahtHiZ+MMUzoH/kR5QwcxWLb6Nrv0+EhLCD5xZ
   8yr8mGIIrAremvfaajGUPWGMVqiWIv4hZLzjJhrdQ8WjHsbK12jaeqPb3
   sqe0j5fGFXDSD5oj+ic7tZemMqEkdGJfCFtvw9rOKWgGD+q4ELsYxStHH
   F7nE8g6SOSNXny4fSwhzLRGSQCasjBTsT+FbDIRJwvpfh7rUf5dUNC1ur
   p37YskQbhAo6C/NBfOuzCpuJeobzoJtYeD3Aze/Ocz62FQWUrh9WXqBtq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346501905"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346501905"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 18:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="701859957"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="701859957"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2023 18:21:38 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qMepo-0006i1-3D;
	Fri, 21 Jul 2023 01:21:33 +0000
Date: Fri, 21 Jul 2023 09:20:49 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v3 3/5] bpf: Add bpf_mptcpify helper
Message-ID: <202307210923.TeQxMqW5-lkp@intel.com>
References: <d746717840dfdcab3e4d8fa710dfaa3958a0ead1.1688366249.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d746717840dfdcab3e4d8fa710dfaa3958a0ead1.1688366249.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[also build test WARNING on mptcp/export-net bpf-next/master bpf/master linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/Squash-to-selftests-bpf-add-two-mptcp-netns-helpers/20230703-144151
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/d746717840dfdcab3e4d8fa710dfaa3958a0ead1.1688366249.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next v3 3/5] bpf: Add bpf_mptcpify helper
config: x86_64-buildonly-randconfig-r003-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210923.TeQxMqW5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210923.TeQxMqW5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210923.TeQxMqW5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/bpf_trace.c:1902:36: warning: 'bpf_mptcpify_proto' defined but not used [-Wunused-const-variable=]
    1902 | static const struct bpf_func_proto bpf_mptcpify_proto = {
         |                                    ^~~~~~~~~~~~~~~~~~


vim +/bpf_mptcpify_proto +1902 kernel/trace/bpf_trace.c

  1901	
> 1902	static const struct bpf_func_proto bpf_mptcpify_proto = {
  1903		.func		= bpf_mptcpify,
  1904		.gpl_only	= false,
  1905		.ret_type	= RET_INTEGER,
  1906		.arg1_type	= ARG_PTR_TO_BTF_ID,
  1907		.arg1_btf_id	= &bpf_mptcpify_btf_ids[0],
  1908	};
  1909	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

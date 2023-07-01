Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A59C2F0;
	Sat,  1 Jul 2023 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688225599; x=1719761599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWoweqh9HQSy9DFcbzQtkZLBs5ouuH7UKskhKJv6tIk=;
  b=nes7X3AXDqKrQCF+Sf7/qJdMcgEdGEHQuO3sD5auSOgq//Sv4JxoPpzw
   JskEimgdVK0g9WQsjBVXhzfHmOUEhx9ZtqGbFgef0Ek1LcJBmvJgZuwPJ
   ljv8CccPQW5k54Xnh8Vq6ZGJkuFoGy4IcLrj5jKklOwpeQtkhl22bv4vq
   LeazuXCV7A88uIEikXt4A2mhl7T6zN6GoEgnV/PqyO1LGD1jfr55xmTUc
   dmsJb/WHRvxJHRyWzynTmmHaHFgjy+Hj3Jyz3HZ71cmfRJAeV6xwh8ffY
   glWGmhfSN9uMd0s+5akCH71kCrlS98qbtKYJ0+ne5qIpaC5k2sGbZ7w9j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="342191815"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="342191815"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 08:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="842203981"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="842203981"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2023 08:33:15 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qFcb4-000G6D-0M;
	Sat, 01 Jul 2023 15:33:14 +0000
Date: Sat, 1 Jul 2023 23:32:45 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v2 2/4] bpf: Add bpf_mptcpify helper
Message-ID: <202307012313.1sND4cvO-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-r001-20230701 (https://download.01.org/0day-ci/archive/20230701/202307012313.1sND4cvO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307012313.1sND4cvO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307012313.1sND4cvO-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/bpf/cgroup.o: in function `cgroup_common_func_proto':
>> kernel/bpf/cgroup.c:2512: undefined reference to `bpf_mptcpify_proto'


vim +2512 kernel/bpf/cgroup.c

dea6a4e1701338 Stanislav Fomichev 2022-08-23  2507  
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2508  /* Common helpers for cgroup hooks. */
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2509  const struct bpf_func_proto *
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2510  cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2511  {
dea6a4e1701338 Stanislav Fomichev 2022-08-23 @2512  	switch (func_id) {
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2513  	case BPF_FUNC_get_local_storage:
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2514  		return &bpf_get_local_storage_proto;
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2515  	case BPF_FUNC_get_retval:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2516  		switch (prog->expected_attach_type) {
bed89185af0de0 Stanislav Fomichev 2022-08-23  2517  		case BPF_CGROUP_INET_INGRESS:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2518  		case BPF_CGROUP_INET_EGRESS:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2519  		case BPF_CGROUP_SOCK_OPS:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2520  		case BPF_CGROUP_UDP4_RECVMSG:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2521  		case BPF_CGROUP_UDP6_RECVMSG:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2522  		case BPF_CGROUP_INET4_GETPEERNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2523  		case BPF_CGROUP_INET6_GETPEERNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2524  		case BPF_CGROUP_INET4_GETSOCKNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2525  		case BPF_CGROUP_INET6_GETSOCKNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2526  			return NULL;
bed89185af0de0 Stanislav Fomichev 2022-08-23  2527  		default:
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2528  			return &bpf_get_retval_proto;
bed89185af0de0 Stanislav Fomichev 2022-08-23  2529  		}
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2530  	case BPF_FUNC_set_retval:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2531  		switch (prog->expected_attach_type) {
bed89185af0de0 Stanislav Fomichev 2022-08-23  2532  		case BPF_CGROUP_INET_INGRESS:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2533  		case BPF_CGROUP_INET_EGRESS:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2534  		case BPF_CGROUP_SOCK_OPS:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2535  		case BPF_CGROUP_UDP4_RECVMSG:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2536  		case BPF_CGROUP_UDP6_RECVMSG:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2537  		case BPF_CGROUP_INET4_GETPEERNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2538  		case BPF_CGROUP_INET6_GETPEERNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2539  		case BPF_CGROUP_INET4_GETSOCKNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2540  		case BPF_CGROUP_INET6_GETSOCKNAME:
bed89185af0de0 Stanislav Fomichev 2022-08-23  2541  			return NULL;
bed89185af0de0 Stanislav Fomichev 2022-08-23  2542  		default:
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2543  			return &bpf_set_retval_proto;
bed89185af0de0 Stanislav Fomichev 2022-08-23  2544  		}
96703c9170f3b5 Geliang Tang       2023-07-01  2545  	case BPF_FUNC_mptcpify:
96703c9170f3b5 Geliang Tang       2023-07-01  2546  		return &bpf_mptcpify_proto;
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2547  	default:
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2548  		return NULL;
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2549  	}
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2550  }
dea6a4e1701338 Stanislav Fomichev 2022-08-23  2551  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

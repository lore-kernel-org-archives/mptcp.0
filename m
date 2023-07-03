Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84B3D6C;
	Mon,  3 Jul 2023 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688381346; x=1719917346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WIUhwBnidD/ZK3tM/pVcvh48zn2SML6z2hQsMaC439g=;
  b=NYP6GYZOIldOvTLtwhKfxB/aXLClJsCC6ryJI7f0BRIVsuvw9fTIG+4U
   lANeBOfJf6yW3Bfw3EZYUENDsH9w3GEBaLy7BdCmQoERwkq0Jw2hKIhrP
   zfbtCxuuoIL/rmPkXIFhPE+drufapBgi2uVOWHMrptZJrYa+5gUDdS/UO
   1hhJsE4lbQkEaVgL9aU5iHcrmOlTAw7bDg83j0GZSLHpwjX2lTVr2+xIR
   MCPH3fFz6gcdf5hjZq2KHP647zN9WZu79Rq3CwVH8z0bpDx9hv0rvv/GW
   7xCE/POIY989bag2wCb2jV9/Xtz1QW3i+YuEGOLV6dZVXEy1CCGO0e/bH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342441798"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="342441798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="695773894"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="695773894"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2023 03:49:03 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qGH78-000HKt-1b;
	Mon, 03 Jul 2023 10:49:02 +0000
Date: Mon, 3 Jul 2023 18:48:57 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v3 2/5] net: socket: add socket_create wrapper
Message-ID: <202307031850.054Lqlel-lkp@intel.com>
References: <bf1cd56ede55306b3272c6b3069830ea6a189c97.1688366249.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1cd56ede55306b3272c6b3069830ea6a189c97.1688366249.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[also build test WARNING on mptcp/export-net bpf-next/master bpf/master linus/master v6.4 next-20230703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/Squash-to-selftests-bpf-add-two-mptcp-netns-helpers/20230703-144151
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/bf1cd56ede55306b3272c6b3069830ea6a189c97.1688366249.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next v3 2/5] net: socket: add socket_create wrapper
config: arc-randconfig-r015-20230703 (https://download.01.org/0day-ci/archive/20230703/202307031850.054Lqlel-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307031850.054Lqlel-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307031850.054Lqlel-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/socket.c:1591:5: warning: no previous prototype for 'socket_create' [-Wmissing-prototypes]
    1591 | int socket_create(struct socket_args *args, struct socket **res)
         |     ^~~~~~~~~~~~~


vim +/socket_create +1591 net/socket.c

  1590	
> 1591	int socket_create(struct socket_args *args, struct socket **res)
  1592	{
  1593		return sock_create(args->family, args->type, args->protocol, res);
  1594	}
  1595	EXPORT_SYMBOL(socket_create);
  1596	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

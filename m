Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEB1FA1
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523372; x=1682059372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LLjw+WYFoXc/ZC/w6bv6h0auNDDUmOkdgxcFIQsWoTs=;
  b=Xs+UdCVe2Sor45ZVGCihLPK/Lx1Q9RAc3Y5zrntBsqZIj63qf0dNIKEA
   scPm9yuWlrXyETLuvv4sf3t7+lTiRfpEMOPAl6LHFgVU5e8XjA9YO1OHl
   5ZvNEMt9zMbuWs7qaSm9M2on/xTUPFkHK4NXhCAAGU6vWeXcXz5mfrs44
   R+MgfgU7la2Xs7LR2pXdVrKderNRy4PAxzBKKaAiBRuQN0lcnFmuSPXvd
   0XauBi1yDHpP09rG6Mb7ksOpg6WFMZfKKI7fRE3rBJKPX3csY49DSk/vd
   w03pcXC6BJhZNPg3QKvqkOt8+l3GlN4gX9/z2rO3KMbluonIkCTRLbmo5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264022122"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264022122"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="670047967"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 23:42:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nhQWg-0007zc-BE;
	Thu, 21 Apr 2022 06:42:50 +0000
Date: Thu, 21 Apr 2022 14:42:25 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v12 07/10] mptcp: add last_snd write access
Message-ID: <202204210456.03kTcuXu-lkp@intel.com>
References: <396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com>

Hi Geliang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to bpf-next/master bpf/master linus/master v5.18-rc3 next-20220420]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/BPF-packet-scheduler/20220420-130015
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220421/202204210456.03kTcuXu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c711e7d26efa699f1cfe5e2c9619bbf5cc98a7a7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Geliang-Tang/BPF-packet-scheduler/20220420-130015
        git checkout c711e7d26efa699f1cfe5e2c9619bbf5cc98a7a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/mptcp/bpf.c: In function 'bpf_mptcp_sched_btf_struct_access':
>> net/mptcp/bpf.c:69:85: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      69 |                 bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %lu",
         |                                                                                   ~~^
         |                                                                                     |
         |                                                                                     long unsigned int
         |                                                                                   %u
      70 |                         off, size, end);
         |                                    ~~~                                               
         |                                    |
         |                                    size_t {aka unsigned int}


vim +69 net/mptcp/bpf.c

    33	
    34	static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
    35						     const struct btf *btf,
    36						     const struct btf_type *t, int off,
    37						     int size, enum bpf_access_type atype,
    38						     u32 *next_btf_id,
    39						     enum bpf_type_flag *flag)
    40	{
    41		const struct btf_type *state;
    42		u32 type_id;
    43		size_t end;
    44	
    45		if (atype == BPF_READ)
    46			return btf_struct_access(log, btf, t, off, size, atype,
    47						 next_btf_id, flag);
    48	
    49		type_id = btf_find_by_name_kind(btf, "mptcp_sock", BTF_KIND_STRUCT);
    50		if (type_id < 0)
    51			return -EINVAL;
    52	
    53		state = btf_type_by_id(btf, type_id);
    54		if (t != state) {
    55			bpf_log(log, "only read is supported\n");
    56			return -EACCES;
    57		}
    58	
    59		switch (off) {
    60		case offsetof(struct mptcp_sock, last_snd):
    61			end = offsetofend(struct mptcp_sock, last_snd);
    62			break;
    63		default:
    64			bpf_log(log, "no write support to mptcp_sock at off %d\n", off);
    65			return -EACCES;
    66		}
    67	
    68		if (off + size > end) {
  > 69			bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %lu",
    70				off, size, end);
    71			return -EACCES;
    72		}
    73	
    74		return NOT_INIT;
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

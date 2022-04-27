Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E03A3B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651066170; x=1682602170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RD/f8s8pwgP2KTbih7vhM2nJQJi9IktRqFayz+wC+dc=;
  b=Ln3rgkOBcgzpgUV+QLfueHGemnyo2lEaff1Iz3QxvVnyZ8HSTUWvo5Us
   /oFP7Oa1IimVguOTO5TAuzA1ZdKr5Kt8lZIcBjcMRIqrJCZajeuLeg4oG
   MnnEDP7ItdWR8sXuuC/wdqW3zdtFDP6UydHjwr2iSWkki/BkMhNWQu/PE
   u9FAOtiqtzPBKK6KlxcBbQv5Q7fZ6X4ZsQTA3WYtpD7HgooWoH7Mnbj/+
   YHbjfSSJvJgbLYb28Hk50rwCBBuRcybrrMh9BmdiMmTdwMy/l3ReLFyT/
   VaGD09imVab1shaZGkIUVER0sCCSgJTqT1jE4ULXKzBJaUtBova8CYEA0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="266088024"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="266088024"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="513683360"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2022 06:29:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1njhjT-0004gI-KG;
	Wed, 27 Apr 2022 13:29:27 +0000
Date: Wed, 27 Apr 2022 21:29:15 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v16 6/8] mptcp: add bpf_mptcp_sched_ops
Message-ID: <202204272125.AiqJUAjR-lkp@intel.com>
References: <8ac278434203662add804d00e007c2cb2b6f52e4.1651024344.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac278434203662add804d00e007c2cb2b6f52e4.1651024344.git.geliang.tang@suse.com>

Hi Geliang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to bpf-next/master bpf/master linus/master v5.18-rc4 next-20220427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/BPF-packet-scheduler/20220427-095943
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220427/202204272125.AiqJUAjR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
net/mptcp/bpf.c:148 bpf_mptcp_sched_init() warn: unsigned 'mptcp_sched_id' is never less than zero.

vim +/mptcp_sched_id +148 net/mptcp/bpf.c

   143	
   144	static int bpf_mptcp_sched_init(struct btf *btf)
   145	{
   146		mptcp_sched_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
   147						       BTF_KIND_STRUCT);
 > 148		if (mptcp_sched_id < 0)
   149			return -EINVAL;
   150		mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
   151	
   152		return 0;
   153	}
   154	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

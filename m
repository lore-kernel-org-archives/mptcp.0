Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD67E
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654075565; x=1685611565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ngog9IFUxbDTWYuPs7xqjojhsq7LzCUJRz/q+Fohudo=;
  b=ij/IL41lD5CEcZkAG82w8jL9ntsXh9LJtZnWMPCCgFqMbNd9P40UTCot
   9L/cuas0+0BRIeKtFJIZd5nITsjc2DR9nNbRTmPXEm+Sc6XqqDzhY0gJc
   FRiQXIOoD8FdmNFnJn/0iy/VGVjOsZk1ExO8o2NYkFBBGc+GoT43bttNl
   U+BRmfOvtJ6uiTGmEwb/T8MfwMLeinfM+Xm1d8knkvd2onPQaEL+kaqzH
   nN26bzYz+E6ZekTMbOwPSf3T1NFeu5eOyApF0oGgky0VLMTbs93ZU84B+
   Et+85o3A5ZU39WfgGUhzcZjE+gErNXzVNOg3ZrA7ulyTVh6bjQ1THaMm+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361901549"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="361901549"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 02:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="823669671"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2022 02:25:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nwKbx-0003nb-Nj;
	Wed, 01 Jun 2022 09:25:53 +0000
Date: Wed, 1 Jun 2022 17:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v5 05/11] mptcp: add bpf set scheduled helper
Message-ID: <202206011710.y7OIrPON-lkp@intel.com>
References: <af10cde0bfec857862b84ac9e2624a544ccd4795.1654065674.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af10cde0bfec857862b84ac9e2624a544ccd4795.1654065674.git.geliang.tang@suse.com>

Hi Geliang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to bpf-next/master bpf/master linus/master v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/BPF-packet-scheduler/20220601-144812
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220601/202206011710.y7OIrPON-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4bfb6a3d6d5ea1744a301d97642ff0077eb280f6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Geliang-Tang/BPF-packet-scheduler/20220601-144812
        git checkout 4bfb6a3d6d5ea1744a301d97642ff0077eb280f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/bpf.c:165:6: warning: no previous prototype for 'bpf_mptcp_subflow_set_scheduled' [-Wmissing-prototypes]
     165 | void bpf_mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_mptcp_subflow_set_scheduled +165 net/mptcp/bpf.c

   164	
 > 165	void bpf_mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow)
   166	{
   167		WRITE_ONCE(subflow->scheduled, true);
   168	}
   169	EXPORT_SYMBOL(bpf_mptcp_subflow_set_scheduled);
   170	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

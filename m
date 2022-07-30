Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAE23A4
	for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 05:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659159473; x=1690695473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4rKSlGfdC7NIvOLSttE/ER5MbL0t/5aFPKKp1/k+tI=;
  b=Co7VyHasdIvKOVDWIcaEgHCXk3mpb/wwsZTdKQTzX+pIOc+tobgWuMQt
   f9WOr6Kql0T1a+3pTPJNrSi9q2ayvzQFX/3sWO/qXBlETp+OEwcnbv3CP
   qKmLnpgN0w8tLhD+oICDGJx6fXfFpmgpuiyPSLqloQ+VcC8p2non6xPrN
   0kBl3NzMaOol4aVv64EgeXhrYPTuvaTUVNtjuy9R5vf1bH1ePrgUEtogR
   QClr3bbrowLEUZ7gdwJtdyLXnyIdkbQhFdlPQvizp/z/Wp8q4Hui3jo8c
   HYY1tYemtFc6m1JgkC7ZxmgJHs8xAQM0HnLaejOFSXdbf4UYawhJY3f/0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286448838"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="286448838"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 22:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="669485124"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2022 22:37:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oHfAV-000CRl-0S;
	Sat, 30 Jul 2022 05:37:43 +0000
Date: Sat, 30 Jul 2022 13:36:55 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: move msk input path under full
 msk socket lock
Message-ID: <202207301339.GBivsDUw-lkp@intel.com>
References: <24af8221d74f9923858c926d4acb7d81e37dd4d2.1659117128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24af8221d74f9923858c926d4acb7d81e37dd4d2.1659117128.git.pabeni@redhat.com>

Hi Paolo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220730-021638
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220730/202207301339.GBivsDUw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f2cae8b9b78304e87a6c4ee4dbaa50cc02b078d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220730-021638
        git checkout f2cae8b9b78304e87a6c4ee4dbaa50cc02b078d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/protocol.c:798:6: warning: no previous prototype for '__mptcp_data_ready' [-Wmissing-prototypes]
     798 | void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
         |      ^~~~~~~~~~~~~~~~~~


vim +/__mptcp_data_ready +798 net/mptcp/protocol.c

   797	
 > 798	void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
   799	{
   800		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
   801	
   802		/* The peer can send data while we are shutting down this
   803		 * subflow at msk destruction time, but we must avoid enqueuing
   804		 * more data to the msk receive queue
   805		 */
   806		if (unlikely(subflow->disposable))
   807			return;
   808	
   809		/* Wake-up the reader only for in-sequence data */
   810		if (move_skbs_to_msk(mptcp_sk(sk), ssk))
   811			sk->sk_data_ready(sk);
   812	}
   813	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

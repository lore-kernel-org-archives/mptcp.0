Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF929CA
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 22:53:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="216103885"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="216103885"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 14:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="591761553"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Nov 2021 14:53:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mq18S-0005Se-BI; Wed, 24 Nov 2021 22:53:04 +0000
Date: Thu, 25 Nov 2021 06:52:27 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Phil Greenland <phil@quantulum.co.uk>
Subject: Re: [PATCH mptcp-next v2 3/4] mptcp: do not block subflows creation
 on errors
Message-ID: <202111250633.wEMz7JQe-lkp@intel.com>
References: <574156bd514d855a159add3e1c54caa9b2c5f880.1637770883.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574156bd514d855a159add3e1c54caa9b2c5f880.1637770883.git.pabeni@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Paolo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to shuah-kselftest/next linus/master v5.16-rc2 next-20211124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Paolo-Abeni/mptcp-improve-subflow-creation-on-errors/20211125-005137
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211125/202111250633.wEMz7JQe-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/6af8e28040c093866aa60ede3f980b53ab3594a5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-improve-subflow-creation-on-errors/20211125-005137
        git checkout 6af8e28040c093866aa60ede3f980b53ab3594a5
        # save the config file to linux build tree
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/pm.c:203:6: warning: no previous prototype for 'mptcp_pm_subflow_closed' [-Wmissing-prototypes]
     203 | void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/mptcp_pm_subflow_closed +203 net/mptcp/pm.c

6af8e28040c093 Paolo Abeni   2021-11-24  202  
1b1c7a0ef7f323 Peter Krystad 2020-03-27 @203  void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
1b1c7a0ef7f323 Peter Krystad 2020-03-27  204  {
1b1c7a0ef7f323 Peter Krystad 2020-03-27  205  	pr_debug("msk=%p", msk);
1b1c7a0ef7f323 Peter Krystad 2020-03-27  206  }
1b1c7a0ef7f323 Peter Krystad 2020-03-27  207  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

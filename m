Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2B72;
	Thu, 25 Nov 2021 02:26:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="232918807"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="232918807"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 18:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="607401973"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2021 18:26:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mq4Sj-0005cR-Oe; Thu, 25 Nov 2021 02:26:13 +0000
Date: Thu, 25 Nov 2021 10:25:51 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
	Phil Greenland <phil@quantulum.co.uk>
Subject: Re: [PATCH mptcp-next v2 3/4] mptcp: do not block subflows creation
 on errors
Message-ID: <202111251042.JLoJ33k0-lkp@intel.com>
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
config: i386-randconfig-a002-20211124 (https://download.01.org/0day-ci/archive/20211125/202111251042.JLoJ33k0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6af8e28040c093866aa60ede3f980b53ab3594a5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-improve-subflow-creation-on-errors/20211125-005137
        git checkout 6af8e28040c093866aa60ede3f980b53ab3594a5
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/pm.c:203:6: warning: no previous prototype for function 'mptcp_pm_subflow_closed' [-Wmissing-prototypes]
   void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
        ^
   net/mptcp/pm.c:203:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
   ^
   static 
   1 warning generated.


vim +/mptcp_pm_subflow_closed +203 net/mptcp/pm.c

6af8e28040c0938 Paolo Abeni   2021-11-24  202  
1b1c7a0ef7f323f Peter Krystad 2020-03-27 @203  void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
1b1c7a0ef7f323f Peter Krystad 2020-03-27  204  {
1b1c7a0ef7f323f Peter Krystad 2020-03-27  205  	pr_debug("msk=%p", msk);
1b1c7a0ef7f323f Peter Krystad 2020-03-27  206  }
1b1c7a0ef7f323f Peter Krystad 2020-03-27  207  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5832CB6
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 10:58:42 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298601193"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="298601193"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="679850489"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2021 02:58:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1muuem-0000RQ-3F; Wed, 08 Dec 2021 10:58:40 +0000
Date: Wed, 8 Dec 2021 18:58:26 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>
Cc: kbuild-all@lists.01.org, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [mptcp:export 24/34] net/mptcp/sockopt.c:1174:12: error:
 redefinition of 'mptcp_getsockopt_v4'
Message-ID: <202112081738.D1IpgkU6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   8d79e486d97bbdec3af4cf2f19d91fec433d437b
commit: 48c617e1584b3190eb02338f4ef77807f433e579 [24/34] mptcp: getsockopt: add support for IP_TOS
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211208/202112081738.D1IpgkU6-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/multipath-tcp/mptcp_net-next/commit/48c617e1584b3190eb02338f4ef77807f433e579
        git remote add mptcp https://github.com/multipath-tcp/mptcp_net-next.git
        git fetch --no-tags mptcp export
        git checkout 48c617e1584b3190eb02338f4ef77807f433e579
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mptcp/sockopt.c:1174:12: error: redefinition of 'mptcp_getsockopt_v4'
    1174 | static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
         |            ^~~~~~~~~~~~~~~~~~~
   net/mptcp/sockopt.c:1161:12: note: previous definition of 'mptcp_getsockopt_v4' was here
    1161 | static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
         |            ^~~~~~~~~~~~~~~~~~~
   net/mptcp/sockopt.c:1161:12: warning: 'mptcp_getsockopt_v4' defined but not used [-Wunused-function]


vim +/mptcp_getsockopt_v4 +1174 net/mptcp/sockopt.c

48c617e1584b31 Florian Westphal 2021-12-08  1173  
3b1e21eb60e8d4 Florian Westphal 2021-12-03 @1174  static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1175  			       char __user *optval, int __user *optlen)
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1176  {
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1177  	struct sock *sk = (void *)msk;
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1178  
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1179  	switch (optname) {
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1180  	case IP_TOS:
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1181  		return mptcp_put_int_option(msk, optval, optlen, inet_sk(sk)->tos);
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1182  	}
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1183  
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1184  	return -EOPNOTSUPP;
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1185  }
3b1e21eb60e8d4 Florian Westphal 2021-12-03  1186  

:::::: The code at line 1174 was first introduced by commit
:::::: 3b1e21eb60e8d4aa42474fed606a8ea8767b0120 mptcp: getsockopt: add support for IP_TOS

:::::: TO: Florian Westphal <fw@strlen.de>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

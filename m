Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F754366;
	Mon, 28 Mar 2022 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648492955; x=1680028955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MoMV6xIVX0o/Wb7VPFeBj8yjhoY98e3aEmNSMGAAsQo=;
  b=MCqhkkuxmeuu9TdrKoILGJJZpMVrqHkDx/18RICm2kVp3HtrXhLZedx6
   j7zqQO8o5VLwClEStL9uRDqCF3Z8QfG9fvUowNUSY8Ec0bTzgk07X03na
   GYZRzsujyDHKZF5bMNJfiu0xuUNfEI9NhPNNHpRnwdEYzYoo6LoPwvzG7
   SlEVlp7+kGUcFEu3zSL9YzWSzejkj67EW5EPbgYCSaUGOOwJkq//6ZL7G
   QDFo13a+r2KytfznOrzqetOIK7iIiVsP9IfOOepINc76vf/ja8OZNAkgD
   ZabBiD85Re2aLITJiJxUtQrPi4vVP/AR9dzHplhShMFp9fShMa1+yJ5Gp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259265759"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="259265759"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 11:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="719224792"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2022 11:42:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nYuK0-0002F9-2Z; Mon, 28 Mar 2022 18:42:32 +0000
Date: Tue, 29 Mar 2022 02:42:02 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: listen diag dump support
Message-ID: <202203290201.H3kHXAzz-lkp@intel.com>
References: <20220328124913.29768-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328124913.29768-4-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Florian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[also build test WARNING on linus/master v5.17 next-20220328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/mptcp-inet-diag-listen-dump-support/20220328-205028
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220329/202203290201.H3kHXAzz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6ef1c5326220cfa09c48f9f9c6e02ec914250e3e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Florian-Westphal/mptcp-inet-diag-listen-dump-support/20220328-205028
        git checkout 6ef1c5326220cfa09c48f9f9c6e02ec914250e3e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/mptcp_diag.c:121:39: warning: variable 'bc' is uninitialized when used here [-Wuninitialized]
                           ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
                                                              ^~
   net/mptcp/mptcp_diag.c:82:19: note: initialize the variable 'bc' to silence this warning
           struct nlattr *bc;
                            ^
                             = NULL
   1 warning generated.


vim +/bc +121 net/mptcp/mptcp_diag.c

    75	
    76	static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callback *cb,
    77					      const struct inet_diag_req_v2 *r,
    78					      bool net_admin)
    79	{
    80		struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
    81		struct net *net = sock_net(skb->sk);
    82		struct nlattr *bc;
    83		int i;
    84	
    85		for (i = diag_ctx->l_slot; i < INET_LHTABLE_SIZE; i++) {
    86			struct inet_listen_hashbucket *ilb;
    87			struct hlist_nulls_node *node;
    88			struct sock *sk;
    89			int num = 0;
    90	
    91			ilb = &tcp_hashinfo.listening_hash[i];
    92	
    93			rcu_read_lock();
    94			spin_lock(&ilb->lock);
    95			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
    96				const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
    97				struct inet_sock *inet = inet_sk(sk);
    98				int ret;
    99	
   100				if (num < diag_ctx->l_num)
   101					goto next_listen;
   102	
   103				if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
   104					goto next_listen;
   105	
   106				sk = ctx->conn;
   107				if (!sk || !net_eq(sock_net(sk), net))
   108					goto next_listen;
   109	
   110				if (r->sdiag_family != AF_UNSPEC &&
   111				    sk->sk_family != r->sdiag_family)
   112					goto next_listen;
   113	
   114				if (r->id.idiag_sport != inet->inet_sport &&
   115				    r->id.idiag_sport)
   116					goto next_listen;
   117	
   118				if (!refcount_inc_not_zero(&sk->sk_refcnt))
   119					goto next_listen;
   120	
 > 121				ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
   122						   sock_put(sk);
   123				if (ret < 0) {
   124					spin_unlock(&ilb->lock);
   125					rcu_read_unlock();
   126					diag_ctx->l_slot = i;
   127					diag_ctx->l_num = num;
   128					return;
   129				}
   130				diag_ctx->l_num = num + 1;
   131				num = 0;
   132	next_listen:
   133				++num;
   134			}
   135			spin_unlock(&ilb->lock);
   136			rcu_read_unlock();
   137	
   138			cond_resched();
   139			diag_ctx->l_num = 0;
   140		}
   141	
   142		diag_ctx->l_num = 0;
   143		diag_ctx->l_slot = i;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

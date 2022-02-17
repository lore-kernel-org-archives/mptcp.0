Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3324602;
	Thu, 17 Feb 2022 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127284; x=1676663284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bpi+oHOSMDPBQC6ViVXTHYfdH0PvJnsPA9Shv9NkaWg=;
  b=GiKeJ67NCdgnnZZoswfUxzYu6McGKHv5IhWQkYNm4/DRSRMR51YHcU98
   t2KJ45mJhCpyvQ1rbIN6sK7h10TyWDRy9SkAgo3rYYhUmwFF98PgCzNcc
   m1QuUMX6pnLHMprSweqo/Nckd0EAuJAz/l1TQvuR5pOVYDijhMJC0BaOZ
   ozxqjvnc8ETT4a8spx4WQkKyQ7oUC2dsb43fEcCvInDwQHdrIdTZURnYO
   ei6QC7x8ltwupkne8eYaq/V1l9Sh80ft9FPqFzqENx7Q60gxNk3iAWzHg
   Wysnp027q2OgzO66lXEbuqseLavMJ1m25+uJ2Bo1DDfyc1IJ3ALzq3FoG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="275553304"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="275553304"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="626225493"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Feb 2022 11:48:02 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nKmkz-0000XR-C2; Thu, 17 Feb 2022 19:48:01 +0000
Date: Fri, 18 Feb 2022 03:47:04 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-next v2 4/5] mptcp: handle join requests via pernet
 listen socket
Message-ID: <202202180141.VfybVriM-lkp@intel.com>
References: <20220217142538.7849-5-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217142538.7849-5-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Florian,

I love your patch! Yet something to improve:

[auto build test ERROR on mptcp/export]
[cannot apply to linus/master v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Florian-Westphal/mptcp-replace-per-addr-listener-sockets/20220217-222844
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: mips-buildonly-randconfig-r002-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180141.VfybVriM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/044982520ba41e284eebe48421fad7feb55f2106
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Florian-Westphal/mptcp-replace-per-addr-listener-sockets/20220217-222844
        git checkout 044982520ba41e284eebe48421fad7feb55f2106
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mptcp/ctrl.c:251:17: error: no member named 'join6' in 'struct mptcp_pernet'; did you mean 'join4'?
                   lsk = pernet->join6.sk;
                                 ^~~~~
                                 join4
   net/mptcp/ctrl.c:49:23: note: 'join4' declared here
           struct mptcp_join_sk join4;
                                ^
   1 error generated.


vim +251 net/mptcp/ctrl.c

   205	
   206	struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
   207	{
   208		struct mptcp_options_received mp_opt;
   209		struct mptcp_pernet *pernet;
   210		struct socket *ssock;
   211		struct sock *lsk;
   212		struct net *net;
   213	
   214		/* paranoia check: don't allow 0 destination port,
   215		 * else __inet_inherit_port will insert the child socket
   216		 * into the phony hash slot of the pernet listener.
   217		 */
   218		if (tcp_hdr(skb)->dest == 0)
   219			return NULL;
   220	
   221		mptcp_get_options(skb, &mp_opt);
   222	
   223		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ))
   224			return NULL;
   225	
   226		net = dev_net(skb_dst(skb)->dev);
   227		if (!mptcp_is_enabled(net))
   228			return NULL;
   229	
   230		/* RFC8684: If the token is unknown [..], the receiver will send
   231		 * back a reset (RST) signal, analogous to an unknown port in TCP,
   232		 * containing an MP_TCPRST option (Section 3.6) [..]
   233		 */
   234		if (!mptcp_token_exists(net, mp_opt.token)) {
   235			struct mptcp_ext *ext = skb_ext_add(skb, SKB_EXT_MPTCP);
   236	
   237			if (ext) {
   238				memset(ext, 0, sizeof(*ext));
   239				ext->reset_reason = MPTCP_RST_EMPTCP;
   240			}
   241			return NULL;
   242		}
   243	
   244		pernet = mptcp_get_pernet(net);
   245	
   246		switch (af) {
   247		case AF_INET:
   248			lsk = pernet->join4.sk;
   249			break;
   250		case AF_INET6:
 > 251			lsk = pernet->join6.sk;
   252			break;
   253		default:
   254			WARN_ON_ONCE(1);
   255			return NULL;
   256		}
   257	
   258		ssock = __mptcp_nmpc_socket(mptcp_sk(lsk));
   259		if (WARN_ON(!ssock))
   260			return NULL;
   261	
   262		return ssock->sk;
   263	}
   264	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

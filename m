Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E964602
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 19:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127223; x=1676663223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kn+UzVML9pqGVrkwI37ngsZqD1bMeYVrIviaAWO9JAg=;
  b=UKLboR5hJkXWFxWpvxPDzXq+KLzvCk9bAYT26tKZyT6twqzgcpIqVCnF
   Hb6HXIRygFRYXc2dMDtCVZKzi+GvI2deEp4vxPceREtV6oSHfxf3IIn2L
   3zGEqAAEn314SLBEL+mIwQEuHpDKfvWBq+x3BcRd52SEqkFNxTcKDc5eU
   1CD8IDfDrDdYBAhcguTEGBnE5hqq//1ggfW27mt0Ud4HL0GXtGbrJYlQW
   7lT2Z8ar8XkXhwr5LWKdEkptXXG/wZitVl/QklAytB0j0C4pJCEz92QN8
   Mpnf3SJT4ns6BFcZTQs/s/RU6noXrvyaD2rS7DfI1/S3wIPc4X4fB/dQ9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250903346"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="250903346"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="774876551"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Feb 2022 11:47:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nKmk1-0000Tp-0D; Thu, 17 Feb 2022 19:47:01 +0000
Date: Fri, 18 Feb 2022 03:46:34 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-next v2 4/5] mptcp: handle join requests via pernet
 listen socket
Message-ID: <202202180141.4Rse3JCH-lkp@intel.com>
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220218/202202180141.4Rse3JCH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/044982520ba41e284eebe48421fad7feb55f2106
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Florian-Westphal/mptcp-replace-per-addr-listener-sockets/20220217-222844
        git checkout 044982520ba41e284eebe48421fad7feb55f2106
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/mptcp/ctrl.c: In function '__mptcp_handle_join':
>> net/mptcp/ctrl.c:251:17: error: 'struct mptcp_pernet' has no member named 'join6'; did you mean 'join4'?
     251 |   lsk = pernet->join6.sk;
         |                 ^~~~~
         |                 join4


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
